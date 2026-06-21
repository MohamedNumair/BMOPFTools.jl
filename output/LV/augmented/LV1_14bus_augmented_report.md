# BMOPF Network Summary: LV1_14bus

**Generated:** 2026-06-21 18:37:39  
**Findings:** 0 errors · 3 warnings · 27 info  
**Convention:** MV_6.4kV: 4-wire; LV_250V: 4-wire; 4 grounding point(s)

---

## 1. Component Inventory

| Component | Count | Notes |
|-----------|------:|-------|
| bus | 7 |  |
| line | 5 |  |
| linecode | 22 |  |
| voltage_source | 1 |  |
| load | 2 | 20.0 kW, 10.0 kvar |
| generator | 3 | capacity: 27.0 kW |
| shunt | 3 |  |
| switch | 0 |  |
| transformer | 1 | Dyn1×1 |
| inverter | 0 | capacity: 0.0 MVA |
| control_profile | 0 |  |

## 2. Voltage Levels

**Voltage levels identified:** 2

| Level | Nominal | Buses | Lines | Loads | Generators |
|-------|---------|------:|------:|------:|-----------:|
| MV_6.4kV | 6.35 kV | 1 | 0 | 0 | 0 |
| LV_250V | 250.0 V | 6 | 5 | 2 | 3 |

**Transformer transitions:**

- `tx3170`: MV_6.4kV → LV_250V (delta_wye, Dyn1)

## 3. Connectivity & Topology

| Property | Value |
|----------|-------|
| Connected components | 1 |
| Fully connected | true |
| Topology | Radial |
| Mean degree | 1.71 |
| Max degree | 3 |
| Degree-1 buses | 3 |
| Tree depth (max hops) | 4 |

## 4. Diversity & Variance

**Overall symmetry score:** MODERATE

### load ⚠

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| p_nom | 10000.0 | 10000.0 | 0.0 | 2 |
| q_nom | 5000.0 | 5000.0 | 0.0 | 2 |

### generator

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| p_max | 5000.0 | 6000.0 | 0.101 | 5 |

### line

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| length | 0.256 | 6.53 | 1.142 | 5 |

### linecode

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| R_series_1_1 | 0.000146 | 0.00457 | 1.723 | 22 |

> 🔵 **[I.DIV.LOAD_PHASE_BALANCED]** Galvanic zone anchored at 'b179' has balanced aggregate load across 2 phase(s) (max spread 0.0%) — the network is effectively balanced and a single-phase equivalent would suffice.

## 5. Loading & Operational Summary

| | Value |
|--|-------|
| Total load P | 20.0 kW |
| Total load Q | 10.0 kvar |
| Total gen capacity | 27.0 kW |
| Generation/load ratio | 135.0% |

**Transformer utilisation:**

| ID | Rating | Loading (est.) |
|----|--------|---------------:|
| tx3170 | 100.0 kVA | 22.4% |

> 🔵 **[I.OPS.UNLOADED_PHASE]** Galvanic zone anchored at bus 'b179' has no load connected to phase terminal '3'.
> 🔵 **[I.OPS.UNLOADED_PHASE]** Galvanic zone anchored at bus 'b2577' has no load connected to phase terminal '1'.
> 🔵 **[I.OPS.UNLOADED_PHASE]** Galvanic zone anchored at bus 'b2577' has no load connected to phase terminal '2'.
> 🔵 **[I.OPS.UNLOADED_PHASE]** Galvanic zone anchored at bus 'b2577' has no load connected to phase terminal '3'.

## 6. Infeasibility Pre-flight

| Check | Result |
|-------|--------|
| Import dependent | false |
| Constraint conflicts | 0 |
| Buses without voltage bounds | 0 |
| Single point of failure | true |
| TPIA status | not_run |

> 🔵 **[I.PRE.SINGLE_SOURCE]** Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.

## 7. Provenance & Model Conventions

**Inferred convention:** MV_6.4kV: 4-wire; LV_250V: 4-wire; 4 grounding point(s)

| Voltage level | Wires | Buses with neutral |
|---------------|-------|-------------------:|
| MV_6.4kV | 4-wire | 1 / 1 |
| LV_250V | 4-wire | 6 / 6 |

| Neutral grounding | Value |
|-------------------|------:|
| Buses with neutral | 7 |
| Neutral branches | 5 |
| Grounding points | 4 |
| Neutral sections | 2 |
| Floating sections | 0 |

**Linecode impedance classification:**

| Verdict | Count |
|---------|------:|
| distinct | 12 |
| near_balanced | 9 |
| not_applicable | 1 |

**OpenDSS default fingerprints:** none detected ✓

