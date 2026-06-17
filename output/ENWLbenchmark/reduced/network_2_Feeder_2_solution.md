# BMOPF Solution Profile: network_2_Feeder_2

**Generated:** 2026-06-18 09:29:45  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 18.0901  
**Solve time:** 0.319 s  
**Findings:** 0 errors · 37 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 127.717 kW |
| Total load | 125.903 kW |
| Total line losses | 3.337 kW |
| Loss fraction | 2.7% |
| Power balance error | 1.522 kW |
| Max neutral shift | 3.128 V (bus `2217`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 36 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_1045` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_573` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_378` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1300` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1668` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_913` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1553` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_649` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1689` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2216` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1709` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2183` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1975` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2240` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1015` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2097` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1002` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2229` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_574` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1239` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_540` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1123` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_500` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1128` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_377` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1765` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_652` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2217` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1614` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1289` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_626` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_392` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_2192` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1742` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1667` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_1106` | `3` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 1.522 kW (>1 % of load). pg=127.72 kW, pd=125.9 kW, p_loss=3.34 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1045`  
  Generator 'der_1045' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_573`  
  Generator 'der_573' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_378`  
  Generator 'der_378' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1300`  
  Generator 'der_1300' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1668`  
  Generator 'der_1668' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_913`  
  Generator 'der_913' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1553`  
  Generator 'der_1553' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_649`  
  Generator 'der_649' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1689`  
  Generator 'der_1689' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2216`  
  Generator 'der_2216' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1709`  
  Generator 'der_1709' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2183`  
  Generator 'der_2183' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1975`  
  Generator 'der_1975' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2240`  
  Generator 'der_2240' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1015`  
  Generator 'der_1015' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2097`  
  Generator 'der_2097' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1002`  
  Generator 'der_1002' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2229`  
  Generator 'der_2229' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_574`  
  Generator 'der_574' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1239`  
  Generator 'der_1239' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_540`  
  Generator 'der_540' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1123`  
  Generator 'der_1123' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_500`  
  Generator 'der_500' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1128`  
  Generator 'der_1128' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_377`  
  Generator 'der_377' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1765`  
  Generator 'der_1765' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_652`  
  Generator 'der_652' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2217`  
  Generator 'der_2217' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1614`  
  Generator 'der_1614' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1289`  
  Generator 'der_1289' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_626`  
  Generator 'der_626' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_392`  
  Generator 'der_392' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_2192`  
  Generator 'der_2192' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1742`  
  Generator 'der_1742' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1667`  
  Generator 'der_1667' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_1106`  
  Generator 'der_1106' phase '3': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 1.522 kW (>1 % of load). pg=127.72 kW, pd=125.9 kW, p_loss=3.34 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 36 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 36A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 3.13 V at bus '2217' — reflects the neutral shift under unbalanced loading.

