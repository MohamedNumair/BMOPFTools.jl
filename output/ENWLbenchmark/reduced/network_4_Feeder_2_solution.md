# BMOPF Solution Profile: network_4_Feeder_2

**Generated:** 2026-06-18 09:29:48  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 3.7529  
**Solve time:** 0.026 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 16.829 kW |
| Total load | 16.746 kW |
| Total line losses | 148.63 W |
| Loss fraction | 0.9% |
| Power balance error | 66.09 W |
| Max neutral shift | 0.852 V (bus `170`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 4 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_376` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_379` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_386` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_162` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_376`  
  Generator 'der_376' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_379`  
  Generator 'der_379' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_386`  
  Generator 'der_386' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_162`  
  Generator 'der_162' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 4 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 4A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.85 V at bus '170' — reflects the neutral shift under unbalanced loading.

