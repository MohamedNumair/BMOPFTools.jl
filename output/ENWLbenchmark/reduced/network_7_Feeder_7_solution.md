# BMOPF Solution Profile: network_7_Feeder_7

**Generated:** 2026-06-21 16:44:08  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -92.0349  
**Solve time:** 0.046 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -125.208 kW |
| Total load | 20.868 kW |
| Total line losses | 307.5 W |
| Loss fraction | 1.5% |
| Power balance error | 146.383 kW |
| Max neutral shift | 0.853 V (bus `332`) |

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
| ✅ | `113` | 240.0 V | 38 | 0.993 (`332`) | 1.0 (`sourcebus`) | 0.5 % (`332`) | 0.85 V (`332`) |

### Per-bus detail

**Zone `113`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `332` | 238.6 | 239.9 | 0.993 | 0.999 | 0.5 % | 0.85 V |
| ✅ | `238` | 238.7 | 239.9 | 0.994 | 0.999 | 0.5 % | 0.84 V |
| ✅ | `345` | 238.7 | 239.9 | 0.994 | 0.999 | 0.5 % | 0.74 V |
| ✅ | `273` | 238.7 | 239.9 | 0.994 | 0.999 | 0.5 % | 0.72 V |
| ✅ | `279` | 238.7 | 239.9 | 0.994 | 0.999 | 0.5 % | 0.71 V |
| ✅ | `337` | 238.7 | 239.9 | 0.994 | 0.999 | 0.5 % | 0.66 V |
| ✅ | `328` | 238.7 | 239.9 | 0.994 | 0.999 | 0.5 % | 0.71 V |
| ✅ | `261` | 238.7 | 239.9 | 0.994 | 0.999 | 0.5 % | 0.73 V |
| ✅ | `255` | 238.7 | 239.9 | 0.994 | 0.999 | 0.5 % | 0.73 V |
| ✅ | `262` | 238.7 | 239.9 | 0.994 | 0.999 | 0.5 % | 0.75 V |
| ✅ | `348` | 238.7 | 239.8 | 0.994 | 0.998 | 0.5 % | 0.69 V |
| ✅ | `245` | 238.7 | 239.9 | 0.994 | 0.999 | 0.5 % | 0.7 V |
| ✅ | `310` | 238.7 | 239.9 | 0.994 | 0.999 | 0.5 % | 0.69 V |
| ✅ | `241` | 238.7 | 239.9 | 0.994 | 0.999 | 0.5 % | 0.7 V |
| ✅ | `263` | 238.8 | 239.9 | 0.994 | 0.999 | 0.5 % | 0.68 V |
| ✅ | `206` | 238.8 | 239.9 | 0.994 | 0.999 | 0.5 % | 0.69 V |
| ✅ | `237` | 238.8 | 239.9 | 0.994 | 0.999 | 0.5 % | 0.69 V |
| ✅ | `171` | 238.8 | 239.9 | 0.994 | 0.999 | 0.5 % | 0.67 V |
| ✅ | `202` | 238.9 | 239.9 | 0.995 | 0.999 | 0.4 % | 0.58 V |
| ✅ | `203` | 238.9 | 239.9 | 0.995 | 0.999 | 0.4 % | 0.58 V |
| ✅ | `132` | 238.9 | 239.9 | 0.995 | 0.999 | 0.4 % | 0.59 V |
| ✅ | `153` | 239.0 | 240.0 | 0.995 | 0.999 | 0.4 % | 0.68 V |
| ✅ | `179` | 239.0 | 240.0 | 0.995 | 0.999 | 0.4 % | 0.54 V |
| ✅ | `120` | 239.1 | 240.0 | 0.995 | 0.999 | 0.4 % | 0.52 V |
| ✅ | `186` | 239.1 | 239.9 | 0.995 | 0.999 | 0.4 % | 0.47 V |
| ✅ | `167` | 239.2 | 240.0 | 0.996 | 0.999 | 0.3 % | 0.41 V |
| ✅ | `117` | 239.2 | 240.0 | 0.996 | 0.999 | 0.3 % | 0.46 V |
| ✅ | `137` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.29 V |
| ✅ | `168` | 239.4 | 240.0 | 0.997 | 0.999 | 0.3 % | 0.35 V |
| ✅ | `113` | 239.4 | 240.0 | 0.997 | 0.999 | 0.3 % | 0.36 V |
| ✅ | `89` | 239.4 | 240.1 | 0.997 | 1.0 | 0.3 % | 0.45 V |
| ✅ | `90` | 239.6 | 240.1 | 0.997 | 0.999 | 0.2 % | 0.27 V |
| ✅ | `71` | 239.6 | 240.1 | 0.997 | 1.0 | 0.2 % | 0.29 V |
| ✅ | `63` | 239.6 | 240.1 | 0.998 | 1.0 | 0.2 % | 0.25 V |
| ✅ | `99` | 239.7 | 240.1 | 0.998 | 1.0 | 0.2 % | 0.24 V |
| ✅ | `98` | 239.7 | 240.1 | 0.998 | 1.0 | 0.2 % | 0.27 V |
| ✅ | `57` | 239.7 | 240.1 | 0.998 | 1.0 | 0.2 % | 0.21 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |
| W | `grid` | `2` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |
| W | `grid` | `3` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 146.383 kW (>1 % of load). pg=-125.21 kW, pd=20.87 kW, p_loss=0.31 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-41.736 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-41.736 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-41.736 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 146.383 kW (>1 % of load). pg=-125.21 kW, pd=20.87 kW, p_loss=0.31 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.85 V at bus '332' — reflects the neutral shift under unbalanced loading.

