# BMOPF Solution Profile: network_5_Feeder_2

**Generated:** 2026-06-18 07:11:46  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 4.0848  
**Solve time:** 0.033 s  
**Findings:** 0 errors · 5 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 17.449 kW |
| Total load | 17.358 kW |
| Total line losses | 152.79 W |
| Loss fraction | 0.9% |
| Power balance error | 61.53 W |
| Max neutral shift | 1.193 V (bus `179`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 5 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_153` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_56` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_138` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_73` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_179` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_153`  
  Generator 'der_153' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_56`  
  Generator 'der_56' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_138`  
  Generator 'der_138' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_73`  
  Generator 'der_73' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_179`  
  Generator 'der_179' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 5 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 5A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.19 V at bus '179' — reflects the neutral shift under unbalanced loading.

