# BMOPF Solution Profile: network_15_Feeder_5

**Generated:** 2026-06-22 15:16:04  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -106.2138  
**Solve time:** 0.138 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 21.292 kW |
| Total load | 21.114 kW |
| Total line losses | 391.99 W |
| Loss fraction | 1.9% |
| Power balance error | 214.01 W |
| Max neutral shift | 1.415 V (bus `510`) |

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
| ✅ | `1064` | 230.0 V | 44 | 1.036 (`510`) | 1.044 (`sourcebus`) | 0.7 % (`510`) | 1.41 V (`510`) |

### Per-bus detail

**Zone `1064`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `70` | 239.8 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.26 V |
| ✅ | `74` | 239.8 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.26 V |
| ✅ | `213` | 239.6 | 240.1 | 1.042 | 1.044 | 0.2 % | 0.52 V |
| ✅ | `75` | 239.8 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.27 V |
| ✅ | `192` | 239.8 | 240.1 | 1.042 | 1.044 | 0.1 % | 0.52 V |
| ✅ | `510` | 238.3 | 239.9 | 1.036 | 1.043 | 0.7 % | 1.41 V |
| ✅ | `496` | 238.4 | 239.9 | 1.036 | 1.043 | 0.7 % | 1.37 V |
| ✅ | `490` | 238.4 | 239.9 | 1.037 | 1.043 | 0.6 % | 1.31 V |
| ✅ | `461` | 238.5 | 239.9 | 1.037 | 1.043 | 0.6 % | 1.19 V |
| ✅ | `457` | 238.6 | 239.9 | 1.037 | 1.043 | 0.6 % | 1.16 V |
| ✅ | `432` | 238.7 | 239.9 | 1.038 | 1.043 | 0.5 % | 1.05 V |
| ✅ | `427` | 238.7 | 239.9 | 1.038 | 1.043 | 0.5 % | 1.04 V |
| ✅ | `244` | 239.2 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.62 V |
| ✅ | `260` | 239.2 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.64 V |
| ✅ | `471` | 239.0 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.75 V |
| ✅ | `509` | 239.0 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.76 V |
| ✅ | `523` | 239.0 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.78 V |
| ✅ | `856` | 238.9 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.91 V |
| ✅ | `774` | 239.0 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.77 V |
| ✅ | `921` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.8 V |
| ✅ | `535` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.78 V |
| ✅ | `903` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.77 V |
| ✅ | `629` | 238.9 | 239.5 | 1.039 | 1.041 | 0.3 % | 0.8 V |
| ✅ | `987` | 238.9 | 239.5 | 1.039 | 1.041 | 0.3 % | 0.89 V |
| ✅ | `797` | 238.9 | 239.5 | 1.039 | 1.041 | 0.3 % | 0.79 V |
| ✅ | `776` | 238.9 | 239.5 | 1.038 | 1.041 | 0.3 % | 0.8 V |
| ✅ | `1064` | 238.9 | 239.5 | 1.038 | 1.041 | 0.3 % | 0.82 V |
| ✅ | `1080` | 238.9 | 239.5 | 1.038 | 1.041 | 0.3 % | 0.83 V |
| ✅ | `1079` | 238.9 | 239.5 | 1.038 | 1.041 | 0.3 % | 0.84 V |
| ✅ | `1106` | 238.9 | 239.5 | 1.038 | 1.041 | 0.3 % | 0.79 V |
| ✅ | `1104` | 238.8 | 239.4 | 1.038 | 1.041 | 0.3 % | 0.78 V |
| ✅ | `815` | 238.8 | 239.4 | 1.038 | 1.041 | 0.3 % | 0.78 V |
| ✅ | `1170` | 238.8 | 239.4 | 1.038 | 1.041 | 0.3 % | 0.69 V |
| ✅ | `1186` | 238.8 | 239.4 | 1.038 | 1.041 | 0.3 % | 0.86 V |
| ✅ | `1202` | 238.8 | 239.4 | 1.038 | 1.041 | 0.3 % | 0.81 V |
| ✅ | `888` | 238.8 | 239.4 | 1.038 | 1.041 | 0.3 % | 0.8 V |
| ✅ | `1301` | 238.7 | 239.4 | 1.038 | 1.041 | 0.3 % | 0.8 V |
| ✅ | `1295` | 238.8 | 239.4 | 1.038 | 1.041 | 0.3 % | 0.78 V |
| ✅ | `1067` | 238.8 | 239.4 | 1.038 | 1.041 | 0.3 % | 0.77 V |
| ✅ | `1123` | 238.8 | 239.4 | 1.038 | 1.041 | 0.3 % | 0.76 V |
| ✅ | `1218` | 238.8 | 239.4 | 1.038 | 1.041 | 0.3 % | 0.74 V |
| ✅ | `1223` | 238.8 | 239.4 | 1.038 | 1.041 | 0.3 % | 0.63 V |
| ✅ | `1134` | 238.8 | 239.4 | 1.038 | 1.041 | 0.3 % | 0.76 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -42.228 kW | [-42.228 kW, 42.228 kW] |
| W | `grid` | `2` | pg | -42.228 kW | [-42.228 kW, 42.228 kW] |
| W | `grid` | `3` | pg | -42.228 kW | [-42.228 kW, 42.228 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 214.01 W (>1 % of load). pg=21.29 kW, pd=21.11 kW, p_loss=0.39 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-42.228 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-42.228 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-42.228 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 214.01 W (>1 % of load). pg=21.29 kW, pd=21.11 kW, p_loss=0.39 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.41 V at bus '510' — reflects the neutral shift under unbalanced loading.

