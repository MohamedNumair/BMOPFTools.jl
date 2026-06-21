# BMOPF Solution Profile: network_18_Feeder_6

**Generated:** 2026-06-21 16:43:12  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -121.5501  
**Solve time:** 0.037 s  
**Findings:** 3 errors · 1 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -125.208 kW |
| Total load | 20.868 kW |
| Total line losses | 704.6 W |
| Loss fraction | 3.4% |
| Power balance error | 146.781 kW |
| Max neutral shift | 1.161 V (bus `461`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 3 | 0 |

## 2. Voltage by Galvanic Zone

Per-unit magnitudes are relative to each zone's own voltage base; volts are not comparable across transformer boundaries.

| St | Zone | V base | Buses | Vm min (pu) | Vm max (pu) | Max imbalance | Max neutral shift |
|:--:|------|-------:|------:|------------:|------------:|--------------:|------------------:|
| ✅ | `109` | 240.0 V | 45 | 0.992 (`382`) | 1.0 (`sourcebus`) | 0.5 % (`382`) | 1.16 V (`461`) |

### Per-bus detail

**Zone `109`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `382` | 238.2 | 239.5 | 0.992 | 0.997 | 0.5 % | 1.07 V |
| ✅ | `274` | 238.3 | 239.5 | 0.992 | 0.997 | 0.5 % | 1.03 V |
| ✅ | `503` | 238.3 | 239.5 | 0.992 | 0.997 | 0.5 % | 1.08 V |
| ✅ | `392` | 238.3 | 239.5 | 0.992 | 0.997 | 0.5 % | 1.03 V |
| ✅ | `261` | 238.3 | 239.5 | 0.992 | 0.997 | 0.5 % | 1.02 V |
| ✅ | `272` | 238.4 | 239.5 | 0.992 | 0.997 | 0.5 % | 1.07 V |
| ✅ | `260` | 238.4 | 239.5 | 0.992 | 0.997 | 0.5 % | 1.04 V |
| ✅ | `251` | 238.4 | 239.5 | 0.993 | 0.997 | 0.5 % | 1.02 V |
| ✅ | `442` | 238.4 | 239.5 | 0.993 | 0.997 | 0.5 % | 1.06 V |
| ✅ | `434` | 238.4 | 239.5 | 0.993 | 0.997 | 0.5 % | 1.05 V |
| ✅ | `509` | 238.5 | 239.5 | 0.993 | 0.997 | 0.5 % | 1.05 V |
| ✅ | `433` | 238.5 | 239.5 | 0.993 | 0.997 | 0.4 % | 1.04 V |
| ✅ | `425` | 238.5 | 239.5 | 0.993 | 0.997 | 0.4 % | 1.04 V |
| ✅ | `417` | 238.5 | 239.5 | 0.993 | 0.997 | 0.4 % | 1.04 V |
| ✅ | `531` | 238.6 | 239.6 | 0.993 | 0.997 | 0.4 % | 0.93 V |
| ✅ | `477` | 238.6 | 239.6 | 0.994 | 0.997 | 0.4 % | 0.92 V |
| ✅ | `469` | 238.6 | 239.6 | 0.994 | 0.997 | 0.4 % | 0.92 V |
| ✅ | `256` | 238.7 | 239.6 | 0.994 | 0.997 | 0.4 % | 0.96 V |
| ✅ | `201` | 238.7 | 239.6 | 0.994 | 0.997 | 0.3 % | 0.92 V |
| ✅ | `461` | 238.8 | 239.6 | 0.994 | 0.997 | 0.3 % | 1.16 V |
| ✅ | `528` | 238.8 | 239.6 | 0.994 | 0.997 | 0.3 % | 1.15 V |
| ✅ | `453` | 238.8 | 239.6 | 0.994 | 0.997 | 0.3 % | 1.14 V |
| ✅ | `190` | 238.8 | 239.6 | 0.994 | 0.997 | 0.3 % | 0.92 V |
| ✅ | `160` | 238.8 | 239.6 | 0.994 | 0.998 | 0.3 % | 0.84 V |
| ✅ | `215` | 238.9 | 239.8 | 0.995 | 0.998 | 0.4 % | 1.01 V |
| ✅ | `122` | 239.0 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.88 V |
| ✅ | `116` | 239.0 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.84 V |
| ✅ | `481` | 239.1 | 239.7 | 0.995 | 0.998 | 0.2 % | 0.77 V |
| ✅ | `422` | 239.1 | 239.7 | 0.995 | 0.998 | 0.2 % | 0.76 V |
| ✅ | `414` | 239.1 | 239.7 | 0.995 | 0.998 | 0.2 % | 0.76 V |
| ✅ | `136` | 239.1 | 239.7 | 0.995 | 0.998 | 0.2 % | 0.69 V |
| ✅ | `130` | 239.1 | 239.7 | 0.995 | 0.998 | 0.2 % | 0.69 V |
| ✅ | `399` | 239.1 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.64 V |
| ✅ | `390` | 239.1 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.64 V |
| ✅ | `473` | 239.1 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.62 V |
| ✅ | `237` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.74 V |
| ✅ | `112` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.77 V |
| ✅ | `117` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.75 V |
| ✅ | `124` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.71 V |
| ✅ | `109` | 239.3 | 239.8 | 0.996 | 0.998 | 0.2 % | 0.57 V |
| ✅ | `81` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.35 V |
| ✅ | `379` | 239.6 | 239.8 | 0.998 | 0.999 | 0.1 % | 0.3 V |
| ✅ | `389` | 239.6 | 239.8 | 0.998 | 0.999 | 0.1 % | 0.3 V |
| ✅ | `491` | 239.6 | 239.8 | 0.998 | 0.999 | 0.1 % | 0.3 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| **E** | `grid` | `1` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |
| **E** | `grid` | `2` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |
| **E** | `grid` | `3` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 146.781 kW (>1 % of load). pg=-125.21 kW, pd=20.87 kW, p_loss=0.7 kW.

## 6. All Findings

- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '1': pg=-41.736 kW violates [-41.736 kW, 41.736 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '2': pg=-41.736 kW violates [-41.736 kW, 41.736 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '3': pg=-41.736 kW violates [-41.736 kW, 41.736 kW].
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 146.781 kW (>1 % of load). pg=-125.21 kW, pd=20.87 kW, p_loss=0.7 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 3 violation(s), 0 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 3V / 0A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.16 V at bus '461' — reflects the neutral shift under unbalanced loading.

