# BMOPF Solution Profile: network_17_Feeder_5

**Generated:** 2026-06-18 09:29:33  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 20.6563  
**Solve time:** 0.918 s  
**Findings:** 0 errors · 40 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 139.765 kW |
| Total load | 138.746 kW |
| Total line losses | 1.924 kW |
| Loss fraction | 1.4% |
| Power balance error | 905.4 W |
| Max neutral shift | 2.387 V (bus `809`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 40 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_1637` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_139` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1963` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1183` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1898` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1621` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_316` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2292` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1171` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_174` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1177` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1367` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_672` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2034` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2295` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1773` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2716` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_500` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1111` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1301` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1811` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2541` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2548` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1765` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2401` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1397` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1004` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1879` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_96` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_840` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1459` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1854` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2570` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1677` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2587` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1742` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2436` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1471` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2726` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2289` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1637`  
  Generator 'der_1637' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_139`  
  Generator 'der_139' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1963`  
  Generator 'der_1963' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1183`  
  Generator 'der_1183' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1898`  
  Generator 'der_1898' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1621`  
  Generator 'der_1621' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_316`  
  Generator 'der_316' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2292`  
  Generator 'der_2292' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1171`  
  Generator 'der_1171' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_174`  
  Generator 'der_174' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1177`  
  Generator 'der_1177' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1367`  
  Generator 'der_1367' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_672`  
  Generator 'der_672' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2034`  
  Generator 'der_2034' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2295`  
  Generator 'der_2295' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1773`  
  Generator 'der_1773' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2716`  
  Generator 'der_2716' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_500`  
  Generator 'der_500' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1111`  
  Generator 'der_1111' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1301`  
  Generator 'der_1301' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1811`  
  Generator 'der_1811' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2541`  
  Generator 'der_2541' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2548`  
  Generator 'der_2548' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1765`  
  Generator 'der_1765' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2401`  
  Generator 'der_2401' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1397`  
  Generator 'der_1397' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1004`  
  Generator 'der_1004' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1879`  
  Generator 'der_1879' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_96`  
  Generator 'der_96' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_840`  
  Generator 'der_840' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1459`  
  Generator 'der_1459' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1854`  
  Generator 'der_1854' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2570`  
  Generator 'der_2570' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1677`  
  Generator 'der_1677' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2587`  
  Generator 'der_2587' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1742`  
  Generator 'der_1742' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2436`  
  Generator 'der_2436' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1471`  
  Generator 'der_1471' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2726`  
  Generator 'der_2726' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2289`  
  Generator 'der_2289' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 40 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 40A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.39 V at bus '809' — reflects the neutral shift under unbalanced loading.

