# BMOPF Solution Profile: network_5_Feeder_5

**Generated:** 2026-06-18 09:29:49  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 12.0352  
**Solve time:** 0.101 s  
**Findings:** 0 errors · 13 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 50.474 kW |
| Total load | 49.825 kW |
| Total line losses | 1.132 kW |
| Loss fraction | 2.3% |
| Power balance error | 482.92 W |
| Max neutral shift | 2.635 V (bus `1160`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 13 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_1066` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_621` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_820` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_780` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_597` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1091` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_779` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_615` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_48` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_551` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_734` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_315` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1160` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1066`  
  Generator 'der_1066' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_621`  
  Generator 'der_621' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_820`  
  Generator 'der_820' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_780`  
  Generator 'der_780' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_597`  
  Generator 'der_597' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1091`  
  Generator 'der_1091' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_779`  
  Generator 'der_779' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_615`  
  Generator 'der_615' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_48`  
  Generator 'der_48' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_551`  
  Generator 'der_551' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_734`  
  Generator 'der_734' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_315`  
  Generator 'der_315' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1160`  
  Generator 'der_1160' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 13 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 13A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.64 V at bus '1160' — reflects the neutral shift under unbalanced loading.

