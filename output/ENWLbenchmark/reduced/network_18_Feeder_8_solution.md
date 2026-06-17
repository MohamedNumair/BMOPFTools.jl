# BMOPF Solution Profile: network_18_Feeder_8

**Generated:** 2026-06-18 07:11:37  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 3.4583  
**Solve time:** 0.033 s  
**Findings:** 0 errors · 6 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 20.015 kW |
| Total load | 19.902 kW |
| Total line losses | 254.76 W |
| Loss fraction | 1.3% |
| Power balance error | 141.76 W |
| Max neutral shift | 1.222 V (bus `312`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 6 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_312` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_326` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_129` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_79` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_340` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_229` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_312`  
  Generator 'der_312' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_326`  
  Generator 'der_326' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_129`  
  Generator 'der_129' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_79`  
  Generator 'der_79' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_340`  
  Generator 'der_340' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_229`  
  Generator 'der_229' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 6 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 6A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.22 V at bus '312' — reflects the neutral shift under unbalanced loading.

