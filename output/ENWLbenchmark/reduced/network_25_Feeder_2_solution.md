# BMOPF Solution Profile: network_25_Feeder_2

**Generated:** 2026-06-18 09:29:43  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 4.0226  
**Solve time:** 0.065 s  
**Findings:** 0 errors · 5 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 17.432 kW |
| Total load | 17.358 kW |
| Total line losses | 177.39 W |
| Loss fraction | 1.0% |
| Power balance error | 103.2 W |
| Max neutral shift | 0.597 V (bus `678`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 5 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_219` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_703` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_678` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_100` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_478` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_219`  
  Generator 'der_219' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_703`  
  Generator 'der_703' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_678`  
  Generator 'der_678' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_100`  
  Generator 'der_100' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_478`  
  Generator 'der_478' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 5 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 5A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.6 V at bus '678' — reflects the neutral shift under unbalanced loading.

