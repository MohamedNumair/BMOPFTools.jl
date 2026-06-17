# BMOPF Solution Profile: network_22_Feeder_1

**Generated:** 2026-06-18 09:29:41  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 0.885  
**Solve time:** 0.061 s  
**Findings:** 0 errors · 8 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 25.347 kW |
| Total load | 25.14 kW |
| Total line losses | 419.74 W |
| Loss fraction | 1.7% |
| Power balance error | 213.05 W |
| Max neutral shift | 1.13 V (bus `271`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 8 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_655` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_379` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_228` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_561` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_217` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_315` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_599` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_459` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_655`  
  Generator 'der_655' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_379`  
  Generator 'der_379' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_228`  
  Generator 'der_228' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_561`  
  Generator 'der_561' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_217`  
  Generator 'der_217' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_315`  
  Generator 'der_315' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_599`  
  Generator 'der_599' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_459`  
  Generator 'der_459' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 8 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 8A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.13 V at bus '271' — reflects the neutral shift under unbalanced loading.

