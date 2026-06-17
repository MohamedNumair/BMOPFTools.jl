# BMOPF Solution Profile: network_25_Feeder_3

**Generated:** 2026-06-18 07:11:42  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 3.4396  
**Solve time:** 0.03 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 13.826 kW |
| Total load | 13.764 kW |
| Total line losses | 197.39 W |
| Loss fraction | 1.4% |
| Power balance error | 135.53 W |
| Max neutral shift | 0.684 V (bus `503`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 4 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_436` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_267` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_503` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_403` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_436`  
  Generator 'der_436' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_267`  
  Generator 'der_267' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_503`  
  Generator 'der_503' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_403`  
  Generator 'der_403' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 4 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 4A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.68 V at bus '503' — reflects the neutral shift under unbalanced loading.

