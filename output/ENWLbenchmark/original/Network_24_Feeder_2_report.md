# BMOPF Network Summary: Network_24_Feeder_2

**Generated:** 2026-06-16 19:46:53  
**Findings:** 0 errors · 45 warnings · 26 info  
**Convention:** LV_240V: 4-wire; 1 grounding point(s)

---

## 1. Component Inventory

| Component | Count | Notes |
|-----------|------:|-------|
| bus | 1694 |  |
| line | 1693 |  |
| linecode | 5 |  |
| voltage_source | 1 |  |
| load | 79 | 73.7 kW, 24.2 kvar |
| generator | 21 | capacity: 522.2 kW |
| shunt | 1 |  |
| switch | 0 |  |
| transformer | 0 |  |

## 2. Voltage Levels

**Voltage levels identified:** 1

| Level | Nominal | Buses | Lines | Loads | Generators |
|-------|---------|------:|------:|------:|-----------:|
| LV_240V | 240.0 V | 1694 | 1693 | 79 | 21 |

## 3. Connectivity & Topology

| Property | Value |
|----------|-------|
| Connected components | 1 |
| Fully connected | true |
| Topology | Radial |
| Mean degree | 2.0 |
| Max degree | 9 |
| Degree-1 buses | 358 |
| Tree depth (max hops) | 234 |

> 🟡 **[W.CONN.DANGLING]** 283 bus(es) are degree-1 with no attached load, generator, or shunt.

## 4. Diversity & Variance

**Overall symmetry score:** MODERATE

### load

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| p_nom | 114.0 | 9740.0 | 1.632 | 79 |
| q_nom | 37.5 | 3200.0 | 1.632 | 79 |

### generator

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| p_max | 4000.0 | 147000.0 | 2.175 | 23 |

### line ⚠

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| length | 0.01 | 29.8 | 2.113 | 1693 |

### linecode

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| R_series_1_1 | 0.000259 | 0.00228 | 0.675 | 5 |

> 🔵 **[I.DIV.LINE_SYMMETRIC]** 35 lines share linecode 'lc6' with similar length (±10%) — electrically near-identical.

## 5. Loading & Operational Summary

| | Value |
|--|-------|
| Total load P | 73.7 kW |
| Total load Q | 24.2 kvar |
| Total gen capacity | 522.2 kW |
| Generation/load ratio | 708.6% |

## 6. Infeasibility Pre-flight

| Check | Result |
|-------|--------|
| Import dependent | false |
| Constraint conflicts | 0 |
| Buses without voltage bounds | 1694 |
| Single point of failure | true |
| TPIA status | not_run |

> 🔵 **[I.PRE.NO_VOLT_BOUNDS]** 1694 bus(es) have no voltage bounds — voltage will be unconstrained at these buses.
> 🔵 **[I.PRE.SINGLE_SOURCE]** Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.

## 7. Provenance & Model Conventions

**Inferred convention:** LV_240V: 4-wire; 1 grounding point(s)

| Voltage level | Wires | Buses with neutral |
|---------------|-------|-------------------:|
| LV_240V | 4-wire | 1694 / 1694 |

| Neutral grounding | Value |
|-------------------|------:|
| Buses with neutral | 1694 |
| Neutral branches | 1693 |
| Grounding points | 1 |
| Neutral sections | 1 |
| Floating sections | 0 |

**Linecode impedance classification:**

| Verdict | Count |
|---------|------:|
| distinct | 5 |

**OpenDSS default fingerprints:** 1 hit(s) — see findings

**Earthing system per galvanic zone:**

| Zone | Buses | Wires | Star point | Downstream earths | Likely system |
|------|------:|-------|------------|------------------:|---------------|
| 240.0 V | 1694 | 4-wire | solid | 0 | TN-S or TT (source-earthed only — protective-earth side not representable in the data model) |

> 🔵 **[I.PROV.DSS_DEFAULT_LENGTH]** 1 of 1693 line(s) have length exactly 1.0 among otherwise varied lengths — the OpenDSS default; these lengths were likely never set.

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
| Line impedance spread | 13400.0× |

| Benchmark readiness | Value |
|---------------------|------:|
| Objective well-posed | true |
| Only slack generation | false |
| Buses with \|V\| bounds | 0.0% |
| Buses with vpn / vpp / vpos bounds | 1693 / 0 / 0 |
| Lines with thermal limits | 100.0% |
| Generators with no DOF (p\_min≈p\_max) | 0 |
| Generators with zero cost (dispatchable) | 0 |
| Same-cost generator pairs (≤1 hop) | 0 |
| Loads with zero p\_nom | 0 |

**Augmentation needed:**

- no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground)

> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1651' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1065' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1578' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1613' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1145' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_309' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_867' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1663' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_105' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_673' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1455' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1561' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1154' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_887' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_386' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_655' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_134' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1208' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1604' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1664' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.

> 🔵 **[I.BENCH.AUGMENTATION]** Case needs augmentation to be a non-trivial OPF benchmark: no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground).

## 9. Data Quality Summary

**Total findings:** 71 (0 errors, 45 warnings, 26 info)

