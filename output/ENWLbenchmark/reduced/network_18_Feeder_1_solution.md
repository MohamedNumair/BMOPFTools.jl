# BMOPF Solution Profile: network_18_Feeder_1

**Generated:** 2026-06-18 07:11:36  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 10.7825  
**Solve time:** 0.122 s  
**Findings:** 0 errors · 15 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 53.38 kW |
| Total load | 52.745 kW |
| Total line losses | 1.266 kW |
| Loss fraction | 2.4% |
| Power balance error | 630.49 W |
| Max neutral shift | 3.098 V (bus `1346`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 14 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_401` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_230` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1314` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_960` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_896` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1346` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_799` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_119` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_821` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_918` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1311` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1154` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1401` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1174` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 630.49 W (>1 % of load). pg=53.38 kW, pd=52.74 kW, p_loss=1.27 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_401`  
  Generator 'der_401' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_230`  
  Generator 'der_230' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1314`  
  Generator 'der_1314' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_960`  
  Generator 'der_960' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_896`  
  Generator 'der_896' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1346`  
  Generator 'der_1346' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_799`  
  Generator 'der_799' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_119`  
  Generator 'der_119' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_821`  
  Generator 'der_821' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_918`  
  Generator 'der_918' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1311`  
  Generator 'der_1311' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1154`  
  Generator 'der_1154' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1401`  
  Generator 'der_1401' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1174`  
  Generator 'der_1174' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 630.49 W (>1 % of load). pg=53.38 kW, pd=52.74 kW, p_loss=1.27 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 14 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 14A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 3.1 V at bus '1346' — reflects the neutral shift under unbalanced loading.

