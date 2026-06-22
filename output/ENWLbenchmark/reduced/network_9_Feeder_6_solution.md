# BMOPF Solution Profile: network_9_Feeder_6

**Generated:** 2026-06-22 15:17:49  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -115.7351  
**Solve time:** 0.065 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 20.9 kW |
| Total load | 20.868 kW |
| Total line losses | 103.11 W |
| Loss fraction | 0.5% |
| Power balance error | 71.53 W |
| Max neutral shift | 0.115 V (bus `165`) |

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
| ✅ | `156` | 230.0 V | 26 | 1.043 (`181`) | 1.044 (`sourcebus`) | 0.1 % (`181`) | 0.12 V (`165`) |

### Per-bus detail

**Zone `156`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `46` | 240.1 | 240.1 | 1.044 | 1.044 | 0.0 % | 0.01 V |
| ✅ | `156` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.04 V |
| ✅ | `181` | 239.8 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.07 V |
| ✅ | `166` | 239.8 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.05 V |
| ✅ | `160` | 239.8 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.05 V |
| ✅ | `178` | 239.8 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.05 V |
| ✅ | `172` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.02 V |
| ✅ | `169` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.02 V |
| ✅ | `163` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.04 V |
| ✅ | `175` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.04 V |
| ✅ | `168` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.05 V |
| ✅ | `158` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.04 V |
| ✅ | `177` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.05 V |
| ✅ | `171` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.05 V |
| ✅ | `180` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.06 V |
| ✅ | `174` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.06 V |
| ✅ | `162` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.11 V |
| ✅ | `165` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.12 V |
| ✅ | `167` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.04 V |
| ✅ | `176` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.04 V |
| ✅ | `170` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.04 V |
| ✅ | `179` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.05 V |
| ✅ | `161` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.05 V |
| ✅ | `164` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.04 V |
| ✅ | `173` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.04 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |
| W | `grid` | `2` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |
| W | `grid` | `3` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-41.736 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-41.736 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-41.736 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.12 V at bus '165' — reflects the neutral shift under unbalanced loading.

