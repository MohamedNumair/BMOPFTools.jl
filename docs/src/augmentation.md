# Case augmentation

Raw distribution network datasets imported from power-flow tools are rarely
ready for use as OPF benchmarks.  They typically lack voltage bounds,
thermal limits, and dispatchable generation — deficiencies that
[`benchmark_readiness_check`](@ref) flags explicitly.

BMOPFTools provides two complementary functions for preparing a case:

- **`fix_case`** — structural repairs: remove inert elements, drop disconnected
  islands, convert near-zero impedance lines to switches, strip redundant bounds.
  All passes are lossless or explicitly opt-in.
- **`augment_case`** — standards-grounded gap-filling: inject voltage bounds,
  infer thermal limits, add slack generation.  Never overwrites existing values.

Both return `(net′, TransformationManifest)`.  `net` is never mutated.

## Recommended workflow

```julia
using BMOPFTools

net = parse_bmopf("my_feeder.json")          # or from_pmd / from_dss

net′,  fix_mf  = fix_case(net)               # structural repairs first
net″,  aug_mf  = augment_case(net′)          # then fill missing bounds/limits

render_manifest(fix_mf)                      # inspect what was repaired
render_manifest(aug_mf)                      # inspect what was added

write_bmopf("my_feeder_fixed_augmented.json", net″)

result  = solve_opf(net″)
report′ = profile_solution(net″, result)
```

Passing the pre-computed `analyze` result to `augment_case` avoids
re-running voltage-level and provenance analyses internally:

```julia
report  = analyze(net′)
net″, aug_mf = augment_case(net′; analysis=report.analysis)
```

Three passes run in order.  Each can be disabled independently via the
[`AugmentationRecipe`](@ref) `apply_*` flags.  **No pass ever overwrites an
existing value** — augmentation only fills gaps.

### Pass 1 — Voltage bounds

Sets `v_min`/`v_max`, `vpn_min`/`vpn_max`, `vpp_min`/`vpp_max`, and
`vneg_max` on buses that lack them.

| Bound | Applies to | Default (pu) | Standard |
|---|---|---|---|
| `v_min`/`v_max` | LV buses (≤ 1 kV) | 0.85 / 1.15 | Solver regularisation; wider than EN 50160 to allow feasibility margin |
| `v_min`/`v_max` | MV buses (1–35 kV) | 0.94 / 1.06 | DSO operational planning practice (UK/EU ±6 %); tighter than LV to budget for downstream voltage drop |
| `v_min`/`v_max` | HV buses (> 35 kV) | 0.95 / 1.05 | Transmission planning practice (±5 %) |
| `vpn_min`/`vpn_max` | All non-source buses with a neutral | 0.90 / 1.10 | EN 50160:2010 §3.5/§3.6 — 95 %-of-week criterion, both LV (230 V) and MV |
| `vpp_min`/`vpp_max` | Buses with ≥ 2 phase terminals | 0.90 / 1.10 | EN 50160:2010 §3.5, same ±10 % band |
| `vneg_max` | 3-phase non-source buses | 0.02 × V_pn_nom | EN 50160:2010 §3.5 — "negative-sequence component shall not exceed 2 % of positive-sequence" |

**Source buses** receive `v_min`/`v_max` only — their phase voltages are
fixed by the voltage source object and `vpn`/`vpp`/`vneg` bounds are
meaningless there.

**Single-phase buses** (one phase terminal + neutral) receive `vpn` but not
`vpp` or `vneg_max`.

**Unassigned buses** (islanded from all voltage sources) are skipped; the
manifest records a note.

### Pass 2 — Thermal limits

Infers `i_max` for linecodes that lack it by matching the diagonal series
resistance R₁₁ against an IEC 60228:2004 / IEC 60364-5-52:2009 lookup table.

The table covers cross-sections from 4 mm² to 240 mm²:

| Cross-section (mm²) | R₁₁ (mΩ/m at 20 °C) | Underground XLPE (A) | Overhead AAC (A) |
|---|---|---|---|
| 4   | 4.950 | 34  | —   |
| 6   | 3.300 | 41  | —   |
| 10  | 1.980 | 57  | 70  |
| 16  | 1.240 | 76  | 95  |
| 25  | 0.787 | 104 | 130 |
| 35  | 0.559 | 134 | 160 |
| 50  | 0.396 | 170 | 200 |
| 70  | 0.283 | 220 | 260 |
| 95  | 0.209 | 277 | 320 |
| 120 | 0.164 | 326 | 375 |
| 150 | 0.132 | 386 | 430 |
| 185 | 0.107 | 451 | 490 |
| 240 | 0.082 | 541 | 600 |

Sources: IEC 60228:2004 (AC resistance at 20 °C), IEC 60364-5-52:2009
Table B.52 (ampacity at 70 °C conductor temperature, single-circuit
in-ground or in-air installation).

The match uses a 15 % relative tolerance on R₁₁.  If no table row falls
within tolerance the linecode is skipped and the manifest records
`"R₁₁ outside lookup range"`.

**Provenance confidence gating.**  The inference is only reliable when R₁₁
comes from a first-principles geometry model (Carson/Pollaczek).  The pass
checks the [`provenance_analysis`](@ref) verdict for each linecode:

