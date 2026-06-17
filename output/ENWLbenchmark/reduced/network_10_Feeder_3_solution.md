# BMOPF Solution Profile: network_10_Feeder_3

**Generated:** 2026-06-18 09:29:19  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 4.2171  
**Solve time:** 0.047 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 16.685 kW |
| Total load | 16.632 kW |
| Total line losses | 107.44 W |
| Loss fraction | 0.6% |
| Power balance error | 54.3 W |
| Max neutral shift | 0.889 V (bus `343`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 4 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_401` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_337` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_397` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_393` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_401`  
  Generator 'der_401' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_337`  
  Generator 'der_337' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_397`  
  Generator 'der_397' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_393`  
  Generator 'der_393' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 4 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 4A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.89 V at bus '343' — reflects the neutral shift under unbalanced loading.

