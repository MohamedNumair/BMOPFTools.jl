# BMOPF Solution Profile: network_20_Feeder_4

**Generated:** 2026-06-18 09:29:41  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 4.0765  
**Solve time:** 0.035 s  
**Findings:** 0 errors · 8 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 24.623 kW |
| Total load | 24.594 kW |
| Total line losses | 39.67 W |
| Loss fraction | 0.2% |
| Power balance error | 10.64 W |
| Max neutral shift | 0.157 V (bus `59`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 8 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_69` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_44` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_58` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_66` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_59` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_65` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_55` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_53` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_69`  
  Generator 'der_69' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_44`  
  Generator 'der_44' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_58`  
  Generator 'der_58' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_66`  
  Generator 'der_66' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_59`  
  Generator 'der_59' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_65`  
  Generator 'der_65' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_55`  
  Generator 'der_55' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_53`  
  Generator 'der_53' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 8 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 8A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.16 V at bus '59' — reflects the neutral shift under unbalanced loading.

