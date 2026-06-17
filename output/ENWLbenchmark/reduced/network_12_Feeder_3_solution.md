# BMOPF Solution Profile: network_12_Feeder_3

**Generated:** 2026-06-18 07:11:25  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 11.8342  
**Solve time:** 0.714 s  
**Findings:** 0 errors · 23 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 81.401 kW |
| Total load | 80.314 kW |
| Total line losses | 2.46 kW |
| Loss fraction | 3.1% |
| Power balance error | 1.372 kW |
| Max neutral shift | 3.557 V (bus `928`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 1 |
| Generator| 0 | 21 |

## 3. Thermal Limits

| Sev | Component | ID | Terminal | cm (A) | i\_max (A) |
|-----|-----------|----|---------:|-------:|----------:|
| W | line | `line916` | `1` | 75.0 | 75.0 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_973` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1352` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_290` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1253` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1371` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1375` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1169` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1377` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_590` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_668` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_552` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1209` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1254` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_495` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1089` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1170` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_799` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_437` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_646` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1208` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_861` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 1.372 kW (>1 % of load). pg=81.4 kW, pd=80.31 kW, p_loss=2.46 kW.

## 6. All Findings

- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line916`  
  Line 'line916' conductor '1': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_973`  
  Generator 'der_973' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1352`  
  Generator 'der_1352' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_290`  
  Generator 'der_290' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1253`  
  Generator 'der_1253' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1371`  
  Generator 'der_1371' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1375`  
  Generator 'der_1375' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1169`  
  Generator 'der_1169' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1377`  
  Generator 'der_1377' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_590`  
  Generator 'der_590' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_668`  
  Generator 'der_668' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_552`  
  Generator 'der_552' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1209`  
  Generator 'der_1209' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1254`  
  Generator 'der_1254' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_495`  
  Generator 'der_495' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1089`  
  Generator 'der_1089' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1170`  
  Generator 'der_1170' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_799`  
  Generator 'der_799' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_437`  
  Generator 'der_437' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_646`  
  Generator 'der_646' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1208`  
  Generator 'der_1208' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_861`  
  Generator 'der_861' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 1.372 kW (>1 % of load). pg=81.4 kW, pd=80.31 kW, p_loss=2.46 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 22 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 1A. Generator: 0V / 21A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 3.56 V at bus '928' — reflects the neutral shift under unbalanced loading.

