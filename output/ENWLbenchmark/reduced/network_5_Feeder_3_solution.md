# BMOPF Solution Profile: network_5_Feeder_3

**Generated:** 2026-06-18 09:29:49  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 24.961  
**Solve time:** 0.656 s  
**Findings:** 0 errors · 40 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 139.549 kW |
| Total load | 137.828 kW |
| Total line losses | 4.02 kW |
| Loss fraction | 2.9% |
| Power balance error | 2.3 kW |
| Max neutral shift | 3.162 V (bus `2489`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 39 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_1424` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1819` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_749` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1711` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1563` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2647` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1183` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_809` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2435` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1357` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_581` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1047` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1346` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1464` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_780` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1666` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1733` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1155` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1594` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2752` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2466` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2900` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2232` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2876` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2249` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_326` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1206` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1763` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1389` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1215` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2199` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_395` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1115` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1181` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_356` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_842` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1631` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1993` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_226` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 2.3 kW (>1 % of load). pg=139.55 kW, pd=137.83 kW, p_loss=4.02 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1424`  
  Generator 'der_1424' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1819`  
  Generator 'der_1819' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_749`  
  Generator 'der_749' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1711`  
  Generator 'der_1711' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1563`  
  Generator 'der_1563' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2647`  
  Generator 'der_2647' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1183`  
  Generator 'der_1183' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_809`  
  Generator 'der_809' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2435`  
  Generator 'der_2435' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1357`  
  Generator 'der_1357' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_581`  
  Generator 'der_581' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1047`  
  Generator 'der_1047' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1346`  
  Generator 'der_1346' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1464`  
  Generator 'der_1464' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_780`  
  Generator 'der_780' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1666`  
  Generator 'der_1666' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1733`  
  Generator 'der_1733' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1155`  
  Generator 'der_1155' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1594`  
  Generator 'der_1594' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2752`  
  Generator 'der_2752' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2466`  
  Generator 'der_2466' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2900`  
  Generator 'der_2900' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2232`  
  Generator 'der_2232' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2876`  
  Generator 'der_2876' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2249`  
  Generator 'der_2249' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_326`  
  Generator 'der_326' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1206`  
  Generator 'der_1206' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1763`  
  Generator 'der_1763' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1389`  
  Generator 'der_1389' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1215`  
  Generator 'der_1215' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2199`  
  Generator 'der_2199' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_395`  
  Generator 'der_395' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1115`  
  Generator 'der_1115' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1181`  
  Generator 'der_1181' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_356`  
  Generator 'der_356' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_842`  
  Generator 'der_842' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1631`  
  Generator 'der_1631' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1993`  
  Generator 'der_1993' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_226`  
  Generator 'der_226' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 2.3 kW (>1 % of load). pg=139.55 kW, pd=137.83 kW, p_loss=4.02 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 39 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 39A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 3.16 V at bus '2489' — reflects the neutral shift under unbalanced loading.

