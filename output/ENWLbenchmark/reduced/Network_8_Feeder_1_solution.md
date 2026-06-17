# BMOPF Solution Profile: Network_8_Feeder_1

**Generated:** 2026-06-18 07:11:19  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 11.3179  
**Solve time:** 0.175 s  
**Findings:** 0 errors · 13 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 50.91 kW |
| Total load | 50.701 kW |
| Total line losses | 469.29 W |
| Loss fraction | 0.9% |
| Power balance error | 260.45 W |
| Max neutral shift | 1.21 V (bus `1929`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 13 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_894` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_439` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_409` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1723` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1911` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_631` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1786` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_602` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1764` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_731` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1901` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1234` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1212` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_894`  
  Generator 'der_894' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_439`  
  Generator 'der_439' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_409`  
  Generator 'der_409' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1723`  
  Generator 'der_1723' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1911`  
  Generator 'der_1911' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_631`  
  Generator 'der_631' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1786`  
  Generator 'der_1786' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_602`  
  Generator 'der_602' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1764`  
  Generator 'der_1764' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_731`  
  Generator 'der_731' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1901`  
  Generator 'der_1901' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1234`  
  Generator 'der_1234' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1212`  
  Generator 'der_1212' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 13 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 13A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.21 V at bus '1929' — reflects the neutral shift under unbalanced loading.

