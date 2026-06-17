# BMOPF Solution Profile: network_1_Feeder_2

**Generated:** 2026-06-18 09:29:40  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 1.6241  
**Solve time:** 0.055 s  
**Findings:** 0 errors · 8 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 25.337 kW |
| Total load | 25.14 kW |
| Total line losses | 339.38 W |
| Loss fraction | 1.3% |
| Power balance error | 142.76 W |
| Max neutral shift | 1.206 V (bus `223`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 8 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_219` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_361` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_440` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_196` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_278` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_456` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_364` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_332` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_219`  
  Generator 'der_219' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_361`  
  Generator 'der_361' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_440`  
  Generator 'der_440' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_196`  
  Generator 'der_196' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_278`  
  Generator 'der_278' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_456`  
  Generator 'der_456' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_364`  
  Generator 'der_364' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_332`  
  Generator 'der_332' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 8 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 8A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.21 V at bus '223' — reflects the neutral shift under unbalanced loading.

