# BMOPF Solution Profile: network_3_Feeder_5

**Generated:** 2026-06-18 09:29:47  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 3.648  
**Solve time:** 0.069 s  
**Findings:** 0 errors · 6 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 19.994 kW |
| Total load | 19.902 kW |
| Total line losses | 201.71 W |
| Loss fraction | 1.0% |
| Power balance error | 109.8 W |
| Max neutral shift | 1.86 V (bus `315`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 6 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_234` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_309` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_130` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_137` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_315` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_284` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_234`  
  Generator 'der_234' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_309`  
  Generator 'der_309' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_130`  
  Generator 'der_130' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_137`  
  Generator 'der_137' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_315`  
  Generator 'der_315' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_284`  
  Generator 'der_284' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 6 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 6A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.86 V at bus '315' — reflects the neutral shift under unbalanced loading.

