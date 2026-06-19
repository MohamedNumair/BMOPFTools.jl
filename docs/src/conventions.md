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
sequence (`vpos_*`). Absent bounds mean *unconstrained* (spec §4.1.5).

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

**Auto-injected source generator.** `solve_opf` and `solve_feasibility_opf`
require at least one generator with a **neutral terminal** at the source bus to
satisfy neutral KCL (the voltage source fixes voltages but does not inject
current).  If none is present, the solver automatically adds a generator named
`_auto_slack` with empty bounds (unconstrained) and zero cost.  A warning is
emitted; the generator appears in the result dict.  For proper OPF benchmarks
replace this with an explicit grid-connection generator that has physically
meaningful bounds and cost — see [Source bus generator injection](opf.md#source-gen-injection).

## Transformer subtypes

Four subtypes, each its own sub-dict under `transformer`.  All impedance
fields are in SI units (Ω or S); `v_ref_*` in V; `s_rating` in VA.

| Subtype | map arity (from, to) | OPF model | impedance fields |
|---|---|---|---|
| `single_phase` | (2, 2) | Γ-equivalent, series Z referred to HV | `r/x_series_from` (HV, Ω), `r/x_series_to` (LV, Ω), `g/b_no_load` (S) |
| `center_tap` | (2, 3) | T-model, per-leg secondary Z | same field names — see note below |
| `wye_delta` | (4, 3) | ideal, series Z on wye winding | single `r_series`/`x_series` on the **wye** side |
| `delta_wye` | (3, 4) | ideal, series Z on wye winding | single `r_series`/`x_series` on the **wye** side |

**`single_phase`**: the series impedance $R = R_1 + N^2 R_2$, $X = X_1 + N^2 X_2$
is lumped onto the HV side (Γ convention).  `r_series_from`/`x_series_from`
are the HV winding values (Ω on the HV voltage base); `r_series_to`/`x_series_to`
are the LV winding values (Ω on the LV voltage base).  The no-load shunt
`g_no_load`/`b_no_load` is placed at the HV terminals, phase-to-ground.

**`center_tap`**: `terminal_map_from = ["1","n"]` (HV phase + neutral),
`terminal_map_to = ["1","n","2"]` (leg-1, center-tap neutral, leg-2).
`v_ref_to` is the **per-leg** voltage (e.g. 120 V, not 240 V).
The OPF uses a T-model with **independent per-leg** secondary impedance
branches — `r_series_to`/`x_series_to` apply separately to each leg, so
unbalanced loading produces different voltages on the two legs.

!!! warning "Leakage from OpenDSS XHL/XLT/XHT"
    For `center_tap`, `x_series_from`/`x_series_to` are the **star-network**
    leakage values, not `XHL/2`.  Given OpenDSS pair-wise values in %:
    ```
    x_series_from = (XHL + XHT − XLT) / 2  ×  Vhv² / (100 · s_rating)
    x_series_to   = (XHL + XLT − XHT) / 2  ×  Vlv² / (100 · s_rating)
    ```
    Using the 2-winding shortcut `XHL/2` on both sides forces both leg
    voltages to be identical under unbalanced loading, which is wrong.

**`wye_delta`/`delta_wye`**: the delta windings are ideal; all series
impedance is on the wye winding.  `v_ref_*` are phase-to-neutral equivalents
(the √3 factor is absorbed into the effective turns ratio `n_eff`).

There is **no wye-wye three-phase type**: three-phase wye-wye units must be
decomposed into three `single_phase` transformers.  The converter currently
parks them in `single_phase` with 3-phase terminal maps and the conformance
check flags the arity (`W.SPEC.XFMR_TMAP_ARITY`) — see the
[conversion guide](conversion.md).

## Time series (extension)

`time_series` at the root plus component-level `time_series` reference
dicts follow the PMD convention (values are multiplicative scale factors on
the static value). This is a BMOPFTools extension beyond the static-only TF
spec; [`get_snapshot`](@ref) materialises a snapshot at a given index and
[`analyze`](@ref) does this automatically.