**Earthing system per galvanic zone:**

| Zone | Buses | Wires | Star point | Downstream earths | Likely system |
|------|------:|-------|------------|------------------:|---------------|
| 6.35 kV | 1 | 4-wire | solid | 0 | solidly earthed |
| 250.0 V | 6 | 4-wire | solid | 2 | TN-C-S / multi-earthed (PME/MEN-style) |

> 🔵 **[I.PROV.B_OFFDIAG]** Linecode 'abc4x95_lv_oh_4w_bundled' B_from_block has positive mutual susceptance — deviates from the Maxwell sign pattern; typical of screen-eliminated/bundled cable reductions, otherwise a sign-convention suspect.
> 🔵 **[I.PROV.B_OFFDIAG]** Linecode 'abc4x95_lv_oh_4w_bundled' B_to_block has positive mutual susceptance — deviates from the Maxwell sign pattern; typical of screen-eliminated/bundled cable reductions, otherwise a sign-convention suspect.
> 🔵 **[I.PROV.B_OFFDIAG]** Linecode 'uglv_185cu_xlpe/nyl/pvc_ug_4w_bundled' B_from_block has positive mutual susceptance — deviates from the Maxwell sign pattern; typical of screen-eliminated/bundled cable reductions, otherwise a sign-convention suspect.
> 🔵 **[I.PROV.B_OFFDIAG]** Linecode 'uglv_185cu_xlpe/nyl/pvc_ug_4w_bundled' B_to_block has positive mutual susceptance — deviates from the Maxwell sign pattern; typical of screen-eliminated/bundled cable reductions, otherwise a sign-convention suspect.
> 🔵 **[I.PROV.B_OFFDIAG]** Linecode 'uglv_240al_xlpe/nyl/pvc_ug_4w_bundled' B_from_block has positive mutual susceptance — deviates from the Maxwell sign pattern; typical of screen-eliminated/bundled cable reductions, otherwise a sign-convention suspect.
> 🔵 **[I.PROV.B_OFFDIAG]** Linecode 'uglv_240al_xlpe/nyl/pvc_ug_4w_bundled' B_to_block has positive mutual susceptance — deviates from the Maxwell sign pattern; typical of screen-eliminated/bundled cable reductions, otherwise a sign-convention suspect.
> 🔵 **[I.PROV.IMPEDANCE_TRANSFORM_KR]** 9 three-wire linecode(s) match the impedance signature of Kron reduction — neutral row/column eliminated from the original four-wire Carson impedance matrix via Schur complement. Exact when every neutral is perfectly grounded; approximate with finite grounding. Zero-sequence behaviour is not captured by the three-wire representation.: moon_hv_oh_3wire, pluto_lv_oh_3wire, ughv_240al_triplex_ug_3w_bundled, ughv_240cu_hdpe/nyl/pvc_ug_3w_bundled, ughv_240cu_xlpe/nyl/pvc_ug_3w_bundled, ughv_400al_triplex_ug_3w_bundled, ughv_400al_xlpe/nyl/pvc_ug_3w_bundled, ughv_95al_xlpe/nyl/pvc_ug_3w_bundled, uglv_240al_xlpe/nyl/pvc_ug_3w_bundled.
> 🔵 **[I.PROV.OVERLAPPING_VOLTAGE_BOUNDS]** Bus 'b179' has 4 voltage bound types active (phase-to-ground, phase-to-neutral, phase-to-phase, negative-sequence) — all are enforced simultaneously, which is valid but adds constraints and may slow the solver.
> 🔵 **[I.PROV.OVERLAPPING_VOLTAGE_BOUNDS]** Bus 'b514' has 4 voltage bound types active (phase-to-ground, phase-to-neutral, phase-to-phase, negative-sequence) — all are enforced simultaneously, which is valid but adds constraints and may slow the solver.
> 🔵 **[I.PROV.OVERLAPPING_VOLTAGE_BOUNDS]** Bus 'b2656' has 4 voltage bound types active (phase-to-ground, phase-to-neutral, phase-to-phase, negative-sequence) — all are enforced simultaneously, which is valid but adds constraints and may slow the solver.
> 🔵 **[I.PROV.OVERLAPPING_VOLTAGE_BOUNDS]** Bus 'b232' has 4 voltage bound types active (phase-to-ground, phase-to-neutral, phase-to-phase, negative-sequence) — all are enforced simultaneously, which is valid but adds constraints and may slow the solver.
> 🔵 **[I.PROV.OVERLAPPING_VOLTAGE_BOUNDS]** Bus 'b2734' has 4 voltage bound types active (phase-to-ground, phase-to-neutral, phase-to-phase, negative-sequence) — all are enforced simultaneously, which is valid but adds constraints and may slow the solver.
> 🔵 **[I.PROV.OVERLAPPING_VOLTAGE_BOUNDS]** Bus 'b3230' has 4 voltage bound types active (phase-to-ground, phase-to-neutral, phase-to-phase, negative-sequence) — all are enforced simultaneously, which is valid but adds constraints and may slow the solver.

