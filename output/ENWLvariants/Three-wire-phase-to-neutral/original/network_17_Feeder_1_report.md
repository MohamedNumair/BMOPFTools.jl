# BMOPF Network Summary: Three-wire-phase-to-neutral / network_17 / Feeder_1

**Generated:** 2026-06-17 17:56:12  
**Findings:** 0 errors · 49 warnings · 7 info  
**Convention:** LV_240V: mixed; implicit (Kron-style) grounding

---

## 1. Component Inventory

| Component | Count | Notes |
|-----------|------:|-------|
| bus | 2843 |  |
| line | 2842 |  |
| linecode | 7 |  |
| voltage_source | 1 |  |
| load | 188 | 163.687 kW, 53.8 kvar |
| generator | 1 | capacity: 0.0 W |
| shunt | 0 |  |
| switch | 0 |  |
| transformer | 0 |  |

## 2. Voltage Levels

**Voltage levels identified:** 1

| Level | Nominal | Buses | Lines | Loads | Generators |
|-------|---------|------:|------:|------:|-----------:|
| LV_240V | 240.0 V | 2843 | 2842 | 188 | 1 |

## 3. Connectivity & Topology

| Property | Value |
|----------|-------|
| Connected components | 1 |
| Fully connected | true |
| Topology | Radial |
| Mean degree | 2.0 |
| Max degree | 5 |
| Degree-1 buses | 346 |
| Tree depth (max hops) | 243 |

> 🟡 **[W.CONN.DANGLING]** 163 bus(es) are degree-1 with no attached load, generator, or shunt.

## 4. Diversity & Variance

**Overall symmetry score:** MODERATE

### load ⚠

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| p_nom | 114.0 | 9740.0 | 1.617 | 188 |
| q_nom | 37.5 | 3200.0 | 1.617 | 188 |

### line

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| length | 0.0141 | 30.0 | 1.698 | 2842 |

### linecode

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| R_series_1_1 | 0.000213 | 0.00231 | 0.692 | 7 |

> 🟡 **[W.DIV.LOAD_SYMMETRIC]** 137 of 188 loads share identical (p_nom, q_nom) — possible copy-paste symmetry.

## 5. Loading & Operational Summary

| | Value |
|--|-------|
| Total load P | 163.687 kW |
| Total load Q | 53.8 kvar |
| Total gen capacity | 0.0 W |
| Generation/load ratio | 0.0% |

> 🟡 **[W.OPS.IMPORT_DEPENDENT]** Network is heavily import-dependent: local generation capacity (0.0 MW) is less than 5% of total load (0.16 MW).

## 6. Infeasibility Pre-flight

| Check | Result |
|-------|--------|
| Import dependent | true |
| Constraint conflicts | 0 |
| Buses without voltage bounds | 2843 |
| Single point of failure | true |
| TPIA status | not_run |

> 🔵 **[I.PRE.NO_VOLT_BOUNDS]** 2843 bus(es) have no voltage bounds — voltage will be unconstrained at these buses.
> 🔵 **[I.PRE.SINGLE_SOURCE]** Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.

## 7. Provenance & Model Conventions

**Inferred convention:** LV_240V: mixed; implicit (Kron-style) grounding

| Voltage level | Wires | Buses with neutral |
|---------------|-------|-------------------:|
| LV_240V | mixed | 189 / 2843 |

| Neutral grounding | Value |
|-------------------|------:|
| Buses with neutral | 189 |
| Neutral branches | 0 |
| Grounding points | 189 |
| Neutral sections | 189 |
| Floating sections | 0 |

**Linecode impedance classification:**

| Verdict | Count |
|---------|------:|
| distinct | 7 |

**OpenDSS default fingerprints:** 1 hit(s) — see findings

**Earthing system per galvanic zone:**

| Zone | Buses | Wires | Star point | Downstream earths | Likely system |
|------|------:|-------|------------|------------------:|---------------|
| 240.0 V | 2843 | ≤3-wire | solid | 188 | indeterminate (3-wire / Kron-style implicit grounding) |

> 🔵 **[I.PROV.DSS_DEFAULT_LENGTH]** 1 of 2842 line(s) have length exactly 1.0 among otherwise varied lengths — the OpenDSS default; these lengths were likely never set.
> 🔵 **[I.PROV.IMPEDANCE_TRANSFORM_PN]** 7 three-wire linecode(s) match the impedance signature of phase-to-neutral approximation — R block is circulant with mutual ≈ ½ self (neutral resistance folded into phase self-terms); X block retains the original geometric structure. Valid approximation for equal phase/neutral conductors; error grows with grounding impedance.: lc1, lc2, lc3, lc4, lc6, lc8, lc9.

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
| Line impedance spread | 7780.0× |

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

**Total findings:** 56 (0 errors, 49 warnings, 7 info)

### 🟡 Warnings

- **[W.CONN.DANGLING]** `bus`  
  163 bus(es) are degree-1 with no attached load, generator, or shunt.
- **[W.DIV.LOAD_SYMMETRIC]** `load`  
  137 of 188 loads share identical (p_nom, q_nom) — possible copy-paste symmetry.
