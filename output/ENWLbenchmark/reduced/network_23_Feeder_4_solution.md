# BMOPF Solution Profile: network_23_Feeder_4

**Generated:** 2026-06-18 09:29:43  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 5.9857  
**Solve time:** 0.344 s  
**Findings:** 0 errors · 23 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 79.582 kW |
| Total load | 78.898 kW |
| Total line losses | 1.124 kW |
| Loss fraction | 1.4% |
| Power balance error | 439.47 W |
| Max neutral shift | 1.94 V (bus `486`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 23 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_832` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_488` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_792` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_557` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_382` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_423` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_457` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1216` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1017` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_598` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_858` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_487` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_873` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_476` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_484` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_666` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_555` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_384` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_405` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1113` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_406` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_994` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1148` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_832`  
  Generator 'der_832' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_488`  
  Generator 'der_488' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_792`  
  Generator 'der_792' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_557`  
  Generator 'der_557' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_382`  
  Generator 'der_382' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_423`  
  Generator 'der_423' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_457`  
  Generator 'der_457' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1216`  
  Generator 'der_1216' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1017`  
  Generator 'der_1017' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_598`  
  Generator 'der_598' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_858`  
  Generator 'der_858' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_487`  
  Generator 'der_487' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_873`  
  Generator 'der_873' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_476`  
  Generator 'der_476' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_484`  
  Generator 'der_484' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_666`  
  Generator 'der_666' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_555`  
  Generator 'der_555' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_384`  
  Generator 'der_384' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_405`  
  Generator 'der_405' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1113`  
  Generator 'der_1113' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_406`  
  Generator 'der_406' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_994`  
  Generator 'der_994' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1148`  
  Generator 'der_1148' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 23 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 23A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.94 V at bus '486' — reflects the neutral shift under unbalanced loading.

