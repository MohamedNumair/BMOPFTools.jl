# BMOPF Solution Profile: network_9_Feeder_3

**Generated:** 2026-06-18 07:11:51  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 4.1981  
**Solve time:** 0.037 s  
**Findings:** 0 errors · 5 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 19.593 kW |
| Total load | 19.566 kW |
| Total line losses | 50.89 W |
| Loss fraction | 0.3% |
| Power balance error | 23.58 W |
| Max neutral shift | 0.201 V (bus `92`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 5 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_90` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_103` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_99` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_88` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_101` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_90`  
  Generator 'der_90' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_103`  
  Generator 'der_103' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_99`  
  Generator 'der_99' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_88`  
  Generator 'der_88' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_101`  
  Generator 'der_101' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 5 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 5A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.2 V at bus '92' — reflects the neutral shift under unbalanced loading.

