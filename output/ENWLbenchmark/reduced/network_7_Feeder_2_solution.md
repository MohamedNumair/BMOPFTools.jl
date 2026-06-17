# BMOPF Solution Profile: network_7_Feeder_2

**Generated:** 2026-06-18 07:11:49  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 10.8085  
**Solve time:** 0.216 s  
**Findings:** 0 errors · 15 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 53.81 kW |
| Total load | 53.399 kW |
| Total line losses | 779.68 W |
| Loss fraction | 1.5% |
| Power balance error | 368.94 W |
| Max neutral shift | 2.517 V (bus `603`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 15 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_525` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_604` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_377` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_98` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_477` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_397` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_244` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_363` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_383` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_175` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_140` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_588` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_486` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_603` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_144` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_525`  
  Generator 'der_525' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_604`  
  Generator 'der_604' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_377`  
  Generator 'der_377' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_98`  
  Generator 'der_98' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_477`  
  Generator 'der_477' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_397`  
  Generator 'der_397' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_244`  
  Generator 'der_244' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_363`  
  Generator 'der_363' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_383`  
  Generator 'der_383' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_175`  
  Generator 'der_175' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_140`  
  Generator 'der_140' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_588`  
  Generator 'der_588' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_486`  
  Generator 'der_486' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_603`  
  Generator 'der_603' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_144`  
  Generator 'der_144' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 15 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 15A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.52 V at bus '603' — reflects the neutral shift under unbalanced loading.

