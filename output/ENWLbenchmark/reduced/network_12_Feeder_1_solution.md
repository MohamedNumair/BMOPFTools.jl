# BMOPF Solution Profile: network_12_Feeder_1

**Generated:** 2026-06-18 07:11:23  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 16.5224  
**Solve time:** 0.385 s  
**Findings:** 0 errors · 41 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 140.089 kW |
| Total load | 138.128 kW |
| Total line losses | 4.629 kW |
| Loss fraction | 3.4% |
| Power balance error | 2.668 kW |
| Max neutral shift | 4.495 V (bus `3070`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 40 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_1066` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2711` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2709` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_160` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_202` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3117` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_316` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1806` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_296` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_161` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_164` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2091` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1859` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2836` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2477` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2752` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_429` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_229` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_207` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2696` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_235` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1900` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2282` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_547` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1961` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_170` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2016` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_331` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_162` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2465` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3070` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2906` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_916` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_212` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_220` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1174` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_182` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_273` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2289` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2534` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 2.668 kW (>1 % of load). pg=140.09 kW, pd=138.13 kW, p_loss=4.63 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1066`  
  Generator 'der_1066' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2711`  
  Generator 'der_2711' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2709`  
  Generator 'der_2709' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_160`  
  Generator 'der_160' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_202`  
  Generator 'der_202' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3117`  
  Generator 'der_3117' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_316`  
  Generator 'der_316' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1806`  
  Generator 'der_1806' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_296`  
  Generator 'der_296' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_161`  
  Generator 'der_161' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_164`  
  Generator 'der_164' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2091`  
  Generator 'der_2091' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1859`  
  Generator 'der_1859' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2836`  
  Generator 'der_2836' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2477`  
  Generator 'der_2477' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2752`  
  Generator 'der_2752' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_429`  
  Generator 'der_429' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_229`  
  Generator 'der_229' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_207`  
  Generator 'der_207' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2696`  
  Generator 'der_2696' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_235`  
  Generator 'der_235' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1900`  
  Generator 'der_1900' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2282`  
  Generator 'der_2282' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_547`  
  Generator 'der_547' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1961`  
  Generator 'der_1961' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_170`  
  Generator 'der_170' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2016`  
  Generator 'der_2016' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_331`  
  Generator 'der_331' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_162`  
  Generator 'der_162' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2465`  
  Generator 'der_2465' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3070`  
  Generator 'der_3070' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2906`  
  Generator 'der_2906' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_916`  
  Generator 'der_916' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_212`  
  Generator 'der_212' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_220`  
  Generator 'der_220' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1174`  
  Generator 'der_1174' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_182`  
  Generator 'der_182' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_273`  
  Generator 'der_273' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2289`  
  Generator 'der_2289' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2534`  
  Generator 'der_2534' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 2.668 kW (>1 % of load). pg=140.09 kW, pd=138.13 kW, p_loss=4.63 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 40 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 40A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 4.49 V at bus '3070' — reflects the neutral shift under unbalanced loading.

