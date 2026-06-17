# BMOPF Network Summary: LV14_13bus

**Generated:** 2026-06-18 08:53:35  
**Findings:** 0 errors · 1 warnings · 12 info  
**Convention:** MV_6.4kV: 4-wire; LV_250V: 4-wire; implicit (Kron-style) grounding

---

## 1. Component Inventory

| Component | Count | Notes |
|-----------|------:|-------|
| bus | 2 |  |
| line | 0 |  |
| linecode | 22 |  |
| voltage_source | 1 |  |
| load | 0 | 0.0 W, 0.0 var |
| generator | 1 | capacity: 0.0 W |
| shunt | 1 |  |
| switch | 0 |  |
| transformer | 1 | Dyn1×1 |

## 2. Voltage Levels

**Voltage levels identified:** 2

| Level | Nominal | Buses | Lines | Loads | Generators |
|-------|---------|------:|------:|------:|-----------:|
| MV_6.4kV | 6.35 kV | 1 | 0 | 0 | 1 |
| LV_250V | 250.0 V | 1 | 0 | 0 | 0 |

**Transformer transitions:**

- `tx381`: MV_6.4kV → LV_250V (delta_wye, Dyn1)

## 3. Connectivity & Topology

| Property | Value |
|----------|-------|
| Connected components | 1 |
| Fully connected | true |
| Topology | Radial |
| Mean degree | 1.0 |
| Max degree | 1 |
| Degree-1 buses | 2 |
| Tree depth (max hops) | 1 |

## 4. Diversity & Variance

**Overall symmetry score:** LOW

### linecode

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| R_series_1_1 | 0.000146 | 0.00457 | 1.723 | 22 |

## 5. Loading & Operational Summary

| | Value |
|--|-------|
| Total load P | 0.0 W |
| Total load Q | 0.0 var |
| Total gen capacity | 0.0 W |

**Transformer utilisation:**

| ID | Rating | Loading (est.) |
|----|--------|---------------:|
| tx381 | 1.0 MVA | 0.0% |

## 6. Infeasibility Pre-flight

| Check | Result |
|-------|--------|
| Import dependent | true |
| Constraint conflicts | 0 |
| Buses without voltage bounds | 2 |
| Single point of failure | true |
| TPIA status | not_run |

> 🔵 **[I.PRE.NO_VOLT_BOUNDS]** 2 bus(es) have no voltage bounds — voltage will be unconstrained at these buses.
> 🔵 **[I.PRE.SINGLE_SOURCE]** Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.

## 7. Provenance & Model Conventions

**Inferred convention:** MV_6.4kV: 4-wire; LV_250V: 4-wire; implicit (Kron-style) grounding

| Voltage level | Wires | Buses with neutral |
|---------------|-------|-------------------:|
| MV_6.4kV | 4-wire | 1 / 1 |
| LV_250V | 4-wire | 1 / 1 |

| Neutral grounding | Value |
|-------------------|------:|
| Buses with neutral | 2 |
| Neutral branches | 0 |
| Grounding points | 2 |
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
| 250.0 V | 1 | 4-wire | solid | 0 | TN-S or TT (source-earthed only — protective-earth side not representable in the data model) |

