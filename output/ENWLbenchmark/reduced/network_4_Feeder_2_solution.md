# BMOPF Solution Profile: network_4_Feeder_2

**Generated:** 2026-06-22 15:17:21  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -96.3277  
**Solve time:** 0.076 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 16.893 kW |
| Total load | 16.746 kW |
| Total line losses | 287.83 W |
| Loss fraction | 1.7% |
| Power balance error | 140.77 W |
| Max neutral shift | 0.544 V (bus `170`) |

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
| ✅ | `149` | 230.0 V | 35 | 1.036 (`386`) | 1.044 (`sourcebus`) | 0.2 % (`170`) | 0.54 V (`170`) |

### Per-bus detail

**Zone `149`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `157` | 239.3 | 239.6 | 1.04 | 1.042 | 0.1 % | 0.19 V |
| ✅ | `149` | 239.4 | 239.6 | 1.041 | 1.042 | 0.1 % | 0.23 V |
| ✅ | `151` | 239.4 | 239.5 | 1.041 | 1.041 | 0.1 % | 0.25 V |
| ✅ | `162` | 239.4 | 239.5 | 1.041 | 1.041 | 0.1 % | 0.33 V |
| ✅ | `208` | 239.3 | 239.5 | 1.04 | 1.041 | 0.1 % | 0.26 V |
| ✅ | `154` | 239.3 | 239.5 | 1.04 | 1.041 | 0.1 % | 0.28 V |
| ✅ | `158` | 239.2 | 239.4 | 1.04 | 1.041 | 0.1 % | 0.32 V |
| ✅ | `170` | 238.9 | 239.4 | 1.039 | 1.041 | 0.2 % | 0.54 V |
| ✅ | `200` | 239.0 | 239.2 | 1.039 | 1.04 | 0.1 % | 0.3 V |
| ✅ | `252` | 238.8 | 239.0 | 1.038 | 1.039 | 0.1 % | 0.26 V |
| ✅ | `263` | 238.8 | 239.0 | 1.038 | 1.039 | 0.1 % | 0.26 V |
| ✅ | `270` | 238.8 | 238.9 | 1.038 | 1.039 | 0.0 % | 0.26 V |
| ✅ | `325` | 238.6 | 238.8 | 1.037 | 1.038 | 0.1 % | 0.28 V |
| ✅ | `328` | 238.5 | 238.8 | 1.037 | 1.038 | 0.2 % | 0.45 V |
| ✅ | `331` | 238.5 | 238.8 | 1.037 | 1.038 | 0.1 % | 0.21 V |
| ✅ | `327` | 238.6 | 238.8 | 1.037 | 1.038 | 0.1 % | 0.24 V |
| ✅ | `343` | 238.5 | 238.7 | 1.037 | 1.038 | 0.1 % | 0.19 V |
| ✅ | `336` | 238.5 | 238.7 | 1.037 | 1.038 | 0.1 % | 0.2 V |
| ✅ | `340` | 238.5 | 238.7 | 1.037 | 1.038 | 0.1 % | 0.18 V |
| ✅ | `348` | 238.5 | 238.7 | 1.037 | 1.038 | 0.1 % | 0.17 V |
| ✅ | `350` | 238.5 | 238.7 | 1.037 | 1.038 | 0.1 % | 0.16 V |
| ✅ | `357` | 238.5 | 238.7 | 1.037 | 1.038 | 0.1 % | 0.18 V |
| ✅ | `358` | 238.5 | 238.6 | 1.037 | 1.037 | 0.1 % | 0.13 V |
| ✅ | `365` | 238.5 | 238.6 | 1.037 | 1.037 | 0.0 % | 0.13 V |
| ✅ | `372` | 238.4 | 238.6 | 1.037 | 1.037 | 0.1 % | 0.09 V |
| ✅ | `366` | 238.5 | 238.6 | 1.037 | 1.037 | 0.1 % | 0.11 V |
| ✅ | `376` | 238.4 | 238.5 | 1.037 | 1.037 | 0.0 % | 0.15 V |
| ✅ | `370` | 238.4 | 238.5 | 1.037 | 1.037 | 0.0 % | 0.1 V |
| ✅ | `379` | 238.4 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.23 V |
| ✅ | `374` | 238.4 | 238.5 | 1.037 | 1.037 | 0.1 % | 0.1 V |
| ✅ | `384` | 238.4 | 238.5 | 1.037 | 1.037 | 0.1 % | 0.1 V |
| ✅ | `390` | 238.4 | 238.5 | 1.037 | 1.037 | 0.1 % | 0.1 V |
| ✅ | `381` | 238.4 | 238.5 | 1.037 | 1.037 | 0.1 % | 0.09 V |
| ✅ | `386` | 238.4 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.1 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -33.492 kW | [-33.492 kW, 33.492 kW] |
| W | `grid` | `2` | pg | -33.492 kW | [-33.492 kW, 33.492 kW] |
| W | `grid` | `3` | pg | -33.492 kW | [-33.492 kW, 33.492 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-33.492 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-33.492 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-33.492 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.54 V at bus '170' — reflects the neutral shift under unbalanced loading.

