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

Bounds are expressed as fractions of a **declared supply voltage** — the
nominal voltage defined by the relevant power-quality standard, which may
differ from the transformer rated voltage in the network model (e.g. a 240 V
transformer in a grid declared at 230 V per EN 50160).  The declared voltage
is resolved per bus in priority order:

1. `bus["v_declared"]` — explicit field set at import time (e.g. by
   `from_pmd` from the PMD voltage base)
2. `AugmentationRecipe` fields `v_declared_lv` / `v_declared_mv` /
   `v_declared_hv` — regional fallback (e.g. `v_declared_lv = 230.0` for
   Europe/Australia)
3. `v_nom` from `voltage_level_analysis` — last resort when neither of
   the above is set

#### Solver regularisation bounds (`v_min` / `v_max`)

`v_min` and `v_max` are **hyperparameters**, not power-quality guarantees.
They widen the feasible set so the solver can find a feasible point even when
the operating point sits at the edge of the physical window.  The same values
are applied to all buses regardless of voltage level.

| Field | Default (pu of `v_declared`) | Purpose |
|---|---|---|
| `v_min` | 0.85 | Lower regularisation bound — disable with `v_min_pu = nothing` |
| `v_max` | 1.15 | Upper regularisation bound — disable with `v_max_pu = nothing` |

**Source buses** receive `v_min`/`v_max` only — `vpn`/`vpp`/`vneg` bounds
are meaningless there because the voltage source pins the terminal voltages.

#### Power-quality bounds

Applied to all non-source buses.  Percentage windows follow EN 50160:2010.

**Four-wire buses** (have a neutral terminal) receive `vpn` bounds, since
customers experience the phase-to-neutral voltage.  `vpp` bounds are also
set when ≥ 2 phase terminals are present.

| Bound | Level | Default (pu of `v_declared`) | Standard |
|---|---|---|---|
| `vpn_min`/`vpn_max` | LV (≤ 1 kV) | 0.90 / 1.10 | EN 50160:2010 §3.5/§3.6, 95 %-of-week ±10 % |
| `vpn_min`/`vpn_max` | MV (1–35 kV) | 0.94 / 1.06 | DSO planning practice ±6 %, budgets for LV voltage drop |
| `vpp_min`/`vpp_max` | LV | 0.90 / 1.10 | EN 50160:2010 §3.5, same ±10 % band |
| `vpp_min`/`vpp_max` | MV | 0.94 / 1.06 | Same ±6 % band as `vpn` |
| `vpp_min`/`vpp_max` | HV (> 35 kV) | 0.95 / 1.05 | Transmission planning ±5 % |

**Three-wire buses** (no neutral terminal) receive `vpp` bounds only.

**Single-phase buses** (one phase terminal + neutral) receive `vpn` but not
`vpp` or `vneg_max`.

**Unassigned buses** (islanded from all voltage sources) are skipped; the
manifest records a note.

| Bound | Applies to | Default | Standard |
|---|---|---|---|
| `vneg_max` | Four-wire, ≥ 2 phases, non-source | 0.02 × vpn_declared | EN 50160:2010 §3.5 — VUF ≤ 2 % |

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

**Slack cost.**  The voltage source is itself the network's current slack, so no
slack *generator* is created. If a source has no `cost`, a per-phase cost is
written onto the `voltage_source` (default 1.0 \$/kWh, matching the
[`from_pmd`](@ref) convention) so imported power is priced in the objective. No
flow bounds are added, so the slack stays unconstrained and the OPF can always
find a feasible point. Controlled by the recipe's `apply_slack_generator` /
`slack_cost` fields (names kept for backwards compatibility).

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
