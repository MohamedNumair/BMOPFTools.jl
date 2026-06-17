# BMOPF Solution Profile: network_19_Feeder_2

**Generated:** 2026-06-18 07:11:38  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 16.4445  
**Solve time:** 0.692 s  
**Findings:** 0 errors · 29 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 99.368 kW |
| Total load | 98.272 kW |
| Total line losses | 3.076 kW |
| Loss fraction | 3.1% |
| Power balance error | 1.98 kW |
| Max neutral shift | 3.179 V (bus `1285`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 28 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_110` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_649` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1285` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1216` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_972` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_108` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_990` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1245` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_498` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_313` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_499` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1658` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_737` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_170` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1264` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1506` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1574` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1669` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_886` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1608` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_866` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_231` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1693` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_335` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1199` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1706` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_359` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_758` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 1.98 kW (>1 % of load). pg=99.37 kW, pd=98.27 kW, p_loss=3.08 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_110`  
  Generator 'der_110' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_649`  
  Generator 'der_649' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1285`  
  Generator 'der_1285' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1216`  
  Generator 'der_1216' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_972`  
  Generator 'der_972' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_108`  
  Generator 'der_108' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_990`  
  Generator 'der_990' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1245`  
  Generator 'der_1245' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_498`  
  Generator 'der_498' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_313`  
  Generator 'der_313' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_499`  
  Generator 'der_499' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1658`  
  Generator 'der_1658' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_737`  
  Generator 'der_737' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_170`  
  Generator 'der_170' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1264`  
  Generator 'der_1264' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1506`  
  Generator 'der_1506' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1574`  
  Generator 'der_1574' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1669`  
  Generator 'der_1669' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_886`  
  Generator 'der_886' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1608`  
  Generator 'der_1608' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_866`  
  Generator 'der_866' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_231`  
  Generator 'der_231' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1693`  
  Generator 'der_1693' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_335`  
  Generator 'der_335' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1199`  
  Generator 'der_1199' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1706`  
  Generator 'der_1706' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_359`  
  Generator 'der_359' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_758`  
  Generator 'der_758' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 1.98 kW (>1 % of load). pg=99.37 kW, pd=98.27 kW, p_loss=3.08 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 28 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 28A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 3.18 V at bus '1285' — reflects the neutral shift under unbalanced loading.

