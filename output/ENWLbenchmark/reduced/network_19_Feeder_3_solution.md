# BMOPF Solution Profile: network_19_Feeder_3

**Generated:** 2026-06-18 07:11:38  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 8.336  
**Solve time:** 0.183 s  
**Findings:** 0 errors · 18 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 59.81 kW |
| Total load | 58.805 kW |
| Total line losses | 2.354 kW |
| Loss fraction | 4.0% |
| Power balance error | 1.349 kW |
| Max neutral shift | 4.231 V (bus `1331`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 17 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_963` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1300` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_823` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1275` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1004` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1331` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1390` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1010` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_831` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1252` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_527` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_880` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_542` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1071` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_449` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_429` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1188` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 1.349 kW (>1 % of load). pg=59.81 kW, pd=58.8 kW, p_loss=2.35 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_963`  
  Generator 'der_963' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1300`  
  Generator 'der_1300' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_823`  
  Generator 'der_823' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1275`  
  Generator 'der_1275' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1004`  
  Generator 'der_1004' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1331`  
  Generator 'der_1331' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1390`  
  Generator 'der_1390' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1010`  
  Generator 'der_1010' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_831`  
  Generator 'der_831' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1252`  
  Generator 'der_1252' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_527`  
  Generator 'der_527' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_880`  
  Generator 'der_880' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_542`  
  Generator 'der_542' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1071`  
  Generator 'der_1071' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_449`  
  Generator 'der_449' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_429`  
  Generator 'der_429' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1188`  
  Generator 'der_1188' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 1.349 kW (>1 % of load). pg=59.81 kW, pd=58.8 kW, p_loss=2.35 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 17 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 17A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 4.23 V at bus '1331' — reflects the neutral shift under unbalanced loading.

