# BMOPF Solution Profile: network_20_Feeder_5

**Generated:** 2026-06-18 07:11:40  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 4.4327  
**Solve time:** 0.084 s  
**Findings:** 0 errors · 6 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 21.153 kW |
| Total load | 21.114 kW |
| Total line losses | 55.24 W |
| Loss fraction | 0.3% |
| Power balance error | 16.56 W |
| Max neutral shift | 0.256 V (bus `44`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 6 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_43` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_61` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_47` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_51` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_46` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_54` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_43`  
  Generator 'der_43' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_61`  
  Generator 'der_61' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_47`  
  Generator 'der_47' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_51`  
  Generator 'der_51' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_46`  
  Generator 'der_46' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_54`  
  Generator 'der_54' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 6 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 6A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.26 V at bus '44' — reflects the neutral shift under unbalanced loading.

