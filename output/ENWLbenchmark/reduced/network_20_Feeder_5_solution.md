# BMOPF Solution Profile: network_20_Feeder_5

**Generated:** 2026-06-22 15:16:42  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -101.6061  
**Solve time:** 0.072 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 21.141 kW |
| Total load | 21.114 kW |
| Total line losses | 47.14 W |
| Loss fraction | 0.2% |
| Power balance error | 20.29 W |
| Max neutral shift | 0.136 V (bus `47`) |

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
| ✅ | `41` | 230.0 V | 25 | 1.043 (`48`) | 1.044 (`sourcebus`) | 0.1 % (`48`) | 0.14 V (`47`) |

### Per-bus detail

**Zone `41`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `48` | 239.9 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.08 V |
| ✅ | `42` | 239.9 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.07 V |
| ✅ | `60` | 239.9 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.06 V |
| ✅ | `63` | 240.0 | 240.1 | 1.043 | 1.044 | 0.0 % | 0.03 V |
| ✅ | `51` | 240.0 | 240.1 | 1.043 | 1.044 | 0.0 % | 0.01 V |
| ✅ | `54` | 240.0 | 240.1 | 1.043 | 1.044 | 0.0 % | 0.01 V |
| ✅ | `45` | 240.0 | 240.1 | 1.043 | 1.044 | 0.0 % | 0.01 V |
| ✅ | `57` | 240.0 | 240.1 | 1.043 | 1.044 | 0.0 % | 0.01 V |
| ✅ | `41` | 240.0 | 240.1 | 1.043 | 1.044 | 0.0 % | 0.01 V |
| ✅ | `62` | 240.0 | 240.1 | 1.043 | 1.044 | 0.0 % | 0.03 V |
| ✅ | `50` | 240.0 | 240.1 | 1.043 | 1.044 | 0.0 % | 0.03 V |
| ✅ | `59` | 240.0 | 240.1 | 1.043 | 1.044 | 0.0 % | 0.03 V |
| ✅ | `53` | 240.0 | 240.1 | 1.043 | 1.044 | 0.0 % | 0.03 V |
| ✅ | `56` | 240.0 | 240.1 | 1.043 | 1.044 | 0.0 % | 0.05 V |
| ✅ | `44` | 239.9 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.13 V |
| ✅ | `47` | 239.9 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.14 V |
| ✅ | `64` | 240.0 | 240.1 | 1.043 | 1.044 | 0.0 % | 0.01 V |
| ✅ | `58` | 240.0 | 240.1 | 1.043 | 1.044 | 0.0 % | 0.02 V |
| ✅ | `49` | 240.0 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.02 V |
| ✅ | `52` | 240.0 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.02 V |
| ✅ | `61` | 240.0 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.04 V |
| ✅ | `43` | 240.0 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.04 V |
| ✅ | `46` | 240.0 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.06 V |
| ✅ | `55` | 240.0 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.08 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -42.228 kW | [-42.228 kW, 42.228 kW] |
| W | `grid` | `2` | pg | -42.228 kW | [-42.228 kW, 42.228 kW] |
| W | `grid` | `3` | pg | -42.228 kW | [-42.228 kW, 42.228 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-42.228 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-42.228 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-42.228 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.14 V at bus '47' — reflects the neutral shift under unbalanced loading.

