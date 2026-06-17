# BMOPF Solution Profile: network_16_Feeder_3

**Generated:** 2026-06-18 07:11:29  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 13.0849  
**Solve time:** 0.193 s  
**Findings:** 0 errors · 17 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 60.294 kW |
| Total load | 59.759 kW |
| Total line losses | 1.114 kW |
| Loss fraction | 1.9% |
| Power balance error | 579.45 W |
| Max neutral shift | 1.847 V (bus `1079`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 17 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_408` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1347` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1205` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1339` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1089` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1101` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_396` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_363` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1327` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_901` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1137` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1079` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1090` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1234` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1071` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_302` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_317` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_408`  
  Generator 'der_408' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1347`  
  Generator 'der_1347' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1205`  
  Generator 'der_1205' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1339`  
  Generator 'der_1339' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1089`  
  Generator 'der_1089' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1101`  
  Generator 'der_1101' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_396`  
  Generator 'der_396' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_363`  
  Generator 'der_363' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1327`  
  Generator 'der_1327' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_901`  
  Generator 'der_901' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1137`  
  Generator 'der_1137' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1079`  
  Generator 'der_1079' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1090`  
  Generator 'der_1090' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1234`  
  Generator 'der_1234' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1071`  
  Generator 'der_1071' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_302`  
  Generator 'der_302' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_317`  
  Generator 'der_317' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 17 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 17A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.85 V at bus '1079' — reflects the neutral shift under unbalanced loading.

