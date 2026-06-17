# BMOPF Solution Profile: network_13_Feeder_2

**Generated:** 2026-06-18 07:11:25  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 1.3753  
**Solve time:** 0.085 s  
**Findings:** 0 errors · 10 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 30.323 kW |
| Total load | 30.079 kW |
| Total line losses | 418.3 W |
| Loss fraction | 1.4% |
| Power balance error | 174.7 W |
| Max neutral shift | 1.448 V (bus `1376`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 10 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_109` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_116` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_414` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1175` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_198` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1376` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1373` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1341` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_209` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1131` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_109`  
  Generator 'der_109' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_116`  
  Generator 'der_116' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_414`  
  Generator 'der_414' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1175`  
  Generator 'der_1175' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_198`  
  Generator 'der_198' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1376`  
  Generator 'der_1376' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1373`  
  Generator 'der_1373' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1341`  
  Generator 'der_1341' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_209`  
  Generator 'der_209' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1131`  
  Generator 'der_1131' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 10 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 10A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.45 V at bus '1376' — reflects the neutral shift under unbalanced loading.

