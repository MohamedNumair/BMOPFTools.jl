# BMOPF Solution Profile: network_17_Feeder_3

**Generated:** 2026-06-18 09:29:31  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 14.5845  
**Solve time:** 0.291 s  
**Findings:** 0 errors · 20 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 74.138 kW |
| Total load | 73.362 kW |
| Total line losses | 1.422 kW |
| Loss fraction | 1.9% |
| Power balance error | 645.99 W |
| Max neutral shift | 3.658 V (bus `734`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 20 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_1131` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1027` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_638` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_744` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_792` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_374` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1122` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_364` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_923` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_363` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_308` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1129` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_572` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_887` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_768` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_297` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_445` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_651` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_468` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1133` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1131`  
  Generator 'der_1131' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1027`  
  Generator 'der_1027' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_638`  
  Generator 'der_638' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_744`  
  Generator 'der_744' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_792`  
  Generator 'der_792' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_374`  
  Generator 'der_374' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1122`  
  Generator 'der_1122' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_364`  
  Generator 'der_364' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_923`  
  Generator 'der_923' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_363`  
  Generator 'der_363' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_308`  
  Generator 'der_308' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1129`  
  Generator 'der_1129' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_572`  
  Generator 'der_572' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_887`  
  Generator 'der_887' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_768`  
  Generator 'der_768' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_297`  
  Generator 'der_297' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_445`  
  Generator 'der_445' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_651`  
  Generator 'der_651' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_468`  
  Generator 'der_468' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1133`  
  Generator 'der_1133' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 20 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 20A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 3.66 V at bus '734' — reflects the neutral shift under unbalanced loading.

