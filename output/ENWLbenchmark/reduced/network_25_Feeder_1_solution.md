# BMOPF Solution Profile: network_25_Feeder_1

**Generated:** 2026-06-18 07:11:42  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 3.5094  
**Solve time:** 0.026 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 13.221 kW |
| Total load | 13.188 kW |
| Total line losses | 47.83 W |
| Loss fraction | 0.4% |
| Power balance error | 15.06 W |
| Max neutral shift | 0.359 V (bus `390`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 3 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_238` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_252` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_390` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_238`  
  Generator 'der_238' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_252`  
  Generator 'der_252' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_390`  
  Generator 'der_390' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.36 V at bus '390' — reflects the neutral shift under unbalanced loading.