| Verdict | Confidence | Included by default? |
|---|---|---|
| `distinct` | `:high` | Yes |
| `near_balanced` | `:medium` | Yes (default threshold) |
| `exactly_balanced` | `:low` | No |
| `decoupled` | `:low` | No |

Lower the threshold with `AugmentationRecipe(thermal_min_confidence=:low)` to
infer limits even from sequence-derived matrices, or raise it to `:high` to
restrict to geometry-derived data only.

**Neutral conductor rating.**  The neutral conductor is assigned the same
`i_max` as the phase conductors.  IEC 60364-5-52:2009 §523 permits a reduced
neutral cross-section above 16 mm² under balanced loading conditions, but the
appropriate reduction is installation- and load-specific and is not applied
automatically.  Set the neutral entry of `i_max` in the linecode manually, or
pass a pre-computed `i_max` vector (which will not be overwritten) if a derated
rating is required.

### Pass 3 — Generation

**Slack generator.**  If no generator with `"_slack" => true` exists at a
source bus, an unconstrained slack generator is injected.  It covers all phase
terminals of the voltage source, uses WYE configuration, and carries a
non-zero cost (default 1.0 \$/kWh, matching the [`from_pmd`](@ref) convention).
No `p_min`/`p_max`/`q_min`/`q_max` are set — the slack is unconstrained so
the OPF can always find a feasible point.

**Reactive bounds.**  For each generator that has `p_max` defined but lacks
`q_min`/`q_max`, symmetric reactive bounds are derived from the recipe
power-factor setting:

```
Q_max = P_max × tan(arccos(pf))
```

Default `pf = 0.90` (EN 50549-1:2019, LV grid-connected DERs):
Q_max ≈ 0.484 × P_max.  Set `q_capability_pf = 0.95` for IEEE 1547-2018
(ANSI) deployments: Q_max ≈ 0.329 × P_max.

## `fix_case` — structural repairs

Seven passes run in order.  Each is independently controlled by the
corresponding `apply_*` flag in [`FixRecipe`](@ref).  All passes default to
`true` except the two that change power-system semantics, which default to
`false` and must be opted into explicitly.

| # | Pass | Default | Notes |
|---|---|---|---|
| 1 | Largest connected component | `true` | Drops buses, lines, loads, generators, and shunts that have no path to a voltage source. |
| 2 | Simplify network | `true` | Merges consecutive same-linecode series lines; removes dangling stub lines (wraps [`simplify_network`](@ref)). |
| 3 | Remove zero loads | `true` | Deletes loads with `p_nom = q_nom = 0` on all phases — electrically inert. |
| 4 | Low-impedance lines → switches | `true` | Replaces lines with total series impedance `\|Z\| < threshold` (default 10⁻⁴ Ω) with closed switches. |
| 5 | Source bus bounds | `true` | Strips all voltage bounds from source buses — redundant because the voltage source pins the terminal voltages exactly. |
| 6 | Adjacent current bounds | `false` | Infers `i_max` for lines/switches that lack it from directly adjacent elements (one hop). Transformers contribute `s_rating / (√3 × V_ref)`; lines and switches propagate their own `i_max`. Takes the minimum over all adjacent bounds. |
| 7 | Perfect grounding | `false` | Promotes grounding shunts whose `1/\|Y₁₁\| < threshold` (default 0.1 Ω) to `perfectly_grounded_terminals` and removes the shunt. **Changes OPF physics** (forces `V_n = 0`). |

```@docs
fix_case
FixRecipe
```

## `augment_case` — standards-grounded gap-filling

```@docs
AugmentationRecipe
default_recipe
```

## `TransformationManifest`

```@docs
TransformationManifest
TransformEntry
manifest_to_dict
render_manifest
```

## `augment_case`

```@docs
augment_case
```

## Serialising the manifest

The manifest is intended to travel alongside the augmented case file so
the pair `(case.json, case_manifest.json)` is self-documenting:

```julia
using JSON3

net′, manifest = augment_case(net)
write_bmopf("feeder_aug.json", net′)
open("feeder_aug_manifest.json", "w") do io
    JSON3.write(io, manifest_to_dict(manifest))
end
```

## Limitations

The following augmentation tasks are **not** handled automatically:

- **DER placement** — adding dispatchable generators to load buses.  Where to
  place them and how to size them is a design choice, not standards-derivable.
  Use the standard generator dict format and add entries to `net["generator"]`
  manually before calling `augment_case`, so reactive bounds are then filled
  in by pass 3.

- **Zero-sequence voltage bound (`vzero_max`)** — the appropriate limit
  depends on the earthing system (TN, TT, IT have fundamentally different
  zero-sequence behaviour) and cannot be standardised without knowing the
  system's neutral earthing arrangement.  Use [`provenance_analysis`](@ref)
  earthing zone results to choose a value if needed.

- **Reactive load (`q_nom`)** — existing reactive demand is preserved as-is.
  If loads were imported with `pf = 0.88` OpenDSS defaults
  (flagged by `I.PROV.OPENDSS_DEFAULT_PF`) the values should be reviewed
  before treating them as benchmark data.

- **Transformer `s_max`** — `s_rating` already plays this role; the solver
  uses it directly.  No separate `s_max` augmentation is needed.
"""
