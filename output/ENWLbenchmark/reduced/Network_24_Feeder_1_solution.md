# BMOPF Solution Profile: Network_24_Feeder_1

**Generated:** 2026-06-18 09:29:14  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 14.4731  
**Solve time:** 0.114 s  
**Findings:** 0 errors · 14 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 52.972 kW |
| Total load | 52.745 kW |
| Total line losses | 418.4 W |
| Loss fraction | 0.8% |
| Power balance error | 191.0 W |
| Max neutral shift | 0.974 V (bus `935`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 14 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_973` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1066` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_792` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_818` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_981` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_592` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_813` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1009` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_815` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_306` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_816` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_842` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_841` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_465` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_973`  
  Generator 'der_973' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1066`  
  Generator 'der_1066' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_792`  
  Generator 'der_792' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_818`  
  Generator 'der_818' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_981`  
  Generator 'der_981' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_592`  
  Generator 'der_592' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_813`  
  Generator 'der_813' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1009`  
  Generator 'der_1009' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_815`  
  Generator 'der_815' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_306`  
  Generator 'der_306' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_816`  
  Generator 'der_816' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_842`  
  Generator 'der_842' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_841`  
  Generator 'der_841' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_465`  
  Generator 'der_465' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 14 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 14A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.97 V at bus '935' — reflects the neutral shift under unbalanced loading.

