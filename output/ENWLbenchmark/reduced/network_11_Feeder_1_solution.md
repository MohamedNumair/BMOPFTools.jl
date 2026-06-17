# BMOPF Solution Profile: network_11_Feeder_1

**Generated:** 2026-06-18 09:29:19  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 2.2547  
**Solve time:** 0.101 s  
**Findings:** 0 errors · 8 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 25.28 kW |
| Total load | 25.14 kW |
| Total line losses | 285.06 W |
| Loss fraction | 1.1% |
| Power balance error | 145.14 W |
| Max neutral shift | 0.963 V (bus `141`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 8 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_122` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_204` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_207` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_202` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_210` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_199` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_121` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_128` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_122`  
  Generator 'der_122' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_204`  
  Generator 'der_204' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_207`  
  Generator 'der_207' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_202`  
  Generator 'der_202' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_210`  
  Generator 'der_210' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_199`  
  Generator 'der_199' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_121`  
  Generator 'der_121' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_128`  
  Generator 'der_128' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 8 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 8A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.96 V at bus '141' — reflects the neutral shift under unbalanced loading.

