# BMOPF Solution Profile: network_6_Feeder_2

**Generated:** 2026-06-18 09:29:50  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 11.4607  
**Solve time:** 0.256 s  
**Findings:** 0 errors · 14 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 52.235 kW |
| Total load | 51.907 kW |
| Total line losses | 539.9 W |
| Loss fraction | 1.0% |
| Power balance error | 212.11 W |
| Max neutral shift | 1.526 V (bus `884`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 14 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_951` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_906` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_246` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_173` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_822` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_926` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_559` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1029` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_597` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_867` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_417` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_428` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_806` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_245` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_951`  
  Generator 'der_951' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_906`  
  Generator 'der_906' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_246`  
  Generator 'der_246' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_173`  
  Generator 'der_173' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_822`  
  Generator 'der_822' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_926`  
  Generator 'der_926' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_559`  
  Generator 'der_559' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1029`  
  Generator 'der_1029' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_597`  
  Generator 'der_597' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_867`  
  Generator 'der_867' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_417`  
  Generator 'der_417' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_428`  
  Generator 'der_428' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_806`  
  Generator 'der_806' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_245`  
  Generator 'der_245' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 14 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 14A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.53 V at bus '884' — reflects the neutral shift under unbalanced loading.

