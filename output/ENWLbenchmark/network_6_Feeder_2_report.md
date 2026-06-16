# BMOPF Network Summary: network_6_Feeder_2

**Generated:** 2026-06-16 15:46:21  
**Findings:** 0 errors · 2 warnings · 20 info  
**Convention:** LV_240V: 4-wire; 1 grounding point(s)

---

## 1. Component Inventory

| Component | Count | Notes |
|-----------|------:|-------|
| bus | 1030 |  |
| line | 1029 |  |
| linecode | 5 |  |
| voltage_source | 1 |  |
| load | 54 | 51.9 kW, 17.1 kvar |
| generator | 15 | capacity: 0.0 W |
| shunt | 1 |  |
| switch | 0 |  |
| transformer | 0 |  |

## 2. Voltage Levels

**Voltage levels identified:** 1

| Level | Nominal | Buses | Lines | Loads | Generators |
|-------|---------|------:|------:|------:|-----------:|
| LV_240V | 240.0 V | 1030 | 1029 | 54 | 15 |

## 3. Connectivity & Topology

| Property | Value |
|----------|-------|
| Connected components | 1 |
| Fully connected | true |
| Topology | Radial |
| Mean degree | 2.0 |
| Max degree | 7 |
| Degree-1 buses | 110 |
| Tree depth (max hops) | 148 |

> 🟡 **[W.CONN.DANGLING]** 68 bus(es) are degree-1 with no attached load, generator, or shunt.

## 4. Diversity & Variance

**Overall symmetry score:** LOW

### load

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| p_nom | 114.0 | 9740.0 | 1.651 | 54 |
| q_nom | 37.5 | 3200.0 | 1.651 | 54 |

### generator

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|

### line

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| length | 0.01 | 14.9 | 1.882 | 1029 |

### linecode

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| R_series_1_1 | 0.000259 | 0.00228 | 0.72 | 5 |

## 5. Loading & Operational Summary

| | Value |
|--|-------|
| Total load P | 51.9 kW |
| Total load Q | 17.1 kvar |
| Total gen capacity | 0.0 W |
| Generation/load ratio | 0.0% |

> 🟡 **[W.OPS.IMPORT_DEPENDENT]** Network is heavily import-dependent: local generation capacity (0.0 MW) is less than 5% of total load (0.05 MW).

## 6. Infeasibility Pre-flight

| Check | Result |
|-------|--------|
| Import dependent | true |
| Constraint conflicts | 0 |
| Buses without voltage bounds | 1030 |
| Single point of failure | true |
| TPIA status | not_run |

> 🔵 **[I.PRE.NO_VOLT_BOUNDS]** 1030 bus(es) have no voltage bounds — voltage will be unconstrained at these buses.
> 🔵 **[I.PRE.SINGLE_SOURCE]** Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.

## 7. Provenance & Model Conventions

**Inferred convention:** LV_240V: 4-wire; 1 grounding point(s)

| Voltage level | Wires | Buses with neutral |
|---------------|-------|-------------------:|
| LV_240V | 4-wire | 1030 / 1030 |

| Neutral grounding | Value |
|-------------------|------:|
| Buses with neutral | 1030 |
| Neutral branches | 1029 |
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
| 240.0 V | 1030 | 4-wire | solid | 0 | TN-S or TT (source-earthed only — protective-earth side not representable in the data model) |

> 🔵 **[I.PROV.DSS_DEFAULT_LENGTH]** 1 of 1029 line(s) have length exactly 1.0 among otherwise varied lengths — the OpenDSS default; these lengths were likely never set.

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
| Line impedance spread | 7460.0× |

| Benchmark readiness | Value |
|---------------------|------:|
| Objective well-posed | true |
| Only slack generation | false |
| Buses with \|V\| bounds | 0.0% |
| Buses with vpn / vpp / vpos bounds | 1029 / 0 / 0 |
| Lines with thermal limits | 100.0% |

**Augmentation needed:**

- no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground)

> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_951' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_906' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_246' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_173' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_822' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_926' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_559' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_1029' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_597' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_867' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_417' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_428' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_806' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
> 🔵 **[I.SPEC.GEN_CONFIG_FUTURE]** Generator 'der_245' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.

> 🔵 **[I.BENCH.AUGMENTATION]** Case needs augmentation to be a non-trivial OPF benchmark: no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground).

## 9. Data Quality Summary

**Total findings:** 22 (0 errors, 2 warnings, 20 info)

### 🟡 Warnings

- **[W.CONN.DANGLING]** `bus`  
  68 bus(es) are degree-1 with no attached load, generator, or shunt.
- **[W.OPS.IMPORT_DEPENDENT]** `network`  
  Network is heavily import-dependent: local generation capacity (0.0 MW) is less than 5% of total load (0.05 MW).

### 🔵 Info

- **[I.PROV.DSS_DEFAULT_LENGTH]** `line`  
  1 of 1029 line(s) have length exactly 1.0 among otherwise varied lengths — the OpenDSS default; these lengths were likely never set.
- **[I.PRE.NO_VOLT_BOUNDS]** `bus`  
  1030 bus(es) have no voltage bounds — voltage will be unconstrained at these buses.
- **[I.PRE.SINGLE_SOURCE]** `network`  
  Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.
- **[I.SCHEMA.UNKNOWN_FIELDS]** `generator`  
  generator has field(s) not in the BMOPF schema: p_max_W, p_min_W.
- **[I.RED.MERGEABLE_LINES]** `line`  
  89 group(s) of series lines (912 lines total) can be merged — intermediate buses have no other connections.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_951`  
  Generator 'der_951' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_906`  
  Generator 'der_906' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_246`  
  Generator 'der_246' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_173`  
  Generator 'der_173' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_822`  
  Generator 'der_822' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_926`  
  Generator 'der_926' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_559`  
  Generator 'der_559' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_1029`  
  Generator 'der_1029' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_597`  
  Generator 'der_597' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_867`  
  Generator 'der_867' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_417`  
  Generator 'der_417' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_428`  
  Generator 'der_428' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_806`  
  Generator 'der_806' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.SPEC.GEN_CONFIG_FUTURE]** `der_245`  
  Generator 'der_245' configuration 'SINGLE_PHASE' is marked future-support in the spec (Table 4); only WYE is currently supported.
- **[I.BENCH.AUGMENTATION]** `network`  
  Case needs augmentation to be a non-trivial OPF benchmark: no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground).