## 8. Spec Conformance & Benchmark Readiness

| Spec conformance | Value |
|------------------|------:|
| Conformance issues | 0 |
| Voltage sources (spec requires 1) | 1 |

| Structural integrity | Value |
|----------------------|------:|
| Reference issues | 0 |
| Dimension issues | 0 |
| Galvanic islands | 2 |
| Islands without voltage reference | 0 |
| Line impedance spread | 58.3× |

| Benchmark readiness | Value |
|---------------------|------:|
| Objective well-posed | true |
| Only slack generation | false |
| Buses with \|V\| bounds | 100.0% |
| Buses with vpn / vpp / vpos bounds | 6 / 6 / 0 |
| Lines with thermal limits | 100.0% |
| Generators with no DOF (p\_min≈p\_max) | 0 |
| Generators with zero cost (dispatchable) | 0 |
| Same-cost generator pairs (≤1 hop) | 0 |
| Loads with zero p\_nom | 0 |

> 🔵 **[I.INT.UNIFORM_GEN_COST]** 1 group(s) of generators share identical costs — dispatch between them is degenerate (any split is optimal); diversify costs for benchmark use.

> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_pv_b' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_pv_a' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.

## 9. Data Quality Summary

**Total findings:** 30 (0 errors, 3 warnings, 27 info)

### 🟡 Warnings

- **[W.DOM.GEN_COST_NEGATIVE]** `der_bat`  
  Generator 'der_bat' has negative cost -0.5 $/kWh.
- **[W.DOM.GEN_COST_NEGATIVE]** `der_pv_b`  
  Generator 'der_pv_b' has negative cost -1.0 $/kWh.
- **[W.DOM.GEN_COST_NEGATIVE]** `der_pv_a`  
  Generator 'der_pv_a' has negative cost -1.0 $/kWh.

### 🔵 Info

- **[I.DIV.LOAD_PHASE_BALANCED]** `load`  
  Galvanic zone anchored at 'b179' has balanced aggregate load across 2 phase(s) (max spread 0.0%) — the network is effectively balanced and a single-phase equivalent would suffice.
- **[I.OPS.UNLOADED_PHASE]** `network`  
  Galvanic zone anchored at bus 'b179' has no load connected to phase terminal '3'.
- **[I.OPS.UNLOADED_PHASE]** `network`  
  Galvanic zone anchored at bus 'b2577' has no load connected to phase terminal '1'.
- **[I.OPS.UNLOADED_PHASE]** `network`  
  Galvanic zone anchored at bus 'b2577' has no load connected to phase terminal '2'.
- **[I.OPS.UNLOADED_PHASE]** `network`  
  Galvanic zone anchored at bus 'b2577' has no load connected to phase terminal '3'.
- **[I.PROV.B_OFFDIAG]** `abc4x95_lv_oh_4w_bundled`  
  Linecode 'abc4x95_lv_oh_4w_bundled' B_from_block has positive mutual susceptance — deviates from the Maxwell sign pattern; typical of screen-eliminated/bundled cable reductions, otherwise a sign-convention suspect.
- **[I.PROV.B_OFFDIAG]** `abc4x95_lv_oh_4w_bundled`  
  Linecode 'abc4x95_lv_oh_4w_bundled' B_to_block has positive mutual susceptance — deviates from the Maxwell sign pattern; typical of screen-eliminated/bundled cable reductions, otherwise a sign-convention suspect.
- **[I.PROV.B_OFFDIAG]** `uglv_185cu_xlpe/nyl/pvc_ug_4w_bundled`  
  Linecode 'uglv_185cu_xlpe/nyl/pvc_ug_4w_bundled' B_from_block has positive mutual susceptance — deviates from the Maxwell sign pattern; typical of screen-eliminated/bundled cable reductions, otherwise a sign-convention suspect.
- **[I.PROV.B_OFFDIAG]** `uglv_185cu_xlpe/nyl/pvc_ug_4w_bundled`  
  Linecode 'uglv_185cu_xlpe/nyl/pvc_ug_4w_bundled' B_to_block has positive mutual susceptance — deviates from the Maxwell sign pattern; typical of screen-eliminated/bundled cable reductions, otherwise a sign-convention suspect.
