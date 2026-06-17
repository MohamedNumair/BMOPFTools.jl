# BMOPF Solution Profile: network_18_Feeder_6

**Generated:** 2026-06-18 07:11:37  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 2.4346  
**Solve time:** 0.037 s  
**Findings:** 0 errors · 7 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 21.058 kW |
| Total load | 20.868 kW |
| Total line losses | 609.0 W |
| Loss fraction | 2.9% |
| Power balance error | 419.11 W |
| Max neutral shift | 1.392 V (bus `509`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 6 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_509` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_272` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_399` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_392` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_124` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_442` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 419.11 W (>1 % of load). pg=21.06 kW, pd=20.87 kW, p_loss=0.61 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_509`  
  Generator 'der_509' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_272`  
  Generator 'der_272' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_399`  
  Generator 'der_399' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_392`  
  Generator 'der_392' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_124`  
  Generator 'der_124' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_442`  
  Generator 'der_442' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 419.11 W (>1 % of load). pg=21.06 kW, pd=20.87 kW, p_loss=0.61 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 6 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 6A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.39 V at bus '509' — reflects the neutral shift under unbalanced loading.

