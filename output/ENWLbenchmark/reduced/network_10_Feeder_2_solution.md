# BMOPF Solution Profile: network_10_Feeder_2

**Generated:** 2026-06-18 07:11:22  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 1.6849  
**Solve time:** 0.008 s  
**Findings:** 0 errors · 2 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 6.932 kW |
| Total load | 6.87 kW |
| Total line losses | 92.26 W |
| Loss fraction | 1.3% |
| Power balance error | 29.79 W |
| Max neutral shift | 1.586 V (bus `444`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 2 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_419` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_416` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_419`  
  Generator 'der_419' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_416`  
  Generator 'der_416' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 2 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 2A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.59 V at bus '444' — reflects the neutral shift under unbalanced loading.

