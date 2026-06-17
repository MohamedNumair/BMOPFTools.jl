# BMOPF Solution Profile: network_18_Feeder_3

**Generated:** 2026-06-18 07:11:37  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 14.5631  
**Solve time:** 0.173 s  
**Findings:** 0 errors · 14 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 50.92 kW |
| Total load | 50.473 kW |
| Total line losses | 983.52 W |
| Loss fraction | 1.9% |
| Power balance error | 537.0 W |
| Max neutral shift | 2.549 V (bus `1209`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 13 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_1452` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_785` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_426` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_719` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_225` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1001` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_808` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1086` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1084` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1192` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1456` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1063` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1188` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 537.0 W (>1 % of load). pg=50.92 kW, pd=50.47 kW, p_loss=0.98 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1452`  
  Generator 'der_1452' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_785`  
  Generator 'der_785' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_426`  
  Generator 'der_426' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_719`  
  Generator 'der_719' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_225`  
  Generator 'der_225' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1001`  
  Generator 'der_1001' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_808`  
  Generator 'der_808' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1086`  
  Generator 'der_1086' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1084`  
  Generator 'der_1084' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1192`  
  Generator 'der_1192' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1456`  
  Generator 'der_1456' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1063`  
  Generator 'der_1063' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1188`  
  Generator 'der_1188' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 537.0 W (>1 % of load). pg=50.92 kW, pd=50.47 kW, p_loss=0.98 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 13 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 13A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.55 V at bus '1209' — reflects the neutral shift under unbalanced loading.

