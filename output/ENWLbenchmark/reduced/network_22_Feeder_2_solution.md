# BMOPF Solution Profile: network_22_Feeder_2

**Generated:** 2026-06-21 16:43:26  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -68.9141  
**Solve time:** 0.033 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -82.584 kW |
| Total load | 13.764 kW |
| Total line losses | 209.65 W |
| Loss fraction | 1.5% |
| Power balance error | 96.558 kW |
| Max neutral shift | 0.671 V (bus `174`) |

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
| ✅ | `112` | 240.0 V | 28 | 0.994 (`174`) | 1.0 (`sourcebus`) | 0.5 % (`174`) | 0.67 V (`174`) |

### Per-bus detail

**Zone `112`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `174` | 238.7 | 239.8 | 0.994 | 0.998 | 0.5 % | 0.67 V |
| ✅ | `186` | 238.7 | 239.8 | 0.994 | 0.998 | 0.5 % | 0.67 V |
| ✅ | `168` | 238.8 | 239.8 | 0.994 | 0.998 | 0.4 % | 0.58 V |
| ✅ | `250` | 239.1 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.35 V |
| ✅ | `251` | 239.1 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.38 V |
| ✅ | `248` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.34 V |
| ✅ | `216` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.1 V |
| ✅ | `239` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.22 V |
| ✅ | `190` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.17 V |
| ✅ | `112` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.28 V |
| ✅ | `142` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.25 V |
| ✅ | `217` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.18 V |
| ✅ | `194` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.26 V |
| ✅ | `210` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.27 V |
| ✅ | `183` | 239.2 | 239.8 | 0.996 | 0.999 | 0.3 % | 0.33 V |
| ✅ | `178` | 239.2 | 239.8 | 0.996 | 0.999 | 0.3 % | 0.31 V |
| ✅ | `171` | 239.2 | 239.8 | 0.996 | 0.999 | 0.3 % | 0.3 V |
| ✅ | `144` | 239.2 | 239.8 | 0.996 | 0.998 | 0.2 % | 0.1 V |
| ✅ | `138` | 239.2 | 239.8 | 0.996 | 0.998 | 0.2 % | 0.09 V |
| ✅ | `150` | 239.2 | 239.8 | 0.996 | 0.998 | 0.2 % | 0.17 V |
| ✅ | `91` | 239.2 | 239.8 | 0.996 | 0.998 | 0.2 % | 0.21 V |
| ✅ | `71` | 239.3 | 239.8 | 0.996 | 0.999 | 0.2 % | 0.2 V |
| ✅ | `64` | 239.4 | 239.8 | 0.997 | 0.999 | 0.2 % | 0.21 V |
| ✅ | `185` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.56 V |
| ✅ | `189` | 239.5 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.51 V |
| ✅ | `179` | 239.5 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.5 V |
| ✅ | `54` | 239.6 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.19 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -27.528 kW | [-27.528 kW, 27.528 kW] |
| W | `grid` | `2` | pg | -27.528 kW | [-27.528 kW, 27.528 kW] |
| W | `grid` | `3` | pg | -27.528 kW | [-27.528 kW, 27.528 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 96.558 kW (>1 % of load). pg=-82.58 kW, pd=13.76 kW, p_loss=0.21 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-27.528 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-27.528 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-27.528 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 96.558 kW (>1 % of load). pg=-82.58 kW, pd=13.76 kW, p_loss=0.21 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.67 V at bus '174' — reflects the neutral shift under unbalanced loading.

