# BMOPF Solution Profile: network_9_Feeder_1

**Generated:** 2026-06-18 09:29:53  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 7.6297  
**Solve time:** 0.314 s  
**Findings:** 0 errors · 22 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 78.091 kW |
| Total load | 77.539 kW |
| Total line losses | 986.81 W |
| Loss fraction | 1.3% |
| Power balance error | 435.04 W |
| Max neutral shift | 1.699 V (bus `2324`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 22 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_1768` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1205` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2391` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2239` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_671` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_807` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1296` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2324` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_407` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_570` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2099` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2019` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2003` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_321` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_756` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1670` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1705` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2045` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_899` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1551` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2113` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1576` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1768`  
  Generator 'der_1768' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1205`  
  Generator 'der_1205' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2391`  
  Generator 'der_2391' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2239`  
  Generator 'der_2239' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_671`  
  Generator 'der_671' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_807`  
  Generator 'der_807' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1296`  
  Generator 'der_1296' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2324`  
  Generator 'der_2324' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_407`  
  Generator 'der_407' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_570`  
  Generator 'der_570' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2099`  
  Generator 'der_2099' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2019`  
  Generator 'der_2019' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2003`  
  Generator 'der_2003' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_321`  
  Generator 'der_321' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_756`  
  Generator 'der_756' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1670`  
  Generator 'der_1670' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1705`  
  Generator 'der_1705' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2045`  
  Generator 'der_2045' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_899`  
  Generator 'der_899' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1551`  
  Generator 'der_1551' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2113`  
  Generator 'der_2113' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1576`  
  Generator 'der_1576' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 22 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 22A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.7 V at bus '2324' — reflects the neutral shift under unbalanced loading.

