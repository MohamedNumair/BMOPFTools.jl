# BMOPF Solution Profile: network_25_Feeder_2

**Generated:** 2026-06-22 15:16:50  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -95.5624  
**Solve time:** 0.072 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 17.402 kW |
| Total load | 17.358 kW |
| Total line losses | 119.74 W |
| Loss fraction | 0.7% |
| Power balance error | 75.28 W |
| Max neutral shift | 0.431 V (bus `184`) |

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
| ✅ | `100` | 230.0 V | 39 | 1.042 (`693`) | 1.044 (`sourcebus`) | 0.2 % (`693`) | 0.43 V (`184`) |

### Per-bus detail

**Zone `100`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `15` | 240.1 | 240.2 | 1.044 | 1.044 | 0.0 % | 0.03 V |
| ✅ | `30` | 240.1 | 240.2 | 1.044 | 1.044 | 0.0 % | 0.04 V |
| ✅ | `111` | 240.1 | 240.2 | 1.044 | 1.044 | 0.0 % | 0.04 V |
| ✅ | `48` | 240.1 | 240.2 | 1.044 | 1.044 | 0.0 % | 0.08 V |
| ✅ | `81` | 240.1 | 240.2 | 1.044 | 1.044 | 0.0 % | 0.08 V |
| ✅ | `100` | 240.1 | 240.2 | 1.044 | 1.044 | 0.0 % | 0.09 V |
| ✅ | `79` | 240.0 | 240.2 | 1.044 | 1.044 | 0.1 % | 0.13 V |
| ✅ | `84` | 240.0 | 240.2 | 1.043 | 1.044 | 0.1 % | 0.17 V |
| ✅ | `308` | 240.0 | 240.2 | 1.043 | 1.044 | 0.1 % | 0.15 V |
| ✅ | `117` | 240.1 | 240.2 | 1.044 | 1.044 | 0.0 % | 0.06 V |
| ✅ | `155` | 240.0 | 240.2 | 1.044 | 1.044 | 0.1 % | 0.13 V |
| ✅ | `184` | 239.7 | 240.2 | 1.042 | 1.044 | 0.2 % | 0.43 V |
| ✅ | `325` | 239.7 | 240.1 | 1.042 | 1.044 | 0.2 % | 0.39 V |
| ✅ | `228` | 239.9 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.21 V |
| ✅ | `285` | 239.9 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.24 V |
| ✅ | `487` | 240.0 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.15 V |
| ✅ | `343` | 240.0 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.13 V |
| ✅ | `320` | 239.8 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.29 V |
| ✅ | `478` | 239.8 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.31 V |
| ✅ | `293` | 239.9 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.23 V |
| ✅ | `534` | 239.9 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.22 V |
| ✅ | `693` | 239.7 | 240.1 | 1.042 | 1.044 | 0.2 % | 0.41 V |
| ✅ | `515` | 239.8 | 240.1 | 1.043 | 1.044 | 0.2 % | 0.32 V |
| ✅ | `523` | 239.8 | 240.1 | 1.043 | 1.044 | 0.2 % | 0.34 V |
| ✅ | `219` | 240.1 | 240.1 | 1.044 | 1.044 | 0.0 % | 0.06 V |
| ✅ | `703` | 239.7 | 240.1 | 1.042 | 1.044 | 0.2 % | 0.38 V |
| ✅ | `522` | 239.8 | 240.1 | 1.042 | 1.044 | 0.2 % | 0.34 V |
| ✅ | `531` | 239.8 | 240.1 | 1.042 | 1.044 | 0.2 % | 0.34 V |
| ✅ | `678` | 239.8 | 240.1 | 1.042 | 1.044 | 0.2 % | 0.35 V |
| ✅ | `758` | 239.7 | 240.1 | 1.042 | 1.044 | 0.2 % | 0.37 V |
| ✅ | `752` | 239.8 | 240.1 | 1.042 | 1.044 | 0.2 % | 0.36 V |
| ✅ | `601` | 239.8 | 240.1 | 1.042 | 1.044 | 0.2 % | 0.34 V |
| ✅ | `361` | 240.0 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.13 V |
| ✅ | `470` | 239.9 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.21 V |
| ✅ | `743` | 239.8 | 240.1 | 1.042 | 1.044 | 0.2 % | 0.34 V |
| ✅ | `464` | 240.0 | 240.1 | 1.044 | 1.044 | 0.1 % | 0.12 V |
| ✅ | `473` | 240.0 | 240.1 | 1.044 | 1.044 | 0.1 % | 0.12 V |
| ✅ | `564` | 240.0 | 240.1 | 1.043 | 1.044 | 0.0 % | 0.12 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -34.716 kW | [-34.716 kW, 34.716 kW] |
| W | `grid` | `2` | pg | -34.716 kW | [-34.716 kW, 34.716 kW] |
| W | `grid` | `3` | pg | -34.716 kW | [-34.716 kW, 34.716 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-34.716 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-34.716 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-34.716 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.43 V at bus '184' — reflects the neutral shift under unbalanced loading.

