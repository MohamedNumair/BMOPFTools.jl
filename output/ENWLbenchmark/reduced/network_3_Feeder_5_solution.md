# BMOPF Solution Profile: network_3_Feeder_5

**Generated:** 2026-06-22 15:17:20  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -99.3237  
**Solve time:** 0.15 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 20.066 kW |
| Total load | 19.902 kW |
| Total line losses | 555.11 W |
| Loss fraction | 2.8% |
| Power balance error | 390.65 W |
| Max neutral shift | 1.464 V (bus `315`) |

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
| ✅ | `105` | 230.0 V | 43 | 1.032 (`315`) | 1.044 (`sourcebus`) | 1.0 % (`315`) | 1.46 V (`315`) |

### Per-bus detail

**Zone `105`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `105` | 239.3 | 239.7 | 1.04 | 1.042 | 0.2 % | 0.04 V |
| ✅ | `112` | 239.1 | 239.7 | 1.04 | 1.042 | 0.2 % | 0.07 V |
| ✅ | `137` | 239.1 | 239.7 | 1.04 | 1.042 | 0.2 % | 0.17 V |
| ✅ | `117` | 239.1 | 239.7 | 1.04 | 1.042 | 0.3 % | 0.08 V |
| ✅ | `149` | 239.1 | 239.7 | 1.04 | 1.042 | 0.3 % | 0.2 V |
| ✅ | `230` | 238.7 | 239.7 | 1.038 | 1.042 | 0.4 % | 0.4 V |
| ✅ | `339` | 238.8 | 239.7 | 1.038 | 1.042 | 0.4 % | 0.36 V |
| ✅ | `223` | 238.8 | 239.7 | 1.038 | 1.042 | 0.4 % | 0.33 V |
| ✅ | `218` | 238.9 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.2 V |
| ✅ | `139` | 239.0 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.18 V |
| ✅ | `123` | 239.0 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.11 V |
| ✅ | `206` | 239.0 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.13 V |
| ✅ | `315` | 237.5 | 239.7 | 1.032 | 1.042 | 1.0 % | 1.46 V |
| ✅ | `216` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.14 V |
| ✅ | `234` | 238.7 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.33 V |
| ✅ | `306` | 238.7 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.3 V |
| ✅ | `227` | 238.7 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.28 V |
| ✅ | `222` | 238.8 | 239.6 | 1.038 | 1.042 | 0.3 % | 0.18 V |
| ✅ | `316` | 238.6 | 239.6 | 1.037 | 1.042 | 0.5 % | 0.39 V |
| ✅ | `228` | 238.8 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.2 V |
| ✅ | `242` | 238.8 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.2 V |
| ✅ | `308` | 238.6 | 239.6 | 1.037 | 1.042 | 0.5 % | 0.38 V |
| ✅ | `301` | 238.6 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.34 V |
| ✅ | `309` | 238.6 | 239.6 | 1.037 | 1.042 | 0.4 % | 0.37 V |
| ✅ | `249` | 238.8 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.21 V |
| ✅ | `236` | 238.8 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.2 V |
| ✅ | `287` | 238.7 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.25 V |
| ✅ | `262` | 238.7 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.24 V |
| ✅ | `276` | 238.7 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.23 V |
| ✅ | `284` | 238.7 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.22 V |
| ✅ | `292` | 238.7 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.28 V |
| ✅ | `250` | 238.8 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.21 V |
| ✅ | `231` | 239.0 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.11 V |
| ✅ | `239` | 239.0 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.1 V |
| ✅ | `312` | 239.0 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.1 V |
| ✅ | `261` | 238.8 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.19 V |
| ✅ | `268` | 238.8 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.18 V |
| ✅ | `275` | 238.8 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.18 V |
| ✅ | `221` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.11 V |
| ✅ | `130` | 239.3 | 239.6 | 1.04 | 1.042 | 0.1 % | 0.28 V |
| ✅ | `313` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.1 V |
| ✅ | `226` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.09 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |
| W | `grid` | `2` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |
| W | `grid` | `3` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 390.65 W (>1 % of load). pg=20.07 kW, pd=19.9 kW, p_loss=0.56 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-39.804 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-39.804 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-39.804 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 390.65 W (>1 % of load). pg=20.07 kW, pd=19.9 kW, p_loss=0.56 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.46 V at bus '315' — reflects the neutral shift under unbalanced loading.

