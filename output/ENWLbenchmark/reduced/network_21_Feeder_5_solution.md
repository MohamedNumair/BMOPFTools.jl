# BMOPF Solution Profile: network_21_Feeder_5

**Generated:** 2026-06-18 07:11:40  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 3.3977  
**Solve time:** 0.082 s  
**Findings:** 0 errors · 7 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 24.089 kW |
| Total load | 23.97 kW |
| Total line losses | 262.65 W |
| Loss fraction | 1.1% |
| Power balance error | 143.75 W |
| Max neutral shift | 1.154 V (bus `965`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 7 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_965` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_417` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_360` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_124` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_642` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_126` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_966` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_965`  
  Generator 'der_965' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_417`  
  Generator 'der_417' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_360`  
  Generator 'der_360' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_124`  
  Generator 'der_124' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_642`  
  Generator 'der_642' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_126`  
  Generator 'der_126' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_966`  
  Generator 'der_966' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 7 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 7A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.15 V at bus '965' — reflects the neutral shift under unbalanced loading.

