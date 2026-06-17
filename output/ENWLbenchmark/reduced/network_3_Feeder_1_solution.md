# BMOPF Solution Profile: network_3_Feeder_1

**Generated:** 2026-06-18 07:11:44  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 13.1813  
**Solve time:** 0.172 s  
**Findings:** 0 errors · 25 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 83.995 kW |
| Total load | 83.254 kW |
| Total line losses | 2.168 kW |
| Loss fraction | 2.6% |
| Power balance error | 1.427 kW |
| Max neutral shift | 1.677 V (bus `815`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 24 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_904` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1065` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_382` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_937` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_296` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1090` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_260` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_417` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_659` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_797` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_570` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_449` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_215` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_499` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1010` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_547` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1019` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1049` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_815` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_772` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_100` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_420` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_693` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_613` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 1.427 kW (>1 % of load). pg=83.99 kW, pd=83.25 kW, p_loss=2.17 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_904`  
  Generator 'der_904' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1065`  
  Generator 'der_1065' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_382`  
  Generator 'der_382' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_937`  
  Generator 'der_937' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_296`  
  Generator 'der_296' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1090`  
  Generator 'der_1090' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_260`  
  Generator 'der_260' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_417`  
  Generator 'der_417' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_659`  
  Generator 'der_659' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_797`  
  Generator 'der_797' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_570`  
  Generator 'der_570' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_449`  
  Generator 'der_449' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_215`  
  Generator 'der_215' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_499`  
  Generator 'der_499' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1010`  
  Generator 'der_1010' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_547`  
  Generator 'der_547' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1019`  
  Generator 'der_1019' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1049`  
  Generator 'der_1049' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_815`  
  Generator 'der_815' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_772`  
  Generator 'der_772' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_100`  
  Generator 'der_100' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_420`  
  Generator 'der_420' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_693`  
  Generator 'der_693' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_613`  
  Generator 'der_613' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 1.427 kW (>1 % of load). pg=83.99 kW, pd=83.25 kW, p_loss=2.17 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 24 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 24A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.68 V at bus '815' — reflects the neutral shift under unbalanced loading.

