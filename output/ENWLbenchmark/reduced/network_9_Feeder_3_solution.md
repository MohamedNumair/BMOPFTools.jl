# BMOPF Solution Profile: network_9_Feeder_3

**Generated:** 2026-06-21 16:44:09  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -75.7939  
**Solve time:** 0.065 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -117.396 kW |
| Total load | 19.566 kW |
| Total line losses | 92.78 W |
| Loss fraction | 0.5% |
| Power balance error | 137.055 kW |
| Max neutral shift | 0.137 V (bus `92`) |

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
| ✅ | `100` | 240.0 V | 23 | 0.999 (`93`) | 1.0 (`sourcebus`) | 0.1 % (`93`) | 0.14 V (`92`) |

### Per-bus detail

**Zone `100`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `93` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.09 V |
| ✅ | `105` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.09 V |
| ✅ | `87` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.09 V |
| ✅ | `92` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.14 V |
| ✅ | `89` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.13 V |
| ✅ | `90` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.07 V |
| ✅ | `96` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.07 V |
| ✅ | `99` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.07 V |
| ✅ | `102` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.07 V |
| ✅ | `101` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.08 V |
| ✅ | `98` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.07 V |
| ✅ | `104` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.07 V |
| ✅ | `95` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.07 V |
| ✅ | `86` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.07 V |
| ✅ | `94` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.06 V |
| ✅ | `97` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.06 V |
| ✅ | `106` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.06 V |
| ✅ | `103` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.06 V |
| ✅ | `88` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.06 V |
| ✅ | `91` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.04 V |
| ✅ | `100` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.02 V |
| ✅ | `85` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.07 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -39.132 kW | [-39.132 kW, 39.132 kW] |
| W | `grid` | `2` | pg | -39.132 kW | [-39.132 kW, 39.132 kW] |
| W | `grid` | `3` | pg | -39.132 kW | [-39.132 kW, 39.132 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 137.055 kW (>1 % of load). pg=-117.4 kW, pd=19.57 kW, p_loss=0.09 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-39.132 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-39.132 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-39.132 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 137.055 kW (>1 % of load). pg=-117.4 kW, pd=19.57 kW, p_loss=0.09 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.14 V at bus '92' — reflects the neutral shift under unbalanced loading.

