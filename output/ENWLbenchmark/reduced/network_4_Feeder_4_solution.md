# BMOPF Solution Profile: network_4_Feeder_4

**Generated:** 2026-06-18 09:29:48  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 17.7735  
**Solve time:** 0.262 s  
**Findings:** 0 errors · 22 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 77.925 kW |
| Total load | 77.221 kW |
| Total line losses | 1.555 kW |
| Loss fraction | 2.0% |
| Power balance error | 851.07 W |
| Max neutral shift | 2.651 V (bus `1155`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 21 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_1041` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_767` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1179` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_941` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_684` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1204` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_75` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_517` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1132` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_593` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1055` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_140` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_858` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1223` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1138` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_725` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1196` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_486` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1085` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_195` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_606` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 851.07 W (>1 % of load). pg=77.92 kW, pd=77.22 kW, p_loss=1.55 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1041`  
  Generator 'der_1041' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_767`  
  Generator 'der_767' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1179`  
  Generator 'der_1179' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_941`  
  Generator 'der_941' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_684`  
  Generator 'der_684' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1204`  
  Generator 'der_1204' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_75`  
  Generator 'der_75' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_517`  
  Generator 'der_517' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1132`  
  Generator 'der_1132' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_593`  
  Generator 'der_593' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1055`  
  Generator 'der_1055' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_140`  
  Generator 'der_140' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_858`  
  Generator 'der_858' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1223`  
  Generator 'der_1223' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1138`  
  Generator 'der_1138' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_725`  
  Generator 'der_725' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1196`  
  Generator 'der_1196' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_486`  
  Generator 'der_486' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1085`  
  Generator 'der_1085' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_195`  
  Generator 'der_195' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_606`  
  Generator 'der_606' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 851.07 W (>1 % of load). pg=77.92 kW, pd=77.22 kW, p_loss=1.55 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 21 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 21A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.65 V at bus '1155' — reflects the neutral shift under unbalanced loading.

