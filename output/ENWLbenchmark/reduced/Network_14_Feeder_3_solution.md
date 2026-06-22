# BMOPF Solution Profile: Network_14_Feeder_3

**Generated:** 2026-06-22 15:15:05  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -305.1912  
**Solve time:** 0.148 s  
**Findings:** 0 errors · 27 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 58.308 kW |
| Total load | 53.963 kW |
| Total line losses | 7.447 kW |
| Loss fraction | 13.8% |
| Power balance error | 3.102 kW |
| Max neutral shift | 4.304 V (bus `95`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 20 |
| Generator| 0 | 6 |

## 2. Voltage by Galvanic Zone

Per-unit magnitudes are relative to each zone's own voltage base; volts are not comparable across transformer boundaries.

| St | Zone | V base | Buses | Vm min (pu) | Vm max (pu) | Max imbalance | Max neutral shift |
|:--:|------|-------:|------:|------------:|------------:|--------------:|------------------:|
| ✅ | `100` | 230.0 V | 62 | 1.034 (`132`) | 1.048 (`104`) | 1.4 % (`132`) | 4.3 V (`95`) |

### Per-bus detail

**Zone `100`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `104` | 238.8 | 241.0 | 1.038 | 1.048 | 1.0 % | 4.27 V |
| ✅ | `113` | 238.8 | 241.0 | 1.038 | 1.048 | 1.0 % | 4.27 V |
| ✅ | `132` | 237.9 | 241.0 | 1.034 | 1.048 | 1.4 % | 0.89 V |
| ✅ | `138` | 238.2 | 241.0 | 1.036 | 1.048 | 1.2 % | 1.0 V |
| ✅ | `146` | 238.6 | 241.0 | 1.037 | 1.048 | 1.1 % | 1.18 V |
| ✅ | `137` | 238.5 | 241.0 | 1.037 | 1.048 | 1.1 % | 1.18 V |
| ✅ | `147` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.22 V |
| ✅ | `128` | 238.6 | 241.0 | 1.037 | 1.048 | 1.1 % | 1.23 V |
| ✅ | `154` | 238.6 | 241.0 | 1.037 | 1.048 | 1.1 % | 1.24 V |
| ✅ | `121` | 238.6 | 241.0 | 1.037 | 1.048 | 1.1 % | 1.25 V |
| ✅ | `148` | 238.6 | 241.0 | 1.037 | 1.048 | 1.1 % | 1.26 V |
| ✅ | `149` | 238.6 | 241.0 | 1.037 | 1.048 | 1.1 % | 1.26 V |
| ✅ | `140` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.27 V |
| ✅ | `151` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.27 V |
| ✅ | `122` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.27 V |
| ✅ | `125` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.27 V |
| ✅ | `139` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.27 V |
| ✅ | `142` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.27 V |
| ✅ | `129` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.27 V |
| ✅ | `136` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.27 V |
| ✅ | `150` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.27 V |
| ✅ | `126` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.27 V |
| ✅ | `133` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.27 V |
| ✅ | `134` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.27 V |
| ✅ | `124` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.27 V |
| ✅ | `130` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.27 V |
| ✅ | `131` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.27 V |
| ✅ | `123` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.27 V |
| ✅ | `145` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.27 V |
| ✅ | `141` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.27 V |
| ✅ | `135` | 238.6 | 241.0 | 1.037 | 1.048 | 1.0 % | 1.28 V |
| ✅ | `93` | 238.6 | 241.0 | 1.038 | 1.048 | 1.0 % | 1.29 V |
| ✅ | `127` | 238.7 | 241.0 | 1.038 | 1.048 | 1.0 % | 1.33 V |
| ✅ | `143` | 238.8 | 241.0 | 1.038 | 1.048 | 1.0 % | 1.37 V |
| ✅ | `144` | 238.9 | 241.0 | 1.039 | 1.048 | 0.9 % | 1.51 V |
| ✅ | `152` | 238.9 | 241.0 | 1.039 | 1.048 | 0.9 % | 1.52 V |
| ✅ | `114` | 238.8 | 241.0 | 1.038 | 1.048 | 0.9 % | 2.79 V |
| ✅ | `96` | 238.8 | 241.0 | 1.038 | 1.048 | 0.9 % | 2.85 V |
| ✅ | `107` | 238.8 | 241.0 | 1.038 | 1.048 | 0.9 % | 4.28 V |
| ✅ | `99` | 238.8 | 241.0 | 1.038 | 1.048 | 0.9 % | 2.61 V |
| ✅ | `111` | 238.8 | 241.0 | 1.038 | 1.048 | 0.9 % | 2.62 V |
| ✅ | `117` | 238.8 | 241.0 | 1.038 | 1.048 | 0.9 % | 2.74 V |
| ✅ | `102` | 238.8 | 241.0 | 1.038 | 1.048 | 0.9 % | 2.75 V |
| ✅ | `105` | 238.8 | 241.0 | 1.038 | 1.048 | 0.9 % | 2.75 V |
| ✅ | `108` | 238.8 | 241.0 | 1.038 | 1.048 | 0.9 % | 2.76 V |
| ✅ | `91` | 238.8 | 241.0 | 1.038 | 1.048 | 0.9 % | 2.77 V |
| ✅ | `115` | 238.8 | 241.0 | 1.038 | 1.048 | 0.9 % | 2.79 V |
| ✅ | `94` | 238.8 | 241.0 | 1.038 | 1.048 | 0.9 % | 2.79 V |
| ✅ | `103` | 238.8 | 241.0 | 1.038 | 1.048 | 0.9 % | 2.79 V |
| ✅ | `118` | 238.8 | 241.0 | 1.038 | 1.048 | 0.9 % | 2.79 V |
| ✅ | `97` | 238.7 | 241.0 | 1.038 | 1.048 | 1.0 % | 2.87 V |
| ✅ | `106` | 238.7 | 241.0 | 1.038 | 1.048 | 1.0 % | 2.93 V |
| ✅ | `112` | 238.6 | 241.0 | 1.038 | 1.048 | 1.0 % | 4.1 V |
| ✅ | `109` | 238.6 | 241.0 | 1.038 | 1.048 | 1.0 % | 4.1 V |
| ✅ | `100` | 238.6 | 241.0 | 1.038 | 1.048 | 1.0 % | 4.1 V |
| ✅ | `119` | 238.8 | 241.0 | 1.038 | 1.048 | 0.9 % | 2.77 V |
| ✅ | `101` | 238.8 | 241.0 | 1.038 | 1.048 | 0.9 % | 2.77 V |
| ✅ | `110` | 238.8 | 241.0 | 1.038 | 1.048 | 0.9 % | 2.77 V |
| ✅ | `116` | 238.8 | 240.8 | 1.038 | 1.047 | 0.9 % | 2.77 V |
| ✅ | `95` | 238.8 | 240.8 | 1.038 | 1.047 | 0.9 % | 4.3 V |
| ✅ | `98` | 238.8 | 240.7 | 1.038 | 1.047 | 0.8 % | 2.78 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |

## 3. Thermal Limits

| Sev | Component | ID | Terminal | cm (A) | i\_max (A) |
|-----|-----------|----|---------:|-------:|----------:|
| W | line | `line106` | `3` | 74.99 | 75.0 |
| W | line | `line106` | `n` | 74.99 | 75.0 |
| W | line | `line112` | `3` | 74.99 | 75.0 |
| W | line | `line112` | `n` | 74.99 | 75.0 |
| W | line | `line95` | `1` | 75.0 | 75.0 |
| W | line | `line95` | `n` | 75.0 | 75.0 |
| W | line | `line92` | `1` | 75.0 | 75.0 |
| W | line | `line92` | `n` | 75.0 | 75.0 |
| W | line | `line94` | `3` | 74.99 | 75.0 |
| W | line | `line94` | `n` | 74.99 | 75.0 |
| W | line | `line103` | `3` | 74.99 | 75.0 |
| W | line | `line103` | `n` | 74.99 | 75.0 |
| W | line | `line108` | `2` | 75.0 | 75.0 |
| W | line | `line108` | `n` | 75.0 | 75.0 |
| W | line | `line99` | `2` | 75.0 | 75.0 |
| W | line | `line99` | `n` | 75.0 | 75.0 |
| W | line | `line111` | `2` | 75.0 | 75.0 |
| W | line | `line111` | `n` | 75.0 | 75.0 |
| W | line | `line113` | `1` | 75.0 | 75.0 |
| W | line | `line113` | `n` | 75.0 | 75.0 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -107.926 kW | [-107.926 kW, 107.926 kW] |
| W | `grid` | `2` | pg | -107.926 kW | [-107.926 kW, 107.926 kW] |
| W | `grid` | `3` | pg | -107.926 kW | [-107.926 kW, 107.926 kW] |
| W | `der_152` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_127` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_144` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 3.102 kW (>1 % of load). pg=58.31 kW, pd=53.96 kW, p_loss=7.45 kW.

## 6. All Findings

- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line106`  
  Line 'line106' conductor '3': cm_fr=74.99 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line106`  
  Line 'line106' conductor 'n': cm_fr=74.99 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line112`  
  Line 'line112' conductor '3': cm_fr=74.99 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line112`  
  Line 'line112' conductor 'n': cm_fr=74.99 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line95`  
  Line 'line95' conductor '1': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line95`  
  Line 'line95' conductor 'n': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line92`  
  Line 'line92' conductor '1': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line92`  
  Line 'line92' conductor 'n': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line94`  
  Line 'line94' conductor '3': cm_fr=74.99 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line94`  
  Line 'line94' conductor 'n': cm_fr=74.99 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line103`  
  Line 'line103' conductor '3': cm_fr=74.99 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line103`  
  Line 'line103' conductor 'n': cm_fr=74.99 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line108`  
  Line 'line108' conductor '2': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line108`  
  Line 'line108' conductor 'n': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line99`  
  Line 'line99' conductor '2': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line99`  
  Line 'line99' conductor 'n': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line111`  
  Line 'line111' conductor '2': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line111`  
  Line 'line111' conductor 'n': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line113`  
  Line 'line113' conductor '1': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line113`  
  Line 'line113' conductor 'n': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-107.926 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-107.926 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-107.926 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_152`  
  Generator 'der_152' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_127`  
  Generator 'der_127' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_144`  
  Generator 'der_144' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 3.102 kW (>1 % of load). pg=58.31 kW, pd=53.96 kW, p_loss=7.45 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 26 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 20A. Generator: 0V / 6A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 4.3 V at bus '95' — reflects the neutral shift under unbalanced loading.

