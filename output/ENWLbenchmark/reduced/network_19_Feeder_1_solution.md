# BMOPF Solution Profile: network_19_Feeder_1

**Generated:** 2026-06-18 09:29:38  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 12.7977  
**Solve time:** 0.215 s  
**Findings:** 0 errors · 14 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 51.124 kW |
| Total load | 50.143 kW |
| Total line losses | 2.675 kW |
| Loss fraction | 5.3% |
| Power balance error | 1.695 kW |
| Max neutral shift | 5.18 V (bus `1019`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 13 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_509` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_864` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_234` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_977` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_897` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_619` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_845` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_848` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1019` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_916` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_470` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_861` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_632` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 1.695 kW (>1 % of load). pg=51.12 kW, pd=50.14 kW, p_loss=2.68 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_509`  
  Generator 'der_509' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_864`  
  Generator 'der_864' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_234`  
  Generator 'der_234' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_977`  
  Generator 'der_977' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_897`  
  Generator 'der_897' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_619`  
  Generator 'der_619' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_845`  
  Generator 'der_845' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_848`  
  Generator 'der_848' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1019`  
  Generator 'der_1019' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_916`  
  Generator 'der_916' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_470`  
  Generator 'der_470' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_861`  
  Generator 'der_861' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_632`  
  Generator 'der_632' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 1.695 kW (>1 % of load). pg=51.12 kW, pd=50.14 kW, p_loss=2.68 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 13 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 13A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 5.18 V at bus '1019' — reflects the neutral shift under unbalanced loading.

