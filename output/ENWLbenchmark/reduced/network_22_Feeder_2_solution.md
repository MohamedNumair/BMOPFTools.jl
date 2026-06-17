# BMOPF Solution Profile: network_22_Feeder_2

**Generated:** 2026-06-18 09:29:41  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 2.6073  
**Solve time:** 0.062 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 13.844 kW |
| Total load | 13.764 kW |
| Total line losses | 185.26 W |
| Loss fraction | 1.3% |
| Power balance error | 105.35 W |
| Max neutral shift | 0.644 V (bus `174`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 4 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_150` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_216` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_251` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_183` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_150`  
  Generator 'der_150' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_216`  
  Generator 'der_216' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_251`  
  Generator 'der_251' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_183`  
  Generator 'der_183' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 4 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 4A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.64 V at bus '174' — reflects the neutral shift under unbalanced loading.

