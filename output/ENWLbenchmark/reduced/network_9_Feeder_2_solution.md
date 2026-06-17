# BMOPF Solution Profile: network_9_Feeder_2

**Generated:** 2026-06-18 09:29:53  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 4.8283  
**Solve time:** 0.046 s  
**Findings:** 0 errors · 6 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 19.975 kW |
| Total load | 19.902 kW |
| Total line losses | 260.73 W |
| Loss fraction | 1.3% |
| Power balance error | 188.05 W |
| Max neutral shift | 0.468 V (bus `106`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 6 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_109` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_97` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_91` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_92` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_103` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_106` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_109`  
  Generator 'der_109' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_97`  
  Generator 'der_97' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_91`  
  Generator 'der_91' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_92`  
  Generator 'der_92' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_103`  
  Generator 'der_103' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_106`  
  Generator 'der_106' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 6 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 6A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.47 V at bus '106' — reflects the neutral shift under unbalanced loading.

