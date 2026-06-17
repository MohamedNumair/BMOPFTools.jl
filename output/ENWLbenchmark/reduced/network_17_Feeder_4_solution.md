# BMOPF Solution Profile: network_17_Feeder_4

**Generated:** 2026-06-18 07:11:32  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 14.296  
**Solve time:** 1.072 s  
**Findings:** 0 errors · 28 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 96.207 kW |
| Total load | 95.008 kW |
| Total line losses | 2.256 kW |
| Loss fraction | 2.4% |
| Power balance error | 1.057 kW |
| Max neutral shift | 3.477 V (bus `1531`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 27 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_566` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_962` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_961` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_106` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1366` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_771` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1055` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1090` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1077` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1465` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_707` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_215` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_478` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1534` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_196` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1331` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1206` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1372` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_829` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_666` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_815` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1441` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_405` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_933` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_247` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1335` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_741` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 1.057 kW (>1 % of load). pg=96.21 kW, pd=95.01 kW, p_loss=2.26 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_566`  
  Generator 'der_566' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_962`  
  Generator 'der_962' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_961`  
  Generator 'der_961' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_106`  
  Generator 'der_106' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1366`  
  Generator 'der_1366' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_771`  
  Generator 'der_771' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1055`  
  Generator 'der_1055' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1090`  
  Generator 'der_1090' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1077`  
  Generator 'der_1077' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1465`  
  Generator 'der_1465' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_707`  
  Generator 'der_707' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_215`  
  Generator 'der_215' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_478`  
  Generator 'der_478' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1534`  
  Generator 'der_1534' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_196`  
  Generator 'der_196' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1331`  
  Generator 'der_1331' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1206`  
  Generator 'der_1206' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1372`  
  Generator 'der_1372' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_829`  
  Generator 'der_829' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_666`  
  Generator 'der_666' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_815`  
  Generator 'der_815' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1441`  
  Generator 'der_1441' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_405`  
  Generator 'der_405' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_933`  
  Generator 'der_933' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_247`  
  Generator 'der_247' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1335`  
  Generator 'der_1335' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_741`  
  Generator 'der_741' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 1.057 kW (>1 % of load). pg=96.21 kW, pd=95.01 kW, p_loss=2.26 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 27 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 27A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 3.48 V at bus '1531' — reflects the neutral shift under unbalanced loading.

