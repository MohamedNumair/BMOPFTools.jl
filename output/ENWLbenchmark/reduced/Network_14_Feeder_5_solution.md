# BMOPF Solution Profile: Network_14_Feeder_5

**Generated:** 2026-06-18 07:11:18  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 10.0082  
**Solve time:** 0.063 s  
**Findings:** 0 errors · 12 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 48.78 kW |
| Total load | 48.595 kW |
| Total line losses | 221.92 W |
| Loss fraction | 0.5% |
| Power balance error | 37.18 W |
| Max neutral shift | 0.852 V (bus `138`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 12 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_114` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_133` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_116` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_102` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_135` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_125` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_105` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_111` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_117` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_127` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_115` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_131` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_114`  
  Generator 'der_114' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_133`  
  Generator 'der_133' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_116`  
  Generator 'der_116' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_102`  
  Generator 'der_102' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_135`  
  Generator 'der_135' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_125`  
  Generator 'der_125' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_105`  
  Generator 'der_105' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_111`  
  Generator 'der_111' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_117`  
  Generator 'der_117' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_127`  
  Generator 'der_127' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_115`  
  Generator 'der_115' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_131`  
  Generator 'der_131' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 12 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 12A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.85 V at bus '138' — reflects the neutral shift under unbalanced loading.

