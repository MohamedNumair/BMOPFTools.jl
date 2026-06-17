# BMOPF Solution Profile: network_7_Feeder_7

**Generated:** 2026-06-18 07:11:50  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 2.2507  
**Solve time:** 0.03 s  
**Findings:** 0 errors · 7 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 21.057 kW |
| Total load | 20.868 kW |
| Total line losses | 553.1 W |
| Loss fraction | 2.7% |
| Power balance error | 364.53 W |
| Max neutral shift | 1.643 V (bus `337`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 6 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_337` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_186` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_237` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_90` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_137` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_179` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 364.53 W (>1 % of load). pg=21.06 kW, pd=20.87 kW, p_loss=0.55 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_337`  
  Generator 'der_337' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_186`  
  Generator 'der_186' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_237`  
  Generator 'der_237' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_90`  
  Generator 'der_90' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_137`  
  Generator 'der_137' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_179`  
  Generator 'der_179' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 364.53 W (>1 % of load). pg=21.06 kW, pd=20.87 kW, p_loss=0.55 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 6 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 6A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.64 V at bus '337' — reflects the neutral shift under unbalanced loading.

