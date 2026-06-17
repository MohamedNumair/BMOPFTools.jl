# BMOPF Solution Profile: network_11_Feeder_3

**Generated:** 2026-06-18 07:11:22  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -2.2718  
**Solve time:** 0.06 s  
**Findings:** 0 errors · 9 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 26.039 kW |
| Total load | 25.77 kW |
| Total line losses | 476.97 W |
| Loss fraction | 1.9% |
| Power balance error | 207.98 W |
| Max neutral shift | 1.959 V (bus `1067`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 9 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_549` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1073` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_727` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1059` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1067` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_584` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1076` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1068` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_77` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_549`  
  Generator 'der_549' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1073`  
  Generator 'der_1073' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_727`  
  Generator 'der_727' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1059`  
  Generator 'der_1059' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1067`  
  Generator 'der_1067' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_584`  
  Generator 'der_584' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1076`  
  Generator 'der_1076' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1068`  
  Generator 'der_1068' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_77`  
  Generator 'der_77' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 9 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 9A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.96 V at bus '1067' — reflects the neutral shift under unbalanced loading.

