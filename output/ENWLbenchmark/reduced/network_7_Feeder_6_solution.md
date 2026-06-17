# BMOPF Solution Profile: network_7_Feeder_6

**Generated:** 2026-06-18 09:29:53  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 2.104  
**Solve time:** 0.042 s  
**Findings:** 0 errors · 6 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 21.177 kW |
| Total load | 21.114 kW |
| Total line losses | 105.73 W |
| Loss fraction | 0.5% |
| Power balance error | 42.32 W |
| Max neutral shift | 0.65 V (bus `153`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 6 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_108` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_97` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_153` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_101` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_100` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_195` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_108`  
  Generator 'der_108' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_97`  
  Generator 'der_97' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_153`  
  Generator 'der_153' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_101`  
  Generator 'der_101' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_100`  
  Generator 'der_100' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_195`  
  Generator 'der_195' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 6 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 6A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.65 V at bus '153' — reflects the neutral shift under unbalanced loading.

