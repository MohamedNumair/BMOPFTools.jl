# BMOPF Solution Profile: network_17_Feeder_2

**Generated:** 2026-06-22 15:16:09  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -51.0286  
**Solve time:** 0.027 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 12.316 kW |
| Total load | 12.276 kW |
| Total line losses | 63.62 W |
| Loss fraction | 0.5% |
| Power balance error | 23.42 W |
| Max neutral shift | 0.471 V (bus `254`) |

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
| ✅ | `102` | 230.0 V | 17 | 1.041 (`254`) | 1.044 (`254`) | 0.4 % (`254`) | 0.47 V (`254`) |

### Per-bus detail

**Zone `102`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `254` | 239.4 | 240.2 | 1.041 | 1.044 | 0.4 % | 0.47 V |
| ✅ | `460` | 239.9 | 240.2 | 1.043 | 1.044 | 0.1 % | 0.16 V |
| ✅ | `412` | 239.9 | 240.2 | 1.043 | 1.044 | 0.1 % | 0.16 V |
| ✅ | `193` | 239.5 | 240.2 | 1.041 | 1.044 | 0.3 % | 0.35 V |
| ✅ | `187` | 239.5 | 240.2 | 1.042 | 1.044 | 0.3 % | 0.34 V |
| ✅ | `110` | 239.7 | 240.2 | 1.042 | 1.044 | 0.2 % | 0.27 V |
| ✅ | `102` | 239.7 | 240.2 | 1.042 | 1.044 | 0.2 % | 0.26 V |
| ✅ | `48` | 239.9 | 240.2 | 1.043 | 1.044 | 0.1 % | 0.12 V |
| ✅ | `30` | 240.0 | 240.2 | 1.043 | 1.044 | 0.1 % | 0.1 V |
| ✅ | `27` | 240.0 | 240.2 | 1.044 | 1.044 | 0.1 % | 0.08 V |
| ✅ | `54` | 239.7 | 240.2 | 1.042 | 1.044 | 0.2 % | 0.23 V |
| ✅ | `108` | 239.7 | 240.2 | 1.042 | 1.044 | 0.2 % | 0.25 V |
| ✅ | `179` | 239.7 | 240.2 | 1.042 | 1.044 | 0.2 % | 0.3 V |
| ✅ | `186` | 239.7 | 240.2 | 1.042 | 1.044 | 0.2 % | 0.31 V |
| ✅ | `118` | 239.7 | 240.2 | 1.042 | 1.044 | 0.2 % | 0.27 V |
| ✅ | `259` | 239.7 | 240.2 | 1.042 | 1.044 | 0.2 % | 0.39 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -24.552 kW | [-24.552 kW, 24.552 kW] |
| W | `grid` | `2` | pg | -24.552 kW | [-24.552 kW, 24.552 kW] |
| W | `grid` | `3` | pg | -24.552 kW | [-24.552 kW, 24.552 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-24.552 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-24.552 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-24.552 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.47 V at bus '254' — reflects the neutral shift under unbalanced loading.

