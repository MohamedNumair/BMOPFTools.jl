# BMOPF Solution Profile: Network_14_Feeder_2

**Generated:** 2026-06-22 15:15:05  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -144.9909  
**Solve time:** 0.057 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 24.314 kW |
| Total load | 24.246 kW |
| Total line losses | 114.79 W |
| Loss fraction | 0.5% |
| Power balance error | 47.25 W |
| Max neutral shift | 0.401 V (bus `85`) |

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
| ✅ | `100` | 230.0 V | 30 | 1.042 (`85`) | 1.044 (`sourcebus`) | 0.2 % (`85`) | 0.4 V (`85`) |

### Per-bus detail

**Zone `100`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `86` | 239.7 | 240.0 | 1.042 | 1.043 | 0.1 % | 0.15 V |
| ✅ | `80` | 239.7 | 240.0 | 1.042 | 1.043 | 0.1 % | 0.16 V |
| ✅ | `98` | 239.7 | 240.0 | 1.042 | 1.043 | 0.1 % | 0.15 V |
| ✅ | `101` | 239.8 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.11 V |
| ✅ | `83` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.11 V |
| ✅ | `104` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.11 V |
| ✅ | `107` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.11 V |
| ✅ | `89` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.11 V |
| ✅ | `92` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.11 V |
| ✅ | `91` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.19 V |
| ✅ | `95` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.12 V |
| ✅ | `79` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.12 V |
| ✅ | `106` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.15 V |
| ✅ | `88` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.15 V |
| ✅ | `97` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.15 V |
| ✅ | `100` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.15 V |
| ✅ | `94` | 239.8 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.2 V |
| ✅ | `103` | 239.7 | 240.0 | 1.042 | 1.043 | 0.1 % | 0.31 V |
| ✅ | `82` | 239.6 | 240.0 | 1.042 | 1.043 | 0.1 % | 0.39 V |
| ✅ | `85` | 239.6 | 240.0 | 1.042 | 1.043 | 0.2 % | 0.4 V |
| ✅ | `102` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.11 V |
| ✅ | `96` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.11 V |
| ✅ | `87` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.11 V |
| ✅ | `81` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.11 V |
| ✅ | `90` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.11 V |
| ✅ | `105` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.11 V |
| ✅ | `99` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.22 V |
| ✅ | `84` | 239.9 | 239.9 | 1.043 | 1.043 | 0.0 % | 0.21 V |
| ✅ | `93` | 239.8 | 239.9 | 1.043 | 1.043 | 0.0 % | 0.16 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -48.492 kW | [-48.492 kW, 48.492 kW] |
| W | `grid` | `2` | pg | -48.492 kW | [-48.492 kW, 48.492 kW] |
| W | `grid` | `3` | pg | -48.492 kW | [-48.492 kW, 48.492 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-48.492 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-48.492 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-48.492 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.4 V at bus '85' — reflects the neutral shift under unbalanced loading.