> 🔵 **[I.PROV.B_OFFDIAG]** Linecode 'abc4x95_lv_oh_4w_bundled' B_from_block has positive mutual susceptance — deviates from the Maxwell sign pattern; typical of screen-eliminated/bundled cable reductions, otherwise a sign-convention suspect.
> 🔵 **[I.PROV.B_OFFDIAG]** Linecode 'abc4x95_lv_oh_4w_bundled' B_to_block has positive mutual susceptance — deviates from the Maxwell sign pattern; typical of screen-eliminated/bundled cable reductions, otherwise a sign-convention suspect.
> 🔵 **[I.PROV.B_OFFDIAG]** Linecode 'uglv_185cu_xlpe/nyl/pvc_ug_4w_bundled' B_from_block has positive mutual susceptance — deviates from the Maxwell sign pattern; typical of screen-eliminated/bundled cable reductions, otherwise a sign-convention suspect.
> 🔵 **[I.PROV.B_OFFDIAG]** Linecode 'uglv_185cu_xlpe/nyl/pvc_ug_4w_bundled' B_to_block has positive mutual susceptance — deviates from the Maxwell sign pattern; typical of screen-eliminated/bundled cable reductions, otherwise a sign-convention suspect.
> 🔵 **[I.PROV.B_OFFDIAG]** Linecode 'uglv_240al_xlpe/nyl/pvc_ug_4w_bundled' B_from_block has positive mutual susceptance — deviates from the Maxwell sign pattern; typical of screen-eliminated/bundled cable reductions, otherwise a sign-convention suspect.
> 🔵 **[I.PROV.B_OFFDIAG]** Linecode 'uglv_240al_xlpe/nyl/pvc_ug_4w_bundled' B_to_block has positive mutual susceptance — deviates from the Maxwell sign pattern; typical of screen-eliminated/bundled cable reductions, otherwise a sign-convention suspect.
> 🔵 **[I.PROV.IMPEDANCE_TRANSFORM_KR]** 9 three-wire linecode(s) match the impedance signature of Kron reduction — neutral row/column eliminated from the original four-wire Carson impedance matrix via Schur complement. Exact when every neutral is perfectly grounded; approximate with finite grounding. Zero-sequence behaviour is not captured by the three-wire representation.: moon_hv_oh_3wire, pluto_lv_oh_3wire, ughv_240al_triplex_ug_3w_bundled, ughv_240cu_hdpe/nyl/pvc_ug_3w_bundled, ughv_240cu_xlpe/nyl/pvc_ug_3w_bundled, ughv_400al_triplex_ug_3w_bundled, ughv_400al_xlpe/nyl/pvc_ug_3w_bundled, ughv_95al_xlpe/nyl/pvc_ug_3w_bundled, uglv_240al_xlpe/nyl/pvc_ug_3w_bundled.

## 8. Spec Conformance & Benchmark Readiness

| Spec conformance | Value |
|------------------|------:|
| Conformance issues | 1 |
| Voltage sources (spec requires 1) | 1 |

| Structural integrity | Value |
|----------------------|------:|
| Reference issues | 0 |
| Dimension issues | 0 |
| Galvanic islands | 2 |
| Islands without voltage reference | 0 |

| Benchmark readiness | Value |
|---------------------|------:|
| Objective well-posed | true |
| Only slack generation | true |
| Buses with \|V\| bounds | 0.0% |
| Buses with vpn / vpp / vpos bounds | 0 / 0 / 0 |
| Lines with thermal limits | 0.0% |
| Generators with no DOF (p\_min≈p\_max) | 0 |
| Generators with zero cost (dispatchable) | 0 |
| Same-cost generator pairs (≤1 hop) | 0 |
| Loads with zero p\_nom | 0 |

**Augmentation needed:**

- only slack generation — dispatch is trivial (loss minimisation); add dispatchable DERs with diverse costs and p/q bounds
- no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground)
- no phase-to-neutral or sequence voltage bounds (vpn_*/vpos_*) — sequence bounds also improve solver robustness for 4-wire OPF

> 🟡 **[W.SPEC.CONFIG_ARITY]** generator 'slack_source': configuration WYE requires 4 terminal(s), terminal_map has 3.

> 🔵 **[I.BENCH.AUGMENTATION]** Case needs augmentation to be a non-trivial OPF benchmark: only slack generation — dispatch is trivial (loss minimisation); add dispatchable DERs with diverse costs and p/q bounds; no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground); no phase-to-neutral or sequence voltage bounds (vpn_*/vpos_*) — sequence bounds also improve solver robustness for 4-wire OPF.

## 9. Data Quality Summary

**Total findings:** 13 (0 errors, 1 warnings, 12 info)

### 🟡 Warnings

- **[W.SPEC.CONFIG_ARITY]** `slack_source`  
  generator 'slack_source': configuration WYE requires 4 terminal(s), terminal_map has 3.

### 🔵 Info

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
- **[I.PRE.NO_VOLT_BOUNDS]** `bus`  
  2 bus(es) have no voltage bounds — voltage will be unconstrained at these buses.
- **[I.PRE.SINGLE_SOURCE]** `network`  
  Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.
- **[I.RED.UNUSED_LINECODES]** `linecode`  
  22 linecode(s) defined but not referenced by any line.
- **[I.RED.DUPLICATE_LINECODES]** `linecode`  
  4 group(s) of linecodes share identical R_series_1_1/X_series_1_1.
- **[I.BENCH.AUGMENTATION]** `network`  
  Case needs augmentation to be a non-trivial OPF benchmark: only slack generation — dispatch is trivial (loss minimisation); add dispatchable DERs with diverse costs and p/q bounds; no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground); no phase-to-neutral or sequence voltage bounds (vpn_*/vpos_*) — sequence bounds also improve solver robustness for 4-wire OPF.

