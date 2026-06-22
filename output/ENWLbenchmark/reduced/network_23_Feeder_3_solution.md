# BMOPF Solution Profile: network_23_Feeder_3

**Generated:** 2026-06-22 15:16:48  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -6.3657  
**Solve time:** 0.007 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 2.279 kW |
| Total load | 2.274 kW |
| Total line losses | 8.74 W |
| Loss fraction | 0.4% |
| Power balance error | 3.95 W |
| Max neutral shift | 0.271 V (bus `57`) |

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
| ✅ | `36` | 230.0 V | 5 | 1.043 (`57`) | 1.044 (`57`) | 0.1 % (`57`) | 0.27 V (`57`) |

### Per-bus detail

**Zone `36`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `57` | 239.9 | 240.2 | 1.043 | 1.044 | 0.1 % | 0.27 V |
| ✅ | `56` | 240.1 | 240.2 | 1.044 | 1.044 | 0.0 % | 0.07 V |
| ✅ | `58` | 240.1 | 240.2 | 1.044 | 1.044 | 0.0 % | 0.03 V |
| ✅ | `36` | 240.1 | 240.2 | 1.044 | 1.044 | 0.0 % | 0.04 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -4.548 kW | [-4.548 kW, 4.548 kW] |
| W | `grid` | `2` | pg | -4.548 kW | [-4.548 kW, 4.548 kW] |
| W | `grid` | `3` | pg | -4.548 kW | [-4.548 kW, 4.548 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-4.548 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-4.548 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-4.548 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.27 V at bus '57' — reflects the neutral shift under unbalanced loading.

