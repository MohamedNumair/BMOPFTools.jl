# BMOPF Solution Profile: network_23_Feeder_3

**Generated:** 2026-06-18 07:11:41  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 0.1373  
**Solve time:** 0.006 s  
**Findings:** 0 errors · 1 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 2.294 kW |
| Total load | 2.274 kW |
| Total line losses | 39.7 W |
| Loss fraction | 1.7% |
| Power balance error | 19.31 W |
| Max neutral shift | 0.546 V (bus `58`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 1 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_58` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_58`  
  Generator 'der_58' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 1 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 1A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.55 V at bus '58' — reflects the neutral shift under unbalanced loading.

