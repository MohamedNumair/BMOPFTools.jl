# BMOPF Solution Profile: network_9_Feeder_6

**Generated:** 2026-06-18 09:29:54  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 3.5481  
**Solve time:** 0.064 s  
**Findings:** 0 errors · 6 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 20.906 kW |
| Total load | 20.868 kW |
| Total line losses | 82.9 W |
| Loss fraction | 0.4% |
| Power balance error | 45.28 W |
| Max neutral shift | 0.269 V (bus `165`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 6 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_168` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_161` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_164` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_169` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_179` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_172` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_168`  
  Generator 'der_168' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_161`  
  Generator 'der_161' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_164`  
  Generator 'der_164' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_169`  
  Generator 'der_169' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_179`  
  Generator 'der_179' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_172`  
  Generator 'der_172' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 6 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 6A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.27 V at bus '165' — reflects the neutral shift under unbalanced loading.

