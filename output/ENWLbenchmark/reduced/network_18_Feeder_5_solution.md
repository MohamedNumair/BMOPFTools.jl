# BMOPF Solution Profile: network_18_Feeder_5

**Generated:** 2026-06-18 09:29:37  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 6.2653  
**Solve time:** 0.081 s  
**Findings:** 0 errors · 12 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 41.336 kW |
| Total load | 40.819 kW |
| Total line losses | 1.511 kW |
| Loss fraction | 3.7% |
| Power balance error | 994.67 W |
| Max neutral shift | 3.205 V (bus `953`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 11 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_495` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_897` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_976` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_610` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_111` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_184` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_516` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_40` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_729` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_368` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_849` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 994.67 W (>1 % of load). pg=41.34 kW, pd=40.82 kW, p_loss=1.51 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_495`  
  Generator 'der_495' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_897`  
  Generator 'der_897' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_976`  
  Generator 'der_976' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_610`  
  Generator 'der_610' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_111`  
  Generator 'der_111' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_184`  
  Generator 'der_184' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_516`  
  Generator 'der_516' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_40`  
  Generator 'der_40' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_729`  
  Generator 'der_729' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_368`  
  Generator 'der_368' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_849`  
  Generator 'der_849' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 994.67 W (>1 % of load). pg=41.34 kW, pd=40.82 kW, p_loss=1.51 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 11 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 11A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 3.2 V at bus '953' — reflects the neutral shift under unbalanced loading.

