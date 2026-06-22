# BMOPF Solution Profile: network_18_Feeder_6

**Generated:** 2026-06-22 15:16:30  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -121.5501  
**Solve time:** 0.082 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 21.054 kW |
| Total load | 20.868 kW |
| Total line losses | 687.8 W |
| Loss fraction | 3.3% |
| Power balance error | 501.47 W |
| Max neutral shift | 0.992 V (bus `503`) |

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
| ✅ | `109` | 230.0 V | 45 | 1.035 (`382`) | 1.044 (`sourcebus`) | 0.6 % (`382`) | 0.99 V (`503`) |

### Per-bus detail

**Zone `109`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `81` | 239.6 | 239.9 | 1.042 | 1.043 | 0.1 % | 0.28 V |
| ✅ | `379` | 239.6 | 239.8 | 1.042 | 1.043 | 0.1 % | 0.22 V |
| ✅ | `389` | 239.6 | 239.8 | 1.042 | 1.043 | 0.1 % | 0.21 V |
| ✅ | `491` | 239.6 | 239.8 | 1.042 | 1.043 | 0.1 % | 0.21 V |
| ✅ | `109` | 239.3 | 239.8 | 1.04 | 1.043 | 0.2 % | 0.45 V |
| ✅ | `112` | 239.1 | 239.8 | 1.04 | 1.042 | 0.3 % | 0.68 V |
| ✅ | `116` | 239.1 | 239.8 | 1.039 | 1.042 | 0.3 % | 0.75 V |
| ✅ | `122` | 239.0 | 239.8 | 1.039 | 1.042 | 0.3 % | 0.78 V |
| ✅ | `215` | 238.9 | 239.8 | 1.039 | 1.042 | 0.4 % | 0.91 V |
| ✅ | `117` | 239.1 | 239.8 | 1.04 | 1.042 | 0.3 % | 0.66 V |
| ✅ | `124` | 239.1 | 239.8 | 1.04 | 1.042 | 0.3 % | 0.64 V |
| ✅ | `237` | 239.1 | 239.8 | 1.04 | 1.042 | 0.3 % | 0.66 V |
| ✅ | `130` | 239.0 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.54 V |
| ✅ | `136` | 239.0 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.55 V |
| ✅ | `414` | 239.0 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.6 V |
| ✅ | `422` | 239.0 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.6 V |
| ✅ | `481` | 239.0 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.61 V |
| ✅ | `160` | 238.7 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.69 V |
| ✅ | `190` | 238.7 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.75 V |
| ✅ | `453` | 238.7 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.93 V |
| ✅ | `528` | 238.7 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.94 V |
| ✅ | `461` | 238.7 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.95 V |
| ✅ | `201` | 238.7 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.76 V |
| ✅ | `469` | 238.5 | 239.6 | 1.037 | 1.042 | 0.5 % | 0.8 V |
| ✅ | `477` | 238.5 | 239.6 | 1.037 | 1.042 | 0.5 % | 0.8 V |
| ✅ | `531` | 238.5 | 239.6 | 1.037 | 1.042 | 0.5 % | 0.82 V |
| ✅ | `256` | 238.6 | 239.6 | 1.037 | 1.042 | 0.4 % | 0.8 V |
| ✅ | `417` | 238.4 | 239.6 | 1.036 | 1.042 | 0.5 % | 0.9 V |
| ✅ | `425` | 238.4 | 239.6 | 1.036 | 1.042 | 0.5 % | 0.9 V |
| ✅ | `433` | 238.4 | 239.6 | 1.036 | 1.042 | 0.5 % | 0.91 V |
| ✅ | `509` | 238.4 | 239.6 | 1.036 | 1.042 | 0.5 % | 0.91 V |
| ✅ | `434` | 238.3 | 239.6 | 1.036 | 1.042 | 0.5 % | 0.92 V |
| ✅ | `442` | 238.3 | 239.6 | 1.036 | 1.042 | 0.5 % | 0.92 V |
| ✅ | `503` | 238.2 | 239.6 | 1.036 | 1.042 | 0.6 % | 0.99 V |
| ✅ | `390` | 239.0 | 239.6 | 1.039 | 1.042 | 0.2 % | 0.46 V |
| ✅ | `399` | 239.0 | 239.6 | 1.039 | 1.042 | 0.2 % | 0.46 V |
| ✅ | `251` | 238.3 | 239.6 | 1.036 | 1.042 | 0.5 % | 0.85 V |
| ✅ | `260` | 238.3 | 239.6 | 1.036 | 1.042 | 0.6 % | 0.88 V |
| ✅ | `272` | 238.3 | 239.6 | 1.036 | 1.042 | 0.6 % | 0.89 V |
| ✅ | `382` | 238.2 | 239.6 | 1.035 | 1.042 | 0.6 % | 0.96 V |
| ✅ | `261` | 238.3 | 239.5 | 1.036 | 1.042 | 0.6 % | 0.86 V |
| ✅ | `274` | 238.2 | 239.5 | 1.036 | 1.042 | 0.6 % | 0.89 V |
| ✅ | `473` | 239.0 | 239.5 | 1.039 | 1.041 | 0.2 % | 0.44 V |
| ✅ | `392` | 238.3 | 239.5 | 1.036 | 1.041 | 0.6 % | 0.81 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |
| W | `grid` | `2` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |
| W | `grid` | `3` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 501.47 W (>1 % of load). pg=21.05 kW, pd=20.87 kW, p_loss=0.69 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-41.736 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-41.736 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-41.736 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 501.47 W (>1 % of load). pg=21.05 kW, pd=20.87 kW, p_loss=0.69 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.99 V at bus '503' — reflects the neutral shift under unbalanced loading.

