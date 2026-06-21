# BMOPF Solution Profile: network_10_Feeder_6

**Generated:** 2026-06-21 16:42:39  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -33.521  
**Solve time:** 0.011 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -41.22 kW |
| Total load | 6.87 kW |
| Total line losses | 28.37 W |
| Loss fraction | 0.4% |
| Power balance error | 48.118 kW |
| Max neutral shift | 0.284 V (bus `367`) |

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
| ✅ | `227` | 240.0 V | 12 | 0.998 (`367`) | 1.0 (`sourcebus`) | 0.1 % (`367`) | 0.28 V (`367`) |

### Per-bus detail

**Zone `227`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `367` | 239.7 | 240.0 | 0.998 | 0.999 | 0.1 % | 0.28 V |
| ✅ | `459` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.25 V |
| ✅ | `301` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.2 V |
| ✅ | `429` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.21 V |
| ✅ | `295` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.19 V |
| ✅ | `338` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.19 V |
| ✅ | `442` | 239.9 | 239.9 | 0.999 | 0.999 | 0.0 % | 0.18 V |
| ✅ | `227` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.18 V |
| ✅ | `286` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.19 V |
| ✅ | `64` | 240.0 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.06 V |
| ✅ | `63` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.02 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -13.74 kW | [-13.74 kW, 13.74 kW] |
| W | `grid` | `2` | pg | -13.74 kW | [-13.74 kW, 13.74 kW] |
| W | `grid` | `3` | pg | -13.74 kW | [-13.74 kW, 13.74 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 48.118 kW (>1 % of load). pg=-41.22 kW, pd=6.87 kW, p_loss=0.03 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-13.74 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-13.74 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-13.74 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 48.118 kW (>1 % of load). pg=-41.22 kW, pd=6.87 kW, p_loss=0.03 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.28 V at bus '367' — reflects the neutral shift under unbalanced loading.

