# BMOPF Solution Profile: network_23_Feeder_2

**Generated:** 2026-06-18 07:11:41  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 16.2061  
**Solve time:** 0.104 s  
**Findings:** 0 errors · 12 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 49.703 kW |
| Total load | 48.931 kW |
| Total line losses | 1.24 kW |
| Loss fraction | 2.5% |
| Power balance error | 468.82 W |
| Max neutral shift | 3.591 V (bus `538`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 12 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_203` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_471` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_196` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_421` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_547` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_198` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_599` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_605` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_405` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_513` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_188` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_197` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_203`  
  Generator 'der_203' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_471`  
  Generator 'der_471' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_196`  
  Generator 'der_196' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_421`  
  Generator 'der_421' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_547`  
  Generator 'der_547' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_198`  
  Generator 'der_198' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_599`  
  Generator 'der_599' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_605`  
  Generator 'der_605' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_405`  
  Generator 'der_405' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_513`  
  Generator 'der_513' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_188`  
  Generator 'der_188' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_197`  
  Generator 'der_197' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 12 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 12A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 3.59 V at bus '538' — reflects the neutral shift under unbalanced loading.

