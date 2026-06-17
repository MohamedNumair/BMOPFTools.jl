# BMOPF Solution Profile: network_21_Feeder_4

**Generated:** 2026-06-18 07:11:40  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 2.3409  
**Solve time:** 0.045 s  
**Findings:** 0 errors · 5 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 17.427 kW |
| Total load | 17.358 kW |
| Total line losses | 121.41 W |
| Loss fraction | 0.7% |
| Power balance error | 52.76 W |
| Max neutral shift | 0.521 V (bus `305`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 5 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_264` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_164` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_305` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_115` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_359` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_264`  
  Generator 'der_264' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_164`  
  Generator 'der_164' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_305`  
  Generator 'der_305' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_115`  
  Generator 'der_115' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_359`  
  Generator 'der_359' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 5 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 5A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.52 V at bus '305' — reflects the neutral shift under unbalanced loading.

