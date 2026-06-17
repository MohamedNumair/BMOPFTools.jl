# BMOPF Network Summary: Three-wire-phase-to-neutral / Network_14 / Feeder_5

**Generated:** 2026-06-18 08:51:45  
**Findings:** 0 errors · 35 warnings · 8 info  
**Convention:** LV_240V: mixed; implicit (Kron-style) grounding

---

## 1. Component Inventory

| Component | Count | Notes |
|-----------|------:|-------|
| bus | 145 |  |
| line | 144 |  |
| linecode | 2 |  |
| voltage_source | 1 |  |
| load | 45 | 48.595 kW, 16.0 kvar |
| generator | 1 | capacity: 0.0 W |
| shunt | 0 |  |
| switch | 0 |  |
| transformer | 0 |  |

## 2. Voltage Levels

**Voltage levels identified:** 1

| Level | Nominal | Buses | Lines | Loads | Generators |
|-------|---------|------:|------:|------:|-----------:|
| LV_240V | 240.0 V | 145 | 144 | 45 | 1 |

## 3. Connectivity & Topology

| Property | Value |
|----------|-------|
| Connected components | 1 |
| Fully connected | true |
| Topology | Radial |
| Mean degree | 1.99 |
| Max degree | 46 |
| Degree-1 buses | 94 |
| Tree depth (max hops) | 52 |

> 🟡 **[W.CONN.DANGLING]** 48 bus(es) are degree-1 with no attached load, generator, or shunt.

## 4. Diversity & Variance

**Overall symmetry score:** MODERATE

### load

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| p_nom | 114.0 | 9740.0 | 1.588 | 45 |
| q_nom | 37.5 | 3200.0 | 1.588 | 45 |

### line ⚠

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| length | 0.0412 | 15.0 | 1.162 | 144 |

### linecode

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| R_series_1_1 | 0.000213 | 0.0023 | 1.174 | 2 |

> 🔵 **[I.DIV.LINE_SYMMETRIC]** 45 lines share linecode 'lc1' with similar length (±10%) — electrically near-identical.

## 5. Loading & Operational Summary

| | Value |
|--|-------|
| Total load P | 48.595 kW |
| Total load Q | 16.0 kvar |
| Total gen capacity | 0.0 W |
| Generation/load ratio | 0.0% |

> 🟡 **[W.OPS.IMPORT_DEPENDENT]** Network is heavily import-dependent: local generation capacity (0.0 MW) is less than 5% of total load (0.05 MW).

## 6. Infeasibility Pre-flight

| Check | Result |
|-------|--------|
| Import dependent | true |
| Constraint conflicts | 0 |
| Buses without voltage bounds | 145 |
| Single point of failure | true |
| TPIA status | not_run |

> 🔵 **[I.PRE.NO_VOLT_BOUNDS]** 145 bus(es) have no voltage bounds — voltage will be unconstrained at these buses.
> 🔵 **[I.PRE.SINGLE_SOURCE]** Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.

## 7. Provenance & Model Conventions

**Inferred convention:** LV_240V: mixed; implicit (Kron-style) grounding

| Voltage level | Wires | Buses with neutral |
|---------------|-------|-------------------:|
| LV_240V | mixed | 46 / 145 |

| Neutral grounding | Value |
|-------------------|------:|
| Buses with neutral | 46 |
| Neutral branches | 0 |
| Grounding points | 46 |
| Neutral sections | 46 |
| Floating sections | 0 |

**Linecode impedance classification:**

| Verdict | Count |
|---------|------:|
| distinct | 2 |

**OpenDSS default fingerprints:** 1 hit(s) — see findings

**Earthing system per galvanic zone:**

| Zone | Buses | Wires | Star point | Downstream earths | Likely system |
|------|------:|-------|------------|------------------:|---------------|
| 240.0 V | 145 | ≤3-wire | solid | 45 | indeterminate (3-wire / Kron-style implicit grounding) |

> 🔵 **[I.PROV.NO_PI_SHUNT]** All 2 linecode(s) have no π-shunt admittance (G_from/B_from/G_to/B_to absent or zero) — the line model reduces to a series impedance only. Shunt capacitance is typically negligible for short LV cables but may be significant for long MV/HV lines.
> 🔵 **[I.PROV.DSS_DEFAULT_LENGTH]** 1 of 144 line(s) have length exactly 1.0 among otherwise varied lengths — the OpenDSS default; these lengths were likely never set.
> 🔵 **[I.PROV.IMPEDANCE_TRANSFORM_PN]** 2 three-wire linecode(s) match the impedance signature of phase-to-neutral approximation — R block is circulant with mutual ≈ ½ self (neutral resistance folded into phase self-terms); X block retains the original geometric structure. Valid approximation for equal phase/neutral conductors; error grows with grounding impedance.: lc1, lc8.

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
| Line impedance spread | 3120.0× |

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

