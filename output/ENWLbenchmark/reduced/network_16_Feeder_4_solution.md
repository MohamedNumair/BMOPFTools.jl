# BMOPF Solution Profile: network_16_Feeder_4

**Generated:** 2026-06-18 09:29:28  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 8.2099  
**Solve time:** 0.326 s  
**Findings:** 0 errors · 16 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 54.034 kW |
| Total load | 53.399 kW |
| Total line losses | 1.832 kW |
| Loss fraction | 3.4% |
| Power balance error | 1.196 kW |
| Max neutral shift | 2.8 V (bus `1090`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 15 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_1449` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1027` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_133` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1427` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1130` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_257` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_879` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_787` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1467` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1302` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_472` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1186` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_957` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_958` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_293` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 1.196 kW (>1 % of load). pg=54.03 kW, pd=53.4 kW, p_loss=1.83 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1449`  
  Generator 'der_1449' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1027`  
  Generator 'der_1027' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_133`  
  Generator 'der_133' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1427`  
  Generator 'der_1427' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1130`  
  Generator 'der_1130' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_257`  
  Generator 'der_257' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_879`  
  Generator 'der_879' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_787`  
  Generator 'der_787' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1467`  
  Generator 'der_1467' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1302`  
  Generator 'der_1302' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_472`  
  Generator 'der_472' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1186`  
  Generator 'der_1186' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_957`  
  Generator 'der_957' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_958`  
  Generator 'der_958' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_293`  
  Generator 'der_293' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 1.196 kW (>1 % of load). pg=54.03 kW, pd=53.4 kW, p_loss=1.83 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 15 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 15A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.8 V at bus '1090' — reflects the neutral shift under unbalanced loading.

