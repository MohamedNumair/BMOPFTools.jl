# BMOPF Solution Profile: network_17_Feeder_2

**Generated:** 2026-06-18 07:11:31  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 4.6433  
**Solve time:** 0.016 s  
**Findings:** 0 errors · 2 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 12.292 kW |
| Total load | 12.276 kW |
| Total line losses | 22.24 W |
| Loss fraction | 0.2% |
| Power balance error | 6.55 W |
| Max neutral shift | 0.324 V (bus `254`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 2 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_118` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_110` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_118`  
  Generator 'der_118' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_110`  
  Generator 'der_110' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 2 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 2A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.32 V at bus '254' — reflects the neutral shift under unbalanced loading.