**Total findings:** 43 (0 errors, 35 warnings, 8 info)

### 🟡 Warnings

- **[W.CONN.DANGLING]** `bus`  
  48 bus(es) are degree-1 with no attached load, generator, or shunt.
- **[W.OPS.IMPORT_DEPENDENT]** `network`  
  Network is heavily import-dependent: local generation capacity (0.0 MW) is less than 5% of total load (0.05 MW).
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line8`  
  Line 'line8' has ||Z||_F = 3.58e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line24`  
  Line 'line24' has ||Z||_F = 8.08e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line38`  
  Line 'line38' has ||Z||_F = 3.29e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line6`  
  Line 'line6' has ||Z||_F = 2.56e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line15`  
  Line 'line15' has ||Z||_F = 2.68e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line28`  
  Line 'line28' has ||Z||_F = 2.63e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line27`  
  Line 'line27' has ||Z||_F = 2.63e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line11`  
  Line 'line11' has ||Z||_F = 2.57e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line36`  
  Line 'line36' has ||Z||_F = 2.23e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line18`  
  Line 'line18' has ||Z||_F = 3.71e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line22`  
  Line 'line22' has ||Z||_F = 8.03e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line29`  
  Line 'line29' has ||Z||_F = 3.07e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line3`  
  Line 'line3' has ||Z||_F = 2.89e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line30`  
  Line 'line30' has ||Z||_F = 3.07e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line5`  
  Line 'line5' has ||Z||_F = 2.56e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line31`  
  Line 'line31' has ||Z||_F = 3.12e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line33`  
  Line 'line33' has ||Z||_F = 3.32e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line13`  
  Line 'line13' has ||Z||_F = 3.43e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line9`  
  Line 'line9' has ||Z||_F = 3.4e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line37`  
  Line 'line37' has ||Z||_F = 3.29e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line14`  
  Line 'line14' has ||Z||_F = 3.43e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line10`  
  Line 'line10' has ||Z||_F = 3.4e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line32`  
  Line 'line32' has ||Z||_F = 3.12e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line4`  
  Line 'line4' has ||Z||_F = 2.89e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line21`  
  Line 'line21' has ||Z||_F = 8.03e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line16`  
  Line 'line16' has ||Z||_F = 2.68e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line35`  
  Line 'line35' has ||Z||_F = 2.23e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line7`  
  Line 'line7' has ||Z||_F = 3.58e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line12`  
  Line 'line12' has ||Z||_F = 2.57e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line34`  
  Line 'line34' has ||Z||_F = 3.32e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line23`  
  Line 'line23' has ||Z||_F = 8.08e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line17`  
  Line 'line17' has ||Z||_F = 3.71e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.SPEC.CONFIG_ARITY]** `slack_source`  
  generator 'slack_source': configuration WYE requires 4 terminal(s), terminal_map has 3.

### 🔵 Info

- **[I.DIV.LINE_SYMMETRIC]** `line`  
  45 lines share linecode 'lc1' with similar length (±10%) — electrically near-identical.
- **[I.PROV.NO_PI_SHUNT]** `linecode`  
  All 2 linecode(s) have no π-shunt admittance (G_from/B_from/G_to/B_to absent or zero) — the line model reduces to a series impedance only. Shunt capacitance is typically negligible for short LV cables but may be significant for long MV/HV lines.
- **[I.PROV.DSS_DEFAULT_LENGTH]** `line`  
  1 of 144 line(s) have length exactly 1.0 among otherwise varied lengths — the OpenDSS default; these lengths were likely never set.
- **[I.PROV.IMPEDANCE_TRANSFORM_PN]** `linecode`  
  2 three-wire linecode(s) match the impedance signature of phase-to-neutral approximation — R block is circulant with mutual ≈ ½ self (neutral resistance folded into phase self-terms); X block retains the original geometric structure. Valid approximation for equal phase/neutral conductors; error grows with grounding impedance.: lc1, lc8.
- **[I.PRE.NO_VOLT_BOUNDS]** `bus`  
  145 bus(es) have no voltage bounds — voltage will be unconstrained at these buses.
- **[I.PRE.SINGLE_SOURCE]** `network`  
  Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.
- **[I.RED.MERGEABLE_LINES]** `line`  
  1 group(s) of series lines (3 lines total) can be merged — intermediate buses have no other connections.
- **[I.BENCH.AUGMENTATION]** `network`  
  Case needs augmentation to be a non-trivial OPF benchmark: only slack generation — dispatch is trivial (loss minimisation); add dispatchable DERs with diverse costs and p/q bounds; no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground); no phase-to-neutral or sequence voltage bounds (vpn_*/vpos_*) — sequence bounds also improve solver robustness for 4-wire OPF.

