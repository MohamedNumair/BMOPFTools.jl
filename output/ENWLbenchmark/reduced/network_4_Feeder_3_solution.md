# BMOPF Solution Profile: network_4_Feeder_3

**Generated:** 2026-06-22 15:17:21  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -76.1266  
**Solve time:** 0.126 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 17.207 kW |
| Total load | 17.034 kW |
| Total line losses | 328.06 W |
| Loss fraction | 1.9% |
| Power balance error | 155.27 W |
| Max neutral shift | 0.815 V (bus `194`) |

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
| ✅ | `102` | 230.0 V | 39 | 1.036 (`212`) | 1.044 (`sourcebus`) | 0.5 % (`107`) | 0.82 V (`194`) |

### Per-bus detail

**Zone `102`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `52` | 239.6 | 240.0 | 1.042 | 1.043 | 0.2 % | 0.32 V |
| ✅ | `67` | 239.4 | 239.9 | 1.041 | 1.043 | 0.2 % | 0.4 V |
| ✅ | `90` | 239.3 | 239.9 | 1.041 | 1.043 | 0.2 % | 0.72 V |
| ✅ | `73` | 239.3 | 239.9 | 1.041 | 1.043 | 0.2 % | 0.44 V |
| ✅ | `89` | 239.0 | 239.8 | 1.039 | 1.043 | 0.4 % | 0.65 V |
| ✅ | `82` | 239.1 | 239.8 | 1.04 | 1.043 | 0.3 % | 0.53 V |
| ✅ | `93` | 238.7 | 239.7 | 1.038 | 1.042 | 0.4 % | 0.75 V |
| ✅ | `84` | 238.9 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.57 V |
| ✅ | `87` | 238.9 | 239.7 | 1.039 | 1.042 | 0.4 % | 0.57 V |
| ✅ | `95` | 238.9 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.55 V |
| ✅ | `96` | 238.8 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.57 V |
| ✅ | `99` | 238.8 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.6 V |
| ✅ | `107` | 238.5 | 239.6 | 1.037 | 1.042 | 0.5 % | 0.74 V |
| ✅ | `102` | 238.7 | 239.6 | 1.038 | 1.042 | 0.4 % | 0.57 V |
| ✅ | `105` | 238.7 | 239.5 | 1.038 | 1.041 | 0.4 % | 0.53 V |
| ✅ | `114` | 238.7 | 239.5 | 1.038 | 1.041 | 0.4 % | 0.53 V |
| ✅ | `120` | 238.7 | 239.5 | 1.038 | 1.041 | 0.4 % | 0.54 V |
| ✅ | `125` | 238.6 | 239.5 | 1.037 | 1.041 | 0.4 % | 0.54 V |
| ✅ | `119` | 238.6 | 239.5 | 1.038 | 1.041 | 0.4 % | 0.52 V |
| ✅ | `121` | 238.6 | 239.5 | 1.037 | 1.041 | 0.4 % | 0.52 V |
| ✅ | `127` | 238.6 | 239.4 | 1.037 | 1.041 | 0.4 % | 0.5 V |
| ✅ | `126` | 238.6 | 239.4 | 1.037 | 1.041 | 0.4 % | 0.53 V |
| ✅ | `130` | 238.6 | 239.4 | 1.037 | 1.041 | 0.4 % | 0.55 V |
| ✅ | `112` | 238.7 | 239.4 | 1.038 | 1.041 | 0.3 % | 0.39 V |
| ✅ | `178` | 238.5 | 239.3 | 1.037 | 1.041 | 0.4 % | 0.59 V |
| ✅ | `171` | 238.5 | 239.3 | 1.037 | 1.041 | 0.4 % | 0.59 V |
| ✅ | `175` | 238.5 | 239.3 | 1.037 | 1.041 | 0.4 % | 0.61 V |
| ✅ | `180` | 238.4 | 239.3 | 1.037 | 1.041 | 0.4 % | 0.62 V |
| ✅ | `185` | 238.4 | 239.3 | 1.037 | 1.041 | 0.4 % | 0.63 V |
| ✅ | `194` | 238.4 | 239.3 | 1.037 | 1.041 | 0.4 % | 0.82 V |
| ✅ | `212` | 238.4 | 239.3 | 1.036 | 1.04 | 0.4 % | 0.52 V |
| ✅ | `200` | 238.4 | 239.3 | 1.037 | 1.04 | 0.4 % | 0.6 V |
| ✅ | `196` | 238.4 | 239.3 | 1.037 | 1.04 | 0.4 % | 0.61 V |
| ✅ | `225` | 238.4 | 239.3 | 1.037 | 1.04 | 0.4 % | 0.61 V |
| ✅ | `239` | 238.4 | 239.3 | 1.037 | 1.04 | 0.4 % | 0.61 V |
| ✅ | `242` | 238.4 | 239.3 | 1.037 | 1.04 | 0.4 % | 0.64 V |
| ✅ | `183` | 238.5 | 239.3 | 1.037 | 1.04 | 0.4 % | 0.64 V |
| ✅ | `234` | 238.4 | 239.3 | 1.037 | 1.04 | 0.4 % | 0.64 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -34.068 kW | [-34.068 kW, 34.068 kW] |
| W | `grid` | `2` | pg | -34.068 kW | [-34.068 kW, 34.068 kW] |
| W | `grid` | `3` | pg | -34.068 kW | [-34.068 kW, 34.068 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-34.068 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-34.068 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-34.068 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.82 V at bus '194' — reflects the neutral shift under unbalanced loading.

