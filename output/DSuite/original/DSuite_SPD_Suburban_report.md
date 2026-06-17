# BMOPF Network Summary: DSuite_SPD_Suburban

**Generated:** 2026-06-18 09:32:04  
**Findings:** 1 errors · 26 warnings · 26 info  
**Convention:** MV_6.4kV: mixed; LV_242V: mixed; implicit (Kron-style) grounding

---

## 1. Component Inventory

| Component | Count | Notes |
|-----------|------:|-------|
| bus | 265 |  |
| line | 264 |  |
| linecode | 63 |  |
| voltage_source | 1 |  |
| load | 119 | 74.0 kW, 0.0 var |
| generator | 1 | capacity: 0.0 W |
| shunt | 0 |  |
| switch | 0 |  |
| transformer | 1 | Dyn1×1 |

## 2. Voltage Levels

**Voltage levels identified:** 2

| Level | Nominal | Buses | Lines | Loads | Generators |
|-------|---------|------:|------:|------:|-----------:|
| MV_6.4kV | 6.41 kV | 2 | 1 | 0 | 1 |
| LV_242V | 242.0 V | 263 | 263 | 119 | 0 |

**Transformer transitions:**

- `dist_transformer_10148922_9108515`: MV_6.4kV → LV_242V (delta_wye, Dyn1)

## 3. Connectivity & Topology

| Property | Value |
|----------|-------|
| Connected components | 1 |
| Fully connected | true |
| Topology | Meshed |
| Mean degree | 2.0 |
| Max degree | 6 |
| Degree-1 buses | 108 |
| Tree depth (max hops) | 29 |

> 🟡 **[W.CONN.MESHED]** Network contains 1 extra edge(s) forming cycles — not purely radial.
> 🟡 **[W.CONN.DANGLING]** 31 bus(es) are degree-1 with no attached load, generator, or shunt.

## 4. Diversity & Variance

**Overall symmetry score:** MODERATE

### load ⚠

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| p_nom | 0.0 | 1000.0 | 0.783 | 119 |
| q_nom | 0.0 | 0.0 | 0.0 | 119 |

### line ⚠

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| length | 0.0041 | 24.6 | 1.607 | 264 |

### linecode

| Parameter | Min | Max | CV | n |
|-----------|-----|-----|----|---|
| R_series_1_1 | 1.0e-6 | 0.0172 | 1.098 | 63 |

> 🟡 **[W.DIV.LOAD_SYMMETRIC]** 117 of 119 loads share identical (p_nom, q_nom) — possible copy-paste symmetry.
> 🔵 **[I.DIV.LINE_SYMMETRIC]** 5 lines share linecode 'busbar' with similar length (±10%) — electrically near-identical.
> 🔵 **[I.DIV.LINE_SYMMETRIC]** 3 lines share linecode 'cable_230v_0.03_al' with similar length (±10%) — electrically near-identical.
> 🔵 **[I.DIV.LINE_SYMMETRIC]** 4 lines share linecode 'cable_230v_0.04_cu' with similar length (±10%) — electrically near-identical.

## 5. Loading & Operational Summary

| | Value |
|--|-------|
| Total load P | 74.0 kW |
| Total load Q | 0.0 var |
| Total gen capacity | 0.0 W |
| Generation/load ratio | 0.0% |

**Transformer utilisation:**

| ID | Rating | Loading (est.) |
|----|--------|---------------:|
| dist_transformer_10148922_9108515 | 750.0 kVA | 9.9% |

> 🟡 **[W.OPS.IMPORT_DEPENDENT]** Network is heavily import-dependent: local generation capacity (0.0 MW) is less than 5% of total load (0.07 MW).
> 🟡 **[W.OPS.LINE_UNCONSTRAINED]** 1 of 264 lines have no thermal limit (i_max or s_max) — OPF thermal constraints will be missing.
> 🔵 **[I.OPR.UNLOADED_PHASE]** Galvanic zone anchored at bus 'sourcebus' has no load connected to phase terminal '1'.
> 🔵 **[I.OPR.UNLOADED_PHASE]** Galvanic zone anchored at bus 'sourcebus' has no load connected to phase terminal '2'.
> 🔵 **[I.OPR.UNLOADED_PHASE]** Galvanic zone anchored at bus 'sourcebus' has no load connected to phase terminal '3'.

## 6. Infeasibility Pre-flight

