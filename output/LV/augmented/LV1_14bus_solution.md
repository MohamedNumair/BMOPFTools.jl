# BMOPF Solution Profile: LV1_14bus

**Generated:** 2026-06-21 16:06:21  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -19500.0349  
**Solve time:** 0.01 s  
**Findings:** 5 errors · 1 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 27.0 kW |
| Total load | 20.0 kW |
| Total line losses | 30.09 W |
| Loss fraction | 0.2% |
| Power balance error | 6.97 kW |
| Max neutral shift | 0.255 V (bus `b2656`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 5 | 0 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| **E** | `der_bat` | `1` | pg | 5.0 kW | [0.0 W, 5.0 kW] |
| **E** | `der_bat` | `2` | pg | 5.0 kW | [0.0 W, 5.0 kW] |
| **E** | `der_bat` | `3` | pg | 5.0 kW | [0.0 W, 5.0 kW] |
| **E** | `der_pv_b` | `2` | pg | 6.0 kW | [0.0 W, 6.0 kW] |
| **E** | `der_pv_a` | `1` | pg | 6.0 kW | [0.0 W, 6.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 6.97 kW (>1 % of load). pg=27.0 kW, pd=20.0 kW, p_loss=0.03 kW.

## 6. All Findings

- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`der_bat`  
  Generator 'der_bat' phase '1': pg=5.0 kW violates [0.0 W, 5.0 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`der_bat`  
  Generator 'der_bat' phase '2': pg=5.0 kW violates [0.0 W, 5.0 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`der_bat`  
  Generator 'der_bat' phase '3': pg=5.0 kW violates [0.0 W, 5.0 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`der_pv_b`  
  Generator 'der_pv_b' phase '2': pg=6.0 kW violates [0.0 W, 6.0 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`der_pv_a`  
  Generator 'der_pv_a' phase '1': pg=6.0 kW violates [0.0 W, 6.0 kW].
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 6.97 kW (>1 % of load). pg=27.0 kW, pd=20.0 kW, p_loss=0.03 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 5 violation(s), 0 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 5V / 0A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.26 V at bus 'b2656' — reflects the neutral shift under unbalanced loading.