- **[W.OPS.IMPORT_DEPENDENT]** `network`  
  Network is heavily import-dependent: local generation capacity (0.0 MW) is less than 5% of total load (0.16 MW).
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line5`  
  Line 'line5' has ||Z||_F = 2.08e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line307`  
  Line 'line307' has ||Z||_F = 3.42e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1257`  
  Line 'line1257' has ||Z||_F = 7.45e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line557`  
  Line 'line557' has ||Z||_F = 7.83e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line116`  
  Line 'line116' has ||Z||_F = 3.94e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1242`  
  Line 'line1242' has ||Z||_F = 6.51e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line93`  
  Line 'line93' has ||Z||_F = 3.97e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line2`  
  Line 'line2' has ||Z||_F = 2.07e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line124`  
  Line 'line124' has ||Z||_F = 3.93e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line2360`  
  Line 'line2360' has ||Z||_F = 9.89e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line2515`  
  Line 'line2515' has ||Z||_F = 8.03e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line81`  
  Line 'line81' has ||Z||_F = 3.96e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line357`  
  Line 'line357' has ||Z||_F = 3.46e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line87`  
  Line 'line87' has ||Z||_F = 3.95e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line75`  
  Line 'line75' has ||Z||_F = 4.39e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line338`  
  Line 'line338' has ||Z||_F = 3.46e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1204`  
  Line 'line1204' has ||Z||_F = 9.79e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line9`  
  Line 'line9' has ||Z||_F = 2.1e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line3`  
  Line 'line3' has ||Z||_F = 2.11e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line246`  
  Line 'line246' has ||Z||_F = 4.81e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line261`  
  Line 'line261' has ||Z||_F = 4.8e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line459`  
  Line 'line459' has ||Z||_F = 7.81e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line396`  
  Line 'line396' has ||Z||_F = 3.45e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line376`  
  Line 'line376' has ||Z||_F = 3.4e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line2494`  
  Line 'line2494' has ||Z||_F = 7.54e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line697`  
  Line 'line697' has ||Z||_F = 9.52e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line233`  
  Line 'line233' has ||Z||_F = 4.75e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line4`  
  Line 'line4' has ||Z||_F = 2.06e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line133`  
  Line 'line133' has ||Z||_F = 3.97e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line507`  
  Line 'line507' has ||Z||_F = 7.82e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1216`  
  Line 'line1216' has ||Z||_F = 5.64e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line7`  
  Line 'line7' has ||Z||_F = 2.13e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line323`  
  Line 'line323' has ||Z||_F = 3.42e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1309`  
  Line 'line1309' has ||Z||_F = 3.53e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line8`  
  Line 'line8' has ||Z||_F = 2.06e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line99`  
  Line 'line99' has ||Z||_F = 3.95e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line6`  
  Line 'line6' has ||Z||_F = 2.08e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1229`  
  Line 'line1229' has ||Z||_F = 5.46e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1284`  
  Line 'line1284' has ||Z||_F = 7.6e-6 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line1889`  
  Line 'line1889' has ||Z||_F = 9.45e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line532`  
  Line 'line532' has ||Z||_F = 7.86e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line276`  
  Line 'line276' has ||Z||_F = 4.79e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line108`  
  Line 'line108' has ||Z||_F = 3.93e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line483`  
  Line 'line483' has ||Z||_F = 7.86e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `line417`  
  Line 'line417' has ||Z||_F = 9.68e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.SPEC.CONFIG_ARITY]** `slack_source`  
  generator 'slack_source': configuration WYE requires 4 terminal(s), terminal_map has 3.

### 🔵 Info

- **[I.PROV.DSS_DEFAULT_LENGTH]** `line`  
  1 of 2842 line(s) have length exactly 1.0 among otherwise varied lengths — the OpenDSS default; these lengths were likely never set.
- **[I.PROV.IMPEDANCE_TRANSFORM_PN]** `linecode`  
  7 three-wire linecode(s) match the impedance signature of phase-to-neutral approximation — R block is circulant with mutual ≈ ½ self (neutral resistance folded into phase self-terms); X block retains the original geometric structure. Valid approximation for equal phase/neutral conductors; error grows with grounding impedance.: lc1, lc2, lc3, lc4, lc6, lc8, lc9.
- **[I.PRE.NO_VOLT_BOUNDS]** `bus`  
  2843 bus(es) have no voltage bounds — voltage will be unconstrained at these buses.
- **[I.PRE.SINGLE_SOURCE]** `network`  
  Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.
- **[I.DOM.LINE_IMPEDANCE_SPREAD]** `line`  
  Adjacent lines 'line1308' and 'line1309' at bus '1297' have ||Z||_F ratio 1010.0× — large impedance contrasts between neighbouring lines cause ill-conditioned KKT Jacobians; consider per-unit scaling or network reformulation.
- **[I.RED.MERGEABLE_LINES]** `line`  
  276 group(s) of series lines (2446 lines total) can be merged — intermediate buses have no other connections.
- **[I.BENCH.AUGMENTATION]** `network`  
  Case needs augmentation to be a non-trivial OPF benchmark: only slack generation — dispatch is trivial (loss minimisation); add dispatchable DERs with diverse costs and p/q bounds; no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground); no phase-to-neutral or sequence voltage bounds (vpn_*/vpos_*) — sequence bounds also improve solver robustness for 4-wire OPF.

