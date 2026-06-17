# BMOPF Solution Profile: network_10_Feeder_1

**Generated:** 2026-06-18 07:11:22  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 0.5768  
**Solve time:** 0.027 s  
**Findings:** 0 errors · 6 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 20.007 kW |
| Total load | 19.902 kW |
| Total line losses | 160.8 W |
| Loss fraction | 0.8% |
| Power balance error | 56.19 W |
| Max neutral shift | 0.92 V (bus `243`) |

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
| W | `der_246` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_120` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_119` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_132` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_243` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_125`  
  Generator 'der_125' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_246`  
  Generator 'der_246' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_120`  
  Generator 'der_120' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_119`  
  Generator 'der_119' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_132`  
  Generator 'der_132' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_243`  
  Generator 'der_243' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 6 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 6A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.92 V at bus '243' — reflects the neutral shift under unbalanced loading.

