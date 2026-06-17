# BMOPF Solution Profile: network_16_Feeder_2

**Generated:** 2026-06-18 07:11:28  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 8.4088  
**Solve time:** 0.212 s  
**Findings:** 0 errors · 19 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 63.455 kW |
| Total load | 62.75 kW |
| Total line losses | 1.281 kW |
| Loss fraction | 2.0% |
| Power balance error | 576.19 W |
| Max neutral shift | 2.027 V (bus `1016`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 19 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_679` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1018` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_167` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_732` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_829` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_627` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_547` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_490` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_608` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_907` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_507` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_900` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_422` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_989` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_406` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_707` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1016` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_994` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_232` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_679`  
  Generator 'der_679' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1018`  
  Generator 'der_1018' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_167`  
  Generator 'der_167' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_732`  
  Generator 'der_732' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_829`  
  Generator 'der_829' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_627`  
  Generator 'der_627' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_547`  
  Generator 'der_547' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_490`  
  Generator 'der_490' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_608`  
  Generator 'der_608' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_907`  
  Generator 'der_907' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_507`  
  Generator 'der_507' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_900`  
  Generator 'der_900' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_422`  
  Generator 'der_422' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_989`  
  Generator 'der_989' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_406`  
  Generator 'der_406' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_707`  
  Generator 'der_707' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1016`  
  Generator 'der_1016' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_994`  
  Generator 'der_994' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_232`  
  Generator 'der_232' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 19 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 19A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.03 V at bus '1016' — reflects the neutral shift under unbalanced loading.

