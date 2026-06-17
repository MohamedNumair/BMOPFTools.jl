# BMOPF Solution Profile: network_15_Feeder_7

**Generated:** 2026-06-18 09:29:27  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 12.2245  
**Solve time:** 0.203 s  
**Findings:** 0 errors · 14 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 52.25 kW |
| Total load | 51.907 kW |
| Total line losses | 492.17 W |
| Loss fraction | 0.9% |
| Power balance error | 148.95 W |
| Max neutral shift | 1.392 V (bus `515`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 14 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_566` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_950` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_423` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1236` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_515` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1119` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1139` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_979` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_306` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_956` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1140` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_424` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_497` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_508` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_566`  
  Generator 'der_566' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_950`  
  Generator 'der_950' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_423`  
  Generator 'der_423' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1236`  
  Generator 'der_1236' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_515`  
  Generator 'der_515' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1119`  
  Generator 'der_1119' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1139`  
  Generator 'der_1139' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_979`  
  Generator 'der_979' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_306`  
  Generator 'der_306' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_956`  
  Generator 'der_956' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1140`  
  Generator 'der_1140' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_424`  
  Generator 'der_424' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_497`  
  Generator 'der_497' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_508`  
  Generator 'der_508' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 14 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 14A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.39 V at bus '515' — reflects the neutral shift under unbalanced loading.

