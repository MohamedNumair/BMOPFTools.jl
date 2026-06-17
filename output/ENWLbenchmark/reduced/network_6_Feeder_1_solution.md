# BMOPF Solution Profile: network_6_Feeder_1

**Generated:** 2026-06-18 09:29:50  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 16.9381  
**Solve time:** 0.414 s  
**Findings:** 0 errors · 30 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 103.092 kW |
| Total load | 102.118 kW |
| Total line losses | 1.615 kW |
| Loss fraction | 1.6% |
| Power balance error | 640.71 W |
| Max neutral shift | 2.233 V (bus `1504`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 30 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_1309` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2258` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1719` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3042` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1676` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2661` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2012` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2177` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_152` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1153` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_456` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2511` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2229` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_229` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3084` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2768` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_996` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3190` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1126` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1814` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3188` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1552` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2318` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1340` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3315` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_589` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3119` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1523` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1466` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1062` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1309`  
  Generator 'der_1309' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2258`  
  Generator 'der_2258' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1719`  
  Generator 'der_1719' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3042`  
  Generator 'der_3042' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1676`  
  Generator 'der_1676' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2661`  
  Generator 'der_2661' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2012`  
  Generator 'der_2012' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2177`  
  Generator 'der_2177' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_152`  
  Generator 'der_152' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1153`  
  Generator 'der_1153' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_456`  
  Generator 'der_456' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2511`  
  Generator 'der_2511' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2229`  
  Generator 'der_2229' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_229`  
  Generator 'der_229' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3084`  
  Generator 'der_3084' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2768`  
  Generator 'der_2768' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_996`  
  Generator 'der_996' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3190`  
  Generator 'der_3190' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1126`  
  Generator 'der_1126' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1814`  
  Generator 'der_1814' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3188`  
  Generator 'der_3188' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1552`  
  Generator 'der_1552' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2318`  
  Generator 'der_2318' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1340`  
  Generator 'der_1340' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3315`  
  Generator 'der_3315' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_589`  
  Generator 'der_589' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3119`  
  Generator 'der_3119' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1523`  
  Generator 'der_1523' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1466`  
  Generator 'der_1466' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1062`  
  Generator 'der_1062' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 30 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 30A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.23 V at bus '1504' — reflects the neutral shift under unbalanced loading.

