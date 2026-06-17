# BMOPF Network Summary: network_11_Feeder_3

**Generated:** 2026-06-18 08:54:25  
**Findings:** 0 errors · 120 warnings · 15 info  
**Convention:** LV_240V: 4-wire; 1 grounding point(s)

---

## 1. Component Inventory

| Component | Count | Notes |
|-----------|------:|-------|
| bus | 1078 |  |
| line | 1077 |  |
| linecode | 7 |  |
| voltage_source | 1 |  |
| load | 33 | 25.77 kW, 8.5 kvar |
| generator | 10 | capacity: 190.62 kW |
| shunt | 1 |  |
| switch | 0 |  |
| transformer | 0 |  |

## 2. Voltage Levels

**Voltage levels identified:** 1

| Level | Nominal | Buses | Lines | Loads | Generators |
|-------|---------|------:|------:|------:|-----------:|
| LV_240V | 240.0 V | 1078 | 1077 | 33 | 10 |

## 3. Connectivity & Topology

| Property | Value |
|----------|-------|
| Connected components | 1 |
| Fully connected | true |
| Topology | Radial |
| Mean degree | 2.0 |
| Max degree | 21 |
| Degree-1 buses | 170 |
| Tree depth (max hops) | 302 |

> 🟡 **[W.CONN.DANGLING]** 138 bus(es) are degree-1 with no attached load, generator, or shunt.

## 4. Diversity & Variance

**Overall symmetry score:** LOW

### load

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| p_nom | 114.0 | 3050.0 | 1.088 | 33 |
| q_nom | 37.5 | 1000.0 | 1.088 | 33 |

### generator

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| p_max | 4000.0 | 51500.0 | 1.354 | 12 |

### line

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| length | 0.01 | 39.1 | 2.559 | 1077 |

### linecode

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| R_series_1_1 | 0.000259 | 0.00228 | 0.696 | 7 |

## 5. Loading & Operational Summary

| | Value |
|--|-------|
| Total load P | 25.77 kW |
| Total load Q | 8.5 kvar |
| Total gen capacity | 190.62 kW |
| Generation/load ratio | 739.7% |

## 6. Infeasibility Pre-flight

| Check | Result |
|-------|--------|
| Import dependent | false |
| Constraint conflicts | 0 |
| Buses without voltage bounds | 1078 |
| Single point of failure | true |
| TPIA status | not_run |

> 🔵 **[I.PRE.NO_VOLT_BOUNDS]** 1078 bus(es) have no voltage bounds — voltage will be unconstrained at these buses.
> 🔵 **[I.PRE.SINGLE_SOURCE]** Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.

## 7. Provenance & Model Conventions

**Inferred convention:** LV_240V: 4-wire; 1 grounding point(s)

| Voltage level | Wires | Buses with neutral |
|---------------|-------|-------------------:|
| LV_240V | 4-wire | 1078 / 1078 |

| Neutral grounding | Value |
|-------------------|------:|
| Buses with neutral | 1078 |
| Neutral branches | 1077 |
| Grounding points | 1 |
| Neutral sections | 1 |
| Floating sections | 0 |

**Linecode impedance classification:**

| Verdict | Count |
|---------|------:|
| distinct | 7 |

**OpenDSS default fingerprints:** 1 hit(s) — see findings

**Earthing system per galvanic zone:**

| Zone | Buses | Wires | Star point | Downstream earths | Likely system |
|------|------:|-------|------------|------------------:|---------------|
| 240.0 V | 1078 | 4-wire | solid | 0 | TN-S or TT (source-earthed only — protective-earth side not representable in the data model) |

> 🔵 **[I.PROV.NO_PI_SHUNT]** All 7 linecode(s) have no π-shunt admittance (G_from/B_from/G_to/B_to absent or zero) — the line model reduces to a series impedance only. Shunt capacitance is typically negligible for short LV cables but may be significant for long MV/HV lines.
> 🔵 **[I.PROV.DSS_DEFAULT_LENGTH]** 1 of 1077 line(s) have length exactly 1.0 among otherwise varied lengths — the OpenDSS default; these lengths were likely never set.

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
| Line impedance spread | 9920.0× |

| Benchmark readiness | Value |
|---------------------|------:|
| Objective well-posed | true |
| Only slack generation | false |
| Buses with \|V\| bounds | 0.0% |
| Buses with vpn / vpp / vpos bounds | 1077 / 0 / 0 |
| Lines with thermal limits | 100.0% |
| Generators with no DOF (p\_min≈p\_max) | 0 |
| Generators with zero cost (dispatchable) | 0 |
| Same-cost generator pairs (≤1 hop) | 0 |
| Loads with zero p\_nom | 0 |

**Augmentation needed:**

- no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground)

> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_549' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1073' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_727' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1059' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1067' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_584' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1076' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1068' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_77' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.

> 🔵 **[I.BENCH.AUGMENTATION]** Case needs augmentation to be a non-trivial OPF benchmark: no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground).

## 9. Data Quality Summary

