# BMOPF Solution Profile: network_20_Feeder_2

**Generated:** 2026-06-18 09:29:40  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 4.2633  
**Solve time:** 0.06 s  
**Findings:** 0 errors · 7 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 23.81 kW |
| Total load | 23.7 kW |
| Total line losses | 204.7 W |
| Loss fraction | 0.9% |
| Power balance error | 95.16 W |
| Max neutral shift | 0.907 V (bus `469`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 7 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_435` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_399` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_235` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_251` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_469` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_497` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_579` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_435`  
  Generator 'der_435' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_399`  
  Generator 'der_399' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_235`  
  Generator 'der_235' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_251`  
  Generator 'der_251' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_469`  
  Generator 'der_469' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_497`  
  Generator 'der_497' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_579`  
  Generator 'der_579' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 7 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 7A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.91 V at bus '469' — reflects the neutral shift under unbalanced loading.