| Check | Result |
|-------|--------|
| Import dependent | true |
| Constraint conflicts | 0 |
| Buses without voltage bounds | 265 |
| Single point of failure | true |
| TPIA status | not_run |

> 🔵 **[I.PRE.NO_VOLT_BOUNDS]** 265 bus(es) have no voltage bounds — voltage will be unconstrained at these buses.
> 🔵 **[I.PRE.SINGLE_SOURCE]** Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.

## 7. Provenance & Model Conventions

**Inferred convention:** MV_6.4kV: mixed; LV_242V: mixed; implicit (Kron-style) grounding

| Voltage level | Wires | Buses with neutral |
|---------------|-------|-------------------:|
| MV_6.4kV | mixed | 1 / 2 |
| LV_242V | mixed | 89 / 263 |

| Neutral grounding | Value |
|-------------------|------:|
| Buses with neutral | 90 |
| Neutral branches | 0 |
| Grounding points | 90 |
| Neutral sections | 90 |
| Floating sections | 0 |

**Linecode impedance classification:**

| Verdict | Count |
|---------|------:|
| exactly_balanced | 16 |
| decoupled | 47 |

**OpenDSS default fingerprints:** 3 hit(s) — see findings

**Earthing system per galvanic zone:**

| Zone | Buses | Wires | Star point | Downstream earths | Likely system |
|------|------:|-------|------------|------------------:|---------------|
| 6.41 kV | 2 | ≤3-wire | solid | 0 | solidly earthed |
| 242.0 V | 263 | ≤3-wire | solid | 88 | indeterminate (3-wire / Kron-style implicit grounding) |

