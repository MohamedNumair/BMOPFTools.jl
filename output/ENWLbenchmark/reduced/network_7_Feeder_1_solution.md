# BMOPF Solution Profile: network_7_Feeder_1

**Generated:** 2026-06-18 09:29:51  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 9.3243  
**Solve time:** 0.392 s  
**Findings:** 0 errors · 19 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 61.9 kW |
| Total load | 60.581 kW |
| Total line losses | 2.403 kW |
| Loss fraction | 4.0% |
| Power balance error | 1.084 kW |
| Max neutral shift | 4.423 V (bus `491`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 18 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_303` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_264` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_290` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_438` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_919` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_592` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_954` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_891` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_580` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_233` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_415` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_81` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_842` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_392` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_503` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_512` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_558` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_77` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 1.084 kW (>1 % of load). pg=61.9 kW, pd=60.58 kW, p_loss=2.4 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_303`  
  Generator 'der_303' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_264`  
  Generator 'der_264' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_290`  
  Generator 'der_290' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_438`  
  Generator 'der_438' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_919`  
  Generator 'der_919' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_592`  
  Generator 'der_592' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_954`  
  Generator 'der_954' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_891`  
  Generator 'der_891' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_580`  
  Generator 'der_580' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_233`  
  Generator 'der_233' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_415`  
  Generator 'der_415' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_81`  
  Generator 'der_81' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_842`  
  Generator 'der_842' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_392`  
  Generator 'der_392' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_503`  
  Generator 'der_503' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_512`  
  Generator 'der_512' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_558`  
  Generator 'der_558' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_77`  
  Generator 'der_77' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 1.084 kW (>1 % of load). pg=61.9 kW, pd=60.58 kW, p_loss=2.4 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 18 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 18A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 4.42 V at bus '491' — reflects the neutral shift under unbalanced loading.

