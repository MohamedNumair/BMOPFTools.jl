# BMOPF Solution Profile: network_16_Feeder_1

**Generated:** 2026-06-18 09:29:27  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 11.5974  
**Solve time:** 0.098 s  
**Findings:** 0 errors · 10 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 40.53 kW |
| Total load | 40.093 kW |
| Total line losses | 725.72 W |
| Loss fraction | 1.8% |
| Power balance error | 289.0 W |
| Max neutral shift | 2.805 V (bus `471`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 10 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_279` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_313` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_124` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_437` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_13` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_8` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_16` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_164` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_468` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_14` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_279`  
  Generator 'der_279' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_313`  
  Generator 'der_313' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_124`  
  Generator 'der_124' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_437`  
  Generator 'der_437' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_13`  
  Generator 'der_13' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_8`  
  Generator 'der_8' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_16`  
  Generator 'der_16' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_164`  
  Generator 'der_164' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_468`  
  Generator 'der_468' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_14`  
  Generator 'der_14' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 10 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 10A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.8 V at bus '471' — reflects the neutral shift under unbalanced loading.

