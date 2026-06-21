# BMOPF Solution Profile: network_17_Feeder_2

**Generated:** 2026-06-21 16:43:00  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -51.0286  
**Solve time:** 0.022 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -73.656 kW |
| Total load | 12.276 kW |
| Total line losses | 69.01 W |
| Loss fraction | 0.6% |
| Power balance error | 86.001 kW |
| Max neutral shift | 0.554 V (bus `254`) |

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
| ✅ | `102` | 240.0 V | 17 | 0.997 (`254`) | 1.0 (`254`) | 0.3 % (`254`) | 0.55 V (`254`) |

### Per-bus detail

**Zone `102`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `254` | 239.4 | 240.2 | 0.997 | 1.0 | 0.3 % | 0.55 V |
| ✅ | `193` | 239.6 | 240.2 | 0.997 | 1.0 | 0.3 % | 0.46 V |
| ✅ | `187` | 239.6 | 240.2 | 0.997 | 1.0 | 0.3 % | 0.45 V |
| ✅ | `259` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.53 V |
| ✅ | `110` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.42 V |
| ✅ | `102` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.41 V |
| ✅ | `186` | 239.7 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.45 V |
| ✅ | `179` | 239.8 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.45 V |
| ✅ | `118` | 239.8 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.42 V |
| ✅ | `108` | 239.8 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.4 V |
| ✅ | `54` | 239.8 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.37 V |
| ✅ | `460` | 239.9 | 240.2 | 0.999 | 1.0 | 0.1 % | 0.21 V |
| ✅ | `412` | 239.9 | 240.2 | 0.999 | 1.0 | 0.1 % | 0.21 V |
| ✅ | `48` | 239.9 | 240.2 | 0.999 | 1.0 | 0.1 % | 0.18 V |
| ✅ | `30` | 240.0 | 240.2 | 0.999 | 1.0 | 0.1 % | 0.14 V |
| ✅ | `27` | 240.0 | 240.2 | 0.999 | 1.0 | 0.1 % | 0.12 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -24.552 kW | [-24.552 kW, 24.552 kW] |
| W | `grid` | `2` | pg | -24.552 kW | [-24.552 kW, 24.552 kW] |
| W | `grid` | `3` | pg | -24.552 kW | [-24.552 kW, 24.552 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 86.001 kW (>1 % of load). pg=-73.66 kW, pd=12.28 kW, p_loss=0.07 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-24.552 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-24.552 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-24.552 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 86.001 kW (>1 % of load). pg=-73.66 kW, pd=12.28 kW, p_loss=0.07 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.55 V at bus '254' — reflects the neutral shift under unbalanced loading.

