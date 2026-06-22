# BMOPF Solution Profile: Network_14_Feeder_2

**Generated:** 2026-06-22 14:52:13  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -144.9909  
**Solve time:** 0.022 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 24.3 kW |
| Total load | 24.246 kW |
| Total line losses | 90.28 W |
| Loss fraction | 0.4% |
| Power balance error | 36.46 W |
| Max neutral shift | 0.319 V (bus `85`) |

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
| ✅ | `100` | 240.0 V | 30 | 0.998 (`85`) | 1.0 (`sourcebus`) | 0.1 % (`85`) | 0.32 V (`85`) |

### Per-bus detail

**Zone `100`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `85` | 239.7 | 240.0 | 0.998 | 0.999 | 0.1 % | 0.32 V |
| ✅ | `82` | 239.7 | 240.0 | 0.998 | 0.999 | 0.1 % | 0.31 V |
| ✅ | `86` | 239.7 | 240.0 | 0.998 | 0.999 | 0.1 % | 0.17 V |
| ✅ | `80` | 239.7 | 240.0 | 0.998 | 0.999 | 0.1 % | 0.15 V |
| ✅ | `98` | 239.7 | 240.0 | 0.998 | 0.999 | 0.1 % | 0.15 V |
| ✅ | `103` | 239.8 | 240.0 | 0.998 | 0.999 | 0.1 % | 0.22 V |
| ✅ | `101` | 239.8 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.07 V |
| ✅ | `93` | 239.8 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.17 V |
| ✅ | `83` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.04 V |
| ✅ | `104` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.04 V |
| ✅ | `107` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.04 V |
| ✅ | `89` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.04 V |
| ✅ | `92` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.05 V |
| ✅ | `94` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.13 V |
| ✅ | `95` | 239.9 | 240.0 | 0.999 | 0.999 | 0.1 % | 0.05 V |
| ✅ | `100` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.09 V |
| ✅ | `97` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.08 V |
| ✅ | `88` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.08 V |
| ✅ | `106` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.08 V |
| ✅ | `91` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.08 V |
| ✅ | `79` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.06 V |
| ✅ | `102` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.05 V |
| ✅ | `96` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.05 V |
| ✅ | `87` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.05 V |
| ✅ | `81` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.05 V |
| ✅ | `90` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.05 V |
| ✅ | `105` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.05 V |
| ✅ | `99` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.04 V |
| ✅ | `84` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.09 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

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
  Maximum neutral terminal voltage: 0.32 V at bus '85' — reflects the neutral shift under unbalanced loading.

