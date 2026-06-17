# BMOPF Solution Profile: Network_24_Feeder_2

**Generated:** 2026-06-18 07:11:18  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 12.2045  
**Solve time:** 0.453 s  
**Findings:** 0 errors · 20 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 74.147 kW |
| Total load | 73.698 kW |
| Total line losses | 871.75 W |
| Loss fraction | 1.2% |
| Power balance error | 423.03 W |
| Max neutral shift | 1.483 V (bus `1455`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 20 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_1651` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1065` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1578` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1613` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1145` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_309` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_867` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1663` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_105` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_673` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1455` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1561` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1154` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_887` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_386` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_655` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_134` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1208` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1604` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1664` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1651`  
  Generator 'der_1651' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1065`  
  Generator 'der_1065' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1578`  
  Generator 'der_1578' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1613`  
  Generator 'der_1613' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1145`  
  Generator 'der_1145' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_309`  
  Generator 'der_309' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_867`  
  Generator 'der_867' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1663`  
  Generator 'der_1663' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_105`  
  Generator 'der_105' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_673`  
  Generator 'der_673' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1455`  
  Generator 'der_1455' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1561`  
  Generator 'der_1561' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1154`  
  Generator 'der_1154' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_887`  
  Generator 'der_887' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_386`  
  Generator 'der_386' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_655`  
  Generator 'der_655' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_134`  
  Generator 'der_134' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1208`  
  Generator 'der_1208' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1604`  
  Generator 'der_1604' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1664`  
  Generator 'der_1664' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 20 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 20A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.48 V at bus '1455' — reflects the neutral shift under unbalanced loading.

