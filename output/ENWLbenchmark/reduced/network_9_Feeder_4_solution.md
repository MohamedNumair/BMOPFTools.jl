# BMOPF Solution Profile: network_9_Feeder_4

**Generated:** 2026-06-18 09:29:54  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 2.197  
**Solve time:** 0.068 s  
**Findings:** 0 errors · 6 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 19.975 kW |
| Total load | 19.902 kW |
| Total line losses | 263.73 W |
| Loss fraction | 1.3% |
| Power balance error | 191.02 W |
| Max neutral shift | 0.471 V (bus `134`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 6 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_125` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_134` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_120` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_137` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_119` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_131` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_125`  
  Generator 'der_125' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_134`  
  Generator 'der_134' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_120`  
  Generator 'der_120' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_137`  
  Generator 'der_137' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_119`  
  Generator 'der_119' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_131`  
  Generator 'der_131' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 6 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 6A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.47 V at bus '134' — reflects the neutral shift under unbalanced loading.

