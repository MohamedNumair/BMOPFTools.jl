# BMOPF Solution Profile: network_20_Feeder_1

**Generated:** 2026-06-18 07:11:39  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 2.3508  
**Solve time:** 0.058 s  
**Findings:** 0 errors · 7 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 23.408 kW |
| Total load | 23.364 kW |
| Total line losses | 60.96 W |
| Loss fraction | 0.3% |
| Power balance error | 17.13 W |
| Max neutral shift | 0.273 V (bus `58`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 7 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_69` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_66` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_70` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_76` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_60` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_77` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_74` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_69`  
  Generator 'der_69' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_66`  
  Generator 'der_66' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_70`  
  Generator 'der_70' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_76`  
  Generator 'der_76' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_60`  
  Generator 'der_60' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_77`  
  Generator 'der_77' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_74`  
  Generator 'der_74' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 7 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 7A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.27 V at bus '58' — reflects the neutral shift under unbalanced loading.

