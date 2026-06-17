# BMOPF Solution Profile: network_23_Feeder_1

**Generated:** 2026-06-18 07:11:41  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 11.9356  
**Solve time:** 0.519 s  
**Findings:** 0 errors · 28 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 98.819 kW |
| Total load | 98.272 kW |
| Total line losses | 952.07 W |
| Loss fraction | 1.0% |
| Power balance error | 404.21 W |
| Max neutral shift | 1.478 V (bus `818`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 28 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_1229` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_236` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1278` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_793` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1231` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1011` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1261` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1240` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_142` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1025` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_303` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_875` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_133` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_216` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_818` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_235` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_801` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1010` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1269` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1029` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_754` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_889` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_383` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1028` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1199` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_558` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_144` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_370` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1229`  
  Generator 'der_1229' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_236`  
  Generator 'der_236' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1278`  
  Generator 'der_1278' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_793`  
  Generator 'der_793' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1231`  
  Generator 'der_1231' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1011`  
  Generator 'der_1011' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1261`  
  Generator 'der_1261' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1240`  
  Generator 'der_1240' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_142`  
  Generator 'der_142' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1025`  
  Generator 'der_1025' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_303`  
  Generator 'der_303' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_875`  
  Generator 'der_875' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_133`  
  Generator 'der_133' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_216`  
  Generator 'der_216' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_818`  
  Generator 'der_818' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_235`  
  Generator 'der_235' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_801`  
  Generator 'der_801' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1010`  
  Generator 'der_1010' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1269`  
  Generator 'der_1269' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1029`  
  Generator 'der_1029' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_754`  
  Generator 'der_754' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_889`  
  Generator 'der_889' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_383`  
  Generator 'der_383' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1028`  
  Generator 'der_1028' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1199`  
  Generator 'der_1199' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_558`  
  Generator 'der_558' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_144`  
  Generator 'der_144' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_370`  
  Generator 'der_370' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 28 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 28A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.48 V at bus '818' — reflects the neutral shift under unbalanced loading.

