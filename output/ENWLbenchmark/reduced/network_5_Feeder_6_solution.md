# BMOPF Solution Profile: network_5_Feeder_6

**Generated:** 2026-06-22 15:17:31  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -86.7931  
**Solve time:** 0.038 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 17.158 kW |
| Total load | 17.034 kW |
| Total line losses | 249.74 W |
| Loss fraction | 1.5% |
| Power balance error | 125.6 W |
| Max neutral shift | 1.043 V (bus `333`) |

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
| ✅ | `103` | 230.0 V | 36 | 1.038 (`189`) | 1.044 (`sourcebus`) | 0.5 % (`189`) | 1.04 V (`333`) |

### Per-bus detail

**Zone `103`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `59` | 239.7 | 240.1 | 1.042 | 1.044 | 0.2 % | 0.44 V |
| ✅ | `58` | 239.7 | 240.1 | 1.042 | 1.044 | 0.2 % | 0.4 V |
| ✅ | `87` | 239.4 | 240.1 | 1.041 | 1.044 | 0.3 % | 0.67 V |
| ✅ | `80` | 239.4 | 240.1 | 1.041 | 1.044 | 0.3 % | 0.63 V |
| ✅ | `216` | 239.2 | 240.1 | 1.04 | 1.044 | 0.4 % | 0.73 V |
| ✅ | `93` | 239.2 | 240.1 | 1.04 | 1.044 | 0.4 % | 0.71 V |
| ✅ | `103` | 239.2 | 240.0 | 1.04 | 1.044 | 0.4 % | 0.76 V |
| ✅ | `108` | 238.9 | 240.0 | 1.039 | 1.044 | 0.5 % | 0.85 V |
| ✅ | `114` | 238.9 | 240.0 | 1.039 | 1.044 | 0.5 % | 0.88 V |
| ✅ | `194` | 238.8 | 240.0 | 1.038 | 1.044 | 0.5 % | 0.9 V |
| ✅ | `116` | 239.1 | 240.0 | 1.04 | 1.044 | 0.4 % | 0.82 V |
| ✅ | `321` | 238.9 | 240.0 | 1.039 | 1.044 | 0.5 % | 1.04 V |
| ✅ | `156` | 239.0 | 240.0 | 1.039 | 1.044 | 0.4 % | 0.98 V |
| ✅ | `141` | 239.0 | 240.0 | 1.039 | 1.044 | 0.4 % | 0.9 V |
| ✅ | `134` | 239.1 | 240.0 | 1.039 | 1.044 | 0.4 % | 0.86 V |
| ✅ | `164` | 239.0 | 240.0 | 1.039 | 1.044 | 0.4 % | 0.93 V |
| ✅ | `333` | 238.9 | 240.0 | 1.039 | 1.044 | 0.5 % | 1.04 V |
| ✅ | `171` | 239.0 | 240.0 | 1.039 | 1.044 | 0.5 % | 0.95 V |
| ✅ | `189` | 238.8 | 240.0 | 1.038 | 1.044 | 0.5 % | 0.99 V |
| ✅ | `318` | 239.0 | 240.0 | 1.039 | 1.044 | 0.5 % | 0.99 V |
| ✅ | `213` | 239.0 | 240.0 | 1.039 | 1.044 | 0.5 % | 0.97 V |
| ✅ | `307` | 239.0 | 240.0 | 1.039 | 1.044 | 0.5 % | 0.99 V |
| ✅ | `188` | 239.0 | 240.0 | 1.039 | 1.044 | 0.5 % | 0.95 V |
| ✅ | `347` | 238.9 | 240.0 | 1.039 | 1.044 | 0.5 % | 1.01 V |
| ✅ | `287` | 239.0 | 240.0 | 1.039 | 1.044 | 0.5 % | 0.99 V |
| ✅ | `263` | 239.0 | 240.0 | 1.039 | 1.044 | 0.5 % | 1.0 V |
| ✅ | `247` | 239.0 | 240.0 | 1.039 | 1.044 | 0.5 % | 0.98 V |
| ✅ | `343` | 239.0 | 240.0 | 1.039 | 1.044 | 0.5 % | 0.98 V |
| ✅ | `234` | 239.0 | 240.0 | 1.039 | 1.044 | 0.5 % | 0.97 V |
| ✅ | `220` | 239.0 | 240.0 | 1.039 | 1.044 | 0.5 % | 0.96 V |
| ✅ | `233` | 238.9 | 240.0 | 1.039 | 1.044 | 0.5 % | 0.96 V |
| ✅ | `227` | 239.0 | 240.0 | 1.039 | 1.044 | 0.5 % | 0.96 V |
| ✅ | `235` | 239.0 | 240.0 | 1.039 | 1.044 | 0.5 % | 0.96 V |
| ✅ | `128` | 239.1 | 240.0 | 1.04 | 1.043 | 0.4 % | 0.8 V |
| ✅ | `292` | 239.1 | 240.0 | 1.039 | 1.043 | 0.4 % | 0.89 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -34.068 kW | [-34.068 kW, 34.068 kW] |
| W | `grid` | `2` | pg | -34.068 kW | [-34.068 kW, 34.068 kW] |
| W | `grid` | `3` | pg | -34.068 kW | [-34.068 kW, 34.068 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-34.068 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-34.068 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-34.068 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.04 V at bus '333' — reflects the neutral shift under unbalanced loading.

