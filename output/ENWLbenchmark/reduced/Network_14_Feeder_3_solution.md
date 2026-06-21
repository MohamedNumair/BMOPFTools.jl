# BMOPF Solution Profile: Network_14_Feeder_3

**Generated:** 2026-06-21 16:42:20  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -305.1523  
**Solve time:** 0.348 s  
**Findings:** 3 errors · 6 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -309.458 kW |
| Total load | 53.963 kW |
| Total line losses | 913.49 W |
| Loss fraction | 1.7% |
| Power balance error | 364.335 kW |
| Max neutral shift | 2.002 V (bus `132`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 2 |
| Generator| 3 | 3 |

## 2. Voltage by Galvanic Zone

Per-unit magnitudes are relative to each zone's own voltage base; volts are not comparable across transformer boundaries.

| St | Zone | V base | Buses | Vm min (pu) | Vm max (pu) | Max imbalance | Max neutral shift |
|:--:|------|-------:|------:|------------:|------------:|--------------:|------------------:|
| ✅ | `100` | 240.0 V | 62 | 0.988 (`132`) | 1.0 (`132`) | 1.2 % (`132`) | 2.0 V (`132`) |

### Per-bus detail

**Zone `100`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `132` | 237.4 | 240.3 | 0.988 | 1.0 | 1.2 % | 2.0 V |
| ✅ | `138` | 237.7 | 240.3 | 0.99 | 1.0 | 1.1 % | 1.67 V |
| ✅ | `137` | 238.0 | 240.3 | 0.991 | 1.0 | 0.9 % | 1.38 V |
| ✅ | `128` | 238.1 | 240.3 | 0.991 | 1.0 | 0.9 % | 1.31 V |
| ✅ | `154` | 238.1 | 240.3 | 0.991 | 1.0 | 0.9 % | 1.3 V |
| ✅ | `146` | 238.1 | 240.3 | 0.991 | 1.0 | 0.9 % | 1.32 V |
| ✅ | `121` | 238.1 | 240.3 | 0.991 | 1.0 | 0.9 % | 1.28 V |
| ✅ | `148` | 238.1 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.27 V |
| ✅ | `149` | 238.1 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.26 V |
| ✅ | `140` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.26 V |
| ✅ | `151` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.26 V |
| ✅ | `122` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.26 V |
| ✅ | `125` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.26 V |
| ✅ | `139` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.26 V |
| ✅ | `142` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.26 V |
| ✅ | `129` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.26 V |
| ✅ | `136` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.26 V |
| ✅ | `150` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.26 V |
| ✅ | `126` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.26 V |
| ✅ | `133` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.26 V |
| ✅ | `134` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.26 V |
| ✅ | `124` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.25 V |
| ✅ | `130` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.25 V |
| ✅ | `131` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.25 V |
| ✅ | `123` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.25 V |
| ✅ | `145` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.25 V |
| ✅ | `141` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.25 V |
| ✅ | `147` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.27 V |
| ✅ | `135` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.24 V |
| ✅ | `93` | 238.2 | 240.3 | 0.992 | 1.0 | 0.9 % | 1.23 V |
| ✅ | `127` | 238.3 | 240.3 | 0.992 | 1.0 | 0.8 % | 1.16 V |
| ✅ | `143` | 238.3 | 240.3 | 0.992 | 1.0 | 0.8 % | 1.1 V |
| ✅ | `144` | 238.5 | 240.3 | 0.993 | 1.0 | 0.7 % | 0.97 V |
| ✅ | `152` | 238.5 | 240.3 | 0.993 | 1.0 | 0.7 % | 0.97 V |
| ✅ | `99` | 239.5 | 240.2 | 0.997 | 1.0 | 0.3 % | 0.17 V |
| ✅ | `111` | 239.6 | 240.2 | 0.997 | 1.0 | 0.3 % | 0.18 V |
| ✅ | `106` | 239.6 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.46 V |
| ✅ | `114` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.64 V |
| ✅ | `117` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.33 V |
| ✅ | `102` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.33 V |
| ✅ | `105` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.33 V |
| ✅ | `97` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.41 V |
| ✅ | `108` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.34 V |
| ✅ | `98` | 239.7 | 240.0 | 0.998 | 0.999 | 0.1 % | 0.56 V |
| ✅ | `116` | 239.7 | 240.1 | 0.998 | 1.0 | 0.1 % | 0.48 V |
| ✅ | `95` | 239.7 | 240.0 | 0.998 | 0.999 | 0.1 % | 0.74 V |
| ✅ | `110` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.37 V |
| ✅ | `101` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.37 V |
| ✅ | `119` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.37 V |
| ✅ | `112` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.68 V |
| ✅ | `109` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.68 V |
| ✅ | `100` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.68 V |
| ✅ | `91` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.35 V |
| ✅ | `115` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.36 V |
| ✅ | `94` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.36 V |
| ✅ | `103` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.37 V |
| ✅ | `118` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.37 V |
| ✅ | `96` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.66 V |
| ✅ | `107` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.62 V |
| ✅ | `104` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.67 V |
| ✅ | `113` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.68 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 3. Thermal Limits

| Sev | Component | ID | Terminal | cm (A) | i\_max (A) |
|-----|-----------|----|---------:|-------:|----------:|
| W | line | `line92` | `1` | 75.0 | 75.0 |
| W | line | `line92` | `n` | 75.0 | 75.0 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| **E** | `grid` | `1` | pg | -107.926 kW | [-107.926 kW, 107.926 kW] |
| **E** | `grid` | `2` | pg | -107.926 kW | [-107.926 kW, 107.926 kW] |
| **E** | `grid` | `3` | pg | -107.926 kW | [-107.926 kW, 107.926 kW] |
| W | `der_152` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_127` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_144` | `1` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 364.335 kW (>1 % of load). pg=-309.46 kW, pd=53.96 kW, p_loss=0.91 kW.

## 6. All Findings

- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line92`  
  Line 'line92' conductor '1': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line92`  
  Line 'line92' conductor 'n': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '1': pg=-107.926 kW violates [-107.926 kW, 107.926 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '2': pg=-107.926 kW violates [-107.926 kW, 107.926 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '3': pg=-107.926 kW violates [-107.926 kW, 107.926 kW].
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_152`  
  Generator 'der_152' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_127`  
  Generator 'der_127' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_144`  
  Generator 'der_144' phase '1': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 364.335 kW (>1 % of load). pg=-309.46 kW, pd=53.96 kW, p_loss=0.91 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 3 violation(s), 5 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 2A. Generator: 3V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 2.0 V at bus '132' — reflects the neutral shift under unbalanced loading.

