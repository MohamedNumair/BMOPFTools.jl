# BMOPF Solution Profile: network_15_Feeder_1

**Generated:** 2026-06-18 07:11:26  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 16.5345  
**Solve time:** 0.308 s  
**Findings:** 0 errors · 21 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 71.166 kW |
| Total load | 70.368 kW |
| Total line losses | 1.603 kW |
| Loss fraction | 2.3% |
| Power balance error | 804.89 W |
| Max neutral shift | 2.538 V (bus `1523`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 20 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_279` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1057` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2310` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2234` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1423` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1573` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_349` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_799` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2020` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1896` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1779` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_798` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1079` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_306` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1762` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1395` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2454` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1564` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2291` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2530` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 804.89 W (>1 % of load). pg=71.17 kW, pd=70.37 kW, p_loss=1.6 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_279`  
  Generator 'der_279' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1057`  
  Generator 'der_1057' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2310`  
  Generator 'der_2310' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2234`  
  Generator 'der_2234' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1423`  
  Generator 'der_1423' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1573`  
  Generator 'der_1573' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_349`  
  Generator 'der_349' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_799`  
  Generator 'der_799' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2020`  
  Generator 'der_2020' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1896`  
  Generator 'der_1896' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1779`  
  Generator 'der_1779' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_798`  
  Generator 'der_798' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1079`  
  Generator 'der_1079' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_306`  
  Generator 'der_306' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1762`  
  Generator 'der_1762' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1395`  
  Generator 'der_1395' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2454`  
  Generator 'der_2454' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1564`  
  Generator 'der_1564' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2291`  
  Generator 'der_2291' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2530`  
  Generator 'der_2530' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 804.89 W (>1 % of load). pg=71.17 kW, pd=70.37 kW, p_loss=1.6 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 20 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 20A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.54 V at bus '1523' — reflects the neutral shift under unbalanced loading.

