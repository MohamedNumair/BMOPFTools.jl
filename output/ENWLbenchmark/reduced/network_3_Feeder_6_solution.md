# BMOPF Solution Profile: network_3_Feeder_6

**Generated:** 2026-06-18 09:29:48  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 10.2159  
**Solve time:** 0.36 s  
**Findings:** 0 errors · 14 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 50.55 kW |
| Total load | 49.825 kW |
| Total line losses | 1.581 kW |
| Loss fraction | 3.2% |
| Power balance error | 856.14 W |
| Max neutral shift | 3.269 V (bus `554`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 13 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_521` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_305` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_313` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_301` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_635` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_494` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_578` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_383` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_593` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_134` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_315` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_40` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_519` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 856.14 W (>1 % of load). pg=50.55 kW, pd=49.83 kW, p_loss=1.58 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_521`  
  Generator 'der_521' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_305`  
  Generator 'der_305' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_313`  
  Generator 'der_313' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_301`  
  Generator 'der_301' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_635`  
  Generator 'der_635' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_494`  
  Generator 'der_494' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_578`  
  Generator 'der_578' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_383`  
  Generator 'der_383' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_593`  
  Generator 'der_593' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_134`  
  Generator 'der_134' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_315`  
  Generator 'der_315' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_40`  
  Generator 'der_40' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_519`  
  Generator 'der_519' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 856.14 W (>1 % of load). pg=50.55 kW, pd=49.83 kW, p_loss=1.58 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 13 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 13A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 3.27 V at bus '554' — reflects the neutral shift under unbalanced loading.

