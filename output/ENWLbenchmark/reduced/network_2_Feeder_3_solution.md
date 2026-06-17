# BMOPF Solution Profile: network_2_Feeder_3

**Generated:** 2026-06-18 09:29:45  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 18.5002  
**Solve time:** 0.293 s  
**Findings:** 0 errors · 29 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 99.967 kW |
| Total load | 98.602 kW |
| Total line losses | 2.599 kW |
| Loss fraction | 2.6% |
| Power balance error | 1.234 kW |
| Max neutral shift | 4.123 V (bus `1676`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 28 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_1522` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1270` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1676` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_954` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_224` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_617` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1360` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_309` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1349` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1513` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1255` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1248` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1398` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1141` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1170` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1636` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_176` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_756` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1673` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_781` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1569` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1095` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_180` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_372` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1556` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_626` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_775` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1537` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 1.234 kW (>1 % of load). pg=99.97 kW, pd=98.6 kW, p_loss=2.6 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1522`  
  Generator 'der_1522' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1270`  
  Generator 'der_1270' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1676`  
  Generator 'der_1676' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_954`  
  Generator 'der_954' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_224`  
  Generator 'der_224' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_617`  
  Generator 'der_617' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1360`  
  Generator 'der_1360' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_309`  
  Generator 'der_309' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1349`  
  Generator 'der_1349' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1513`  
  Generator 'der_1513' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1255`  
  Generator 'der_1255' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1248`  
  Generator 'der_1248' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1398`  
  Generator 'der_1398' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1141`  
  Generator 'der_1141' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1170`  
  Generator 'der_1170' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1636`  
  Generator 'der_1636' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_176`  
  Generator 'der_176' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_756`  
  Generator 'der_756' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1673`  
  Generator 'der_1673' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_781`  
  Generator 'der_781' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1569`  
  Generator 'der_1569' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1095`  
  Generator 'der_1095' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_180`  
  Generator 'der_180' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_372`  
  Generator 'der_372' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1556`  
  Generator 'der_1556' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_626`  
  Generator 'der_626' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_775`  
  Generator 'der_775' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1537`  
  Generator 'der_1537' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 1.234 kW (>1 % of load). pg=99.97 kW, pd=98.6 kW, p_loss=2.6 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 28 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 28A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 4.12 V at bus '1676' — reflects the neutral shift under unbalanced loading.

