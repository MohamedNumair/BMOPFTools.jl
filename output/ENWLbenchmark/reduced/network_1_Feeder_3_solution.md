# BMOPF Solution Profile: network_1_Feeder_3

**Generated:** 2026-06-18 07:11:39  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 11.8231  
**Solve time:** 0.069 s  
**Findings:** 0 errors · 10 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 40.746 kW |
| Total load | 40.093 kW |
| Total line losses | 941.29 W |
| Loss fraction | 2.3% |
| Power balance error | 288.82 W |
| Max neutral shift | 4.697 V (bus `504`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 10 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_109` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_151` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_237` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_261` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_119` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_204` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_481` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_503` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_342` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_132` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_109`  
  Generator 'der_109' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_151`  
  Generator 'der_151' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_237`  
  Generator 'der_237' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_261`  
  Generator 'der_261' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_119`  
  Generator 'der_119' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_204`  
  Generator 'der_204' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_481`  
  Generator 'der_481' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_503`  
  Generator 'der_503' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_342`  
  Generator 'der_342' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_132`  
  Generator 'der_132' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 10 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 10A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 4.7 V at bus '504' — reflects the neutral shift under unbalanced loading.

