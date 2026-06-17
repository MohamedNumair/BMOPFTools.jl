# BMOPF Solution Profile: network_5_Feeder_1

**Generated:** 2026-06-18 07:11:46  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 1.0483  
**Solve time:** 0.007 s  
**Findings:** 0 errors · 1 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 5.547 kW |
| Total load | 5.538 kW |
| Total line losses | 15.57 W |
| Loss fraction | 0.3% |
| Power balance error | 6.59 W |
| Max neutral shift | 0.391 V (bus `55`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 1 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_99` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_99`  
  Generator 'der_99' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 1 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 1A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.39 V at bus '55' — reflects the neutral shift under unbalanced loading.

