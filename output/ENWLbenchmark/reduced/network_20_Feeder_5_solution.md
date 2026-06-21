# BMOPF Solution Profile: network_20_Feeder_5

**Generated:** 2026-06-21 16:43:25  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -101.6061  
**Solve time:** 0.092 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -126.684 kW |
| Total load | 21.114 kW |
| Total line losses | 87.07 W |
| Loss fraction | 0.4% |
| Power balance error | 147.885 kW |
| Max neutral shift | 0.324 V (bus `51`) |

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
| ✅ | `41` | 240.0 V | 25 | 0.999 (`48`) | 1.0 (`sourcebus`) | 0.1 % (`48`) | 0.32 V (`51`) |

### Per-bus detail

**Zone `41`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `48` | 240.0 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.09 V |
| ✅ | `44` | 240.0 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.18 V |
| ✅ | `47` | 240.0 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.17 V |
| ✅ | `42` | 240.0 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.09 V |
| ✅ | `60` | 240.0 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.08 V |
| ✅ | `63` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.06 V |
| ✅ | `55` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.05 V |
| ✅ | `54` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.09 V |
| ✅ | `45` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.06 V |
| ✅ | `57` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.06 V |
| ✅ | `56` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.09 V |
| ✅ | `53` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.07 V |
| ✅ | `59` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.07 V |
| ✅ | `50` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.07 V |
| ✅ | `62` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.07 V |
| ✅ | `61` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.21 V |
| ✅ | `41` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.06 V |
| ✅ | `64` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.05 V |
| ✅ | `58` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.05 V |
| ✅ | `49` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.05 V |
| ✅ | `52` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.05 V |
| ✅ | `43` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.05 V |
| ✅ | `46` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.2 V |
| ✅ | `51` | 240.0 | 240.1 | 0.999 | 1.0 | 0.0 % | 0.32 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -42.228 kW | [-42.228 kW, 42.228 kW] |
| W | `grid` | `2` | pg | -42.228 kW | [-42.228 kW, 42.228 kW] |
| W | `grid` | `3` | pg | -42.228 kW | [-42.228 kW, 42.228 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 147.885 kW (>1 % of load). pg=-126.68 kW, pd=21.11 kW, p_loss=0.09 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-42.228 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-42.228 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-42.228 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 147.885 kW (>1 % of load). pg=-126.68 kW, pd=21.11 kW, p_loss=0.09 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.32 V at bus '51' — reflects the neutral shift under unbalanced loading.

