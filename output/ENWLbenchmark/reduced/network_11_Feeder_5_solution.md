# BMOPF Solution Profile: network_11_Feeder_5

**Generated:** 2026-06-18 09:29:20  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 13.255  
**Solve time:** 0.564 s  
**Findings:** 0 errors · 22 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 78.946 kW |
| Total load | 77.821 kW |
| Total line losses | 1.729 kW |
| Loss fraction | 2.2% |
| Power balance error | 604.43 W |
| Max neutral shift | 2.284 V (bus `631`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 22 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_463` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_581` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_286` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_269` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_787` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_631` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_452` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_464` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_282` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_109` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_304` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_268` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_504` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_756` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_759` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_281` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_834` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_648` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_284` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_622` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_774` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_197` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_463`  
  Generator 'der_463' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_581`  
  Generator 'der_581' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_286`  
  Generator 'der_286' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_269`  
  Generator 'der_269' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_787`  
  Generator 'der_787' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_631`  
  Generator 'der_631' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_452`  
  Generator 'der_452' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_464`  
  Generator 'der_464' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_282`  
  Generator 'der_282' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_109`  
  Generator 'der_109' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_304`  
  Generator 'der_304' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_268`  
  Generator 'der_268' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_504`  
  Generator 'der_504' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_756`  
  Generator 'der_756' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_759`  
  Generator 'der_759' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_281`  
  Generator 'der_281' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_834`  
  Generator 'der_834' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_648`  
  Generator 'der_648' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_284`  
  Generator 'der_284' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_622`  
  Generator 'der_622' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_774`  
  Generator 'der_774' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_197`  
  Generator 'der_197' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 22 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 22A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.28 V at bus '631' — reflects the neutral shift under unbalanced loading.

