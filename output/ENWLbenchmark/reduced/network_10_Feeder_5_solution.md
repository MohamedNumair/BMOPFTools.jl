# BMOPF Solution Profile: network_10_Feeder_5

**Generated:** 2026-06-22 15:15:39  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -56.1723  
**Solve time:** 0.046 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 13.253 kW |
| Total load | 13.188 kW |
| Total line losses | 121.79 W |
| Loss fraction | 0.9% |
| Power balance error | 56.69 W |
| Max neutral shift | 0.555 V (bus `276`) |

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
| ✅ | `146` | 230.0 V | 17 | 1.04 (`276`) | 1.044 (`sourcebus`) | 0.2 % (`276`) | 0.55 V (`276`) |

### Per-bus detail

**Zone `146`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `146` | 239.7 | 239.9 | 1.042 | 1.043 | 0.1 % | 0.21 V |
| ✅ | `271` | 239.3 | 239.8 | 1.04 | 1.043 | 0.2 % | 0.21 V |
| ✅ | `261` | 239.5 | 239.8 | 1.041 | 1.043 | 0.1 % | 0.28 V |
| ✅ | `274` | 239.5 | 239.8 | 1.041 | 1.043 | 0.2 % | 0.22 V |
| ✅ | `266` | 239.5 | 239.8 | 1.041 | 1.043 | 0.1 % | 0.28 V |
| ✅ | `273` | 239.3 | 239.8 | 1.04 | 1.043 | 0.2 % | 0.54 V |
| ✅ | `276` | 239.2 | 239.8 | 1.04 | 1.043 | 0.2 % | 0.55 V |
| ✅ | `298` | 239.3 | 239.8 | 1.04 | 1.043 | 0.2 % | 0.2 V |
| ✅ | `301` | 239.4 | 239.8 | 1.041 | 1.043 | 0.2 % | 0.16 V |
| ✅ | `293` | 239.4 | 239.8 | 1.041 | 1.043 | 0.2 % | 0.22 V |
| ✅ | `300` | 239.4 | 239.8 | 1.041 | 1.043 | 0.2 % | 0.25 V |
| ✅ | `307` | 239.4 | 239.8 | 1.041 | 1.043 | 0.2 % | 0.22 V |
| ✅ | `312` | 239.4 | 239.8 | 1.041 | 1.043 | 0.2 % | 0.21 V |
| ✅ | `299` | 239.4 | 239.8 | 1.041 | 1.043 | 0.2 % | 0.21 V |
| ✅ | `272` | 239.5 | 239.8 | 1.041 | 1.043 | 0.1 % | 0.4 V |
| ✅ | `275` | 239.5 | 239.7 | 1.041 | 1.042 | 0.1 % | 0.27 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -26.376 kW | [-26.376 kW, 26.376 kW] |
| W | `grid` | `2` | pg | -26.376 kW | [-26.376 kW, 26.376 kW] |
| W | `grid` | `3` | pg | -26.376 kW | [-26.376 kW, 26.376 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-26.376 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-26.376 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-26.376 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.55 V at bus '276' — reflects the neutral shift under unbalanced loading.

