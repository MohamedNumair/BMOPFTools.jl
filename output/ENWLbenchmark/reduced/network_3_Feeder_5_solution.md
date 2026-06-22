# BMOPF Solution Profile: network_3_Feeder_5

**Generated:** 2026-06-22 14:52:57  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -99.3237  
**Solve time:** 0.047 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 20.018 kW |
| Total load | 19.902 kW |
| Total line losses | 387.28 W |
| Loss fraction | 1.9% |
| Power balance error | 271.4 W |
| Max neutral shift | 1.723 V (bus `315`) |

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
| ✅ | `105` | 240.0 V | 43 | 0.99 (`315`) | 1.0 (`sourcebus`) | 0.9 % (`315`) | 1.72 V (`315`) |

### Per-bus detail

**Zone `105`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `315` | 237.7 | 239.8 | 0.99 | 0.999 | 0.9 % | 1.72 V |
| ✅ | `316` | 238.8 | 239.8 | 0.994 | 0.998 | 0.4 % | 0.61 V |
| ✅ | `308` | 238.8 | 239.8 | 0.994 | 0.998 | 0.4 % | 0.61 V |
| ✅ | `309` | 238.9 | 239.8 | 0.994 | 0.998 | 0.4 % | 0.57 V |
| ✅ | `301` | 238.9 | 239.8 | 0.994 | 0.998 | 0.4 % | 0.56 V |
| ✅ | `234` | 238.9 | 239.8 | 0.995 | 0.998 | 0.4 % | 0.57 V |
| ✅ | `230` | 238.9 | 239.8 | 0.995 | 0.999 | 0.4 % | 0.63 V |
| ✅ | `306` | 238.9 | 239.8 | 0.995 | 0.998 | 0.4 % | 0.54 V |
| ✅ | `339` | 238.9 | 239.8 | 0.995 | 0.999 | 0.4 % | 0.59 V |
| ✅ | `287` | 238.9 | 239.8 | 0.995 | 0.998 | 0.4 % | 0.48 V |
| ✅ | `227` | 238.9 | 239.8 | 0.995 | 0.998 | 0.4 % | 0.52 V |
| ✅ | `262` | 239.0 | 239.8 | 0.995 | 0.998 | 0.4 % | 0.46 V |
| ✅ | `276` | 239.0 | 239.8 | 0.995 | 0.998 | 0.4 % | 0.4 V |
| ✅ | `284` | 239.0 | 239.8 | 0.995 | 0.998 | 0.4 % | 0.39 V |
| ✅ | `292` | 239.0 | 239.8 | 0.995 | 0.998 | 0.4 % | 0.36 V |
| ✅ | `223` | 239.0 | 239.8 | 0.995 | 0.999 | 0.4 % | 0.56 V |
| ✅ | `275` | 239.0 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.44 V |
| ✅ | `268` | 239.0 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.44 V |
| ✅ | `261` | 239.0 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.44 V |
| ✅ | `250` | 239.0 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.44 V |
| ✅ | `249` | 239.0 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.45 V |
| ✅ | `236` | 239.0 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.44 V |
| ✅ | `228` | 239.0 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.44 V |
| ✅ | `242` | 239.0 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.42 V |
| ✅ | `222` | 239.0 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.43 V |
| ✅ | `226` | 239.1 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.38 V |
| ✅ | `313` | 239.1 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.38 V |
| ✅ | `221` | 239.1 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.38 V |
| ✅ | `216` | 239.1 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.39 V |
| ✅ | `218` | 239.1 | 239.8 | 0.995 | 0.999 | 0.3 % | 0.43 V |
| ✅ | `139` | 239.1 | 239.8 | 0.996 | 0.999 | 0.3 % | 0.41 V |
| ✅ | `312` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.36 V |
| ✅ | `239` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.36 V |
| ✅ | `231` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.36 V |
| ✅ | `206` | 239.1 | 239.8 | 0.996 | 0.999 | 0.3 % | 0.37 V |
| ✅ | `123` | 239.2 | 239.8 | 0.996 | 0.999 | 0.3 % | 0.34 V |
| ✅ | `117` | 239.3 | 239.9 | 0.996 | 0.999 | 0.3 % | 0.29 V |
| ✅ | `149` | 239.3 | 239.9 | 0.996 | 0.999 | 0.3 % | 0.22 V |
| ✅ | `137` | 239.3 | 239.9 | 0.996 | 0.999 | 0.2 % | 0.25 V |
| ✅ | `112` | 239.3 | 239.9 | 0.996 | 0.999 | 0.2 % | 0.28 V |
| ✅ | `130` | 239.4 | 239.8 | 0.997 | 0.998 | 0.2 % | 0.15 V |
| ✅ | `105` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.23 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |
| W | `grid` | `2` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |
| W | `grid` | `3` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 271.4 W (>1 % of load). pg=20.02 kW, pd=19.9 kW, p_loss=0.39 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-39.804 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-39.804 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-39.804 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 271.4 W (>1 % of load). pg=20.02 kW, pd=19.9 kW, p_loss=0.39 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.72 V at bus '315' — reflects the neutral shift under unbalanced loading.

