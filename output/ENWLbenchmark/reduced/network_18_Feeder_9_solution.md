# BMOPF Solution Profile: network_18_Feeder_9

**Generated:** 2026-06-18 09:29:38  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 13.0761  
**Solve time:** 0.184 s  
**Findings:** 0 errors · 14 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 50.69 kW |
| Total load | 50.143 kW |
| Total line losses | 1.88 kW |
| Loss fraction | 3.7% |
| Power balance error | 1.332 kW |
| Max neutral shift | 2.198 V (bus `1057`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 13 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_1180` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_952` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_575` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_361` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_363` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_542` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1198` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1181` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_130` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_989` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_978` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1021` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1173` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 1.332 kW (>1 % of load). pg=50.69 kW, pd=50.14 kW, p_loss=1.88 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1180`  
  Generator 'der_1180' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_952`  
  Generator 'der_952' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_575`  
  Generator 'der_575' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_361`  
  Generator 'der_361' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_363`  
  Generator 'der_363' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_542`  
  Generator 'der_542' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1198`  
  Generator 'der_1198' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1181`  
  Generator 'der_1181' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_130`  
  Generator 'der_130' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_989`  
  Generator 'der_989' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_978`  
  Generator 'der_978' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1021`  
  Generator 'der_1021' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1173`  
  Generator 'der_1173' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 1.332 kW (>1 % of load). pg=50.69 kW, pd=50.14 kW, p_loss=1.88 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 13 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 13A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.2 V at bus '1057' — reflects the neutral shift under unbalanced loading.

