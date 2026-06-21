# BMOPF Solution Profile: Network_14_Feeder_5

**Generated:** 2026-06-21 16:42:21  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -212.4221  
**Solve time:** 0.263 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -291.558 kW |
| Total load | 48.595 kW |
| Total line losses | 495.72 W |
| Loss fraction | 1.0% |
| Power balance error | 340.649 kW |
| Max neutral shift | 1.004 V (bus `138`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 3 |

## 2. Voltage by Galvanic Zone

Per-unit magnitudes are relative to each zone's own voltage base; volts are not comparable across transformer boundaries.

| St | Zone | V base | Buses | Vm min (pu) | Vm max (pu) | Max imbalance | Max neutral shift |
|:--:|------|-------:|------:|------------:|------------:|--------------:|------------------:|
| ✅ | `100` | 240.0 V | 47 | 0.994 (`138`) | 1.0 (`sourcebus`) | 0.5 % (`138`) | 1.0 V (`138`) |

### Per-bus detail

**Zone `100`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `138` | 238.7 | 239.9 | 0.994 | 0.999 | 0.5 % | 1.0 V |
| ✅ | `144` | 239.0 | 239.9 | 0.995 | 0.999 | 0.4 % | 0.69 V |
| ✅ | `105` | 239.2 | 239.9 | 0.996 | 0.999 | 0.3 % | 0.52 V |
| ✅ | `102` | 239.2 | 239.9 | 0.996 | 0.999 | 0.3 % | 0.51 V |
| ✅ | `123` | 239.3 | 239.9 | 0.996 | 0.999 | 0.2 % | 0.43 V |
| ✅ | `133` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.14 V |
| ✅ | `114` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.58 V |
| ✅ | `120` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.32 V |
| ✅ | `108` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.32 V |
| ✅ | `111` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.33 V |
| ✅ | `117` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.33 V |
| ✅ | `135` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.33 V |
| ✅ | `132` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.32 V |
| ✅ | `126` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.32 V |
| ✅ | `129` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.32 V |
| ✅ | `141` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.31 V |
| ✅ | `115` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.28 V |
| ✅ | `113` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.35 V |
| ✅ | `143` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.35 V |
| ✅ | `104` | 239.4 | 239.8 | 0.997 | 0.998 | 0.1 % | 0.33 V |
| ✅ | `134` | 239.4 | 239.8 | 0.997 | 0.998 | 0.2 % | 0.32 V |
| ✅ | `128` | 239.4 | 239.8 | 0.997 | 0.999 | 0.2 % | 0.31 V |
| ✅ | `110` | 239.4 | 239.8 | 0.997 | 0.999 | 0.2 % | 0.31 V |
| ✅ | `101` | 239.4 | 239.8 | 0.997 | 0.999 | 0.2 % | 0.3 V |
| ✅ | `107` | 239.4 | 239.8 | 0.997 | 0.999 | 0.2 % | 0.3 V |
| ✅ | `140` | 239.4 | 239.8 | 0.997 | 0.999 | 0.2 % | 0.3 V |
| ✅ | `137` | 239.4 | 239.8 | 0.997 | 0.999 | 0.2 % | 0.3 V |
| ✅ | `119` | 239.4 | 239.8 | 0.997 | 0.999 | 0.2 % | 0.3 V |
| ✅ | `122` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.3 V |
| ✅ | `98` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.3 V |
| ✅ | `116` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.22 V |
| ✅ | `125` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.19 V |
| ✅ | `131` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.18 V |
| ✅ | `127` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.27 V |
| ✅ | `112` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.28 V |
| ✅ | `109` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.28 V |
| ✅ | `130` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.28 V |
| ✅ | `136` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.28 V |
| ✅ | `139` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.28 V |
| ✅ | `124` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.28 V |
| ✅ | `142` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.28 V |
| ✅ | `103` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.28 V |
| ✅ | `121` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.24 V |
| ✅ | `118` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.18 V |
| ✅ | `100` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.17 V |
| ✅ | `106` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.17 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -97.19 kW | [-97.19 kW, 97.19 kW] |
| W | `grid` | `2` | pg | -97.19 kW | [-97.19 kW, 97.19 kW] |
| W | `grid` | `3` | pg | -97.19 kW | [-97.19 kW, 97.19 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 340.649 kW (>1 % of load). pg=-291.56 kW, pd=48.6 kW, p_loss=0.5 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-97.19 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-97.19 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-97.19 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 340.649 kW (>1 % of load). pg=-291.56 kW, pd=48.6 kW, p_loss=0.5 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.0 V at bus '138' — reflects the neutral shift under unbalanced loading.

