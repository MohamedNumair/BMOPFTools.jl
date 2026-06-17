# BMOPF Solution Profile: network_1_Feeder_1

**Generated:** 2026-06-18 09:29:40  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 10.527  
**Solve time:** 0.134 s  
**Findings:** 0 errors · 14 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 52.596 kW |
| Total load | 52.343 kW |
| Total line losses | 362.7 W |
| Loss fraction | 0.7% |
| Power balance error | 109.32 W |
| Max neutral shift | 1.158 V (bus `208`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 14 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_785` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_701` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_208` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_34` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_813` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_458` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_639` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_327` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_780` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_387` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_629` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_900` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_406` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_342` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_785`  
  Generator 'der_785' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_701`  
  Generator 'der_701' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_208`  
  Generator 'der_208' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_34`  
  Generator 'der_34' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_813`  
  Generator 'der_813' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_458`  
  Generator 'der_458' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_639`  
  Generator 'der_639' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_327`  
  Generator 'der_327' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_780`  
  Generator 'der_780' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_387`  
  Generator 'der_387' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_629`  
  Generator 'der_629' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_900`  
  Generator 'der_900' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_406`  
  Generator 'der_406' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_342`  
  Generator 'der_342' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 14 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 14A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.16 V at bus '208' — reflects the neutral shift under unbalanced loading.

