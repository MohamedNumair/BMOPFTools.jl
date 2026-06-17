# BMOPF Solution Profile: network_18_Feeder_4

**Generated:** 2026-06-18 07:11:37  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 3.7892  
**Solve time:** 0.055 s  
**Findings:** 0 errors · 9 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 28.645 kW |
| Total load | 28.518 kW |
| Total line losses | 348.46 W |
| Loss fraction | 1.2% |
| Power balance error | 221.42 W |
| Max neutral shift | 1.18 V (bus `1112`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 9 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_942` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1091` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_912` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1112` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_118` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_278` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_845` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_215` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_309` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_942`  
  Generator 'der_942' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1091`  
  Generator 'der_1091' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_912`  
  Generator 'der_912' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1112`  
  Generator 'der_1112' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_118`  
  Generator 'der_118' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_278`  
  Generator 'der_278' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_845`  
  Generator 'der_845' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_215`  
  Generator 'der_215' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_309`  
  Generator 'der_309' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 9 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 9A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.18 V at bus '1112' — reflects the neutral shift under unbalanced loading.

