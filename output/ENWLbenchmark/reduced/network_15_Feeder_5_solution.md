# BMOPF Solution Profile: network_15_Feeder_5

**Generated:** 2026-06-18 07:11:27  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 3.23  
**Solve time:** 0.066 s  
**Findings:** 0 errors · 7 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 21.386 kW |
| Total load | 21.114 kW |
| Total line losses | 663.1 W |
| Loss fraction | 3.1% |
| Power balance error | 390.8 W |
| Max neutral shift | 2.592 V (bus `1186`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 6 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_987` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_496` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1186` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_461` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_856` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_192` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 390.8 W (>1 % of load). pg=21.39 kW, pd=21.11 kW, p_loss=0.66 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_987`  
  Generator 'der_987' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_496`  
  Generator 'der_496' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1186`  
  Generator 'der_1186' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_461`  
  Generator 'der_461' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_856`  
  Generator 'der_856' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_192`  
  Generator 'der_192' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 390.8 W (>1 % of load). pg=21.39 kW, pd=21.11 kW, p_loss=0.66 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 6 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 6A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.59 V at bus '1186' — reflects the neutral shift under unbalanced loading.

