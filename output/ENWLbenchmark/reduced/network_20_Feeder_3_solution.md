# BMOPF Solution Profile: network_20_Feeder_3

**Generated:** 2026-06-18 07:11:40  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 4.7028  
**Solve time:** 0.077 s  
**Findings:** 0 errors · 15 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 54.147 kW |
| Total load | 53.663 kW |
| Total line losses | 941.91 W |
| Loss fraction | 1.8% |
| Power balance error | 457.47 W |
| Max neutral shift | 2.45 V (bus `646`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 15 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_345` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_338` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_241` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_349` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_490` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_340` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_179` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_646` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_346` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_323` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_344` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_325` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_512` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_342` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_579` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_345`  
  Generator 'der_345' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_338`  
  Generator 'der_338' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_241`  
  Generator 'der_241' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_349`  
  Generator 'der_349' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_490`  
  Generator 'der_490' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_340`  
  Generator 'der_340' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_179`  
  Generator 'der_179' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_646`  
  Generator 'der_646' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_346`  
  Generator 'der_346' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_323`  
  Generator 'der_323' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_344`  
  Generator 'der_344' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_325`  
  Generator 'der_325' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_512`  
  Generator 'der_512' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_342`  
  Generator 'der_342' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_579`  
  Generator 'der_579' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 15 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 15A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.45 V at bus '646' — reflects the neutral shift under unbalanced loading.

