# BMOPF Solution Profile: network_10_Feeder_6

**Generated:** 2026-06-22 15:15:39  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -33.521  
**Solve time:** 0.016 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 6.886 kW |
| Total load | 6.87 kW |
| Total line losses | 31.72 W |
| Loss fraction | 0.5% |
| Power balance error | 15.36 W |
| Max neutral shift | 0.249 V (bus `367`) |

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
| ✅ | `227` | 230.0 V | 12 | 1.042 (`367`) | 1.044 (`sourcebus`) | 0.1 % (`367`) | 0.25 V (`367`) |

### Per-bus detail

**Zone `227`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `64` | 239.9 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.1 V |
| ✅ | `63` | 240.0 | 240.1 | 1.044 | 1.044 | 0.0 % | 0.05 V |
| ✅ | `227` | 239.8 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.08 V |
| ✅ | `442` | 239.8 | 240.0 | 1.042 | 1.043 | 0.1 % | 0.04 V |
| ✅ | `338` | 239.8 | 240.0 | 1.042 | 1.043 | 0.1 % | 0.09 V |
| ✅ | `295` | 239.8 | 240.0 | 1.042 | 1.043 | 0.1 % | 0.09 V |
| ✅ | `286` | 239.8 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.08 V |
| ✅ | `301` | 239.8 | 239.9 | 1.042 | 1.043 | 0.1 % | 0.1 V |
| ✅ | `367` | 239.6 | 239.9 | 1.042 | 1.043 | 0.1 % | 0.25 V |
| ✅ | `429` | 239.8 | 239.9 | 1.042 | 1.043 | 0.1 % | 0.09 V |
| ✅ | `459` | 239.8 | 239.9 | 1.042 | 1.043 | 0.1 % | 0.11 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -13.74 kW | [-13.74 kW, 13.74 kW] |
| W | `grid` | `2` | pg | -13.74 kW | [-13.74 kW, 13.74 kW] |
| W | `grid` | `3` | pg | -13.74 kW | [-13.74 kW, 13.74 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-13.74 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-13.74 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-13.74 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.25 V at bus '367' — reflects the neutral shift under unbalanced loading.

