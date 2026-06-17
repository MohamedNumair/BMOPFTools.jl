# BMOPF Solution Profile: network_7_Feeder_3

**Generated:** 2026-06-18 09:29:51  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 14.3303  
**Solve time:** 0.23 s  
**Findings:** 0 errors · 13 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 50.359 kW |
| Total load | 50.143 kW |
| Total line losses | 553.69 W |
| Loss fraction | 1.1% |
| Power balance error | 337.71 W |
| Max neutral shift | 1.558 V (bus `401`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 13 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_401` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_304` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_151` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_360` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_299` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_201` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_159` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_366` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_306` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_104` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_372` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_302` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_206` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_401`  
  Generator 'der_401' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_304`  
  Generator 'der_304' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_151`  
  Generator 'der_151' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_360`  
  Generator 'der_360' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_299`  
  Generator 'der_299' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_201`  
  Generator 'der_201' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_159`  
  Generator 'der_159' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_366`  
  Generator 'der_366' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_306`  
  Generator 'der_306' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_104`  
  Generator 'der_104' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_372`  
  Generator 'der_372' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_302`  
  Generator 'der_302' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_206`  
  Generator 'der_206' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 13 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 13A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.56 V at bus '401' — reflects the neutral shift under unbalanced loading.

