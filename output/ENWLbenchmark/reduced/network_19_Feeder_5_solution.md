# BMOPF Solution Profile: network_19_Feeder_5

**Generated:** 2026-06-18 09:29:40  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 7.2151  
**Solve time:** 0.278 s  
**Findings:** 0 errors · 19 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 63.099 kW |
| Total load | 62.75 kW |
| Total line losses | 623.75 W |
| Loss fraction | 1.0% |
| Power balance error | 274.69 W |
| Max neutral shift | 2.255 V (bus `623`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 19 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_968` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1152` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1147` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1013` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_623` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_801` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_577` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_761` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_413` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1101` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_494` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1019` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_441` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1112` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_213` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_253` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_887` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_384` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_550` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_968`  
  Generator 'der_968' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1152`  
  Generator 'der_1152' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1147`  
  Generator 'der_1147' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1013`  
  Generator 'der_1013' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_623`  
  Generator 'der_623' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_801`  
  Generator 'der_801' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_577`  
  Generator 'der_577' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_761`  
  Generator 'der_761' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_413`  
  Generator 'der_413' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1101`  
  Generator 'der_1101' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_494`  
  Generator 'der_494' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1019`  
  Generator 'der_1019' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_441`  
  Generator 'der_441' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1112`  
  Generator 'der_1112' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_213`  
  Generator 'der_213' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_253`  
  Generator 'der_253' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_887`  
  Generator 'der_887' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_384`  
  Generator 'der_384' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_550`  
  Generator 'der_550' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 19 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 19A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.25 V at bus '623' — reflects the neutral shift under unbalanced loading.

