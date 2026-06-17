# BMOPF Solution Profile: network_5_Feeder_7

**Generated:** 2026-06-18 07:11:47  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 4.3022  
**Solve time:** 0.034 s  
**Findings:** 0 errors · 6 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 21.208 kW |
| Total load | 21.114 kW |
| Total line losses | 179.7 W |
| Loss fraction | 0.9% |
| Power balance error | 85.46 W |
| Max neutral shift | 0.902 V (bus `297`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 6 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_129` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_297` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_79` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_60` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_221` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_77` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_129`  
  Generator 'der_129' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_297`  
  Generator 'der_297' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_79`  
  Generator 'der_79' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_60`  
  Generator 'der_60' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_221`  
  Generator 'der_221' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_77`  
  Generator 'der_77' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 6 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 6A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.9 V at bus '297' — reflects the neutral shift under unbalanced loading.

