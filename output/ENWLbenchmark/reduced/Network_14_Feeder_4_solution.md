# BMOPF Solution Profile: Network_14_Feeder_4

**Generated:** 2026-06-18 07:11:18  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 14.2375  
**Solve time:** 0.185 s  
**Findings:** 0 errors · 17 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 60.295 kW |
| Total load | 59.759 kW |
| Total line losses | 911.18 W |
| Loss fraction | 1.5% |
| Power balance error | 375.12 W |
| Max neutral shift | 1.574 V (bus `1516`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 17 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_1361` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1516` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1535` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_381` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1761` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1503` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1513` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_385` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1697` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1791` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_386` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_384` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1589` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1504` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1620` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1783` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_380` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1361`  
  Generator 'der_1361' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1516`  
  Generator 'der_1516' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1535`  
  Generator 'der_1535' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_381`  
  Generator 'der_381' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1761`  
  Generator 'der_1761' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1503`  
  Generator 'der_1503' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1513`  
  Generator 'der_1513' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_385`  
  Generator 'der_385' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1697`  
  Generator 'der_1697' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1791`  
  Generator 'der_1791' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_386`  
  Generator 'der_386' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_384`  
  Generator 'der_384' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1589`  
  Generator 'der_1589' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1504`  
  Generator 'der_1504' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1620`  
  Generator 'der_1620' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1783`  
  Generator 'der_1783' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_380`  
  Generator 'der_380' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 17 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 17A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.57 V at bus '1516' — reflects the neutral shift under unbalanced loading.

