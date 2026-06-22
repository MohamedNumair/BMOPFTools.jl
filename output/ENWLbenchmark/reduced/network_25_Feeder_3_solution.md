# BMOPF Solution Profile: network_25_Feeder_3

**Generated:** 2026-06-22 15:16:50  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -65.7786  
**Solve time:** 0.053 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 13.81 kW |
| Total load | 13.764 kW |
| Total line losses | 165.42 W |
| Loss fraction | 1.2% |
| Power balance error | 119.2 W |
| Max neutral shift | 0.499 V (bus `404`) |

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
| ✅ | `118` | 230.0 V | 28 | 1.041 (`404`) | 1.044 (`sourcebus`) | 0.2 % (`404`) | 0.5 V (`404`) |

### Per-bus detail

**Zone `118`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `403` | 239.6 | 240.0 | 1.042 | 1.044 | 0.2 % | 0.44 V |
| ✅ | `404` | 239.5 | 240.0 | 1.041 | 1.044 | 0.2 % | 0.5 V |
| ✅ | `77` | 239.7 | 240.0 | 1.042 | 1.044 | 0.1 % | 0.33 V |
| ✅ | `326` | 239.6 | 240.0 | 1.042 | 1.044 | 0.2 % | 0.39 V |
| ✅ | `334` | 239.6 | 240.0 | 1.042 | 1.044 | 0.2 % | 0.4 V |
| ✅ | `68` | 239.8 | 240.0 | 1.042 | 1.044 | 0.1 % | 0.31 V |
| ✅ | `81` | 239.8 | 240.0 | 1.042 | 1.044 | 0.1 % | 0.31 V |
| ✅ | `348` | 239.6 | 240.0 | 1.042 | 1.044 | 0.2 % | 0.38 V |
| ✅ | `243` | 239.7 | 240.0 | 1.042 | 1.044 | 0.2 % | 0.4 V |
| ✅ | `356` | 239.6 | 240.0 | 1.042 | 1.044 | 0.2 % | 0.37 V |
| ✅ | `409` | 239.6 | 240.0 | 1.042 | 1.044 | 0.2 % | 0.35 V |
| ✅ | `85` | 239.8 | 240.0 | 1.042 | 1.044 | 0.1 % | 0.31 V |
| ✅ | `411` | 239.6 | 240.0 | 1.042 | 1.044 | 0.2 % | 0.38 V |
| ✅ | `436` | 239.7 | 240.0 | 1.042 | 1.044 | 0.1 % | 0.43 V |
| ✅ | `503` | 239.7 | 240.0 | 1.042 | 1.044 | 0.1 % | 0.43 V |
| ✅ | `410` | 239.7 | 240.0 | 1.042 | 1.044 | 0.1 % | 0.39 V |
| ✅ | `417` | 239.7 | 240.0 | 1.042 | 1.044 | 0.1 % | 0.39 V |
| ✅ | `443` | 239.7 | 240.0 | 1.042 | 1.044 | 0.1 % | 0.38 V |
| ✅ | `499` | 239.7 | 240.0 | 1.042 | 1.044 | 0.1 % | 0.37 V |
| ✅ | `118` | 239.8 | 240.0 | 1.042 | 1.043 | 0.1 % | 0.32 V |
| ✅ | `130` | 239.8 | 240.0 | 1.042 | 1.043 | 0.1 % | 0.32 V |
| ✅ | `277` | 239.8 | 240.0 | 1.042 | 1.043 | 0.1 % | 0.31 V |
| ✅ | `124` | 239.8 | 240.0 | 1.042 | 1.043 | 0.1 % | 0.32 V |
| ✅ | `475` | 239.7 | 240.0 | 1.042 | 1.043 | 0.1 % | 0.38 V |
| ✅ | `267` | 239.8 | 240.0 | 1.042 | 1.043 | 0.1 % | 0.34 V |
| ✅ | `297` | 239.8 | 240.0 | 1.042 | 1.043 | 0.1 % | 0.3 V |
| ✅ | `501` | 239.7 | 240.0 | 1.042 | 1.043 | 0.1 % | 0.38 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -27.528 kW | [-27.528 kW, 27.528 kW] |
| W | `grid` | `2` | pg | -27.528 kW | [-27.528 kW, 27.528 kW] |
| W | `grid` | `3` | pg | -27.528 kW | [-27.528 kW, 27.528 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-27.528 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-27.528 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-27.528 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.5 V at bus '404' — reflects the neutral shift under unbalanced loading.

