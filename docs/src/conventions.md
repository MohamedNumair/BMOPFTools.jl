# Data model conventions

This page documents the BMOPF data-model conventions as implemented by
BMOPFTools, following the Task Force specification ([ref. 1](methodology.md#refs)) with the
implementation choices called out explicitly.

## Structure and identifiers

The network is a nested `Dict{String,Any}`: component types at the top level
(`bus`, `line`, `linecode`, `voltage_source`, `load`, `generator`, `shunt`,
`switch`, `transformer`), each a dict of `id => component`. IDs are
**strings** and carry no ordering semantics. Keys beginning with `_`
(`_meta`, `_pmd`, `_slack`, …) are tolerated extension/bookkeeping fields
and are never reported as schema violations.

## Units

All physical quantities are SI (spec Table 8):

| Quantity | Unit |
|---|---|
| voltage | V |
| current | A |
| length | m |
| active / reactive / apparent power | W / var / VA |
| resistance / reactance | Ω (lines: Ω/m) |
| conductance / susceptance | S (lines: S/m) |
| angle | rad |
| generation cost | \$/kWh |

Note that PowerModelsDistribution's ENGINEERING model already normalises
line lengths to metres and linecodes to per-metre values, so `from_pmd`
output is SI without further scaling; voltages and powers are scaled by the
PMD `voltage_scale_factor`/`power_scale_factor` settings.

## Terminal names

Terminal identifiers are **strings**. The library writes the OpenDSS-flavoured
convention `"1", "2", "3", "n"` and understands these conventions on read:

| Convention | Phases | Neutral |
|---|---|---|
| OpenDSS numeric | `"1" "2" "3"` | `"4"` (positional, see below) |
| BMOPFTools canonical | `"1" "2" "3"` | `"n"` |
| Letter | `"a" "b" "c"` (any case) | `"n"`/`"N"` |
| IEC 60445 | `"L1" "L2" "L3"` | `"N"` |

**Neutral identification** is heuristic (the spec carries no explicit
marker): a terminal named `n`/`N` is the neutral; failing that, terminal
`"4"` of a bus whose terminal set is exactly `{"1","2","3","4"}`. Anything
else is treated as all-phase.

**Ingest normalisation**: JSON files with non-string terminal entries (e.g.
`[1,2,3,4]`) are coerced by [`parse_bmopf`](@ref). If every numeric token is
covered by the alias table (default `1→"1", 2→"2", 3→"3", 4→"n"`,
overridable via `terminal_aliases`), the aliases apply; otherwise — the
profiling guard, e.g. a 5th conductor present — everything becomes its
verbatim decimal string. Coercion is recorded in
`_meta["terminal_coercions"]` and flagged as `W.SPEC.TERMINAL_TYPES`.

## Buses, bounds and grounding

A bus carries `terminal_names`, optionally `perfectly_grounded_terminals`,
and optional voltage-magnitude bounds in four flavours: phase-to-ground
(`v_min`/`v_max`), phase-to-neutral (`vpn_*`), phase-to-phase (`vpp_*`) and
sequence (`vsym_*`). Absent bounds mean *unconstrained* (spec §4.1.5).

Grounding semantics (spec Table 10):

- **perfect grounding** is a bus property (`perfectly_grounded_terminals`);
- **grounding through an impedance** is a `shunt` whose terminal map
  references the neutral (e.g. `Y = [G_1_1 + jB_1_1]`, `N = ["n"]`);
- loads, generators, transformers and switches **never** connect directly
  to ground — only to bus terminals;
- voltage sources are defined voltage-to-ground and pin every terminal in
  their map (a source whose map includes the neutral references it to
  ground).

## Lines, linecodes and matrices

Lines carry only topology (`bus_from`/`bus_to`, terminal maps, `length`,
`linecode`); all impedance lives in the linecode as per-length matrices in
flattened row-first pattern keys: `R_series_1_2 ⇒ rs[1,2]` (Ω/m), likewise
`X_series_*`, and optional `G_from_*`/`G_to_*`/`B_from_*`/`B_to_*` (S/m)
for the two shunt half-sections of the Π model. Optional ratings: `i_max`
(A, per conductor) and `s_max` (VA).

The spec defines full row-first storage; BMOPFTools also *reads*
upper-triangular shorthand (mirroring the missing transpose entries) and
reports it as `I.SPEC.MATRIX_TRIANGULAR`. It always *writes* all n²
entries.

## Loads and generators

`configuration` ∈ `SINGLE_PHASE` (2 terminals, between any two nodes),
`WYE` (4 terminals, midpoint return) or `DELTA` (3 terminals). Setpoint
vectors `p_nom`/`q_nom` have length 1 (single-phase) or 3. Note the spec
FAQ: a "wye" in the BMOPF sense always has the neutral return — a
2-terminal load is `SINGLE_PHASE`, not a degenerate wye.

Generators additionally carry per-phase `cost` (\$/kWh; scalar shorthand
accepted) and optional `p_min/p_max/q_min/q_max`. A generator without
bounds is an unbounded (slack-style) unit. The converter marks the slack it
synthesises with `_slack: true`.

## Transformer subtypes

Four subtypes, each its own sub-dict under `transformer`, with terminal-map
arities and impedance fields per the spec:

| Subtype | map arity (from, to) | impedance fields |
|---|---|---|
| `single_phase` | (2, 2) | `r/x_series_from`, `r/x_series_to` (Ω, per winding) |
| `center_tap` | (2, 3) | `r/x_series_from`, `r/x_series_to` |
| `wye_delta` | (4, 3) | single `r_series`/`x_series` on the **wye** windings |
| `delta_wye` | (3, 4) | single `r_series`/`x_series` on the **wye** windings |

The wye-side single impedance follows the spec's math model (the delta
windings are ideal). `v_ref_*` are line-to-line on three-phase windings;
`s_rating` is the through-rating in VA.

There is **no wye-wye type** in the spec: three-phase wye-wye units must be
decomposed into three `single_phase` transformers. The converter currently
parks them in `single_phase` with 3-phase maps and the conformance check
flags the arity (`W.SPEC.XFMR_TMAP_ARITY`) — see the
[conversion guide](conversion.md).

## Time series (extension)

`time_series` at the root plus component-level `time_series` reference
dicts follow the PMD convention (values are multiplicative scale factors on
the static value). This is a BMOPFTools extension beyond the static-only TF
spec; [`get_snapshot`](@ref) materialises a snapshot at a given index and
[`analyze`](@ref) does this automatically.
