# Conversion guide

[`from_pmd`](@ref) converts a PowerModelsDistribution ENGINEERING dict into
the BMOPF data model; [`to_pmd`](@ref) is its inverse. This page documents
every deliberate decision in those converters — the things you would
otherwise have to discover by diffing data.

## Scaling and basic field mapping

- Voltages: PMD `vm` (per-unit on `voltage_scale_factor`) → volts;
  `va` degrees → **radians**.
- Powers: PMD values × `power_scale_factor` → W/var/VA.
- Terminals: PMD integers `1,2,3 → "1","2","3"`, `4 → "n"`.
- PMD enum values (`WYE`, `DELTA`, …) → strings.
- Unrecognised PMD fields are preserved per component under a `_pmd`
  sub-dict — nothing is silently dropped; `to_pmd` merges them back.
- Line lengths and per-length linecode values arrive from PMD already in
  metres / Ω-per-metre (PMD normalises DSS units internally).

## The earth terminal (OpenDSS `.0`)

PMD maps the OpenDSS earth reference node `.0` to terminal **5**. BMOPF has
no earth terminal — ground is implicit — so `from_pmd` resolves every
occurrence:

| PMD pattern | BMOPF result |
|---|---|
| bus `terminals` containing 5 | filtered from `terminal_names` |
| bus `grounded = [5]` | dropped (earth is not a bus terminal) |
| self-loop line with `t_connections = [5]` (a neutral-to-earth **reactor**) | a `shunt` at the bus with `G = R/(R²+X²)`, `B = −X/(R²+X²)` on the neutral |
| voltage source with `connections = [1,2,3,5]` (neutral bonded to earth) | earth entry dropped, `vm`/`va` sliced with the same mask |
| transformer wye winding `connections = [.., 5]` (star point earthed directly) | re-routed to the bus **neutral** terminal, with a warning |

The last row is a genuine modeling change: the star point is then earthed
through that bus's grounding impedance rather than solidly. The warning
makes it visible; the alternative (an extra perfectly-grounded terminal) is
exact but non-standard — see `docs/taskforce_feedback.md` item 7.

## The explicit slack generator

The OpenDSS circuit object is simultaneously a voltage reference and an
implicit unbounded power injection. The BMOPF `voltage_source` captures only
the former, which leaves the generation-cost objective degenerate for every
raw utility dataset (no generators at all). `from_pmd` therefore adds, per
source, a generator `slack_<source_id>`:

- at the source bus, `WYE`, phases + bus neutral;
- per-phase `cost` (kwarg `slack_cost`, default 1.0 \$/kWh) — minimum-cost
  dispatch then equals loss minimisation;
- **no p/q bounds** (slack), marked `_slack: true`.

Disable with `from_pmd(eng; add_slack_generator=false)`.

!!! warning "Formulation convention required"
    Under the spec's §3.8.1 source model the source current is a free
    auxiliary variable. A co-located *costed unbounded* generator makes the
    OPF unbounded unless the problem builder treats the slack generator as
    *the* costed representation of the source injection (bind the source
    current to it, or omit the free auxiliary current). See taskforce
    feedback item 2.

## Load configuration

PMD labels 2-terminal loads "wye"; the spec distinguishes `SINGLE_PHASE`
(any two nodes) from `WYE` (4-terminal midpoint return). `from_pmd`
reclassifies by terminal arity; `to_pmd` maps `SINGLE_PHASE` back to PMD
wye.

## Transformer impedance bases

PMD gives per-winding resistance `rw` and winding-pair leakage `xsc`, both
per-unit on the winding base. BMOPF wants ohms.

**`single_phase` / `center_tap`** (per-winding fields):

```
Z_base,side = v_ref_side² / s_rating
r_series_side = rw_side · Z_base,side
x_series_side = (xsc₁ / 2) · Z_base,side     # pair total split evenly
```

**`wye_delta` / `delta_wye`** (single wye-side fields, the delta windings
being ideal per the spec math model): referring the delta-winding impedance
through the turns ratio lands on the same base — the √3 factors of the
line-to-line `v_ref` cancel against the per-winding power S/3 — so

```
Z_base = v_ref_wye² / s_rating
r_series = (rw₁ + rw₂) · Z_base
x_series = xsc₁ · Z_base
```

`to_pmd` inverts with an even split (`rw = [r_pu/2, r_pu/2]`); the original
per-winding split is not representable in the spec model and is therefore
not preserved (the totals are exact).

## Known limitations

- **Wye-wye three-phase transformers** have no spec type. They are parked
  in `single_phase` with 3-phase terminal maps and flagged
  (`W.SPEC.XFMR_TMAP_ARITY`); the faithful decomposition into three
  single-phase units is future work.
- **Generator costs** do not exist in PMD's ENGINEERING model; only the
  synthesised slack carries one after conversion.
- **`basefreq` mismatches** between linecodes and the circuit are a
  parse-time phenomenon (PMD warns during `parse_file`); they are not
  recoverable from the ENGINEERING dict and hence not visible to
  BMOPFTools.
- **RegControl / tap controllers** do not convert; see the
  regulator-pattern detection in the [methodology notes](methodology.md).
