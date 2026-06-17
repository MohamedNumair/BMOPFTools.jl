# BMOPF Solution Profile: network_3_Feeder_2

**Generated:** 2026-06-18 07:11:45  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 9.7094  
**Solve time:** 0.134 s  
**Findings:** 0 errors · 18 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 60.742 kW |
| Total load | 59.759 kW |
| Total line losses | 2.297 kW |
| Loss fraction | 3.8% |
| Power balance error | 1.314 kW |
| Max neutral shift | 4.372 V (bus `797`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 17 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_922` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_991` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_604` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_847` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_913` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_650` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_652` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_635` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_600` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_108` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_143` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_731` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_115` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_797` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_538` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_126` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_154` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 1.314 kW (>1 % of load). pg=60.74 kW, pd=59.76 kW, p_loss=2.3 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_922`  
  Generator 'der_922' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_991`  
  Generator 'der_991' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_604`  
  Generator 'der_604' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_847`  
  Generator 'der_847' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_913`  
  Generator 'der_913' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_650`  
  Generator 'der_650' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_652`  
  Generator 'der_652' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_635`  
  Generator 'der_635' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_600`  
  Generator 'der_600' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_108`  
  Generator 'der_108' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_143`  
  Generator 'der_143' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_731`  
  Generator 'der_731' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_115`  
  Generator 'der_115' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_797`  
  Generator 'der_797' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_538`  
  Generator 'der_538' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_126`  
  Generator 'der_126' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_154`  
  Generator 'der_154' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 1.314 kW (>1 % of load). pg=60.74 kW, pd=59.76 kW, p_loss=2.3 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 17 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 17A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 4.37 V at bus '797' — reflects the neutral shift under unbalanced loading.

