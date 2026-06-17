# BMOPF Solution Profile: Network_14_Feeder_3

**Generated:** 2026-06-18 07:11:17  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 8.8388  
**Solve time:** 0.064 s  
**Findings:** 0 errors · 15 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 54.276 kW |
| Total load | 53.963 kW |
| Total line losses | 390.54 W |
| Loss fraction | 0.7% |
| Power balance error | 77.69 W |
| Max neutral shift | 1.656 V (bus `132`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 15 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_109` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_114` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_147` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_112` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_107` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_113` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_95` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_96` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_152` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_104` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_143` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_127` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_100` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_144` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_146` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_109`  
  Generator 'der_109' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_114`  
  Generator 'der_114' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_147`  
  Generator 'der_147' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_112`  
  Generator 'der_112' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_107`  
  Generator 'der_107' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_113`  
  Generator 'der_113' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_95`  
  Generator 'der_95' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_96`  
  Generator 'der_96' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_152`  
  Generator 'der_152' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_104`  
  Generator 'der_104' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_143`  
  Generator 'der_143' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_127`  
  Generator 'der_127' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_100`  
  Generator 'der_100' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_144`  
  Generator 'der_144' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_146`  
  Generator 'der_146' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 15 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 15A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.66 V at bus '132' — reflects the neutral shift under unbalanced loading.

