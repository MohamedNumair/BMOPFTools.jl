# BMOPF Solution Profile: network_7_Feeder_5

**Generated:** 2026-06-18 09:29:53  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 7.4553  
**Solve time:** 0.353 s  
**Findings:** 0 errors · 16 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 54.464 kW |
| Total load | 54.251 kW |
| Total line losses | 500.53 W |
| Loss fraction | 0.9% |
| Power balance error | 287.25 W |
| Max neutral shift | 1.415 V (bus `471`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 16 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_471` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_463` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_360` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_349` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_433` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_166` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_97` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_153` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_127` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_164` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_311` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_417` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_142` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_103` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_370` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_243` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_471`  
  Generator 'der_471' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_463`  
  Generator 'der_463' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_360`  
  Generator 'der_360' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_349`  
  Generator 'der_349' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_433`  
  Generator 'der_433' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_166`  
  Generator 'der_166' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_97`  
  Generator 'der_97' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_153`  
  Generator 'der_153' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_127`  
  Generator 'der_127' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_164`  
  Generator 'der_164' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_311`  
  Generator 'der_311' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_417`  
  Generator 'der_417' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_142`  
  Generator 'der_142' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_103`  
  Generator 'der_103' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_370`  
  Generator 'der_370' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_243`  
  Generator 'der_243' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 16 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 16A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.41 V at bus '471' — reflects the neutral shift under unbalanced loading.

