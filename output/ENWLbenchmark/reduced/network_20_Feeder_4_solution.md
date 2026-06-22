# BMOPF Solution Profile: network_20_Feeder_4

**Generated:** 2026-06-22 15:16:42  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -134.9131  
**Solve time:** 0.075 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 24.631 kW |
| Total load | 24.594 kW |
| Total line losses | 75.06 W |
| Loss fraction | 0.3% |
| Power balance error | 37.74 W |
| Max neutral shift | 0.162 V (bus `47`) |

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
| ✅ | `41` | 230.0 V | 31 | 1.043 (`47`) | 1.044 (`sourcebus`) | 0.1 % (`47`) | 0.16 V (`47`) |

### Per-bus detail

**Zone `41`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `60` | 239.8 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.09 V |
| ✅ | `48` | 239.8 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.09 V |
| ✅ | `42` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.08 V |
| ✅ | `63` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.08 V |
| ✅ | `66` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.05 V |
| ✅ | `69` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.05 V |
| ✅ | `45` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.08 V |
| ✅ | `51` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.08 V |
| ✅ | `54` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.08 V |
| ✅ | `59` | 239.9 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.1 V |
| ✅ | `53` | 239.9 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.1 V |
| ✅ | `57` | 239.9 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.08 V |
| ✅ | `41` | 239.9 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.08 V |
| ✅ | `68` | 239.9 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.08 V |
| ✅ | `50` | 239.9 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.09 V |
| ✅ | `62` | 239.9 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.09 V |
| ✅ | `56` | 239.9 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.1 V |
| ✅ | `65` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.14 V |
| ✅ | `44` | 239.8 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.16 V |
| ✅ | `47` | 239.8 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.16 V |
| ✅ | `64` | 239.9 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.07 V |
| ✅ | `49` | 239.9 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.07 V |
| ✅ | `61` | 239.9 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.07 V |
| ✅ | `43` | 239.9 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.07 V |
| ✅ | `52` | 239.9 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.07 V |
| ✅ | `67` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.07 V |
| ✅ | `70` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.07 V |
| ✅ | `58` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.09 V |
| ✅ | `46` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.06 V |
| ✅ | `55` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.07 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -49.188 kW | [-49.188 kW, 49.188 kW] |
| W | `grid` | `2` | pg | -49.188 kW | [-49.188 kW, 49.188 kW] |
| W | `grid` | `3` | pg | -49.188 kW | [-49.188 kW, 49.188 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-49.188 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-49.188 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-49.188 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.16 V at bus '47' — reflects the neutral shift under unbalanced loading.

