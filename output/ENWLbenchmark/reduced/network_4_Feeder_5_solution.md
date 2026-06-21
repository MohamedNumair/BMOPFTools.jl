# BMOPF Solution Profile: network_4_Feeder_5

**Generated:** 2026-06-21 16:43:57  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -104.3354  
**Solve time:** 0.045 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -117.396 kW |
| Total load | 19.566 kW |
| Total line losses | 236.78 W |
| Loss fraction | 1.2% |
| Power balance error | 137.199 kW |
| Max neutral shift | 0.817 V (bus `376`) |

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
| ✅ | `109` | 240.0 V | 44 | 0.995 (`404`) | 1.0 (`sourcebus`) | 0.3 % (`175`) | 0.82 V (`376`) |

### Per-bus detail

**Zone `109`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `404` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.56 V |
| ✅ | `348` | 239.1 | 239.5 | 0.996 | 0.997 | 0.2 % | 0.52 V |
| ✅ | `375` | 239.1 | 239.5 | 0.996 | 0.997 | 0.2 % | 0.52 V |
| ✅ | `406` | 239.1 | 239.5 | 0.996 | 0.997 | 0.2 % | 0.5 V |
| ✅ | `396` | 239.1 | 239.5 | 0.996 | 0.997 | 0.2 % | 0.51 V |
| ✅ | `341` | 239.1 | 239.5 | 0.996 | 0.997 | 0.2 % | 0.52 V |
| ✅ | `364` | 239.1 | 239.6 | 0.996 | 0.997 | 0.2 % | 0.67 V |
| ✅ | `399` | 239.1 | 239.6 | 0.996 | 0.997 | 0.2 % | 0.52 V |
| ✅ | `326` | 239.2 | 239.6 | 0.996 | 0.997 | 0.2 % | 0.52 V |
| ✅ | `394` | 239.2 | 239.6 | 0.996 | 0.997 | 0.2 % | 0.52 V |
| ✅ | `321` | 239.2 | 239.6 | 0.996 | 0.997 | 0.2 % | 0.52 V |
| ✅ | `376` | 239.2 | 239.6 | 0.996 | 0.998 | 0.2 % | 0.82 V |
| ✅ | `307` | 239.2 | 239.6 | 0.996 | 0.997 | 0.2 % | 0.52 V |
| ✅ | `175` | 239.2 | 239.9 | 0.996 | 0.999 | 0.3 % | 0.71 V |
| ✅ | `324` | 239.2 | 239.6 | 0.996 | 0.998 | 0.1 % | 0.58 V |
| ✅ | `329` | 239.2 | 239.6 | 0.996 | 0.998 | 0.1 % | 0.59 V |
| ✅ | `319` | 239.2 | 239.6 | 0.996 | 0.998 | 0.1 % | 0.56 V |
| ✅ | `311` | 239.3 | 239.6 | 0.996 | 0.998 | 0.1 % | 0.54 V |
| ✅ | `342` | 239.3 | 239.6 | 0.996 | 0.998 | 0.1 % | 0.5 V |
| ✅ | `276` | 239.3 | 239.6 | 0.996 | 0.998 | 0.1 % | 0.49 V |
| ✅ | `271` | 239.3 | 239.6 | 0.996 | 0.998 | 0.1 % | 0.4 V |
| ✅ | `216` | 239.3 | 239.6 | 0.996 | 0.998 | 0.1 % | 0.4 V |
| ✅ | `125` | 239.4 | 239.8 | 0.997 | 0.998 | 0.2 % | 0.43 V |
| ✅ | `202` | 239.4 | 239.6 | 0.997 | 0.998 | 0.1 % | 0.35 V |
| ✅ | `278` | 239.4 | 239.6 | 0.997 | 0.998 | 0.1 % | 0.33 V |
| ✅ | `255` | 239.4 | 239.6 | 0.997 | 0.998 | 0.1 % | 0.31 V |
| ✅ | `189` | 239.4 | 239.6 | 0.997 | 0.998 | 0.1 % | 0.29 V |
| ✅ | `173` | 239.5 | 239.6 | 0.997 | 0.998 | 0.1 % | 0.25 V |
| ✅ | `183` | 239.5 | 239.6 | 0.997 | 0.998 | 0.1 % | 0.13 V |
| ✅ | `162` | 239.5 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.33 V |
| ✅ | `129` | 239.5 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.25 V |
| ✅ | `114` | 239.5 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.24 V |
| ✅ | `147` | 239.5 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.26 V |
| ✅ | `91` | 239.6 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.24 V |
| ✅ | `118` | 239.6 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.25 V |
| ✅ | `85` | 239.6 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.22 V |
| ✅ | `94` | 239.7 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.08 V |
| ✅ | `71` | 239.8 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.17 V |
| ✅ | `68` | 239.8 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.16 V |
| ✅ | `240` | 239.8 | 239.9 | 0.998 | 0.999 | 0.0 % | 0.19 V |
| ✅ | `109` | 239.8 | 239.9 | 0.998 | 0.999 | 0.0 % | 0.17 V |
| ✅ | `66` | 239.8 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.16 V |
| ✅ | `65` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.12 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -39.132 kW | [-39.132 kW, 39.132 kW] |
| W | `grid` | `2` | pg | -39.132 kW | [-39.132 kW, 39.132 kW] |
| W | `grid` | `3` | pg | -39.132 kW | [-39.132 kW, 39.132 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 137.199 kW (>1 % of load). pg=-117.4 kW, pd=19.57 kW, p_loss=0.24 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-39.132 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-39.132 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-39.132 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 137.199 kW (>1 % of load). pg=-117.4 kW, pd=19.57 kW, p_loss=0.24 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.82 V at bus '376' — reflects the neutral shift under unbalanced loading.

