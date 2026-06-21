# BMOPF Solution Profile: network_18_Feeder_8

**Generated:** 2026-06-21 16:43:12  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -110.3003  
**Solve time:** 0.091 s  
**Findings:** 3 errors · 1 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -119.412 kW |
| Total load | 19.902 kW |
| Total line losses | 356.78 W |
| Loss fraction | 1.8% |
| Power balance error | 139.671 kW |
| Max neutral shift | 1.086 V (bus `229`) |

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
| ✅ | `110` | 240.0 V | 44 | 0.993 (`229`) | 1.0 (`sourcebus`) | 0.5 % (`229`) | 1.09 V (`229`) |

### Per-bus detail

**Zone `110`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `229` | 238.6 | 239.8 | 0.993 | 0.999 | 0.5 % | 1.09 V |
| ✅ | `209` | 238.6 | 239.8 | 0.993 | 0.999 | 0.5 % | 1.0 V |
| ✅ | `202` | 238.7 | 239.8 | 0.994 | 0.999 | 0.5 % | 0.93 V |
| ✅ | `320` | 239.0 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.22 V |
| ✅ | `345` | 239.0 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.13 V |
| ✅ | `312` | 239.0 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.45 V |
| ✅ | `339` | 239.0 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.11 V |
| ✅ | `347` | 239.0 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.11 V |
| ✅ | `330` | 239.0 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.11 V |
| ✅ | `317` | 239.0 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.11 V |
| ✅ | `331` | 239.0 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.21 V |
| ✅ | `340` | 239.0 | 239.6 | 0.995 | 0.998 | 0.3 % | 0.15 V |
| ✅ | `333` | 239.0 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.13 V |
| ✅ | `302` | 239.0 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.14 V |
| ✅ | `305` | 239.0 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.36 V |
| ✅ | `291` | 239.0 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.16 V |
| ✅ | `298` | 239.0 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.36 V |
| ✅ | `319` | 239.0 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.2 V |
| ✅ | `326` | 239.0 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.2 V |
| ✅ | `272` | 239.1 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.19 V |
| ✅ | `247` | 239.1 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.25 V |
| ✅ | `318` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.21 V |
| ✅ | `241` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.18 V |
| ✅ | `235` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.18 V |
| ✅ | `231` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.25 V |
| ✅ | `117` | 239.2 | 239.8 | 0.996 | 0.999 | 0.3 % | 0.31 V |
| ✅ | `110` | 239.3 | 239.8 | 0.996 | 0.999 | 0.2 % | 0.3 V |
| ✅ | `243` | 239.3 | 239.8 | 0.996 | 0.998 | 0.2 % | 0.31 V |
| ✅ | `249` | 239.3 | 239.8 | 0.996 | 0.998 | 0.2 % | 0.31 V |
| ✅ | `255` | 239.3 | 239.8 | 0.996 | 0.998 | 0.2 % | 0.31 V |
| ✅ | `137` | 239.3 | 240.0 | 0.996 | 0.999 | 0.3 % | 0.62 V |
| ✅ | `79` | 239.4 | 240.1 | 0.997 | 1.0 | 0.3 % | 0.79 V |
| ✅ | `129` | 239.4 | 240.0 | 0.997 | 0.999 | 0.2 % | 0.56 V |
| ✅ | `120` | 239.4 | 240.0 | 0.997 | 0.999 | 0.2 % | 0.54 V |
| ✅ | `283` | 239.5 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.08 V |
| ✅ | `201` | 239.5 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.09 V |
| ✅ | `193` | 239.5 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.1 V |
| ✅ | `77` | 239.5 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.23 V |
| ✅ | `52` | 239.7 | 240.0 | 0.998 | 0.999 | 0.1 % | 0.23 V |
| ✅ | `49` | 239.7 | 240.0 | 0.998 | 0.999 | 0.1 % | 0.23 V |
| ✅ | `43` | 239.8 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.18 V |
| ✅ | `158` | 239.8 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.2 V |
| ✅ | `41` | 239.9 | 240.1 | 0.999 | 0.999 | 0.1 % | 0.15 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| **E** | `grid` | `1` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |
| **E** | `grid` | `2` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |
| **E** | `grid` | `3` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 139.671 kW (>1 % of load). pg=-119.41 kW, pd=19.9 kW, p_loss=0.36 kW.

## 6. All Findings

- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '1': pg=-39.804 kW violates [-39.804 kW, 39.804 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '2': pg=-39.804 kW violates [-39.804 kW, 39.804 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '3': pg=-39.804 kW violates [-39.804 kW, 39.804 kW].
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 139.671 kW (>1 % of load). pg=-119.41 kW, pd=19.9 kW, p_loss=0.36 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 3 violation(s), 0 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 3V / 0A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.09 V at bus '229' — reflects the neutral shift under unbalanced loading.

