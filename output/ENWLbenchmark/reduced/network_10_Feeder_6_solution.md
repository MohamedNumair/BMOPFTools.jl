# BMOPF Solution Profile: network_10_Feeder_6

**Generated:** 2026-06-18 09:29:19  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 1.0957  
**Solve time:** 0.016 s  
**Findings:** 0 errors · 2 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 6.892 kW |
| Total load | 6.87 kW |
| Total line losses | 47.1 W |
| Loss fraction | 0.7% |
| Power balance error | 24.75 W |
| Max neutral shift | 0.526 V (bus `442`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 2 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_367` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_442` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_367`  
  Generator 'der_367' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_442`  
  Generator 'der_442' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 2 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 2A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.53 V at bus '442' — reflects the neutral shift under unbalanced loading.