> 🔵 **[I.PROV.NEGATIVE_MUTUAL_R]** Linecode 'cable_230v_0.05_cu' has negative mutual resistance entries [(1, 2), (1, 3), (2, 3)] — unusual; Carson-derived matrices have positive mutuals.
> 🔵 **[I.PROV.NEGATIVE_MUTUAL_R]** Linecode 'cable_230v_185_al_wavef' has negative mutual resistance entries [(1, 2), (1, 3), (2, 3)] — unusual; Carson-derived matrices have positive mutuals.
> 🔵 **[I.PROV.NEGATIVE_MUTUAL_R]** Linecode 'default' has negative mutual resistance entries [(1, 2), (1, 3), (2, 3)] — unusual; Carson-derived matrices have positive mutuals.
> 🔵 **[I.PROV.NEGATIVE_MUTUAL_R]** Linecode 'unknown_lv_ohline_m' has negative mutual resistance entries [(1, 2), (1, 3), (2, 3)] — unusual; Carson-derived matrices have positive mutuals.
> 🔵 **[I.PROV.NEGATIVE_MUTUAL_R]** Linecode 'unknown_lv_cable_m' has negative mutual resistance entries [(1, 2), (1, 3), (2, 3)] — unusual; Carson-derived matrices have positive mutuals.
> 🔵 **[I.PROV.SEQ_DERIVED]** 16 linecode(s) have exactly balanced impedance matrices (equal self, equal mutual entries) — likely constructed from sequence parameters (r1,x1,r0,x0) or a transposition assumption, not from conductor geometry: cable_230v_0.05_cu, cable_230v_185_al_wavef, cable_230v_240_al_consac, cable_230v_25_al_acs, cable_230v_25_al_act, cable_230v_25_al_ascs, cable_230v_25_al_asct, cable_230v_300_al_wave, cable_230v_35_al_acs, cable_230v_35_al_act, cable_230v_35_al_ascs, cable_230v_35_al_asct, cable_230v_35_al_hybrid, default, unknown_lv_cable_m, unknown_lv_ohline_m.
> 🔵 **[I.PROV.DECOUPLED_PHASES]** 47 linecode(s) have zero mutual coupling (diagonal impedance matrix) — positive-sequence-only data; the phases decouple into independent single-phase networks: busbar, cable_230v_0.0125_al, cable_230v_0.0125_cu, cable_230v_0.0225_cu, cable_230v_0.025_cu, cable_230v_0.03_al, cable_230v_0.04_al, cable_230v_0.04_cu, cable_230v_0.06_al, cable_230v_0.06_cu, cable_230v_0.15_al, cable_230v_0.15_cu, cable_230v_0.1_al, cable_230v_0.1_cu, cable_230v_0.25_al, cable_230v_0.25_cu, cable_230v_0.2_al, cable_230v_0.2_cu, cable_230v_0.3_al, cable_230v_0.3_cu, cable_230v_0.5_al, cable_230v_0.5_cu, cable_230v_16_cu, cable_230v_185_al, cable_230v_185_al_wave, cable_230v_25_al, cable_230v_25_cu, cable_230v_25_cu_cscs, cable_230v_25_cu_csct, cable_230v_300_al_consac, cable_230v_300_cu, cable_230v_35_cu_ccs, cable_230v_35_cu_cct, cable_230v_35_cu_cscs, cable_230v_35_cu_csct, cable_230v_4_cu, cable_230v_95_al, cable_230v_95_cu, connector, ohl_230v_0.0225_ocu, ohl_230v_0.05_oal, ohl_230v_25_oal, ohl_230v_35_abc, ohl_230v_50_abc, ohl_230v_50_oal, unknown_lv_cable_s, unknown_lv_ohline_s.
> 🔵 **[I.PROV.NO_PI_SHUNT]** All 63 linecode(s) have no π-shunt admittance (G_from/B_from/G_to/B_to absent or zero) — the line model reduces to a series impedance only. Shunt capacitance is typically negligible for short LV cables but may be significant for long MV/HV lines.
> 🔵 **[I.PROV.DSS_DEFAULT_XFMR]** 1 transformer(s) have impedance matching the OpenDSS defaults — likely unspecified in the source: dist_transformer_10148922_9108515 (%r=0.2).
> 🔵 **[I.PROV.DSS_DEFAULT_LENGTH]** 2 of 264 line(s) have length exactly 1.0 among otherwise varied lengths — the OpenDSS default; these lengths were likely never set.
> 🔵 **[I.PROV.IMPEDANCE_TRANSFORM_KR]** 63 three-wire linecode(s) match the impedance signature of Kron reduction — neutral row/column eliminated from the original four-wire Carson impedance matrix via Schur complement. Exact when every neutral is perfectly grounded; approximate with finite grounding. Zero-sequence behaviour is not captured by the three-wire representation.: busbar, cable_230v_0.0125_al, cable_230v_0.0125_cu, cable_230v_0.0225_cu, cable_230v_0.025_cu, cable_230v_0.03_al, cable_230v_0.04_al, cable_230v_0.04_cu, cable_230v_0.05_cu, cable_230v_0.06_al, cable_230v_0.06_cu, cable_230v_0.15_al, cable_230v_0.15_cu, cable_230v_0.1_al, cable_230v_0.1_cu, cable_230v_0.25_al, cable_230v_0.25_cu, cable_230v_0.2_al, cable_230v_0.2_cu, cable_230v_0.3_al, cable_230v_0.3_cu, cable_230v_0.5_al, cable_230v_0.5_cu, cable_230v_16_cu, cable_230v_185_al, cable_230v_185_al_wave, cable_230v_185_al_wavef, cable_230v_240_al_consac, cable_230v_25_al, cable_230v_25_al_acs, cable_230v_25_al_act, cable_230v_25_al_ascs, cable_230v_25_al_asct, cable_230v_25_cu, cable_230v_25_cu_cscs, cable_230v_25_cu_csct, cable_230v_300_al_consac, cable_230v_300_al_wave, cable_230v_300_cu, cable_230v_35_al_acs, cable_230v_35_al_act, cable_230v_35_al_ascs, cable_230v_35_al_asct, cable_230v_35_al_hybrid, cable_230v_35_cu_ccs, cable_230v_35_cu_cct, cable_230v_35_cu_cscs, cable_230v_35_cu_csct, cable_230v_4_cu, cable_230v_95_al, cable_230v_95_cu, connector, default, ohl_230v_0.0225_ocu, ohl_230v_0.05_oal, ohl_230v_25_oal, ohl_230v_35_abc, ohl_230v_50_abc, ohl_230v_50_oal, unknown_lv_cable_m, unknown_lv_cable_s, unknown_lv_ohline_m, unknown_lv_ohline_s.

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
| Line impedance spread | 784000.0× |

| Benchmark readiness | Value |
|---------------------|------:|
| Objective well-posed | true |
| Only slack generation | true |
| Buses with \|V\| bounds | 0.0% |
| Buses with vpn / vpp / vpos bounds | 0 / 0 / 0 |
| Lines with thermal limits | 99.6% |
| Generators with no DOF (p\_min≈p\_max) | 0 |
| Generators with zero cost (dispatchable) | 0 |
| Same-cost generator pairs (≤1 hop) | 0 |
| Loads with zero p\_nom | 45 |

