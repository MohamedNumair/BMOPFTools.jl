# BMOPF Solution Profile: network_11_Feeder_2

**Generated:** 2026-06-18 09:29:19  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 0.7882  
**Solve time:** 0.013 s  
**Findings:** 0 errors · 1 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 5.222 kW |
| Total load | 5.214 kW |
| Total line losses | 13.63 W |
| Loss fraction | 0.3% |
| Power balance error | 5.73 W |
| Max neutral shift | 0.411 V (bus `214`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 1 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_214` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_214`  
  Generator 'der_214' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 1 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 1A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.41 V at bus '214' — reflects the neutral shift under unbalanced loading.

