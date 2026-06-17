# BMOPF Solution Profile: Network_14_Feeder_6

**Generated:** 2026-06-18 09:29:14  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 10.2169  
**Solve time:** 0.053 s  
**Findings:** 0 errors · 11 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 43.161 kW |
| Total load | 43.009 kW |
| Total line losses | 184.31 W |
| Loss fraction | 0.4% |
| Power balance error | 32.3 W |
| Max neutral shift | 0.732 V (bus `168`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 11 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_133` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_151` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_165` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_157` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_141` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_135` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_163` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_161` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_144` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_132` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_146` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_133`  
  Generator 'der_133' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_151`  
  Generator 'der_151' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_165`  
  Generator 'der_165' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_157`  
  Generator 'der_157' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_141`  
  Generator 'der_141' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_135`  
  Generator 'der_135' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_163`  
  Generator 'der_163' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_161`  
  Generator 'der_161' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_144`  
  Generator 'der_144' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_132`  
  Generator 'der_132' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_146`  
  Generator 'der_146' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 11 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 11A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.73 V at bus '168' — reflects the neutral shift under unbalanced loading.