**Augmentation needed:**

- only slack generation — dispatch is trivial (loss minimisation); add dispatchable DERs with diverse costs and p/q bounds
- no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground)
- no phase-to-neutral or sequence voltage bounds (vpn_*/vpos_*) — sequence bounds also improve solver robustness for 4-wire OPF
- 1 of 264 lines lack thermal limits — add i_max/s_max (e.g. correlated with conductor cross-section)

> 🟡 **[W.INT.LOW_IMPEDANCE_LINE]** 15 line(s) have total series impedance below 10⁻³× the network median — they degrade NLP conditioning; model them as lossless switches: 11559424, 11559428, 11559434, 11559435, 11559440, 7214043, 7214058, 7236245, 7236246, 7355058, 7355059, 7355060, 7355061, 7368989, 7368994.

> 🟡 **[W.SPEC.CONFIG_ARITY]** generator 'slack_source': configuration WYE requires 4 terminal(s), terminal_map has 3.

> 🔵 **[I.BENCH.AUGMENTATION]** Case needs augmentation to be a non-trivial OPF benchmark: only slack generation — dispatch is trivial (loss minimisation); add dispatchable DERs with diverse costs and p/q bounds; no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground); no phase-to-neutral or sequence voltage bounds (vpn_*/vpos_*) — sequence bounds also improve solver robustness for 4-wire OPF; 1 of 264 lines lack thermal limits — add i_max/s_max (e.g. correlated with conductor cross-section).
> 🔵 **[I.BENCH.LOAD_ZERO_PNOM]** 45 load(s) have p_nom = 0 on all phases — these loads impose no real power demand: sop_x1_12934917_1, sop_x1_12934917_2, sop_x1_12934917_3, sop_x2_13363295_1, sop_x2_13363295_2, sop_x2_13363295_3, sop_x3_12934945_1, sop_x3_12934945_2, sop_x3_12934945_3, sop_x4_17655571_1, sop_x4_17655571_2, sop_x4_17655571_3, statcom_12725180_1, statcom_12725180_2, statcom_12725180_3, statcom_12934941_1, statcom_12934941_2, statcom_12934941_3, statcom_12958003_1, statcom_12958003_2, statcom_12958003_3, statcom_12969125_1, statcom_12969125_2, statcom_12969125_3, statcom_13435074_1, statcom_13435074_2, statcom_13435074_3, statcom_13435075_1, statcom_13435075_2, statcom_13435075_3, statcom_14756890_1, statcom_14756890_2, statcom_14756890_3, statcom_17855759_1, statcom_17855759_2, statcom_17855759_3, statcom_17874064_1, statcom_17874064_2, statcom_17874064_3, statcom_9369082_1, statcom_9369082_2, statcom_9369082_3, str_9108515_1, str_9108515_2, str_9108515_3.

## 9. Data Quality Summary

**Total findings:** 53 (1 errors, 26 warnings, 26 info)

### 🔴 Errors

- **[E.COMP.MISSING_REQUIRED]** `sourcez`  
  line 'sourcez' is missing required field(s): linecode.

### 🟡 Warnings

- **[W.CONN.MESHED]** `network`  
  Network contains 1 extra edge(s) forming cycles — not purely radial.
- **[W.CONN.DANGLING]** `bus`  
  31 bus(es) are degree-1 with no attached load, generator, or shunt.
- **[W.DIV.LOAD_SYMMETRIC]** `load`  
  117 of 119 loads share identical (p_nom, q_nom) — possible copy-paste symmetry.
- **[W.OPS.IMPORT_DEPENDENT]** `network`  
  Network is heavily import-dependent: local generation capacity (0.0 MW) is less than 5% of total load (0.07 MW).
