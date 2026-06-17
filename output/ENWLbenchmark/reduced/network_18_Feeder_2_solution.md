# BMOPF Solution Profile: network_18_Feeder_2

**Generated:** 2026-06-18 07:11:36  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 4.6876  
**Solve time:** 0.33 s  
**Findings:** 0 errors · 7 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 23.282 kW |
| Total load | 23.07 kW |
| Total line losses | 541.73 W |
| Loss fraction | 2.3% |
| Power balance error | 329.92 W |
| Max neutral shift | 2.27 V (bus `908`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 6 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_982` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_909` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_908` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_614` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_990` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_843` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 329.92 W (>1 % of load). pg=23.28 kW, pd=23.07 kW, p_loss=0.54 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_982`  
  Generator 'der_982' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_909`  
  Generator 'der_909' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_908`  
  Generator 'der_908' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_614`  
  Generator 'der_614' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_990`  
  Generator 'der_990' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_843`  
  Generator 'der_843' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 329.92 W (>1 % of load). pg=23.28 kW, pd=23.07 kW, p_loss=0.54 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 6 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 6A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.27 V at bus '908' — reflects the neutral shift under unbalanced loading.

