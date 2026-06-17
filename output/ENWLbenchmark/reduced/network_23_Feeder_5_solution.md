# BMOPF Solution Profile: network_23_Feeder_5

**Generated:** 2026-06-18 09:29:43  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 9.0569  
**Solve time:** 0.098 s  
**Findings:** 0 errors · 11 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 41.407 kW |
| Total load | 41.137 kW |
| Total line losses | 486.21 W |
| Loss fraction | 1.2% |
| Power balance error | 216.74 W |
| Max neutral shift | 1.984 V (bus `676`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 11 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_812` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_749` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_324` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_748` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_123` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_883` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_676` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_881` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_320` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_664` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_654` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_812`  
  Generator 'der_812' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_749`  
  Generator 'der_749' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_324`  
  Generator 'der_324' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_748`  
  Generator 'der_748' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_123`  
  Generator 'der_123' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_883`  
  Generator 'der_883' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_676`  
  Generator 'der_676' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_881`  
  Generator 'der_881' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_320`  
  Generator 'der_320' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_664`  
  Generator 'der_664' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_654`  
  Generator 'der_654' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 11 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 11A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.98 V at bus '676' — reflects the neutral shift under unbalanced loading.

