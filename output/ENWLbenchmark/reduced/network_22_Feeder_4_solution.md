# BMOPF Solution Profile: network_22_Feeder_4

**Generated:** 2026-06-18 09:29:42  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 5.5129  
**Solve time:** 0.055 s  
**Findings:** 0 errors · 7 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 23.843 kW |
| Total load | 23.7 kW |
| Total line losses | 290.8 W |
| Loss fraction | 1.2% |
| Power balance error | 147.38 W |
| Max neutral shift | 1.152 V (bus `539`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 7 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_218` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_539` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_404` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_209` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_585` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_520` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_710` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_218`  
  Generator 'der_218' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_539`  
  Generator 'der_539' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_404`  
  Generator 'der_404' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_209`  
  Generator 'der_209' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_585`  
  Generator 'der_585' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_520`  
  Generator 'der_520' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_710`  
  Generator 'der_710' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 7 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 7A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.15 V at bus '539' — reflects the neutral shift under unbalanced loading.

