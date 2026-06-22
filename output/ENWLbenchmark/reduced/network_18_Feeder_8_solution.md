# BMOPF Solution Profile: network_18_Feeder_8

**Generated:** 2026-06-22 15:16:31  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -110.3003  
**Solve time:** 0.095 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 20.049 kW |
| Total load | 19.902 kW |
| Total line losses | 381.38 W |
| Loss fraction | 1.9% |
| Power balance error | 234.34 W |
| Max neutral shift | 1.414 V (bus `229`) |

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
| ✅ | `110` | 230.0 V | 44 | 1.037 (`229`) | 1.044 (`sourcebus`) | 0.6 % (`229`) | 1.41 V (`229`) |

### Per-bus detail

**Zone `110`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `79` | 239.3 | 240.0 | 1.041 | 1.044 | 0.3 % | 0.84 V |
| ✅ | `41` | 239.8 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.25 V |
| ✅ | `158` | 239.7 | 240.0 | 1.042 | 1.044 | 0.1 % | 0.31 V |
| ✅ | `43` | 239.7 | 240.0 | 1.042 | 1.044 | 0.1 % | 0.31 V |
| ✅ | `49` | 239.6 | 240.0 | 1.042 | 1.043 | 0.1 % | 0.4 V |
| ✅ | `52` | 239.6 | 239.9 | 1.042 | 1.043 | 0.2 % | 0.41 V |
| ✅ | `120` | 239.3 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.71 V |
| ✅ | `129` | 239.3 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.72 V |
| ✅ | `137` | 239.2 | 239.9 | 1.04 | 1.043 | 0.3 % | 0.81 V |
| ✅ | `77` | 239.4 | 239.8 | 1.041 | 1.043 | 0.2 % | 0.5 V |
| ✅ | `193` | 239.4 | 239.8 | 1.041 | 1.043 | 0.2 % | 0.39 V |
| ✅ | `201` | 239.4 | 239.8 | 1.041 | 1.043 | 0.2 % | 0.38 V |
| ✅ | `283` | 239.4 | 239.8 | 1.041 | 1.043 | 0.2 % | 0.37 V |
| ✅ | `255` | 239.1 | 239.7 | 1.04 | 1.042 | 0.3 % | 0.68 V |
| ✅ | `249` | 239.1 | 239.7 | 1.04 | 1.042 | 0.3 % | 0.68 V |
| ✅ | `243` | 239.1 | 239.7 | 1.04 | 1.042 | 0.3 % | 0.68 V |
| ✅ | `110` | 239.1 | 239.7 | 1.04 | 1.042 | 0.3 % | 0.69 V |
| ✅ | `229` | 238.4 | 239.7 | 1.037 | 1.042 | 0.6 % | 1.41 V |
| ✅ | `202` | 238.5 | 239.7 | 1.037 | 1.042 | 0.5 % | 1.31 V |
| ✅ | `209` | 238.4 | 239.7 | 1.037 | 1.042 | 0.6 % | 1.39 V |
| ✅ | `117` | 239.1 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.74 V |
| ✅ | `231` | 239.0 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.74 V |
| ✅ | `235` | 239.0 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.62 V |
| ✅ | `241` | 239.0 | 239.7 | 1.039 | 1.042 | 0.3 % | 0.61 V |
| ✅ | `318` | 239.0 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.57 V |
| ✅ | `247` | 239.0 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.78 V |
| ✅ | `298` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.82 V |
| ✅ | `305` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.82 V |
| ✅ | `312` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.83 V |
| ✅ | `272` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.81 V |
| ✅ | `319` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.83 V |
| ✅ | `326` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.84 V |
| ✅ | `331` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.84 V |
| ✅ | `291` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.82 V |
| ✅ | `320` | 238.8 | 239.6 | 1.038 | 1.042 | 0.3 % | 0.88 V |
| ✅ | `302` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.82 V |
| ✅ | `340` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.86 V |
| ✅ | `317` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.81 V |
| ✅ | `339` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.82 V |
| ✅ | `330` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.82 V |
| ✅ | `345` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.84 V |
| ✅ | `333` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.79 V |
| ✅ | `347` | 238.9 | 239.6 | 1.039 | 1.042 | 0.3 % | 0.79 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |
| W | `grid` | `2` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |
| W | `grid` | `3` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 234.34 W (>1 % of load). pg=20.05 kW, pd=19.9 kW, p_loss=0.38 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-39.804 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-39.804 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-39.804 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 234.34 W (>1 % of load). pg=20.05 kW, pd=19.9 kW, p_loss=0.38 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.41 V at bus '229' — reflects the neutral shift under unbalanced loading.

