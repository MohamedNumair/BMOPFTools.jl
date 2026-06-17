# BMOPF Solution Profile: network_22_Feeder_6

**Generated:** 2026-06-18 07:11:41  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 3.0301  
**Solve time:** 0.07 s  
**Findings:** 0 errors · 11 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 30.427 kW |
| Total load | 30.079 kW |
| Total line losses | 670.58 W |
| Loss fraction | 2.2% |
| Power balance error | 322.86 W |
| Max neutral shift | 2.385 V (bus `601`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 10 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_601` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_196` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_286` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_437` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_600` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_434` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_86` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_545` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_258` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_85` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 322.86 W (>1 % of load). pg=30.43 kW, pd=30.08 kW, p_loss=0.67 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_601`  
  Generator 'der_601' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_196`  
  Generator 'der_196' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_286`  
  Generator 'der_286' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_437`  
  Generator 'der_437' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_600`  
  Generator 'der_600' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_434`  
  Generator 'der_434' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_86`  
  Generator 'der_86' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_545`  
  Generator 'der_545' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_258`  
  Generator 'der_258' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_85`  
  Generator 'der_85' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 322.86 W (>1 % of load). pg=30.43 kW, pd=30.08 kW, p_loss=0.67 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 10 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 10A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.39 V at bus '601' — reflects the neutral shift under unbalanced loading.

