# BMOPF Solution Profile: network_5_Feeder_6

**Generated:** 2026-06-18 09:29:49  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 3.2707  
**Solve time:** 0.029 s  
**Findings:** 0 errors · 6 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 17.298 kW |
| Total load | 17.034 kW |
| Total line losses | 505.69 W |
| Loss fraction | 3.0% |
| Power balance error | 242.16 W |
| Max neutral shift | 2.131 V (bus `333`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 5 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_292` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_321` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_343` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_87` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_333` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 242.16 W (>1 % of load). pg=17.3 kW, pd=17.03 kW, p_loss=0.51 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_292`  
  Generator 'der_292' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_321`  
  Generator 'der_321' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_343`  
  Generator 'der_343' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_87`  
  Generator 'der_87' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_333`  
  Generator 'der_333' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 242.16 W (>1 % of load). pg=17.3 kW, pd=17.03 kW, p_loss=0.51 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 5 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 5A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.13 V at bus '333' — reflects the neutral shift under unbalanced loading.

