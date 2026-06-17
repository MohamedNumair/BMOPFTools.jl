# BMOPF Solution Profile: network_21_Feeder_1

**Generated:** 2026-06-18 07:11:40  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 3.5584  
**Solve time:** 0.037 s  
**Findings:** 0 errors · 6 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 20.967 kW |
| Total load | 20.868 kW |
| Total line losses | 273.63 W |
| Loss fraction | 1.3% |
| Power balance error | 174.36 W |
| Max neutral shift | 0.742 V (bus `135`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 6 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_178` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_472` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_350` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_561` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_135` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_357` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_178`  
  Generator 'der_178' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_472`  
  Generator 'der_472' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_350`  
  Generator 'der_350' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_561`  
  Generator 'der_561' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_135`  
  Generator 'der_135' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_357`  
  Generator 'der_357' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 6 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 6A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.74 V at bus '135' — reflects the neutral shift under unbalanced loading.

