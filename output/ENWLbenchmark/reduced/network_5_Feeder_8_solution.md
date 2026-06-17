# BMOPF Solution Profile: network_5_Feeder_8

**Generated:** 2026-06-18 07:11:47  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 2.2859  
**Solve time:** 0.058 s  
**Findings:** 0 errors · 10 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 30.615 kW |
| Total load | 30.355 kW |
| Total line losses | 446.5 W |
| Loss fraction | 1.5% |
| Power balance error | 186.33 W |
| Max neutral shift | 1.36 V (bus `178`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 10 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_454` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_178` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_150` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_326` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_55` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_446` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_161` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_48` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_389` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_315` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_454`  
  Generator 'der_454' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_178`  
  Generator 'der_178' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_150`  
  Generator 'der_150' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_326`  
  Generator 'der_326' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_55`  
  Generator 'der_55' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_446`  
  Generator 'der_446' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_161`  
  Generator 'der_161' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_48`  
  Generator 'der_48' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_389`  
  Generator 'der_389' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_315`  
  Generator 'der_315' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 10 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 10A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.36 V at bus '178' — reflects the neutral shift under unbalanced loading.

