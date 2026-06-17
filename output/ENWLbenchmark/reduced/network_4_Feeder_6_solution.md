# BMOPF Solution Profile: network_4_Feeder_6

**Generated:** 2026-06-18 09:29:48  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 2.9064  
**Solve time:** 0.091 s  
**Findings:** 0 errors · 7 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 23.613 kW |
| Total load | 23.364 kW |
| Total line losses | 457.35 W |
| Loss fraction | 2.0% |
| Power balance error | 208.55 W |
| Max neutral shift | 1.526 V (bus `398`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 7 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_395` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_264` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_184` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_241` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_324` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_367` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_398` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_395`  
  Generator 'der_395' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_264`  
  Generator 'der_264' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_184`  
  Generator 'der_184' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_241`  
  Generator 'der_241' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_324`  
  Generator 'der_324' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_367`  
  Generator 'der_367' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_398`  
  Generator 'der_398' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 7 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 7A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.53 V at bus '398' — reflects the neutral shift under unbalanced loading.

