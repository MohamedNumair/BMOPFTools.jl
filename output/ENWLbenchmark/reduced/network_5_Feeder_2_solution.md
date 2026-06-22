# BMOPF Solution Profile: network_5_Feeder_2

**Generated:** 2026-06-22 15:17:22  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -80.7477  
**Solve time:** 0.077 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 17.441 kW |
| Total load | 17.358 kW |
| Total line losses | 136.13 W |
| Loss fraction | 0.8% |
| Power balance error | 52.66 W |
| Max neutral shift | 0.6 V (bus `157`) |

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
| ✅ | `102` | 230.0 V | 39 | 1.039 (`157`) | 1.044 (`sourcebus`) | 0.4 % (`157`) | 0.6 V (`157`) |

### Per-bus detail

**Zone `102`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `32` | 240.1 | 240.1 | 1.044 | 1.044 | 0.0 % | 0.03 V |
| ✅ | `38` | 239.9 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.06 V |
| ✅ | `45` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.08 V |
| ✅ | `49` | 239.7 | 240.0 | 1.042 | 1.043 | 0.1 % | 0.19 V |
| ✅ | `52` | 239.6 | 240.0 | 1.042 | 1.043 | 0.2 % | 0.28 V |
| ✅ | `56` | 239.6 | 240.0 | 1.042 | 1.043 | 0.2 % | 0.3 V |
| ✅ | `57` | 239.5 | 240.0 | 1.041 | 1.043 | 0.2 % | 0.36 V |
| ✅ | `63` | 239.5 | 239.9 | 1.042 | 1.043 | 0.2 % | 0.24 V |
| ✅ | `95` | 239.4 | 239.9 | 1.041 | 1.043 | 0.2 % | 0.35 V |
| ✅ | `102` | 239.2 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.5 V |
| ✅ | `99` | 239.3 | 239.9 | 1.041 | 1.043 | 0.2 % | 0.38 V |
| ✅ | `103` | 239.3 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.43 V |
| ✅ | `107` | 239.2 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.46 V |
| ✅ | `108` | 239.3 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.41 V |
| ✅ | `120` | 239.3 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.42 V |
| ✅ | `128` | 239.2 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.45 V |
| ✅ | `138` | 239.2 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.45 V |
| ✅ | `136` | 239.1 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.47 V |
| ✅ | `142` | 239.1 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.47 V |
| ✅ | `140` | 239.1 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.47 V |
| ✅ | `145` | 239.1 | 239.9 | 1.039 | 1.043 | 0.3 % | 0.49 V |
| ✅ | `146` | 239.1 | 239.9 | 1.039 | 1.043 | 0.4 % | 0.49 V |
| ✅ | `149` | 239.1 | 239.9 | 1.039 | 1.043 | 0.4 % | 0.49 V |
| ✅ | `153` | 239.0 | 239.9 | 1.039 | 1.043 | 0.4 % | 0.45 V |
| ✅ | `150` | 239.0 | 239.9 | 1.039 | 1.043 | 0.4 % | 0.49 V |
| ✅ | `154` | 239.0 | 239.9 | 1.039 | 1.043 | 0.4 % | 0.51 V |
| ✅ | `157` | 238.9 | 239.9 | 1.039 | 1.043 | 0.4 % | 0.6 V |
| ✅ | `176` | 239.0 | 239.8 | 1.039 | 1.043 | 0.4 % | 0.53 V |
| ✅ | `179` | 238.9 | 239.8 | 1.039 | 1.043 | 0.4 % | 0.54 V |
| ✅ | `181` | 238.9 | 239.8 | 1.039 | 1.043 | 0.4 % | 0.53 V |
| ✅ | `188` | 238.9 | 239.8 | 1.039 | 1.043 | 0.4 % | 0.55 V |
| ✅ | `185` | 238.9 | 239.8 | 1.039 | 1.043 | 0.4 % | 0.54 V |
| ✅ | `190` | 238.9 | 239.8 | 1.039 | 1.043 | 0.4 % | 0.54 V |
| ✅ | `193` | 238.9 | 239.8 | 1.039 | 1.043 | 0.4 % | 0.56 V |
| ✅ | `68` | 239.6 | 239.8 | 1.042 | 1.043 | 0.1 % | 0.17 V |
| ✅ | `184` | 238.9 | 239.8 | 1.039 | 1.043 | 0.4 % | 0.53 V |
| ✅ | `73` | 239.6 | 239.8 | 1.042 | 1.043 | 0.1 % | 0.15 V |
| ✅ | `74` | 239.6 | 239.8 | 1.042 | 1.043 | 0.1 % | 0.13 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -34.716 kW | [-34.716 kW, 34.716 kW] |
| W | `grid` | `2` | pg | -34.716 kW | [-34.716 kW, 34.716 kW] |
| W | `grid` | `3` | pg | -34.716 kW | [-34.716 kW, 34.716 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-34.716 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-34.716 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-34.716 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.6 V at bus '157' — reflects the neutral shift under unbalanced loading.