### 🟡 Warnings

- **[W.CONN.DANGLING]** `bus`  
  283 bus(es) are degree-1 with no attached load, generator, or shunt.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line158`  
  Line 'line158' has ||Z||_F = 7.92e-6 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line7`  
  Line 'line7' has ||Z||_F = 3.96e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1226`  
  Line 'line1226' has ||Z||_F = 3.42e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line159`  
  Line 'line159' has ||Z||_F = 7.92e-6 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line238`  
  Line 'line238' has ||Z||_F = 8.75e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line5`  
  Line 'line5' has ||Z||_F = 5.01e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1257`  
  Line 'line1257' has ||Z||_F = 2.9e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line62`  
  Line 'line62' has ||Z||_F = 6.77e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line44`  
  Line 'line44' has ||Z||_F = 4.04e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1228`  
  Line 'line1228' has ||Z||_F = 3.42e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line33`  
  Line 'line33' has ||Z||_F = 7.3e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1227`  
  Line 'line1227' has ||Z||_F = 3.42e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line89`  
  Line 'line89' has ||Z||_F = 4.04e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1223`  
  Line 'line1223' has ||Z||_F = 3.42e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line9`  
  Line 'line9' has ||Z||_F = 4.62e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1225`  
  Line 'line1225' has ||Z||_F = 3.42e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line8`  
  Line 'line8' has ||Z||_F = 4.82e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1230`  
  Line 'line1230' has ||Z||_F = 3.42e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line279`  
  Line 'line279' has ||Z||_F = 7.17e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line6`  
  Line 'line6' has ||Z||_F = 4.75e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line278`  
  Line 'line278' has ||Z||_F = 7.17e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line3`  
  Line 'line3' has ||Z||_F = 4.48e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1256`  
  Line 'line1256' has ||Z||_F = 2.9e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1229`  
  Line 'line1229' has ||Z||_F = 3.42e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line2`  
  Line 'line2' has ||Z||_F = 5.07e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line510`  
  Line 'line510' has ||Z||_F = 9.54e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line10`  
  Line 'line10' has ||Z||_F = 4.62e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line880`  
  Line 'line880' has ||Z||_F = 9.17e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line239`  
  Line 'line239' has ||Z||_F = 8.75e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line37`  
  Line 'line37' has ||Z||_F = 6.39e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line4`  
  Line 'line4' has ||Z||_F = 4.62e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line499`  
  Line 'line499' has ||Z||_F = 6.72e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1222`  
  Line 'line1222' has ||Z||_F = 3.42e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1258`  
  Line 'line1258' has ||Z||_F = 2.9e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line68`  
  Line 'line68' has ||Z||_F = 4.27e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line90`  
  Line 'line90' has ||Z||_F = 4.04e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line56`  
  Line 'line56' has ||Z||_F = 6.53e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line488`  
  Line 'line488' has ||Z||_F = 5.07e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line145`  
  Line 'line145' has ||Z||_F = 2.79e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line50`  
  Line 'line50' has ||Z||_F = 5.77e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line287`  
  Line 'line287' has ||Z||_F = 3.27e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line286`  
  Line 'line286' has ||Z||_F = 3.27e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1206`  
  Line 'line1206' has ||Z||_F = 3.17e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1255`  
  Line 'line1255' has ||Z||_F = 2.9e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.

### 🔵 Info

- **[I.DIV.LINE_SYMMETRIC]** `line`  
  35 lines share linecode 'lc6' with similar length (±10%) — electrically near-identical.
- **[I.PROV.DSS_DEFAULT_LENGTH]** `line`  
  1 of 1693 line(s) have length exactly 1.0 among otherwise varied lengths — the OpenDSS default; these lengths were likely never set.
- **[I.PRE.NO_VOLT_BOUNDS]** `bus`  
  1694 bus(es) have no voltage bounds — voltage will be unconstrained at these buses.
- **[I.PRE.SINGLE_SOURCE]** `network`  
  Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.
- **[I.RED.MERGEABLE_LINES]** `line`  
  96 group(s) of series lines (1132 lines total) can be merged — intermediate buses have no other connections.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1651`  
  Generator 'der_1651' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1065`  
  Generator 'der_1065' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1578`  
  Generator 'der_1578' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1613`  
  Generator 'der_1613' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1145`  
  Generator 'der_1145' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_309`  
  Generator 'der_309' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_867`  
  Generator 'der_867' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1663`  
  Generator 'der_1663' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_105`  
  Generator 'der_105' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_673`  
  Generator 'der_673' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1455`  
  Generator 'der_1455' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1561`  
  Generator 'der_1561' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1154`  
  Generator 'der_1154' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_887`  
  Generator 'der_887' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_386`  
  Generator 'der_386' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_655`  
  Generator 'der_655' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_134`  
  Generator 'der_134' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1208`  
  Generator 'der_1208' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1604`  
  Generator 'der_1604' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1664`  
  Generator 'der_1664' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.BENCH.AUGMENTATION]** `network`  
  Case needs augmentation to be a non-trivial OPF benchmark: no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground).

