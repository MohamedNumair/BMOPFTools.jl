# BMOPF Solution Profile: network_7_Feeder_7

**Generated:** 2026-06-22 15:17:44  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -92.0349  
**Solve time:** 0.077 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 20.987 kW |
| Total load | 20.868 kW |
| Total line losses | 358.69 W |
| Loss fraction | 1.7% |
| Power balance error | 240.03 W |
| Max neutral shift | 1.203 V (bus `332`) |

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
| ✅ | `113` | 230.0 V | 38 | 1.037 (`332`) | 1.044 (`sourcebus`) | 0.6 % (`332`) | 1.2 V (`332`) |

### Per-bus detail

**Zone `113`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `99` | 239.7 | 240.1 | 1.042 | 1.044 | 0.2 % | 0.33 V |
| ✅ | `57` | 239.7 | 240.1 | 1.042 | 1.044 | 0.2 % | 0.31 V |
| ✅ | `98` | 239.7 | 240.1 | 1.042 | 1.044 | 0.2 % | 0.28 V |
| ✅ | `63` | 239.6 | 240.0 | 1.042 | 1.044 | 0.2 % | 0.36 V |
| ✅ | `89` | 239.3 | 240.0 | 1.041 | 1.043 | 0.3 % | 0.58 V |
| ✅ | `71` | 239.5 | 240.0 | 1.041 | 1.043 | 0.2 % | 0.43 V |
| ✅ | `90` | 239.5 | 240.0 | 1.041 | 1.043 | 0.2 % | 0.44 V |
| ✅ | `113` | 239.3 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.55 V |
| ✅ | `168` | 239.3 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.54 V |
| ✅ | `153` | 238.9 | 239.9 | 1.039 | 1.043 | 0.4 % | 0.91 V |
| ✅ | `117` | 239.1 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.7 V |
| ✅ | `167` | 239.1 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.62 V |
| ✅ | `137` | 239.3 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.52 V |
| ✅ | `179` | 238.9 | 239.8 | 1.039 | 1.043 | 0.4 % | 0.82 V |
| ✅ | `120` | 239.0 | 239.8 | 1.039 | 1.043 | 0.4 % | 0.79 V |
| ✅ | `186` | 239.0 | 239.8 | 1.039 | 1.043 | 0.4 % | 0.8 V |
| ✅ | `132` | 238.8 | 239.8 | 1.038 | 1.043 | 0.4 % | 0.88 V |
| ✅ | `203` | 238.8 | 239.8 | 1.038 | 1.043 | 0.4 % | 0.88 V |
| ✅ | `202` | 238.8 | 239.8 | 1.038 | 1.043 | 0.4 % | 0.88 V |
| ✅ | `238` | 238.6 | 239.8 | 1.037 | 1.043 | 0.6 % | 1.15 V |
| ✅ | `237` | 238.7 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.01 V |
| ✅ | `171` | 238.7 | 239.8 | 1.038 | 1.043 | 0.5 % | 0.99 V |
| ✅ | `262` | 238.6 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.07 V |
| ✅ | `206` | 238.7 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.01 V |
| ✅ | `263` | 238.7 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.01 V |
| ✅ | `241` | 238.6 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.04 V |
| ✅ | `332` | 238.5 | 239.8 | 1.037 | 1.043 | 0.6 % | 1.2 V |
| ✅ | `245` | 238.6 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.04 V |
| ✅ | `348` | 238.6 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.03 V |
| ✅ | `255` | 238.6 | 239.8 | 1.037 | 1.043 | 0.5 % | 1.08 V |
| ✅ | `345` | 238.6 | 239.8 | 1.037 | 1.043 | 0.5 % | 1.11 V |
| ✅ | `273` | 238.6 | 239.8 | 1.037 | 1.043 | 0.5 % | 1.08 V |
| ✅ | `279` | 238.6 | 239.8 | 1.037 | 1.043 | 0.5 % | 1.08 V |
| ✅ | `261` | 238.6 | 239.8 | 1.037 | 1.043 | 0.5 % | 1.08 V |
| ✅ | `337` | 238.6 | 239.8 | 1.037 | 1.043 | 0.5 % | 1.07 V |
| ✅ | `310` | 238.6 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.03 V |
| ✅ | `328` | 238.6 | 239.8 | 1.037 | 1.043 | 0.5 % | 1.07 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |
| W | `grid` | `2` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |
| W | `grid` | `3` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 240.03 W (>1 % of load). pg=20.99 kW, pd=20.87 kW, p_loss=0.36 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-41.736 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-41.736 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-41.736 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 240.03 W (>1 % of load). pg=20.99 kW, pd=20.87 kW, p_loss=0.36 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.2 V at bus '332' — reflects the neutral shift under unbalanced loading.

