# BMOPF Solution Profile: network_2_Feeder_4

**Generated:** 2026-06-18 09:29:46  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 10.1862  
**Solve time:** 0.415 s  
**Findings:** 0 errors · 29 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 102.859 kW |
| Total load | 101.716 kW |
| Total line losses | 1.907 kW |
| Loss fraction | 1.9% |
| Power balance error | 763.52 W |
| Max neutral shift | 4.749 V (bus `1604`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 29 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_509` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1576` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1134` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1308` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_851` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1047` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1555` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_917` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_526` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1383` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_572` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_251` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1348` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_858` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_796` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_293` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_942` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_690` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1298` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1286` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1501` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_262` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1507` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_842` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_595` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_915` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1604` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_579` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1160` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_509`  
  Generator 'der_509' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1576`  
  Generator 'der_1576' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1134`  
  Generator 'der_1134' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1308`  
  Generator 'der_1308' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_851`  
  Generator 'der_851' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1047`  
  Generator 'der_1047' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1555`  
  Generator 'der_1555' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_917`  
  Generator 'der_917' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_526`  
  Generator 'der_526' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1383`  
  Generator 'der_1383' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_572`  
  Generator 'der_572' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_251`  
  Generator 'der_251' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1348`  
  Generator 'der_1348' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_858`  
  Generator 'der_858' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_796`  
  Generator 'der_796' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_293`  
  Generator 'der_293' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_942`  
  Generator 'der_942' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_690`  
  Generator 'der_690' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1298`  
  Generator 'der_1298' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1286`  
  Generator 'der_1286' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1501`  
  Generator 'der_1501' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_262`  
  Generator 'der_262' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1507`  
  Generator 'der_1507' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_842`  
  Generator 'der_842' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_595`  
  Generator 'der_595' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_915`  
  Generator 'der_915' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1604`  
  Generator 'der_1604' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_579`  
  Generator 'der_579' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1160`  
  Generator 'der_1160' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 29 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 29A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 4.75 V at bus '1604' — reflects the neutral shift under unbalanced loading.

