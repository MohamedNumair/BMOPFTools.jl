# BMOPF Solution Profile: network_4_Feeder_1

**Generated:** 2026-06-18 09:29:48  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 3.8475  
**Solve time:** 0.089 s  
**Findings:** 0 errors · 6 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 23.141 kW |
| Total load | 23.07 kW |
| Total line losses | 107.56 W |
| Loss fraction | 0.5% |
| Power balance error | 36.81 W |
| Max neutral shift | 0.465 V (bus `336`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 6 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_219` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_296` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_336` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_320` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_374` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_367` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_219`  
  Generator 'der_219' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_296`  
  Generator 'der_296' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_336`  
  Generator 'der_336' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_320`  
  Generator 'der_320' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_374`  
  Generator 'der_374' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_367`  
  Generator 'der_367' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 6 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 6A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.46 V at bus '336' — reflects the neutral shift under unbalanced loading.