**Total findings:** 135 (0 errors, 120 warnings, 15 info)

### 🟡 Warnings

- **[W.CONN.DANGLING]** `bus`  
  138 bus(es) are degree-1 with no attached load, generator, or shunt.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line120`  
  Line 'line120' has ||Z||_F = 8.88e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line902`  
  Line 'line902' has ||Z||_F = 3.89e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line864`  
  Line 'line864' has ||Z||_F = 3.34e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line329`  
  Line 'line329' has ||Z||_F = 7.13e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line131`  
  Line 'line131' has ||Z||_F = 9.5e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line190`  
  Line 'line190' has ||Z||_F = 6.99e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line183`  
  Line 'line183' has ||Z||_F = 3.53e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line826`  
  Line 'line826' has ||Z||_F = 1.58e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line728`  
  Line 'line728' has ||Z||_F = 3.1e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line2`  
  Line 'line2' has ||Z||_F = 7.68e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line13`  
  Line 'line13' has ||Z||_F = 7.66e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line206`  
  Line 'line206' has ||Z||_F = 8.86e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line755`  
  Line 'line755' has ||Z||_F = 3.08e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line871`  
  Line 'line871' has ||Z||_F = 4.29e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1014`  
  Line 'line1014' has ||Z||_F = 9.9e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line364`  
  Line 'line364' has ||Z||_F = 9.0e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line155`  
  Line 'line155' has ||Z||_F = 2.93e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line10`  
  Line 'line10' has ||Z||_F = 7.67e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line158`  
  Line 'line158' has ||Z||_F = 3.12e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line7`  
  Line 'line7' has ||Z||_F = 7.61e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line151`  
  Line 'line151' has ||Z||_F = 4.26e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line176`  
  Line 'line176' has ||Z||_F = 6.92e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line166`  
  Line 'line166' has ||Z||_F = 6.95e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line64`  
  Line 'line64' has ||Z||_F = 8.84e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line188`  
  Line 'line188' has ||Z||_F = 6.93e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line132`  
  Line 'line132' has ||Z||_F = 5.44e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line159`  
  Line 'line159' has ||Z||_F = 2.88e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line124`  
  Line 'line124' has ||Z||_F = 9.89e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line172`  
  Line 'line172' has ||Z||_F = 6.97e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line5`  
  Line 'line5' has ||Z||_F = 7.74e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line14`  
  Line 'line14' has ||Z||_F = 7.68e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line149`  
  Line 'line149' has ||Z||_F = 7.97e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line334`  
  Line 'line334' has ||Z||_F = 9.95e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line12`  
  Line 'line12' has ||Z||_F = 7.69e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line196`  
  Line 'line196' has ||Z||_F = 6.97e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line163`  
  Line 'line163' has ||Z||_F = 3.53e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line15`  
  Line 'line15' has ||Z||_F = 7.69e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line937`  
  Line 'line937' has ||Z||_F = 5.94e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line178`  
  Line 'line178' has ||Z||_F = 6.93e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line135`  
  Line 'line135' has ||Z||_F = 7.23e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line22`  
  Line 'line22' has ||Z||_F = 9.4e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line825`  
  Line 'line825' has ||Z||_F = 1.58e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line922`  
  Line 'line922' has ||Z||_F = 8.17e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line963`  
  Line 'line963' has ||Z||_F = 9.98e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line761`  
  Line 'line761' has ||Z||_F = 3.05e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line858`  
  Line 'line858' has ||Z||_F = 3.17e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line4`  
  Line 'line4' has ||Z||_F = 7.68e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line16`  
  Line 'line16' has ||Z||_F = 7.73e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line171`  
  Line 'line171' has ||Z||_F = 3.49e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line189`  
  Line 'line189' has ||Z||_F = 3.52e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line164`  
  Line 'line164' has ||Z||_F = 6.95e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line25`  
  Line 'line25' has ||Z||_F = 8.46e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line297`  
  Line 'line297' has ||Z||_F = 7.11e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line976`  
  Line 'line976' has ||Z||_F = 9.9e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line878`  
  Line 'line878' has ||Z||_F = 3.94e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line24`  
  Line 'line24' has ||Z||_F = 8.48e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line28`  
  Line 'line28' has ||Z||_F = 7.4e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line133`  
  Line 'line133' has ||Z||_F = 3.96e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line169`  
  Line 'line169' has ||Z||_F = 3.45e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line182`  
  Line 'line182' has ||Z||_F = 6.89e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line187`  
  Line 'line187' has ||Z||_F = 3.49e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line20`  
  Line 'line20' has ||Z||_F = 9.95e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line185`  
  Line 'line185' has ||Z||_F = 3.45e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line179`  
  Line 'line179' has ||Z||_F = 3.53e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line140`  
  Line 'line140' has ||Z||_F = 9.73e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line191`  
  Line 'line191' has ||Z||_F = 3.48e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line749`  
  Line 'line749' has ||Z||_F = 3.09e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line156`  
  Line 'line156' has ||Z||_F = 3.08e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line137`  
  Line 'line137' has ||Z||_F = 6.11e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line837`  
  Line 'line837' has ||Z||_F = 4.74e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line168`  
  Line 'line168' has ||Z||_F = 6.93e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line157`  
  Line 'line157' has ||Z||_F = 2.91e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line778`  
  Line 'line778' has ||Z||_F = 3.03e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line769`  
  Line 'line769' has ||Z||_F = 3.08e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line842`  
  Line 'line842' has ||Z||_F = 2.96e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line786`  
  Line 'line786' has ||Z||_F = 3.1e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line370`  
  Line 'line370' has ||Z||_F = 9.49e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line153`  
  Line 'line153' has ||Z||_F = 8.86e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line556`  
  Line 'line556' has ||Z||_F = 9.81e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line9`  
  Line 'line9' has ||Z||_F = 8.19e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line194`  
  Line 'line194' has ||Z||_F = 6.95e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line134`  
  Line 'line134' has ||Z||_F = 6.1e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line291`  
  Line 'line291' has ||Z||_F = 8.9e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line177`  
  Line 'line177' has ||Z||_F = 3.52e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line192`  
  Line 'line192' has ||Z||_F = 6.9e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line165`  
  Line 'line165' has ||Z||_F = 3.45e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line167`  
  Line 'line167' has ||Z||_F = 3.53e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line154`  
  Line 'line154' has ||Z||_F = 8.89e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line476`  
  Line 'line476' has ||Z||_F = 6.07e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line203`  
  Line 'line203' has ||Z||_F = 8.86e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line735`  
  Line 'line735' has ||Z||_F = 3.03e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line8`  
  Line 'line8' has ||Z||_F = 7.71e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line193`  
  Line 'line193' has ||Z||_F = 3.52e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line339`  
  Line 'line339' has ||Z||_F = 6.02e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line887`  
  Line 'line887' has ||Z||_F = 8.26e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line180`  
  Line 'line180' has ||Z||_F = 7.01e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line175`  
  Line 'line175' has ||Z||_F = 3.48e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line649`  
  Line 'line649' has ||Z||_F = 9.43e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line660`  
  Line 'line660' has ||Z||_F = 4.68e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line743`  
  Line 'line743' has ||Z||_F = 3.05e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line186`  
  Line 'line186' has ||Z||_F = 6.94e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line852`  
  Line 'line852' has ||Z||_F = 4.64e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line160`  
  Line 'line160' has ||Z||_F = 3.08e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line847`  
  Line 'line847' has ||Z||_F = 3.08e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line184`  
  Line 'line184' has ||Z||_F = 6.98e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line144`  
  Line 'line144' has ||Z||_F = 8.73e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line174`  
  Line 'line174' has ||Z||_F = 6.99e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line6`  
  Line 'line6' has ||Z||_F = 7.69e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line11`  
  Line 'line11' has ||Z||_F = 7.69e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line720`  
  Line 'line720' has ||Z||_F = 3.03e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line3`  
  Line 'line3' has ||Z||_F = 7.63e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line181`  
  Line 'line181' has ||Z||_F = 3.45e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line147`  
  Line 'line147' has ||Z||_F = 9.5e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line136`  
  Line 'line136' has ||Z||_F = 5.63e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line150`  
  Line 'line150' has ||Z||_F = 7.73e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line170`  
  Line 'line170' has ||Z||_F = 6.95e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line359`  
  Line 'line359' has ||Z||_F = 8.86e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line152`  
  Line 'line152' has ||Z||_F = 7.92e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line173`  
  Line 'line173' has ||Z||_F = 3.5e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.

### 🔵 Info

- **[I.PROV.NO_PI_SHUNT]** `linecode`  
  All 7 linecode(s) have no π-shunt admittance (G_from/B_from/G_to/B_to absent or zero) — the line model reduces to a series impedance only. Shunt capacitance is typically negligible for short LV cables but may be significant for long MV/HV lines.
- **[I.PROV.DSS_DEFAULT_LENGTH]** `line`  
  1 of 1077 line(s) have length exactly 1.0 among otherwise varied lengths — the OpenDSS default; these lengths were likely never set.
- **[I.PRE.NO_VOLT_BOUNDS]** `bus`  
  1078 bus(es) have no voltage bounds — voltage will be unconstrained at these buses.
- **[I.PRE.SINGLE_SOURCE]** `network`  
  Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.
- **[I.RED.MERGEABLE_LINES]** `line`  
  89 group(s) of series lines (861 lines total) can be merged — intermediate buses have no other connections.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_549`  
  Generator 'der_549' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1073`  
  Generator 'der_1073' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_727`  
  Generator 'der_727' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1059`  
  Generator 'der_1059' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1067`  
  Generator 'der_1067' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_584`  
  Generator 'der_584' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1076`  
  Generator 'der_1076' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1068`  
  Generator 'der_1068' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_77`  
  Generator 'der_77' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.BENCH.AUGMENTATION]** `network`  
  Case needs augmentation to be a non-trivial OPF benchmark: no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground).

