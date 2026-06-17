# BMOPF Solution Profile: network_9_Feeder_5

**Generated:** 2026-06-18 09:29:54  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 16.7208  
**Solve time:** 0.63 s  
**Findings:** 0 errors · 31 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 109.103 kW |
| Total load | 108.154 kW |
| Total line losses | 1.674 kW |
| Loss fraction | 1.5% |
| Power balance error | 724.35 W |
| Max neutral shift | 2.671 V (bus `2822`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 2 |
| Generator| 0 | 29 |

## 3. Thermal Limits

| Sev | Component | ID | Terminal | cm (A) | i\_max (A) |
|-----|-----------|----|---------:|-------:|----------:|
| W | line | `line317` | `1` | 75.0 | 75.0 |
| W | line | `line317` | `n` | 75.0 | 75.0 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_3582` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1422` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3271` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3394` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2948` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2453` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3106` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1425` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3067` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1703` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3236` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2562` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2583` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2143` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3527` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_399` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3285` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2321` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2858` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1145` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1705` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_383` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2985` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_306` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1005` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2512` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2755` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_352` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1062` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line317`  
  Line 'line317' conductor '1': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line317`  
  Line 'line317' conductor 'n': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3582`  
  Generator 'der_3582' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1422`  
  Generator 'der_1422' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3271`  
  Generator 'der_3271' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3394`  
  Generator 'der_3394' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2948`  
  Generator 'der_2948' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2453`  
  Generator 'der_2453' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3106`  
  Generator 'der_3106' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1425`  
  Generator 'der_1425' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3067`  
  Generator 'der_3067' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1703`  
  Generator 'der_1703' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3236`  
  Generator 'der_3236' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2562`  
  Generator 'der_2562' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2583`  
  Generator 'der_2583' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2143`  
  Generator 'der_2143' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3527`  
  Generator 'der_3527' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_399`  
  Generator 'der_399' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3285`  
  Generator 'der_3285' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2321`  
  Generator 'der_2321' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2858`  
  Generator 'der_2858' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1145`  
  Generator 'der_1145' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1705`  
  Generator 'der_1705' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_383`  
  Generator 'der_383' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2985`  
  Generator 'der_2985' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_306`  
  Generator 'der_306' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1005`  
  Generator 'der_1005' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2512`  
  Generator 'der_2512' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2755`  
  Generator 'der_2755' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_352`  
  Generator 'der_352' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1062`  
  Generator 'der_1062' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 31 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 2A. Generator: 0V / 29A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.67 V at bus '2822' — reflects the neutral shift under unbalanced loading.

