# BMOPF Solution Profile: network_11_Feeder_1

**Generated:** 2026-06-22 15:15:39  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -137.2117  
**Solve time:** 0.095 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 25.302 kW |
| Total load | 25.14 kW |
| Total line losses | 357.89 W |
| Loss fraction | 1.4% |
| Power balance error | 195.79 W |
| Max neutral shift | 0.985 V (bus `141`) |

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
| ✅ | `117` | 230.0 V | 41 | 1.038 (`141`) | 1.044 (`sourcebus`) | 0.3 % (`141`) | 0.99 V (`141`) |

### Per-bus detail

**Zone `117`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `88` | 239.3 | 239.6 | 1.04 | 1.042 | 0.1 % | 0.5 V |
| ✅ | `85` | 239.3 | 239.6 | 1.041 | 1.042 | 0.1 % | 0.5 V |
| ✅ | `73` | 239.3 | 239.6 | 1.041 | 1.042 | 0.1 % | 0.5 V |
| ✅ | `76` | 239.3 | 239.6 | 1.04 | 1.042 | 0.1 % | 0.52 V |
| ✅ | `125` | 239.2 | 239.6 | 1.04 | 1.042 | 0.1 % | 0.54 V |
| ✅ | `117` | 239.3 | 239.6 | 1.04 | 1.042 | 0.1 % | 0.52 V |
| ✅ | `120` | 239.3 | 239.6 | 1.04 | 1.042 | 0.1 % | 0.53 V |
| ✅ | `123` | 239.3 | 239.6 | 1.04 | 1.042 | 0.1 % | 0.55 V |
| ✅ | `126` | 239.3 | 239.6 | 1.04 | 1.042 | 0.1 % | 0.55 V |
| ✅ | `128` | 239.3 | 239.6 | 1.04 | 1.042 | 0.1 % | 0.6 V |
| ✅ | `122` | 239.3 | 239.6 | 1.04 | 1.042 | 0.1 % | 0.62 V |
| ✅ | `132` | 239.1 | 239.6 | 1.04 | 1.042 | 0.2 % | 0.75 V |
| ✅ | `97` | 239.2 | 239.6 | 1.04 | 1.042 | 0.1 % | 0.64 V |
| ✅ | `135` | 239.1 | 239.6 | 1.04 | 1.042 | 0.2 % | 0.76 V |
| ✅ | `140` | 239.1 | 239.6 | 1.039 | 1.042 | 0.2 % | 0.78 V |
| ✅ | `138` | 239.1 | 239.6 | 1.039 | 1.042 | 0.2 % | 0.79 V |
| ✅ | `139` | 239.1 | 239.6 | 1.039 | 1.042 | 0.2 % | 0.8 V |
| ✅ | `142` | 239.0 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.87 V |
| ✅ | `141` | 238.8 | 239.6 | 1.038 | 1.042 | 0.3 % | 0.99 V |
| ✅ | `127` | 239.3 | 239.6 | 1.04 | 1.042 | 0.1 % | 0.5 V |
| ✅ | `176` | 239.1 | 239.5 | 1.04 | 1.042 | 0.2 % | 0.71 V |
| ✅ | `207` | 239.1 | 239.5 | 1.04 | 1.041 | 0.2 % | 0.78 V |
| ✅ | `201` | 239.1 | 239.5 | 1.04 | 1.041 | 0.2 % | 0.75 V |
| ✅ | `213` | 239.1 | 239.5 | 1.04 | 1.041 | 0.2 % | 0.75 V |
| ✅ | `198` | 239.1 | 239.5 | 1.04 | 1.041 | 0.2 % | 0.74 V |
| ✅ | `211` | 239.1 | 239.5 | 1.04 | 1.041 | 0.2 % | 0.75 V |
| ✅ | `208` | 239.1 | 239.5 | 1.04 | 1.041 | 0.2 % | 0.76 V |
| ✅ | `205` | 239.1 | 239.5 | 1.039 | 1.041 | 0.2 % | 0.77 V |
| ✅ | `199` | 239.1 | 239.5 | 1.04 | 1.041 | 0.2 % | 0.72 V |
| ✅ | `202` | 239.0 | 239.5 | 1.039 | 1.041 | 0.2 % | 0.82 V |
| ✅ | `214` | 239.0 | 239.5 | 1.039 | 1.041 | 0.2 % | 0.83 V |
| ✅ | `210` | 239.1 | 239.5 | 1.04 | 1.041 | 0.2 % | 0.77 V |
| ✅ | `204` | 239.1 | 239.5 | 1.04 | 1.041 | 0.2 % | 0.82 V |
| ✅ | `206` | 239.1 | 239.5 | 1.04 | 1.041 | 0.2 % | 0.74 V |
| ✅ | `209` | 239.1 | 239.5 | 1.04 | 1.041 | 0.2 % | 0.74 V |
| ✅ | `212` | 239.1 | 239.5 | 1.04 | 1.041 | 0.2 % | 0.73 V |
| ✅ | `203` | 239.1 | 239.5 | 1.04 | 1.041 | 0.2 % | 0.73 V |
| ✅ | `200` | 239.1 | 239.5 | 1.04 | 1.041 | 0.2 % | 0.73 V |
| ✅ | `121` | 239.3 | 239.4 | 1.04 | 1.041 | 0.1 % | 0.31 V |
| ✅ | `124` | 239.3 | 239.3 | 1.04 | 1.041 | 0.0 % | 0.31 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -50.28 kW | [-50.28 kW, 50.28 kW] |
| W | `grid` | `2` | pg | -50.28 kW | [-50.28 kW, 50.28 kW] |
| W | `grid` | `3` | pg | -50.28 kW | [-50.28 kW, 50.28 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-50.28 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-50.28 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-50.28 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.99 V at bus '141' — reflects the neutral shift under unbalanced loading.