- **[W.OPS.LINE_UNCONSTRAINED]** `line`  
  1 of 264 lines have no thermal limit (i_max or s_max) — OPF thermal constraints will be missing.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `7355059`  
  Line '7355059' has ||Z||_F = 9.31e-7 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `3165501`  
  Line '3165501' has ||Z||_F = 4.19e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `7368994`  
  Line '7368994' has ||Z||_F = 7.27e-7 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `11559424`  
  Line '11559424' has ||Z||_F = 4.26e-7 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `11559435`  
  Line '11559435' has ||Z||_F = 3.38e-7 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `11559428`  
  Line '11559428' has ||Z||_F = 2.18e-7 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `10699724`  
  Line '10699724' has ||Z||_F = 2.45e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `10703033`  
  Line '10703033' has ||Z||_F = 8.07e-5 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `7355061`  
  Line '7355061' has ||Z||_F = 1.06e-7 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `11559440`  
  Line '11559440' has ||Z||_F = 2.65e-7 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `7355060`  
  Line '7355060' has ||Z||_F = 8.62e-7 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `7368989`  
  Line '7368989' has ||Z||_F = 1.06e-7 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `11559434`  
  Line '11559434' has ||Z||_F = 2.18e-7 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `7236246`  
  Line '7236246' has ||Z||_F = 1.06e-7 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `7236245`  
  Line '7236245' has ||Z||_F = 7.91e-7 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `7355058`  
  Line '7355058' has ||Z||_F = 1.06e-7 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `7214043`  
  Line '7214043' has ||Z||_F = 1.06e-7 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.DOM.LINE_LOW_IMPEDANCE]** `7214058`  
  Line '7214058' has ||Z||_F = 6.61e-7 Ω < threshold 0.0001 Ω — near-zero series impedance; consider replacing with a switch object to avoid ill-conditioned KVL constraints.
- **[W.RED.ZERO_LOADS]** `load`  
  45 load(s) have p_nom=0 and q_nom=0 — electrically inert.
- **[W.INT.LOW_IMPEDANCE_LINE]** `line`  
  15 line(s) have total series impedance below 10⁻³× the network median — they degrade NLP conditioning; model them as lossless switches: 11559424, 11559428, 11559434, 11559435, 11559440, 7214043, 7214058, 7236245, 7236246, 7355058, 7355059, 7355060, 7355061, 7368989, 7368994.
- **[W.SPEC.CONFIG_ARITY]** `slack_source`  
  generator 'slack_source': configuration WYE requires 4 terminal(s), terminal_map has 3.

### 🔵 Info

- **[I.DIV.LINE_SYMMETRIC]** `line`  
  5 lines share linecode 'busbar' with similar length (±10%) — electrically near-identical.
- **[I.DIV.LINE_SYMMETRIC]** `line`  
  3 lines share linecode 'cable_230v_0.03_al' with similar length (±10%) — electrically near-identical.
- **[I.DIV.LINE_SYMMETRIC]** `line`  
  4 lines share linecode 'cable_230v_0.04_cu' with similar length (±10%) — electrically near-identical.
- **[I.OPR.UNLOADED_PHASE]** `network`  
  Galvanic zone anchored at bus 'sourcebus' has no load connected to phase terminal '1'.
- **[I.OPR.UNLOADED_PHASE]** `network`  
  Galvanic zone anchored at bus 'sourcebus' has no load connected to phase terminal '2'.
- **[I.OPR.UNLOADED_PHASE]** `network`  
  Galvanic zone anchored at bus 'sourcebus' has no load connected to phase terminal '3'.
- **[I.PROV.NEGATIVE_MUTUAL_R]** `cable_230v_0.05_cu`  
  Linecode 'cable_230v_0.05_cu' has negative mutual resistance entries [(1, 2), (1, 3), (2, 3)] — unusual; Carson-derived matrices have positive mutuals.
- **[I.PROV.NEGATIVE_MUTUAL_R]** `cable_230v_185_al_wavef`  
  Linecode 'cable_230v_185_al_wavef' has negative mutual resistance entries [(1, 2), (1, 3), (2, 3)] — unusual; Carson-derived matrices have positive mutuals.
- **[I.PROV.NEGATIVE_MUTUAL_R]** `default`  
  Linecode 'default' has negative mutual resistance entries [(1, 2), (1, 3), (2, 3)] — unusual; Carson-derived matrices have positive mutuals.
- **[I.PROV.NEGATIVE_MUTUAL_R]** `unknown_lv_ohline_m`  
  Linecode 'unknown_lv_ohline_m' has negative mutual resistance entries [(1, 2), (1, 3), (2, 3)] — unusual; Carson-derived matrices have positive mutuals.
- **[I.PROV.NEGATIVE_MUTUAL_R]** `unknown_lv_cable_m`  
  Linecode 'unknown_lv_cable_m' has negative mutual resistance entries [(1, 2), (1, 3), (2, 3)] — unusual; Carson-derived matrices have positive mutuals.
