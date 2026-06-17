# BMOPF Network Summary: network_10 / Feeder_6

**Generated:** 2026-06-17 17:49:57  
**Findings:** 0 errors · 2 warnings · 5 info  
**Convention:** LV_240V: 4-wire; 1 grounding point(s)

---

## 1. Component Inventory

| Component | Count | Notes |
|-----------|------:|-------|
| bus | 12 |  |
| line | 11 |  |
| linecode | 8 |  |
| voltage_source | 1 |  |
| load | 5 | 6.87 kW, 2.3 kvar |
| generator | 1 | capacity: 0.0 W |
| shunt | 1 |  |
| switch | 0 |  |
| transformer | 0 |  |

## 2. Voltage Levels

**Voltage levels identified:** 1

| Level | Nominal | Buses | Lines | Loads | Generators |
|-------|---------|------:|------:|------:|-----------:|
| LV_240V | 240.0 V | 12 | 11 | 5 | 1 |

## 3. Connectivity & Topology

| Property | Value |
|----------|-------|
| Connected components | 1 |
| Fully connected | true |
| Topology | Radial |
| Mean degree | 1.83 |
| Max degree | 3 |
| Degree-1 buses | 6 |
| Tree depth (max hops) | 6 |

## 4. Diversity & Variance

**Overall symmetry score:** LOW

### load

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| p_nom | 306.0 | 2940.0 | 0.818 | 5 |
| q_nom | 101.0 | 966.0 | 0.818 | 5 |

### line

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| length | 3.13 | 133.0 | 1.367 | 11 |

### linecode

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| R_series_1_1 | 0.000259 | 0.00228 | 0.748 | 8 |

## 5. Loading & Operational Summary

| | Value |
|--|-------|
| Total load P | 6.87 kW |
| Total load Q | 2.3 kvar |
| Total gen capacity | 0.0 W |
| Generation/load ratio | 0.0% |

> 🟡 **[W.OPS.IMPORT_DEPENDENT]** Network is heavily import-dependent: local generation capacity (0.0 MW) is less than 5% of total load (0.01 MW).

## 6. Infeasibility Pre-flight

| Check | Result |
|-------|--------|
| Import dependent | true |
| Constraint conflicts | 0 |
| Buses without voltage bounds | 12 |
| Single point of failure | true |
| TPIA status | not_run |

> 🔵 **[I.PRE.NO_VOLT_BOUNDS]** 12 bus(es) have no voltage bounds — voltage will be unconstrained at these buses.
> 🔵 **[I.PRE.SINGLE_SOURCE]** Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.

## 7. Provenance & Model Conventions

**Inferred convention:** LV_240V: 4-wire; 1 grounding point(s)

| Voltage level | Wires | Buses with neutral |
|---------------|-------|-------------------:|
| LV_240V | 4-wire | 12 / 12 |

| Neutral grounding | Value |
|-------------------|------:|
| Buses with neutral | 12 |
| Neutral branches | 11 |
| Grounding points | 1 |
| Neutral sections | 1 |
| Floating sections | 0 |

**Linecode impedance classification:**

| Verdict | Count |
|---------|------:|
| distinct | 8 |

**OpenDSS default fingerprints:** none detected ✓

**Earthing system per galvanic zone:**

| Zone | Buses | Wires | Star point | Downstream earths | Likely system |
|------|------:|-------|------------|------------------:|---------------|
| 240.0 V | 12 | 4-wire | solid | 0 | TN-S or TT (source-earthed only — protective-earth side not representable in the data model) |

## 8. Spec Conformance & Benchmark Readiness

| Spec conformance | Value |
|------------------|------:|
| Conformance issues | 1 |
| Voltage sources (spec requires 1) | 1 |

| Structural integrity | Value |
|----------------------|------:|
| Reference issues | 0 |
| Dimension issues | 0 |
| Galvanic islands | 1 |
| Islands without voltage reference | 0 |
| Line impedance spread | 42.6× |

| Benchmark readiness | Value |
|---------------------|------:|
| Objective well-posed | true |
| Only slack generation | true |
| Buses with \|V\| bounds | 0.0% |
| Buses with vpn / vpp / vpos bounds | 0 / 0 / 0 |
| Lines with thermal limits | 100.0% |
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

**Total findings:** 7 (0 errors, 2 warnings, 5 info)

### 🟡 Warnings

- **[W.OPS.IMPORT_DEPENDENT]** `network`  
  Network is heavily import-dependent: local generation capacity (0.0 MW) is less than 5% of total load (0.01 MW).
- **[W.SPEC.CONFIG_ARITY]** `slack_source`  
  generator 'slack_source': configuration WYE requires 4 terminal(s), terminal_map has 3.

### 🔵 Info

- **[I.PRE.NO_VOLT_BOUNDS]** `bus`  
  12 bus(es) have no voltage bounds — voltage will be unconstrained at these buses.
- **[I.PRE.SINGLE_SOURCE]** `network`  
  Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.
- **[I.RED.MERGEABLE_LINES]** `line`  
  2 group(s) of series lines (4 lines total) can be merged — intermediate buses have no other connections.
- **[I.RED.UNUSED_LINECODES]** `linecode`  
  4 linecode(s) defined but not referenced by any line.
- **[I.BENCH.AUGMENTATION]** `network`  
  Case needs augmentation to be a non-trivial OPF benchmark: only slack generation — dispatch is trivial (loss minimisation); add dispatchable DERs with diverse costs and p/q bounds; no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground); no phase-to-neutral or sequence voltage bounds (vpn_*/vpos_*) — sequence bounds also improve solver robustness for 4-wire OPF.

