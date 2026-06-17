# BMOPF Solution Profile: network_4_Feeder_5

**Generated:** 2026-06-18 09:29:48  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 5.7015  
**Solve time:** 0.063 s  
**Findings:** 0 errors · 5 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 19.721 kW |
| Total load | 19.566 kW |
| Total line losses | 302.15 W |
| Loss fraction | 1.5% |
| Power balance error | 146.9 W |
| Max neutral shift | 1.433 V (bus `396`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 5 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_376` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_147` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_118` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_396` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_342` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_376`  
  Generator 'der_376' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_147`  
  Generator 'der_147' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_118`  
  Generator 'der_118' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_396`  
  Generator 'der_396' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_342`  
  Generator 'der_342' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 5 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 5A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.43 V at bus '396' — reflects the neutral shift under unbalanced loading.

