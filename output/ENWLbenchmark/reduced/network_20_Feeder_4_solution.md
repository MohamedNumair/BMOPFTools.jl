# BMOPF Solution Profile: network_20_Feeder_4

**Generated:** 2026-06-21 16:43:25  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -134.9131  
**Solve time:** 0.035 s  
**Findings:** 3 errors · 1 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -147.564 kW |
| Total load | 24.594 kW |
| Total line losses | 64.58 W |
| Loss fraction | 0.3% |
| Power balance error | 172.223 kW |
| Max neutral shift | 0.091 V (bus `47`) |

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
| ✅ | `41` | 240.0 V | 31 | 0.999 (`60`) | 1.0 (`sourcebus`) | 0.1 % (`60`) | 0.09 V (`47`) |

### Per-bus detail

**Zone `41`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `60` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.06 V |
| ✅ | `48` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.05 V |
| ✅ | `42` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.05 V |
| ✅ | `63` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.02 V |
| ✅ | `47` | 240.0 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.09 V |
| ✅ | `44` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.08 V |
| ✅ | `45` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.01 V |
| ✅ | `51` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.0 V |
| ✅ | `54` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.0 V |
| ✅ | `66` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.04 V |
| ✅ | `69` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.04 V |
| ✅ | `57` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.0 V |
| ✅ | `65` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.07 V |
| ✅ | `56` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.03 V |
| ✅ | `62` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.02 V |
| ✅ | `50` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.01 V |
| ✅ | `68` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.01 V |
| ✅ | `41` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.01 V |
| ✅ | `64` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.01 V |
| ✅ | `49` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.01 V |
| ✅ | `61` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.01 V |
| ✅ | `43` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.01 V |
| ✅ | `52` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.01 V |
| ✅ | `67` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.01 V |
| ✅ | `70` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.01 V |
| ✅ | `46` | 240.0 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.04 V |
| ✅ | `58` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.06 V |
| ✅ | `55` | 240.0 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.06 V |
| ✅ | `53` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.05 V |
| ✅ | `59` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.05 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| **E** | `grid` | `1` | pg | -49.188 kW | [-49.188 kW, 49.188 kW] |
| **E** | `grid` | `2` | pg | -49.188 kW | [-49.188 kW, 49.188 kW] |
| **E** | `grid` | `3` | pg | -49.188 kW | [-49.188 kW, 49.188 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 172.223 kW (>1 % of load). pg=-147.56 kW, pd=24.59 kW, p_loss=0.06 kW.

## 6. All Findings

- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '1': pg=-49.188 kW violates [-49.188 kW, 49.188 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '2': pg=-49.188 kW violates [-49.188 kW, 49.188 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '3': pg=-49.188 kW violates [-49.188 kW, 49.188 kW].
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 172.223 kW (>1 % of load). pg=-147.56 kW, pd=24.59 kW, p_loss=0.06 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 3 violation(s), 0 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 3V / 0A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.09 V at bus '47' — reflects the neutral shift under unbalanced loading.

