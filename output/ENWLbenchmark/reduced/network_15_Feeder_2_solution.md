# BMOPF Solution Profile: network_15_Feeder_2

**Generated:** 2026-06-18 09:29:24  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 13.3247  
**Solve time:** 0.895 s  
**Findings:** 0 errors · 28 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 98.744 kW |
| Total load | 97.066 kW |
| Total line losses | 3.33 kW |
| Loss fraction | 3.4% |
| Power balance error | 1.651 kW |
| Max neutral shift | 4.225 V (bus `2337`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 27 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_2230` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2588` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2116` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1988` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1090` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2484` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2702` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1395` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_536` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_310` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2707` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2238` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1534` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2234` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2237` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1903` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1321` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2036` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_430` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2245` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2737` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1394` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2126` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1163` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_925` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2035` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1056` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 1.651 kW (>1 % of load). pg=98.74 kW, pd=97.07 kW, p_loss=3.33 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2230`  
  Generator 'der_2230' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2588`  
  Generator 'der_2588' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2116`  
  Generator 'der_2116' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1988`  
  Generator 'der_1988' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1090`  
  Generator 'der_1090' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2484`  
  Generator 'der_2484' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2702`  
  Generator 'der_2702' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1395`  
  Generator 'der_1395' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_536`  
  Generator 'der_536' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_310`  
  Generator 'der_310' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2707`  
  Generator 'der_2707' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2238`  
  Generator 'der_2238' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1534`  
  Generator 'der_1534' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2234`  
  Generator 'der_2234' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2237`  
  Generator 'der_2237' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1903`  
  Generator 'der_1903' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1321`  
  Generator 'der_1321' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2036`  
  Generator 'der_2036' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_430`  
  Generator 'der_430' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2245`  
  Generator 'der_2245' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2737`  
  Generator 'der_2737' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1394`  
  Generator 'der_1394' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2126`  
  Generator 'der_2126' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1163`  
  Generator 'der_1163' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_925`  
  Generator 'der_925' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2035`  
  Generator 'der_2035' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1056`  
  Generator 'der_1056' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 1.651 kW (>1 % of load). pg=98.74 kW, pd=97.07 kW, p_loss=3.33 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 27 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 27A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 4.23 V at bus '2337' — reflects the neutral shift under unbalanced loading.

