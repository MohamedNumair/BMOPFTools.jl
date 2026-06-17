# BMOPF Solution Profile: network_15_Feeder_4

**Generated:** 2026-06-18 07:11:27  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 16.8568  
**Solve time:** 0.419 s  
**Findings:** 0 errors · 35 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 116.436 kW |
| Total load | 115.439 kW |
| Total line losses | 1.989 kW |
| Loss fraction | 1.7% |
| Power balance error | 992.23 W |
| Max neutral shift | 2.457 V (bus `2033`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 35 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_2556` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1018` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_4164` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1909` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1075` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3297` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3294` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3248` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_959` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_4521` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1942` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3193` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2195` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_594` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1595` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3983` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_570` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_4752` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1720` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_4735` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_275` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_4751` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3342` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3955` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1472` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_4711` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2444` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_4759` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2810` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3077` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1471` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3151` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_4710` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_3194` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_4691` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2556`  
  Generator 'der_2556' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1018`  
  Generator 'der_1018' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_4164`  
  Generator 'der_4164' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1909`  
  Generator 'der_1909' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1075`  
  Generator 'der_1075' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3297`  
  Generator 'der_3297' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3294`  
  Generator 'der_3294' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3248`  
  Generator 'der_3248' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_959`  
  Generator 'der_959' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_4521`  
  Generator 'der_4521' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1942`  
  Generator 'der_1942' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3193`  
  Generator 'der_3193' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2195`  
  Generator 'der_2195' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_594`  
  Generator 'der_594' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1595`  
  Generator 'der_1595' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3983`  
  Generator 'der_3983' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_570`  
  Generator 'der_570' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_4752`  
  Generator 'der_4752' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1720`  
  Generator 'der_1720' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_4735`  
  Generator 'der_4735' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_275`  
  Generator 'der_275' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_4751`  
  Generator 'der_4751' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3342`  
  Generator 'der_3342' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3955`  
  Generator 'der_3955' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1472`  
  Generator 'der_1472' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_4711`  
  Generator 'der_4711' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2444`  
  Generator 'der_2444' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_4759`  
  Generator 'der_4759' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2810`  
  Generator 'der_2810' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3077`  
  Generator 'der_3077' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1471`  
  Generator 'der_1471' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3151`  
  Generator 'der_3151' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_4710`  
  Generator 'der_4710' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_3194`  
  Generator 'der_3194' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_4691`  
  Generator 'der_4691' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 35 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 35A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.46 V at bus '2033' — reflects the neutral shift under unbalanced loading.