- **[I.PROV.SEQ_DERIVED]** `linecode`  
  16 linecode(s) have exactly balanced impedance matrices (equal self, equal mutual entries) — likely constructed from sequence parameters (r1,x1,r0,x0) or a transposition assumption, not from conductor geometry: cable_230v_0.05_cu, cable_230v_185_al_wavef, cable_230v_240_al_consac, cable_230v_25_al_acs, cable_230v_25_al_act, cable_230v_25_al_ascs, cable_230v_25_al_asct, cable_230v_300_al_wave, cable_230v_35_al_acs, cable_230v_35_al_act, cable_230v_35_al_ascs, cable_230v_35_al_asct, cable_230v_35_al_hybrid, default, unknown_lv_cable_m, unknown_lv_ohline_m.
- **[I.PROV.DECOUPLED_PHASES]** `linecode`  
  47 linecode(s) have zero mutual coupling (diagonal impedance matrix) — positive-sequence-only data; the phases decouple into independent single-phase networks: busbar, cable_230v_0.0125_al, cable_230v_0.0125_cu, cable_230v_0.0225_cu, cable_230v_0.025_cu, cable_230v_0.03_al, cable_230v_0.04_al, cable_230v_0.04_cu, cable_230v_0.06_al, cable_230v_0.06_cu, cable_230v_0.15_al, cable_230v_0.15_cu, cable_230v_0.1_al, cable_230v_0.1_cu, cable_230v_0.25_al, cable_230v_0.25_cu, cable_230v_0.2_al, cable_230v_0.2_cu, cable_230v_0.3_al, cable_230v_0.3_cu, cable_230v_0.5_al, cable_230v_0.5_cu, cable_230v_16_cu, cable_230v_185_al, cable_230v_185_al_wave, cable_230v_25_al, cable_230v_25_cu, cable_230v_25_cu_cscs, cable_230v_25_cu_csct, cable_230v_300_al_consac, cable_230v_300_cu, cable_230v_35_cu_ccs, cable_230v_35_cu_cct, cable_230v_35_cu_cscs, cable_230v_35_cu_csct, cable_230v_4_cu, cable_230v_95_al, cable_230v_95_cu, connector, ohl_230v_0.0225_ocu, ohl_230v_0.05_oal, ohl_230v_25_oal, ohl_230v_35_abc, ohl_230v_50_abc, ohl_230v_50_oal, unknown_lv_cable_s, unknown_lv_ohline_s.
- **[I.PROV.NO_PI_SHUNT]** `linecode`  
  All 63 linecode(s) have no π-shunt admittance (G_from/B_from/G_to/B_to absent or zero) — the line model reduces to a series impedance only. Shunt capacitance is typically negligible for short LV cables but may be significant for long MV/HV lines.
- **[I.PROV.DSS_DEFAULT_XFMR]** `transformer`  
  1 transformer(s) have impedance matching the OpenDSS defaults — likely unspecified in the source: dist_transformer_10148922_9108515 (%r=0.2).
- **[I.PROV.DSS_DEFAULT_LENGTH]** `line`  
  2 of 264 line(s) have length exactly 1.0 among otherwise varied lengths — the OpenDSS default; these lengths were likely never set.
