# BMOPF Solution Profile: network_11_Feeder_4

**Generated:** 2026-06-18 09:29:20  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 8.7546  
**Solve time:** 0.212 s  
**Findings:** 0 errors · 16 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 54.53 kW |
| Total load | 54.251 kW |
| Total line losses | 481.95 W |
| Loss fraction | 0.9% |
| Power balance error | 202.53 W |
| Max neutral shift | 1.162 V (bus `518`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 16 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_623` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_498` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_353` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_349` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_517` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_340` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_617` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_923` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_357` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_855` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_542` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_492` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_341` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_351` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_346` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_352` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_623`  
  Generator 'der_623' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_498`  
  Generator 'der_498' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_353`  
  Generator 'der_353' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_349`  
  Generator 'der_349' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_517`  
  Generator 'der_517' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_340`  
  Generator 'der_340' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_617`  
  Generator 'der_617' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_923`  
  Generator 'der_923' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_357`  
  Generator 'der_357' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_855`  
  Generator 'der_855' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_542`  
  Generator 'der_542' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_492`  
  Generator 'der_492' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_341`  
  Generator 'der_341' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_351`  
  Generator 'der_351' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_346`  
  Generator 'der_346' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_352`  
  Generator 'der_352' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 16 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 16A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.16 V at bus '518' — reflects the neutral shift under unbalanced loading.

