# BMOPF Solution Profile: Network_14_Feeder_6

**Generated:** 2026-06-21 16:42:21  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -245.1443  
**Solve time:** 0.201 s  
**Findings:** 3 errors · 1 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -258.055 kW |
| Total load | 43.009 kW |
| Total line losses | 416.18 W |
| Loss fraction | 1.0% |
| Power balance error | 301.481 kW |
| Max neutral shift | 0.881 V (bus `168`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 3 | 0 |

## 2. Voltage by Galvanic Zone

Per-unit magnitudes are relative to each zone's own voltage base; volts are not comparable across transformer boundaries.

| St | Zone | V base | Buses | Vm min (pu) | Vm max (pu) | Max imbalance | Max neutral shift |
|:--:|------|-------:|------:|------------:|------------:|--------------:|------------------:|
| ✅ | `127` | 240.0 V | 46 | 0.995 (`168`) | 1.0 (`sourcebus`) | 0.4 % (`168`) | 0.88 V (`168`) |

### Per-bus detail

**Zone `127`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `168` | 238.9 | 239.9 | 0.995 | 0.999 | 0.4 % | 0.88 V |
| ✅ | `135` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.43 V |
| ✅ | `132` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.43 V |
| ✅ | `163` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.19 V |
| ✅ | `153` | 239.5 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.28 V |
| ✅ | `130` | 239.5 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.15 V |
| ✅ | `136` | 239.5 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.14 V |
| ✅ | `148` | 239.5 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.14 V |
| ✅ | `144` | 239.5 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.5 V |
| ✅ | `151` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.08 V |
| ✅ | `165` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.25 V |
| ✅ | `150` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.16 V |
| ✅ | `147` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.16 V |
| ✅ | `138` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.16 V |
| ✅ | `162` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.15 V |
| ✅ | `156` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.15 V |
| ✅ | `159` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.15 V |
| ✅ | `171` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.14 V |
| ✅ | `141` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.34 V |
| ✅ | `143` | 239.6 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.14 V |
| ✅ | `173` | 239.6 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.14 V |
| ✅ | `134` | 239.6 | 239.8 | 0.998 | 0.999 | 0.1 % | 0.12 V |
| ✅ | `164` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.11 V |
| ✅ | `158` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.12 V |
| ✅ | `155` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.12 V |
| ✅ | `140` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.12 V |
| ✅ | `131` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.12 V |
| ✅ | `137` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.12 V |
| ✅ | `170` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.12 V |
| ✅ | `167` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.12 V |
| ✅ | `149` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.12 V |
| ✅ | `152` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.12 V |
| ✅ | `127` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.13 V |
| ✅ | `161` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.16 V |
| ✅ | `146` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.15 V |
| ✅ | `145` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.13 V |
| ✅ | `142` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.12 V |
| ✅ | `139` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.12 V |
| ✅ | `160` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.12 V |
| ✅ | `166` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.12 V |
| ✅ | `169` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.12 V |
| ✅ | `154` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.12 V |
| ✅ | `172` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.12 V |
| ✅ | `133` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.13 V |
| ✅ | `157` | 239.6 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.18 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| **E** | `grid` | `1` | pg | -86.018 kW | [-86.018 kW, 86.018 kW] |
| **E** | `grid` | `2` | pg | -86.018 kW | [-86.018 kW, 86.018 kW] |
| **E** | `grid` | `3` | pg | -86.018 kW | [-86.018 kW, 86.018 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 301.481 kW (>1 % of load). pg=-258.06 kW, pd=43.01 kW, p_loss=0.42 kW.

## 6. All Findings

- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '1': pg=-86.018 kW violates [-86.018 kW, 86.018 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '2': pg=-86.018 kW violates [-86.018 kW, 86.018 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '3': pg=-86.018 kW violates [-86.018 kW, 86.018 kW].
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 301.481 kW (>1 % of load). pg=-258.06 kW, pd=43.01 kW, p_loss=0.42 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 3 violation(s), 0 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 3V / 0A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.88 V at bus '168' — reflects the neutral shift under unbalanced loading.

