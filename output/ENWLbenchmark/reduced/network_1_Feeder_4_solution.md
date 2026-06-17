# BMOPF Solution Profile: network_1_Feeder_4

**Generated:** 2026-06-18 07:11:39  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 14.4684  
**Solve time:** 0.139 s  
**Findings:** 0 errors · 20 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 71.85 kW |
| Total load | 69.804 kW |
| Total line losses | 3.154 kW |
| Loss fraction | 4.5% |
| Power balance error | 1.108 kW |
| Max neutral shift | 5.983 V (bus `1230`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 19 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_679` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_783` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_591` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_645` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_416` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1144` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_280` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_522` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_945` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_520` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_292` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_311` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_411` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_989` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1163` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1085` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_53` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_854` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1212` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 1.108 kW (>1 % of load). pg=71.85 kW, pd=69.8 kW, p_loss=3.15 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_679`  
  Generator 'der_679' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_783`  
  Generator 'der_783' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_591`  
  Generator 'der_591' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_645`  
  Generator 'der_645' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_416`  
  Generator 'der_416' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1144`  
  Generator 'der_1144' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_280`  
  Generator 'der_280' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_522`  
  Generator 'der_522' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_945`  
  Generator 'der_945' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_520`  
  Generator 'der_520' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_292`  
  Generator 'der_292' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_311`  
  Generator 'der_311' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_411`  
  Generator 'der_411' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_989`  
  Generator 'der_989' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1163`  
  Generator 'der_1163' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1085`  
  Generator 'der_1085' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_53`  
  Generator 'der_53' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_854`  
  Generator 'der_854' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1212`  
  Generator 'der_1212' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 1.108 kW (>1 % of load). pg=71.85 kW, pd=69.8 kW, p_loss=3.15 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 19 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 19A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 5.98 V at bus '1230' — reflects the neutral shift under unbalanced loading.

