# BMOPF Network Summary: network_16_Feeder_4

**Generated:** 2026-06-18 08:54:55  
**Findings:** 0 errors · 3 warnings · 21 info  
**Convention:** LV_240V: 4-wire; 1 grounding point(s)

---

## 1. Component Inventory

| Component | Count | Notes |
|-----------|------:|-------|
| bus | 1563 |  |
| line | 1562 |  |
| linecode | 8 |  |
| voltage_source | 1 |  |
| load | 58 | 53.399 kW, 17.6 kvar |
| generator | 16 | capacity: 380.393 kW |
| shunt | 1 |  |
| switch | 0 |  |
| transformer | 0 |  |

## 2. Voltage Levels

**Voltage levels identified:** 1

| Level | Nominal | Buses | Lines | Loads | Generators |
|-------|---------|------:|------:|------:|-----------:|
| LV_240V | 240.0 V | 1563 | 1562 | 58 | 16 |

## 3. Connectivity & Topology

| Property | Value |
|----------|-------|
| Connected components | 1 |
| Fully connected | true |
| Topology | Radial |
| Mean degree | 2.0 |
| Max degree | 5 |
| Degree-1 buses | 219 |
| Tree depth (max hops) | 405 |

> 🟡 **[W.CONN.DANGLING]** 160 bus(es) are degree-1 with no attached load, generator, or shunt.

## 4. Diversity & Variance

**Overall symmetry score:** LOW

### load

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| p_nom | 114.0 | 9740.0 | 1.67 | 58 |
| q_nom | 37.5 | 3200.0 | 1.67 | 58 |

### generator

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| p_max | 4000.0 | 107000.0 | 1.865 | 18 |

### line

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| length | 0.034 | 27.9 | 1.892 | 1562 |

### linecode

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| R_series_1_1 | 0.000259 | 0.00228 | 0.667 | 8 |

## 5. Loading & Operational Summary

| | Value |
|--|-------|
| Total load P | 53.399 kW |
| Total load Q | 17.6 kvar |
| Total gen capacity | 380.393 kW |
| Generation/load ratio | 712.4% |

## 6. Infeasibility Pre-flight

| Check | Result |
|-------|--------|
| Import dependent | false |
| Constraint conflicts | 0 |
| Buses without voltage bounds | 1563 |
| Single point of failure | true |
| TPIA status | not_run |

> 🔵 **[I.PRE.NO_VOLT_BOUNDS]** 1563 bus(es) have no voltage bounds — voltage will be unconstrained at these buses.
> 🔵 **[I.PRE.SINGLE_SOURCE]** Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.

## 7. Provenance & Model Conventions

**Inferred convention:** LV_240V: 4-wire; 1 grounding point(s)

| Voltage level | Wires | Buses with neutral |
|---------------|-------|-------------------:|
| LV_240V | 4-wire | 1563 / 1563 |

| Neutral grounding | Value |
|-------------------|------:|
| Buses with neutral | 1563 |
| Neutral branches | 1562 |
| Grounding points | 1 |
| Neutral sections | 1 |
| Floating sections | 0 |

**Linecode impedance classification:**

| Verdict | Count |
|---------|------:|
| distinct | 8 |

**OpenDSS default fingerprints:** 1 hit(s) — see findings

**Earthing system per galvanic zone:**

| Zone | Buses | Wires | Star point | Downstream earths | Likely system |
|------|------:|-------|------------|------------------:|---------------|
| 240.0 V | 1563 | 4-wire | solid | 0 | TN-S or TT (source-earthed only — protective-earth side not representable in the data model) |

> 🔵 **[I.PROV.NO_PI_SHUNT]** All 8 linecode(s) have no π-shunt admittance (G_from/B_from/G_to/B_to absent or zero) — the line model reduces to a series impedance only. Shunt capacitance is typically negligible for short LV cables but may be significant for long MV/HV lines.
> 🔵 **[I.PROV.DSS_DEFAULT_LENGTH]** 1 of 1562 line(s) have length exactly 1.0 among otherwise varied lengths — the OpenDSS default; these lengths were likely never set.

## 8. Spec Conformance & Benchmark Readiness

| Spec conformance | Value |
|------------------|------:|
| Conformance issues | 0 |
| Voltage sources (spec requires 1) | 1 |

| Structural integrity | Value |
|----------------------|------:|
| Reference issues | 0 |
| Dimension issues | 0 |
| Galvanic islands | 1 |
| Islands without voltage reference | 0 |
| Line impedance spread | 2520.0× |

| Benchmark readiness | Value |
|---------------------|------:|
| Objective well-posed | true |
| Only slack generation | false |
| Buses with \|V\| bounds | 0.0% |
| Buses with vpn / vpp / vpos bounds | 1562 / 0 / 0 |
| Lines with thermal limits | 100.0% |
| Generators with no DOF (p\_min≈p\_max) | 0 |
| Generators with zero cost (dispatchable) | 0 |
| Same-cost generator pairs (≤1 hop) | 0 |
| Loads with zero p\_nom | 0 |

**Augmentation needed:**

- no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground)

> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1449' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1027' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_133' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1427' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1130' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_257' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_879' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_787' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1467' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1302' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_472' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1186' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_957' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_958' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_293' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.

> 🔵 **[I.BENCH.AUGMENTATION]** Case needs augmentation to be a non-trivial OPF benchmark: no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground).

## 9. Data Quality Summary

**Total findings:** 24 (0 errors, 3 warnings, 21 info)

### 🟡 Warnings

- **[W.CONN.DANGLING]** `bus`  
  160 bus(es) are degree-1 with no attached load, generator, or shunt.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line120`  
  Line 'line120' has ||Z||_F = 4.82e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line118`  
  Line 'line118' has ||Z||_F = 8.75e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.

### 🔵 Info

- **[I.PROV.NO_PI_SHUNT]** `linecode`  
  All 8 linecode(s) have no π-shunt admittance (G_from/B_from/G_to/B_to absent or zero) — the line model reduces to a series impedance only. Shunt capacitance is typically negligible for short LV cables but may be significant for long MV/HV lines.
- **[I.PROV.DSS_DEFAULT_LENGTH]** `line`  
  1 of 1562 line(s) have length exactly 1.0 among otherwise varied lengths — the OpenDSS default; these lengths were likely never set.
- **[I.PRE.NO_VOLT_BOUNDS]** `bus`  
  1563 bus(es) have no voltage bounds — voltage will be unconstrained at these buses.
- **[I.PRE.SINGLE_SOURCE]** `network`  
  Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.
- **[I.RED.MERGEABLE_LINES]** `line`  
  114 group(s) of series lines (1260 lines total) can be merged — intermediate buses have no other connections.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1449`  
  Generator 'der_1449' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1027`  
  Generator 'der_1027' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_133`  
  Generator 'der_133' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1427`  
  Generator 'der_1427' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1130`  
  Generator 'der_1130' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_257`  
  Generator 'der_257' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_879`  
  Generator 'der_879' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_787`  
  Generator 'der_787' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1467`  
  Generator 'der_1467' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1302`  
  Generator 'der_1302' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_472`  
  Generator 'der_472' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1186`  
  Generator 'der_1186' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_957`  
  Generator 'der_957' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_958`  
  Generator 'der_958' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_293`  
  Generator 'der_293' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.BENCH.AUGMENTATION]** `network`  
  Case needs augmentation to be a non-trivial OPF benchmark: no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground).

