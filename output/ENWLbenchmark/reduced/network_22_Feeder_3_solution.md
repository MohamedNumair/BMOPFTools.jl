# BMOPF Solution Profile: network_22_Feeder_3

**Generated:** 2026-06-18 09:29:42  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 12.0404  
**Solve time:** 0.182 s  
**Findings:** 0 errors · 13 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 50.332 kW |
| Total load | 49.501 kW |
| Total line losses | 1.941 kW |
| Loss fraction | 3.9% |
| Power balance error | 1.11 kW |
| Max neutral shift | 4.156 V (bus `894`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 12 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_949` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_116` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_773` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_627` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_348` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_179` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_198` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_808` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_166` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_779` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_384` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_618` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 1.11 kW (>1 % of load). pg=50.33 kW, pd=49.5 kW, p_loss=1.94 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_949`  
  Generator 'der_949' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_116`  
  Generator 'der_116' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_773`  
  Generator 'der_773' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_627`  
  Generator 'der_627' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_348`  
  Generator 'der_348' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_179`  
  Generator 'der_179' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_198`  
  Generator 'der_198' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_808`  
  Generator 'der_808' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_166`  
  Generator 'der_166' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_779`  
  Generator 'der_779' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_384`  
  Generator 'der_384' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_618`  
  Generator 'der_618' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 1.11 kW (>1 % of load). pg=50.33 kW, pd=49.5 kW, p_loss=1.94 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 12 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 12A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 4.16 V at bus '894' — reflects the neutral shift under unbalanced loading.

