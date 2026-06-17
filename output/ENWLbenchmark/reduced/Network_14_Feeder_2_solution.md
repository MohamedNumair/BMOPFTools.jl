# BMOPF Solution Profile: Network_14_Feeder_2

**Generated:** 2026-06-18 07:11:17  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 3.9001  
**Solve time:** 0.029 s  
**Findings:** 0 errors · 7 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 24.302 kW |
| Total load | 24.246 kW |
| Total line losses | 78.65 W |
| Loss fraction | 0.3% |
| Power balance error | 23.06 W |
| Max neutral shift | 0.423 V (bus `91`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 7 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_82` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_91` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_86` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_103` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_99` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_84` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_85` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_82`  
  Generator 'der_82' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_91`  
  Generator 'der_91' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_86`  
  Generator 'der_86' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_103`  
  Generator 'der_103' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_99`  
  Generator 'der_99' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_84`  
  Generator 'der_84' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_85`  
  Generator 'der_85' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 7 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 7A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.42 V at bus '91' — reflects the neutral shift under unbalanced loading.

