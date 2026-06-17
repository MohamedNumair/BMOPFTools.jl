# BMOPF Solution Profile: network_5_Feeder_4

**Generated:** 2026-06-18 07:11:47  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 2.5009  
**Solve time:** 0.061 s  
**Findings:** 0 errors · 9 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 25.499 kW |
| Total load | 24.858 kW |
| Total line losses | 1.234 kW |
| Loss fraction | 5.0% |
| Power balance error | 593.35 W |
| Max neutral shift | 4.372 V (bus `440`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 8 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_248` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_387` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_440` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_425` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_421` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_374` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_142` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_277` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 593.35 W (>1 % of load). pg=25.5 kW, pd=24.86 kW, p_loss=1.23 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_248`  
  Generator 'der_248' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_387`  
  Generator 'der_387' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_440`  
  Generator 'der_440' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_425`  
  Generator 'der_425' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_421`  
  Generator 'der_421' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_374`  
  Generator 'der_374' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_142`  
  Generator 'der_142' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_277`  
  Generator 'der_277' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 593.35 W (>1 % of load). pg=25.5 kW, pd=24.86 kW, p_loss=1.23 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 8 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 8A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 4.37 V at bus '440' — reflects the neutral shift under unbalanced loading.

