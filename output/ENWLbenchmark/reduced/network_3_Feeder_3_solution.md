# BMOPF Solution Profile: network_3_Feeder_3

**Generated:** 2026-06-18 09:29:47  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 12.0077  
**Solve time:** 0.521 s  
**Findings:** 0 errors · 26 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 86.1 kW |
| Total load | 85.084 kW |
| Total line losses | 2.96 kW |
| Loss fraction | 3.5% |
| Power balance error | 1.943 kW |
| Max neutral shift | 2.966 V (bus `957`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 25 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_571` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_463` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_959` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_937` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_593` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_171` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_164` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_551` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_957` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1209` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_259` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_707` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_603` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_282` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_951` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_835` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_345` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_377` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_820` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1196` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_49` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1030` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_343` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_455` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1096` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 1.943 kW (>1 % of load). pg=86.1 kW, pd=85.08 kW, p_loss=2.96 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_571`  
  Generator 'der_571' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_463`  
  Generator 'der_463' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_959`  
  Generator 'der_959' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_937`  
  Generator 'der_937' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_593`  
  Generator 'der_593' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_171`  
  Generator 'der_171' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_164`  
  Generator 'der_164' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_551`  
  Generator 'der_551' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_957`  
  Generator 'der_957' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1209`  
  Generator 'der_1209' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_259`  
  Generator 'der_259' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_707`  
  Generator 'der_707' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_603`  
  Generator 'der_603' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_282`  
  Generator 'der_282' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_951`  
  Generator 'der_951' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_835`  
  Generator 'der_835' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_345`  
  Generator 'der_345' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_377`  
  Generator 'der_377' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_820`  
  Generator 'der_820' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1196`  
  Generator 'der_1196' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_49`  
  Generator 'der_49' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1030`  
  Generator 'der_1030' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_343`  
  Generator 'der_343' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_455`  
  Generator 'der_455' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1096`  
  Generator 'der_1096' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 1.943 kW (>1 % of load). pg=86.1 kW, pd=85.08 kW, p_loss=2.96 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 25 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 25A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.97 V at bus '957' — reflects the neutral shift under unbalanced loading.

