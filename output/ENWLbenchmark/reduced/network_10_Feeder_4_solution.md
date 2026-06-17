# BMOPF Solution Profile: network_10_Feeder_4

**Generated:** 2026-06-18 09:29:19  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 2.8396  
**Solve time:** 0.013 s  
**Findings:** 0 errors · 2 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 12.017 kW |
| Total load | 11.982 kW |
| Total line losses | 73.42 W |
| Loss fraction | 0.6% |
| Power balance error | 38.6 W |
| Max neutral shift | 0.755 V (bus `496`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 2 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_273` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_495` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_273`  
  Generator 'der_273' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_495`  
  Generator 'der_495' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 2 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 2A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.76 V at bus '496' — reflects the neutral shift under unbalanced loading.

