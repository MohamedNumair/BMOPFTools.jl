# BMOPF Solution Profile: network_10_Feeder_5

**Generated:** 2026-06-18 09:29:19  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 2.8422  
**Solve time:** 0.014 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 13.283 kW |
| Total load | 13.188 kW |
| Total line losses | 157.8 W |
| Loss fraction | 1.2% |
| Power balance error | 62.98 W |
| Max neutral shift | 0.859 V (bus `301`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 3 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_272` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_301` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_274` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_272`  
  Generator 'der_272' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_301`  
  Generator 'der_301' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_274`  
  Generator 'der_274' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.86 V at bus '301' — reflects the neutral shift under unbalanced loading.