- **[I.PROV.B_OFFDIAG]** `uglv_240al_xlpe/nyl/pvc_ug_4w_bundled`  
  Linecode 'uglv_240al_xlpe/nyl/pvc_ug_4w_bundled' B_from_block has positive mutual susceptance — deviates from the Maxwell sign pattern; typical of screen-eliminated/bundled cable reductions, otherwise a sign-convention suspect.
- **[I.PROV.B_OFFDIAG]** `uglv_240al_xlpe/nyl/pvc_ug_4w_bundled`  
  Linecode 'uglv_240al_xlpe/nyl/pvc_ug_4w_bundled' B_to_block has positive mutual susceptance — deviates from the Maxwell sign pattern; typical of screen-eliminated/bundled cable reductions, otherwise a sign-convention suspect.
- **[I.PROV.IMPEDANCE_TRANSFORM_KR]** `linecode`  
  9 three-wire linecode(s) match the impedance signature of Kron reduction — neutral row/column eliminated from the original four-wire Carson impedance matrix via Schur complement. Exact when every neutral is perfectly grounded; approximate with finite grounding. Zero-sequence behaviour is not captured by the three-wire representation.: moon_hv_oh_3wire, pluto_lv_oh_3wire, ughv_240al_triplex_ug_3w_bundled, ughv_240cu_hdpe/nyl/pvc_ug_3w_bundled, ughv_240cu_xlpe/nyl/pvc_ug_3w_bundled, ughv_400al_triplex_ug_3w_bundled, ughv_400al_xlpe/nyl/pvc_ug_3w_bundled, ughv_95al_xlpe/nyl/pvc_ug_3w_bundled, uglv_240al_xlpe/nyl/pvc_ug_3w_bundled.
- **[I.PROV.OVERLAPPING_VOLTAGE_BOUNDS]** `b179`  
  Bus 'b179' has 4 voltage bound types active (phase-to-ground, phase-to-neutral, phase-to-phase, negative-sequence) — all are enforced simultaneously, which is valid but adds constraints and may slow the solver.
- **[I.PROV.OVERLAPPING_VOLTAGE_BOUNDS]** `b514`  
  Bus 'b514' has 4 voltage bound types active (phase-to-ground, phase-to-neutral, phase-to-phase, negative-sequence) — all are enforced simultaneously, which is valid but adds constraints and may slow the solver.
- **[I.PROV.OVERLAPPING_VOLTAGE_BOUNDS]** `b2656`  
  Bus 'b2656' has 4 voltage bound types active (phase-to-ground, phase-to-neutral, phase-to-phase, negative-sequence) — all are enforced simultaneously, which is valid but adds constraints and may slow the solver.
- **[I.PROV.OVERLAPPING_VOLTAGE_BOUNDS]** `b232`  
  Bus 'b232' has 4 voltage bound types active (phase-to-ground, phase-to-neutral, phase-to-phase, negative-sequence) — all are enforced simultaneously, which is valid but adds constraints and may slow the solver.
- **[I.PROV.OVERLAPPING_VOLTAGE_BOUNDS]** `b2734`  
  Bus 'b2734' has 4 voltage bound types active (phase-to-ground, phase-to-neutral, phase-to-phase, negative-sequence) — all are enforced simultaneously, which is valid but adds constraints and may slow the solver.
- **[I.PROV.OVERLAPPING_VOLTAGE_BOUNDS]** `b3230`  
  Bus 'b3230' has 4 voltage bound types active (phase-to-ground, phase-to-neutral, phase-to-phase, negative-sequence) — all are enforced simultaneously, which is valid but adds constraints and may slow the solver.
- **[I.PRE.SINGLE_SOURCE]** `network`  
  Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.
- **[I.SCHEMA.UNKNOWN_FIELDS]** `[b179]`  
  Additional property not defined in schema at [bus][b179].
- **[I.SCHEMA.UNKNOWN_FIELDS]** `bus`  
  bus has field(s) not in the BMOPF schema: v_declared.
- **[I.RED.MERGEABLE_LINES]** `line`  
  1 group(s) of series lines (2 lines total) can be merged — intermediate buses have no other connections.
- **[I.RED.UNUSED_LINECODES]** `linecode`  
  20 linecode(s) defined but not referenced by any line.
- **[I.RED.DUPLICATE_LINECODES]** `linecode`  
  4 group(s) of linecodes share identical R_series_1_1/X_series_1_1.
- **[I.INT.UNIFORM_GEN_COST]** `generator`  
  1 group(s) of generators share identical costs — dispatch between them is degenerate (any split is optimal); diversify costs for benchmark use.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_pv_b`  
  Generator 'der_pv_b' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_pv_a`  
  Generator 'der_pv_a' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.

