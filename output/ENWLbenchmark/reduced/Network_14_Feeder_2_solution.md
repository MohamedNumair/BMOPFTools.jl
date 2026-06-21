# BMOPF Solution Profile: Network_14_Feeder_2

**Generated:** 2026-06-21 16:42:20  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -144.9909  
**Solve time:** 0.038 s  
**Findings:** 3 errors · 1 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -145.476 kW |
| Total load | 24.246 kW |
| Total line losses | 123.53 W |
| Loss fraction | 0.5% |
| Power balance error | 169.846 kW |
| Max neutral shift | 0.507 V (bus `85`) |

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
| ✅ | `100` | 240.0 V | 30 | 0.998 (`85`) | 1.0 (`sourcebus`) | 0.2 % (`85`) | 0.51 V (`85`) |

### Per-bus detail

**Zone `100`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `85` | 239.6 | 240.0 | 0.998 | 0.999 | 0.2 % | 0.51 V |
| ✅ | `82` | 239.6 | 240.0 | 0.998 | 0.999 | 0.2 % | 0.5 V |
| ✅ | `103` | 239.7 | 240.0 | 0.998 | 0.999 | 0.1 % | 0.43 V |
| ✅ | `80` | 239.7 | 240.1 | 0.998 | 0.999 | 0.1 % | 0.29 V |
| ✅ | `98` | 239.7 | 240.1 | 0.998 | 0.999 | 0.1 % | 0.29 V |
| ✅ | `86` | 239.7 | 240.0 | 0.998 | 0.999 | 0.1 % | 0.42 V |
| ✅ | `94` | 239.8 | 240.0 | 0.998 | 0.999 | 0.1 % | 0.3 V |
| ✅ | `101` | 239.8 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.24 V |
| ✅ | `91` | 239.8 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.34 V |
| ✅ | `100` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.25 V |
| ✅ | `97` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.25 V |
| ✅ | `88` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.25 V |
| ✅ | `106` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.25 V |
| ✅ | `93` | 239.9 | 239.9 | 0.999 | 0.999 | 0.0 % | 0.11 V |
| ✅ | `83` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.23 V |
| ✅ | `84` | 239.9 | 239.9 | 0.999 | 0.999 | 0.0 % | 0.11 V |
| ✅ | `105` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.2 V |
| ✅ | `90` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.2 V |
| ✅ | `81` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.2 V |
| ✅ | `87` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.2 V |
| ✅ | `96` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.21 V |
| ✅ | `102` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.21 V |
| ✅ | `99` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.2 V |
| ✅ | `79` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.23 V |
| ✅ | `95` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.23 V |
| ✅ | `92` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.23 V |
| ✅ | `89` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.23 V |
| ✅ | `107` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.23 V |
| ✅ | `104` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.23 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| **E** | `grid` | `1` | pg | -48.492 kW | [-48.492 kW, 48.492 kW] |
| **E** | `grid` | `2` | pg | -48.492 kW | [-48.492 kW, 48.492 kW] |
| **E** | `grid` | `3` | pg | -48.492 kW | [-48.492 kW, 48.492 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 169.846 kW (>1 % of load). pg=-145.48 kW, pd=24.25 kW, p_loss=0.12 kW.

## 6. All Findings

- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '1': pg=-48.492 kW violates [-48.492 kW, 48.492 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '2': pg=-48.492 kW violates [-48.492 kW, 48.492 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '3': pg=-48.492 kW violates [-48.492 kW, 48.492 kW].
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 169.846 kW (>1 % of load). pg=-145.48 kW, pd=24.25 kW, p_loss=0.12 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 3 violation(s), 0 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 3V / 0A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.51 V at bus '85' — reflects the neutral shift under unbalanced loading.

