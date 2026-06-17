# BMOPF Solution Profile: network_21_Feeder_3

**Generated:** 2026-06-18 09:29:41  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 10.6467  
**Solve time:** 0.154 s  
**Findings:** 0 errors · 17 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 59.783 kW |
| Total load | 59.429 kW |
| Total line losses | 895.94 W |
| Loss fraction | 1.5% |
| Power balance error | 542.18 W |
| Max neutral shift | 1.328 V (bus `644`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 17 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_264` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_837` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_765` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_756` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_760` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_839` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_757` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_840` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_782` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_153` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_481` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_440` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_734` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_271` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_843` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_723` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_145` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_264`  
  Generator 'der_264' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_837`  
  Generator 'der_837' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_765`  
  Generator 'der_765' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_756`  
  Generator 'der_756' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_760`  
  Generator 'der_760' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_839`  
  Generator 'der_839' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_757`  
  Generator 'der_757' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_840`  
  Generator 'der_840' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_782`  
  Generator 'der_782' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_153`  
  Generator 'der_153' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_481`  
  Generator 'der_481' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_440`  
  Generator 'der_440' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_734`  
  Generator 'der_734' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_271`  
  Generator 'der_271' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_843`  
  Generator 'der_843' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_723`  
  Generator 'der_723' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_145`  
  Generator 'der_145' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 17 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 17A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.33 V at bus '644' — reflects the neutral shift under unbalanced loading.

