# BMOPF Solution Profile: network_10_Feeder_4

**Generated:** 2026-06-21 16:42:39  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -33.5295  
**Solve time:** 0.022 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -71.892 kW |
| Total load | 11.982 kW |
| Total line losses | 62.45 W |
| Loss fraction | 0.5% |
| Power balance error | 83.936 kW |
| Max neutral shift | 0.384 V (bus `496`) |

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
| ✅ | `165` | 240.0 V | 17 | 0.997 (`497`) | 1.0 (`sourcebus`) | 0.2 % (`497`) | 0.38 V (`496`) |

### Per-bus detail

**Zone `165`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `497` | 239.6 | 240.1 | 0.997 | 0.999 | 0.2 % | 0.31 V |
| ✅ | `496` | 239.6 | 240.0 | 0.998 | 0.999 | 0.2 % | 0.38 V |
| ✅ | `490` | 239.6 | 240.1 | 0.998 | 0.999 | 0.2 % | 0.29 V |
| ✅ | `495` | 239.6 | 240.0 | 0.998 | 0.999 | 0.2 % | 0.25 V |
| ✅ | `462` | 239.6 | 240.1 | 0.998 | 0.999 | 0.2 % | 0.29 V |
| ✅ | `169` | 239.7 | 240.1 | 0.998 | 1.0 | 0.2 % | 0.23 V |
| ✅ | `273` | 239.7 | 240.1 | 0.998 | 1.0 | 0.2 % | 0.31 V |
| ✅ | `165` | 239.8 | 240.1 | 0.998 | 1.0 | 0.1 % | 0.21 V |
| ✅ | `264` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.18 V |
| ✅ | `289` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.17 V |
| ✅ | `256` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.18 V |
| ✅ | `280` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.18 V |
| ✅ | `179` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.14 V |
| ✅ | `85` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.15 V |
| ✅ | `185` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.11 V |
| ✅ | `83` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.15 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -23.964 kW | [-23.964 kW, 23.964 kW] |
| W | `grid` | `2` | pg | -23.964 kW | [-23.964 kW, 23.964 kW] |
| W | `grid` | `3` | pg | -23.964 kW | [-23.964 kW, 23.964 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 83.936 kW (>1 % of load). pg=-71.89 kW, pd=11.98 kW, p_loss=0.06 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-23.964 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-23.964 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-23.964 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 83.936 kW (>1 % of load). pg=-71.89 kW, pd=11.98 kW, p_loss=0.06 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.38 V at bus '496' — reflects the neutral shift under unbalanced loading.

