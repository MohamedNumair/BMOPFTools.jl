# BMOPF Solution Profile: network_12_Feeder_2

**Generated:** 2026-06-18 07:11:24  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 16.4948  
**Solve time:** 0.488 s  
**Findings:** 0 errors · 21 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 77.405 kW |
| Total load | 76.927 kW |
| Total line losses | 1.016 kW |
| Loss fraction | 1.3% |
| Power balance error | 538.11 W |
| Max neutral shift | 2.132 V (bus `1753`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 21 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_1800` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1645` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_46` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1366` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1303` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1248` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1176` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1704` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_79` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1816` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_282` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_732` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1765` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1250` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1552` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_754` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1530` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_842` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1550` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_911` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1817` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1800`  
  Generator 'der_1800' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1645`  
  Generator 'der_1645' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_46`  
  Generator 'der_46' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1366`  
  Generator 'der_1366' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1303`  
  Generator 'der_1303' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1248`  
  Generator 'der_1248' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1176`  
  Generator 'der_1176' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1704`  
  Generator 'der_1704' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_79`  
  Generator 'der_79' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1816`  
  Generator 'der_1816' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_282`  
  Generator 'der_282' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_732`  
  Generator 'der_732' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1765`  
  Generator 'der_1765' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1250`  
  Generator 'der_1250' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1552`  
  Generator 'der_1552' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_754`  
  Generator 'der_754' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1530`  
  Generator 'der_1530' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_842`  
  Generator 'der_842' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1550`  
  Generator 'der_1550' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_911`  
  Generator 'der_911' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1817`  
  Generator 'der_1817' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 21 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 21A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.13 V at bus '1753' — reflects the neutral shift under unbalanced loading.

