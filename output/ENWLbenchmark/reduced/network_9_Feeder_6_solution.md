# BMOPF Solution Profile: network_9_Feeder_6

**Generated:** 2026-06-21 16:44:13  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -115.7351  
**Solve time:** 0.055 s  
**Findings:** 3 errors · 1 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -125.208 kW |
| Total load | 20.868 kW |
| Total line losses | 89.59 W |
| Loss fraction | 0.4% |
| Power balance error | 146.166 kW |
| Max neutral shift | 0.143 V (bus `165`) |

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
| ✅ | `156` | 240.0 V | 26 | 0.999 (`181`) | 1.0 (`sourcebus`) | 0.1 % (`181`) | 0.14 V (`165`) |

### Per-bus detail

**Zone `156`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `181` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.06 V |
| ✅ | `166` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.06 V |
| ✅ | `160` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.05 V |
| ✅ | `178` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.05 V |
| ✅ | `163` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.06 V |
| ✅ | `169` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.09 V |
| ✅ | `165` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.14 V |
| ✅ | `172` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.1 V |
| ✅ | `175` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.07 V |
| ✅ | `162` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.14 V |
| ✅ | `174` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.09 V |
| ✅ | `180` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.09 V |
| ✅ | `171` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.08 V |
| ✅ | `177` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.08 V |
| ✅ | `158` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.07 V |
| ✅ | `164` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.08 V |
| ✅ | `167` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.07 V |
| ✅ | `176` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.07 V |
| ✅ | `170` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.07 V |
| ✅ | `179` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.06 V |
| ✅ | `161` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.05 V |
| ✅ | `173` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.07 V |
| ✅ | `168` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.1 V |
| ✅ | `156` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.07 V |
| ✅ | `46` | 240.1 | 240.1 | 1.0 | 1.0 | 0.0 % | 0.01 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| **E** | `grid` | `1` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |
| **E** | `grid` | `2` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |
| **E** | `grid` | `3` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 146.166 kW (>1 % of load). pg=-125.21 kW, pd=20.87 kW, p_loss=0.09 kW.

## 6. All Findings

- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '1': pg=-41.736 kW violates [-41.736 kW, 41.736 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '2': pg=-41.736 kW violates [-41.736 kW, 41.736 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '3': pg=-41.736 kW violates [-41.736 kW, 41.736 kW].
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 146.166 kW (>1 % of load). pg=-125.21 kW, pd=20.87 kW, p_loss=0.09 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 3 violation(s), 0 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 3V / 0A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.14 V at bus '165' — reflects the neutral shift under unbalanced loading.

