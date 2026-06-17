# BMOPF Solution Profile: network_2_Feeder_5

**Generated:** 2026-06-18 09:29:46  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 5.005  
**Solve time:** 0.062 s  
**Findings:** 0 errors · 6 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 21.151 kW |
| Total load | 21.114 kW |
| Total line losses | 66.55 W |
| Loss fraction | 0.3% |
| Power balance error | 29.95 W |
| Max neutral shift | 0.687 V (bus `256`) |

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
| W | `der_194` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_151` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_167` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_256` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_149` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_125`  
  Generator 'der_125' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_194`  
  Generator 'der_194' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_151`  
  Generator 'der_151' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_167`  
  Generator 'der_167' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_256`  
  Generator 'der_256' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_149`  
  Generator 'der_149' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 6 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 6A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.69 V at bus '256' — reflects the neutral shift under unbalanced loading.