- **[I.PROV.IMPEDANCE_TRANSFORM_KR]** `linecode`  
  63 three-wire linecode(s) match the impedance signature of Kron reduction — neutral row/column eliminated from the original four-wire Carson impedance matrix via Schur complement. Exact when every neutral is perfectly grounded; approximate with finite grounding. Zero-sequence behaviour is not captured by the three-wire representation.: busbar, cable_230v_0.0125_al, cable_230v_0.0125_cu, cable_230v_0.0225_cu, cable_230v_0.025_cu, cable_230v_0.03_al, cable_230v_0.04_al, cable_230v_0.04_cu, cable_230v_0.05_cu, cable_230v_0.06_al, cable_230v_0.06_cu, cable_230v_0.15_al, cable_230v_0.15_cu, cable_230v_0.1_al, cable_230v_0.1_cu, cable_230v_0.25_al, cable_230v_0.25_cu, cable_230v_0.2_al, cable_230v_0.2_cu, cable_230v_0.3_al, cable_230v_0.3_cu, cable_230v_0.5_al, cable_230v_0.5_cu, cable_230v_16_cu, cable_230v_185_al, cable_230v_185_al_wave, cable_230v_185_al_wavef, cable_230v_240_al_consac, cable_230v_25_al, cable_230v_25_al_acs, cable_230v_25_al_act, cable_230v_25_al_ascs, cable_230v_25_al_asct, cable_230v_25_cu, cable_230v_25_cu_cscs, cable_230v_25_cu_csct, cable_230v_300_al_consac, cable_230v_300_al_wave, cable_230v_300_cu, cable_230v_35_al_acs, cable_230v_35_al_act, cable_230v_35_al_ascs, cable_230v_35_al_asct, cable_230v_35_al_hybrid, cable_230v_35_cu_ccs, cable_230v_35_cu_cct, cable_230v_35_cu_cscs, cable_230v_35_cu_csct, cable_230v_4_cu, cable_230v_95_al, cable_230v_95_cu, connector, default, ohl_230v_0.0225_ocu, ohl_230v_0.05_oal, ohl_230v_25_oal, ohl_230v_35_abc, ohl_230v_50_abc, ohl_230v_50_oal, unknown_lv_cable_m, unknown_lv_cable_s, unknown_lv_ohline_m, unknown_lv_ohline_s.
- **[I.PRE.NO_VOLT_BOUNDS]** `bus`  
  265 bus(es) have no voltage bounds — voltage will be unconstrained at these buses.
- **[I.PRE.SINGLE_SOURCE]** `network`  
  Network has a single voltage source — single point of failure. Infeasibility of the source makes the entire network infeasible.
- **[I.SCHEMA.UNKNOWN_FIELDS]** `network`  
  meta has field(s) not in the BMOPF schema: reference, source.
- **[I.DOM.LINE_IMPEDANCE_SPREAD]** `line`  
  Adjacent lines '3246478' and '7214058' at bus '17636403' have ||Z||_F ratio 1430.0× — large impedance contrasts between neighbouring lines cause ill-conditioned KKT Jacobians; consider per-unit scaling or network reformulation.
- **[I.RED.MERGEABLE_LINES]** `line`  
  36 group(s) of series lines (98 lines total) can be merged — intermediate buses have no other connections.
- **[I.RED.UNUSED_LINECODES]** `linecode`  
  35 linecode(s) defined but not referenced by any line.
- **[I.RED.DUPLICATE_LINECODES]** `linecode`  
  8 group(s) of linecodes share identical R_series_1_1/X_series_1_1.
- **[I.BENCH.AUGMENTATION]** `network`  
  Case needs augmentation to be a non-trivial OPF benchmark: only slack generation — dispatch is trivial (loss minimisation); add dispatchable DERs with diverse costs and p/q bounds; no voltage magnitude bounds on any bus — voltage is unconstrained; add v_min/v_max (phase-to-ground); no phase-to-neutral or sequence voltage bounds (vpn_*/vpos_*) — sequence bounds also improve solver robustness for 4-wire OPF; 1 of 264 lines lack thermal limits — add i_max/s_max (e.g. correlated with conductor cross-section).
- **[I.BENCH.LOAD_ZERO_PNOM]** `load`  
  45 load(s) have p_nom = 0 on all phases — these loads impose no real power demand: sop_x1_12934917_1, sop_x1_12934917_2, sop_x1_12934917_3, sop_x2_13363295_1, sop_x2_13363295_2, sop_x2_13363295_3, sop_x3_12934945_1, sop_x3_12934945_2, sop_x3_12934945_3, sop_x4_17655571_1, sop_x4_17655571_2, sop_x4_17655571_3, statcom_12725180_1, statcom_12725180_2, statcom_12725180_3, statcom_12934941_1, statcom_12934941_2, statcom_12934941_3, statcom_12958003_1, statcom_12958003_2, statcom_12958003_3, statcom_12969125_1, statcom_12969125_2, statcom_12969125_3, statcom_13435074_1, statcom_13435074_2, statcom_13435074_3, statcom_13435075_1, statcom_13435075_2, statcom_13435075_3, statcom_14756890_1, statcom_14756890_2, statcom_14756890_3, statcom_17855759_1, statcom_17855759_2, statcom_17855759_3, statcom_17874064_1, statcom_17874064_2, statcom_17874064_3, statcom_9369082_1, statcom_9369082_2, statcom_9369082_3, str_9108515_1, str_9108515_2, str_9108515_3.

