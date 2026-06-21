# BMOPF Solution Profile: network_5_Feeder_1

**Generated:** 2026-06-21 16:43:57  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -9.8204  
**Solve time:** 0.013 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -33.228 kW |
| Total load | 5.538 kW |
| Total line losses | 42.91 W |
| Loss fraction | 0.8% |
| Power balance error | 38.809 kW |
| Max neutral shift | 0.71 V (bus `99`) |

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
| ✅ | `130` | 240.0 V | 11 | 0.997 (`99`) | 1.0 (`55`) | 0.3 % (`99`) | 0.71 V (`99`) |

### Per-bus detail

**Zone `130`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `99` | 239.4 | 240.2 | 0.997 | 1.0 | 0.3 % | 0.71 V |
| ✅ | `130` | 239.5 | 240.2 | 0.997 | 1.0 | 0.3 % | 0.65 V |
| ✅ | `96` | 239.5 | 240.2 | 0.997 | 1.0 | 0.3 % | 0.63 V |
| ✅ | `94` | 239.6 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.52 V |
| ✅ | `55` | 239.8 | 240.2 | 0.998 | 1.0 | 0.2 % | 0.28 V |
| ✅ | `87` | 239.8 | 240.2 | 0.999 | 1.0 | 0.1 % | 0.27 V |
| ✅ | `52` | 239.9 | 240.2 | 0.999 | 1.0 | 0.1 % | 0.25 V |
| ✅ | `36` | 239.9 | 240.2 | 0.999 | 1.0 | 0.1 % | 0.21 V |
| ✅ | `34` | 240.0 | 240.2 | 0.999 | 1.0 | 0.1 % | 0.18 V |
| ✅ | `33` | 240.0 | 240.2 | 0.999 | 1.0 | 0.1 % | 0.17 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -11.076 kW | [-11.076 kW, 11.076 kW] |
| W | `grid` | `2` | pg | -11.076 kW | [-11.076 kW, 11.076 kW] |
| W | `grid` | `3` | pg | -11.076 kW | [-11.076 kW, 11.076 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 38.809 kW (>1 % of load). pg=-33.23 kW, pd=5.54 kW, p_loss=0.04 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-11.076 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-11.076 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-11.076 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 38.809 kW (>1 % of load). pg=-33.23 kW, pd=5.54 kW, p_loss=0.04 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.71 V at bus '99' — reflects the neutral shift under unbalanced loading.

