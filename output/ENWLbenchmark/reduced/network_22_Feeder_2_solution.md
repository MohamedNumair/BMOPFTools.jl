# BMOPF Solution Profile: network_22_Feeder_2

**Generated:** 2026-06-22 15:16:44  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -68.9141  
**Solve time:** 0.062 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 13.861 kW |
| Total load | 13.764 kW |
| Total line losses | 220.64 W |
| Loss fraction | 1.6% |
| Power balance error | 123.15 W |
| Max neutral shift | 1.157 V (bus `174`) |

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
| ✅ | `112` | 230.0 V | 28 | 1.037 (`174`) | 1.044 (`sourcebus`) | 0.5 % (`174`) | 1.16 V (`174`) |

### Per-bus detail

**Zone `112`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `185` | 239.4 | 240.0 | 1.041 | 1.043 | 0.2 % | 0.6 V |
| ✅ | `189` | 239.5 | 240.0 | 1.041 | 1.043 | 0.2 % | 0.56 V |
| ✅ | `179` | 239.5 | 240.0 | 1.041 | 1.043 | 0.2 % | 0.55 V |
| ✅ | `54` | 239.5 | 240.0 | 1.041 | 1.043 | 0.2 % | 0.39 V |
| ✅ | `64` | 239.3 | 239.9 | 1.04 | 1.043 | 0.2 % | 0.53 V |
| ✅ | `171` | 239.2 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.66 V |
| ✅ | `178` | 239.2 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.67 V |
| ✅ | `183` | 239.1 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.69 V |
| ✅ | `71` | 239.3 | 239.8 | 1.04 | 1.043 | 0.3 % | 0.56 V |
| ✅ | `91` | 239.2 | 239.8 | 1.04 | 1.043 | 0.3 % | 0.62 V |
| ✅ | `112` | 239.0 | 239.8 | 1.039 | 1.043 | 0.3 % | 0.74 V |
| ✅ | `168` | 238.7 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.06 V |
| ✅ | `186` | 238.6 | 239.8 | 1.037 | 1.043 | 0.5 % | 1.16 V |
| ✅ | `174` | 238.6 | 239.8 | 1.037 | 1.043 | 0.5 % | 1.16 V |
| ✅ | `217` | 239.0 | 239.8 | 1.039 | 1.043 | 0.3 % | 0.76 V |
| ✅ | `216` | 239.0 | 239.8 | 1.039 | 1.043 | 0.3 % | 0.78 V |
| ✅ | `190` | 239.0 | 239.8 | 1.039 | 1.043 | 0.3 % | 0.76 V |
| ✅ | `142` | 239.0 | 239.8 | 1.039 | 1.043 | 0.3 % | 0.75 V |
| ✅ | `251` | 239.0 | 239.8 | 1.039 | 1.043 | 0.4 % | 0.81 V |
| ✅ | `248` | 239.0 | 239.8 | 1.039 | 1.043 | 0.4 % | 0.8 V |
| ✅ | `250` | 239.0 | 239.8 | 1.039 | 1.043 | 0.4 % | 0.81 V |
| ✅ | `210` | 239.0 | 239.8 | 1.039 | 1.043 | 0.3 % | 0.76 V |
| ✅ | `194` | 239.0 | 239.8 | 1.039 | 1.043 | 0.3 % | 0.76 V |
| ✅ | `239` | 239.0 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.72 V |
| ✅ | `138` | 239.2 | 239.7 | 1.04 | 1.042 | 0.3 % | 0.46 V |
| ✅ | `150` | 239.2 | 239.7 | 1.04 | 1.042 | 0.3 % | 0.43 V |
| ✅ | `144` | 239.2 | 239.7 | 1.04 | 1.042 | 0.3 % | 0.44 V |

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
  Maximum neutral terminal voltage: 1.16 V at bus '174' — reflects the neutral shift under unbalanced loading.

