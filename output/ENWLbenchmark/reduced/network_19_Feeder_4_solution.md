# BMOPF Solution Profile: network_19_Feeder_4

**Generated:** 2026-06-18 09:29:39  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 11.8121  
**Solve time:** 0.245 s  
**Findings:** 0 errors · 14 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 52.082 kW |
| Total load | 51.907 kW |
| Total line losses | 434.14 W |
| Loss fraction | 0.8% |
| Power balance error | 259.12 W |
| Max neutral shift | 0.987 V (bus `939`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 14 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_832` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_98` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_970` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_813` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_301` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1098` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_874` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_975` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_467` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_422` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_958` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_497` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_478` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_258` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_832`  
  Generator 'der_832' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_98`  
  Generator 'der_98' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_970`  
  Generator 'der_970' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_813`  
  Generator 'der_813' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_301`  
  Generator 'der_301' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1098`  
  Generator 'der_1098' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_874`  
  Generator 'der_874' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_975`  
  Generator 'der_975' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_467`  
  Generator 'der_467' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_422`  
  Generator 'der_422' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_958`  
  Generator 'der_958' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_497`  
  Generator 'der_497' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_478`  
  Generator 'der_478' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_258`  
  Generator 'der_258' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 14 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 14A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.99 V at bus '939' — reflects the neutral shift under unbalanced loading.

