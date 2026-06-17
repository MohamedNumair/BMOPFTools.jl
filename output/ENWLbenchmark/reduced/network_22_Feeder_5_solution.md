# BMOPF Solution Profile: network_22_Feeder_5

**Generated:** 2026-06-18 09:29:42  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 1.0934  
**Solve time:** 0.063 s  
**Findings:** 0 errors · 9 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 24.925 kW |
| Total load | 24.594 kW |
| Total line losses | 651.94 W |
| Loss fraction | 2.7% |
| Power balance error | 320.56 W |
| Max neutral shift | 2.311 V (bus `560`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 8 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_454` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_194` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_276` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_615` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_539` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_443` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_424` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_560` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 320.56 W (>1 % of load). pg=24.93 kW, pd=24.59 kW, p_loss=0.65 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_454`  
  Generator 'der_454' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_194`  
  Generator 'der_194' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_276`  
  Generator 'der_276' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_615`  
  Generator 'der_615' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_539`  
  Generator 'der_539' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_443`  
  Generator 'der_443' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_424`  
  Generator 'der_424' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_560`  
  Generator 'der_560' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 320.56 W (>1 % of load). pg=24.93 kW, pd=24.59 kW, p_loss=0.65 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 8 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 8A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.31 V at bus '560' — reflects the neutral shift under unbalanced loading.

