# BMOPF Solution Profile: network_15_Feeder_6

**Generated:** 2026-06-18 09:29:26  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 13.1146  
**Solve time:** 0.277 s  
**Findings:** 0 errors · 17 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 60.453 kW |
| Total load | 59.759 kW |
| Total line losses | 1.278 kW |
| Loss fraction | 2.1% |
| Power balance error | 583.76 W |
| Max neutral shift | 2.62 V (bus `1613`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 17 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_279` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_236` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1518` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1636` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1370` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1613` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1283` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_283` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1178` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_213` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1189` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1566` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1121` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1058` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1445` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_195` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1110` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_279`  
  Generator 'der_279' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_236`  
  Generator 'der_236' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1518`  
  Generator 'der_1518' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1636`  
  Generator 'der_1636' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1370`  
  Generator 'der_1370' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1613`  
  Generator 'der_1613' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1283`  
  Generator 'der_1283' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_283`  
  Generator 'der_283' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1178`  
  Generator 'der_1178' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_213`  
  Generator 'der_213' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1189`  
  Generator 'der_1189' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1566`  
  Generator 'der_1566' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1121`  
  Generator 'der_1121' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1058`  
  Generator 'der_1058' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1445`  
  Generator 'der_1445' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_195`  
  Generator 'der_195' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1110`  
  Generator 'der_1110' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 17 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 17A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.62 V at bus '1613' — reflects the neutral shift under unbalanced loading.

