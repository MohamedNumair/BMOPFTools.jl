# BMOPF Solution Profile: network_10_Feeder_2

**Generated:** 2026-06-22 15:15:39  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -30.7821  
**Solve time:** 0.01 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 6.891 kW |
| Total load | 6.87 kW |
| Total line losses | 30.92 W |
| Loss fraction | 0.5% |
| Power balance error | 9.99 W |
| Max neutral shift | 0.528 V (bus `416`) |

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
| ✅ | `1` | 230.0 V | 10 | 1.041 (`419`) | 1.044 (`3`) | 0.3 % (`444`) | 0.53 V (`416`) |

### Per-bus detail

**Zone `1`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `3` | 240.0 | 240.2 | 1.044 | 1.044 | 0.1 % | 0.14 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `1` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | 0.0 V |
| ✅ | `24` | 240.1 | 240.2 | 1.044 | 1.044 | 0.0 % | 0.03 V |
| ✅ | `143` | 240.1 | 240.2 | 1.044 | 1.044 | 0.0 % | 0.03 V |
| ✅ | `444` | 239.5 | 240.2 | 1.041 | 1.044 | 0.3 % | 0.46 V |
| ✅ | `381` | 240.0 | 240.2 | 1.043 | 1.044 | 0.1 % | 0.17 V |
| ✅ | `442` | 239.5 | 240.2 | 1.041 | 1.044 | 0.3 % | 0.49 V |
| ✅ | `419` | 239.5 | 240.2 | 1.041 | 1.044 | 0.3 % | 0.5 V |
| ✅ | `416` | 239.5 | 240.2 | 1.041 | 1.044 | 0.3 % | 0.53 V |

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
  Maximum neutral terminal voltage: 0.53 V at bus '416' — reflects the neutral shift under unbalanced loading.

