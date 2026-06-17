# BMOPF Solution Profile: network_13_Feeder_3

**Generated:** 2026-06-18 07:11:25  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 0.0685  
**Solve time:** 0.005 s  
**Findings:** 0 errors · 1 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 2.287 kW |
| Total load | 2.274 kW |
| Total line losses | 24.52 W |
| Loss fraction | 1.1% |
| Power balance error | 11.89 W |
| Max neutral shift | 0.35 V (bus `107`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 1 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_107` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_107`  
  Generator 'der_107' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 1 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 1A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.35 V at bus '107' — reflects the neutral shift under unbalanced loading.

