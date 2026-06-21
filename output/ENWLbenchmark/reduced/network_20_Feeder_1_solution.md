# BMOPF Solution Profile: network_20_Feeder_1

**Generated:** 2026-06-21 16:43:24  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -133.9374  
**Solve time:** 0.156 s  
**Findings:** 3 errors · 1 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -140.184 kW |
| Total load | 23.364 kW |
| Total line losses | 62.55 W |
| Loss fraction | 0.3% |
| Power balance error | 163.61 kW |
| Max neutral shift | 0.201 V (bus `58`) |

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
| ✅ | `52` | 240.0 V | 27 | 0.999 (`58`) | 1.0 (`sourcebus`) | 0.1 % (`58`) | 0.2 V (`58`) |

### Per-bus detail

**Zone `52`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `58` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.2 V |
| ✅ | `55` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.2 V |
| ✅ | `59` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.1 V |
| ✅ | `53` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.1 V |
| ✅ | `71` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.09 V |
| ✅ | `76` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.14 V |
| ✅ | `74` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.1 V |
| ✅ | `56` | 240.0 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.07 V |
| ✅ | `65` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.07 V |
| ✅ | `62` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.07 V |
| ✅ | `77` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.11 V |
| ✅ | `68` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.07 V |
| ✅ | `67` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.11 V |
| ✅ | `73` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.09 V |
| ✅ | `64` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.09 V |
| ✅ | `61` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.09 V |
| ✅ | `52` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.07 V |
| ✅ | `75` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.07 V |
| ✅ | `72` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.07 V |
| ✅ | `54` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.06 V |
| ✅ | `63` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.06 V |
| ✅ | `60` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.06 V |
| ✅ | `69` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.06 V |
| ✅ | `57` | 240.0 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.05 V |
| ✅ | `66` | 240.0 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.03 V |
| ✅ | `70` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.08 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| **E** | `grid` | `1` | pg | -46.728 kW | [-46.728 kW, 46.728 kW] |
| **E** | `grid` | `2` | pg | -46.728 kW | [-46.728 kW, 46.728 kW] |
| **E** | `grid` | `3` | pg | -46.728 kW | [-46.728 kW, 46.728 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 163.61 kW (>1 % of load). pg=-140.18 kW, pd=23.36 kW, p_loss=0.06 kW.

## 6. All Findings

- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '1': pg=-46.728 kW violates [-46.728 kW, 46.728 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '2': pg=-46.728 kW violates [-46.728 kW, 46.728 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '3': pg=-46.728 kW violates [-46.728 kW, 46.728 kW].
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 163.61 kW (>1 % of load). pg=-140.18 kW, pd=23.36 kW, p_loss=0.06 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 3 violation(s), 0 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 3V / 0A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.2 V at bus '58' — reflects the neutral shift under unbalanced loading.

