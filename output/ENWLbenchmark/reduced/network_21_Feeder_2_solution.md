# BMOPF Solution Profile: network_21_Feeder_2

**Generated:** 2026-06-18 07:11:40  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 3.7208  
**Solve time:** 0.039 s  
**Findings:** 0 errors · 6 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 21.244 kW |
| Total load | 21.114 kW |
| Total line losses | 272.9 W |
| Loss fraction | 1.3% |
| Power balance error | 143.21 W |
| Max neutral shift | 1.038 V (bus `190`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 6 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_356` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_389` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_190` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_298` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_307` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_478` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_356`  
  Generator 'der_356' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_389`  
  Generator 'der_389' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_190`  
  Generator 'der_190' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_298`  
  Generator 'der_298' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_307`  
  Generator 'der_307' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_478`  
  Generator 'der_478' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 6 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 6A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.04 V at bus '190' — reflects the neutral shift under unbalanced loading.

