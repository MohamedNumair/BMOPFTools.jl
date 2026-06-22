# BMOPF Solution Profile: network_9_Feeder_2

**Generated:** 2026-06-22 15:17:45  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -110.3514  
**Solve time:** 0.073 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 19.932 kW |
| Total load | 19.902 kW |
| Total line losses | 106.19 W |
| Loss fraction | 0.5% |
| Power balance error | 76.17 W |
| Max neutral shift | 0.104 V (bus `96`) |

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
| ✅ | `100` | 230.0 V | 24 | 1.043 (`97`) | 1.044 (`sourcebus`) | 0.1 % (`97`) | 0.1 V (`96`) |

### Per-bus detail

**Zone `100`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `89` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.03 V |
| ✅ | `97` | 239.8 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.06 V |
| ✅ | `109` | 239.8 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.06 V |
| ✅ | `91` | 239.8 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.06 V |
| ✅ | `103` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.02 V |
| ✅ | `106` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.01 V |
| ✅ | `94` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.03 V |
| ✅ | `100` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.03 V |
| ✅ | `90` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.03 V |
| ✅ | `99` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.03 V |
| ✅ | `108` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.03 V |
| ✅ | `102` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.03 V |
| ✅ | `111` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.03 V |
| ✅ | `105` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.05 V |
| ✅ | `93` | 239.8 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.1 V |
| ✅ | `96` | 239.8 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.1 V |
| ✅ | `110` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.02 V |
| ✅ | `107` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.02 V |
| ✅ | `98` | 239.9 | 240.0 | 1.043 | 1.043 | 0.1 % | 0.02 V |
| ✅ | `101` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.02 V |
| ✅ | `92` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.03 V |
| ✅ | `95` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.01 V |
| ✅ | `104` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.03 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |
| W | `grid` | `2` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |
| W | `grid` | `3` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-39.804 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-39.804 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-39.804 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.1 V at bus '96' — reflects the neutral shift under unbalanced loading.

