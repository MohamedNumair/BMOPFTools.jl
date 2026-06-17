# BMOPF Solution Profile: network_18_Feeder_7

**Generated:** 2026-06-18 09:29:38  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 4.1742  
**Solve time:** 0.073 s  
**Findings:** 0 errors · 7 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 24.298 kW |
| Total load | 24.246 kW |
| Total line losses | 111.22 W |
| Loss fraction | 0.5% |
| Power balance error | 59.1 W |
| Max neutral shift | 0.614 V (bus `526`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 7 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_166` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_264` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_143` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_528` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_187` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_564` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_391` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_166`  
  Generator 'der_166' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_264`  
  Generator 'der_264' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_143`  
  Generator 'der_143' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_528`  
  Generator 'der_528' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_187`  
  Generator 'der_187' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_564`  
  Generator 'der_564' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_391`  
  Generator 'der_391' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 7 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 7A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.61 V at bus '526' — reflects the neutral shift under unbalanced loading.

