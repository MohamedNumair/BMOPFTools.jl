# BMOPF Solution Profile: network_11_Feeder_2

**Generated:** 2026-06-22 15:15:39  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -7.6535  
**Solve time:** 0.009 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 5.238 kW |
| Total load | 5.214 kW |
| Total line losses | 34.89 W |
| Loss fraction | 0.7% |
| Power balance error | 10.79 W |
| Max neutral shift | 0.834 V (bus `214`) |

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
| ✅ | `164` | 230.0 V | 8 | 1.04 (`214`) | 1.044 (`sourcebus`) | 0.4 % (`214`) | 0.83 V (`214`) |

### Per-bus detail

**Zone `164`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `85` | 240.0 | 240.1 | 1.044 | 1.044 | 0.1 % | 0.1 V |
| ✅ | `77` | 240.0 | 240.1 | 1.044 | 1.044 | 0.1 % | 0.1 V |
| ✅ | `169` | 239.9 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.11 V |
| ✅ | `164` | 240.0 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.08 V |
| ✅ | `172` | 240.0 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.16 V |
| ✅ | `214` | 239.3 | 240.1 | 1.04 | 1.044 | 0.4 % | 0.83 V |
| ✅ | `170` | 240.0 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.06 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -10.428 kW | [-10.428 kW, 10.428 kW] |
| W | `grid` | `2` | pg | -10.428 kW | [-10.428 kW, 10.428 kW] |
| W | `grid` | `3` | pg | -10.428 kW | [-10.428 kW, 10.428 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-10.428 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-10.428 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-10.428 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.83 V at bus '214' — reflects the neutral shift under unbalanced loading.

