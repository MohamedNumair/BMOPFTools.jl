# BMOPF Solution Profile: network_4_Feeder_3

**Generated:** 2026-06-18 09:29:48  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 3.6061  
**Solve time:** 0.04 s  
**Findings:** 0 errors · 5 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 17.208 kW |
| Total load | 17.034 kW |
| Total line losses | 305.37 W |
| Loss fraction | 1.8% |
| Power balance error | 131.61 W |
| Max neutral shift | 1.173 V (bus `234`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 5 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_234` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_212` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_194` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_90` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_183` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_234`  
  Generator 'der_234' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_212`  
  Generator 'der_212' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_194`  
  Generator 'der_194' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_90`  
  Generator 'der_90' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_183`  
  Generator 'der_183' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 5 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 5A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.17 V at bus '234' — reflects the neutral shift under unbalanced loading.

