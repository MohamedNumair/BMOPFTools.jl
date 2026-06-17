# BMOPF Solution Profile: Network_14_Feeder_1

**Generated:** 2026-06-18 09:29:13  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 10.0053  
**Solve time:** 0.524 s  
**Findings:** 0 errors · 18 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 61.625 kW |
| Total load | 60.845 kW |
| Total line losses | 1.375 kW |
| Loss fraction | 2.3% |
| Power balance error | 595.15 W |
| Max neutral shift | 3.165 V (bus `2303`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 18 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_500` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1974` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1719` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2303` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_592` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_569` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1655` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_546` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2301` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1127` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_411` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1591` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1857` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1918` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1919` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1367` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2299` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1994` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_500`  
  Generator 'der_500' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1974`  
  Generator 'der_1974' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1719`  
  Generator 'der_1719' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2303`  
  Generator 'der_2303' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_592`  
  Generator 'der_592' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_569`  
  Generator 'der_569' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1655`  
  Generator 'der_1655' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_546`  
  Generator 'der_546' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2301`  
  Generator 'der_2301' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1127`  
  Generator 'der_1127' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_411`  
  Generator 'der_411' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1591`  
  Generator 'der_1591' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1857`  
  Generator 'der_1857' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1918`  
  Generator 'der_1918' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1919`  
  Generator 'der_1919' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1367`  
  Generator 'der_1367' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2299`  
  Generator 'der_2299' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1994`  
  Generator 'der_1994' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 18 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 18A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 3.16 V at bus '2303' — reflects the neutral shift under unbalanced loading.

