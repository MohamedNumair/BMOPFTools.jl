# BMOPF Solution Profile: network_13_Feeder_1

**Generated:** 2026-06-18 09:29:22  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 12.858  
**Solve time:** 0.104 s  
**Findings:** 0 errors · 13 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 49.524 kW |
| Total load | 48.931 kW |
| Total line losses | 1.125 kW |
| Loss fraction | 2.3% |
| Power balance error | 531.93 W |
| Max neutral shift | 3.19 V (bus `1036`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 12 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_961` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1040` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1051` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_635` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_976` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_670` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_842` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_633` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_634` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1012` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_613` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1106` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 531.93 W (>1 % of load). pg=49.52 kW, pd=48.93 kW, p_loss=1.13 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_961`  
  Generator 'der_961' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1040`  
  Generator 'der_1040' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1051`  
  Generator 'der_1051' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_635`  
  Generator 'der_635' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_976`  
  Generator 'der_976' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_670`  
  Generator 'der_670' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_842`  
  Generator 'der_842' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_633`  
  Generator 'der_633' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_634`  
  Generator 'der_634' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1012`  
  Generator 'der_1012' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_613`  
  Generator 'der_613' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1106`  
  Generator 'der_1106' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 531.93 W (>1 % of load). pg=49.52 kW, pd=48.93 kW, p_loss=1.13 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 12 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 12A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 3.19 V at bus '1036' — reflects the neutral shift under unbalanced loading.

