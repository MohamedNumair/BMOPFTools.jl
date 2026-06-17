# BMOPF Solution Profile: network_3_Feeder_4

**Generated:** 2026-06-18 07:11:45  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 2.6171  
**Solve time:** 0.11 s  
**Findings:** 0 errors · 11 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 30.906 kW |
| Total load | 30.355 kW |
| Total line losses | 972.72 W |
| Loss fraction | 3.2% |
| Power balance error | 421.61 W |
| Max neutral shift | 4.439 V (bus `598`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 10 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_133` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_388` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_64` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_160` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_67` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_395` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_597` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_210` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_598` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_478` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 421.61 W (>1 % of load). pg=30.91 kW, pd=30.36 kW, p_loss=0.97 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_133`  
  Generator 'der_133' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_388`  
  Generator 'der_388' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_64`  
  Generator 'der_64' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_160`  
  Generator 'der_160' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_67`  
  Generator 'der_67' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_395`  
  Generator 'der_395' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_597`  
  Generator 'der_597' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_210`  
  Generator 'der_210' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_598`  
  Generator 'der_598' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_478`  
  Generator 'der_478' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 421.61 W (>1 % of load). pg=30.91 kW, pd=30.36 kW, p_loss=0.97 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 10 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 10A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 4.44 V at bus '598' — reflects the neutral shift under unbalanced loading.

