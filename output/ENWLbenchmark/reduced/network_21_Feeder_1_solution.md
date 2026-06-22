# BMOPF Solution Profile: network_21_Feeder_1

**Generated:** 2026-06-22 15:16:42  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -114.7413  
**Solve time:** 0.15 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 21.029 kW |
| Total load | 20.868 kW |
| Total line losses | 604.77 W |
| Loss fraction | 2.9% |
| Power balance error | 444.21 W |
| Max neutral shift | 0.37 V (bus `623`) |

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
| ✅ | `107` | 230.0 V | 49 | 1.036 (`623`) | 1.044 (`sourcebus`) | 0.4 % (`623`) | 0.37 V (`623`) |

### Per-bus detail

**Zone `107`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `178` | 239.1 | 239.6 | 1.039 | 1.042 | 0.2 % | 0.28 V |
| ✅ | `124` | 239.1 | 239.6 | 1.04 | 1.042 | 0.2 % | 0.18 V |
| ✅ | `163` | 239.1 | 239.6 | 1.04 | 1.042 | 0.2 % | 0.19 V |
| ✅ | `107` | 239.1 | 239.6 | 1.04 | 1.042 | 0.2 % | 0.18 V |
| ✅ | `133` | 239.1 | 239.6 | 1.04 | 1.042 | 0.2 % | 0.17 V |
| ✅ | `77` | 239.2 | 239.6 | 1.04 | 1.042 | 0.2 % | 0.17 V |
| ✅ | `184` | 239.1 | 239.6 | 1.04 | 1.042 | 0.2 % | 0.1 V |
| ✅ | `135` | 239.1 | 239.6 | 1.039 | 1.042 | 0.2 % | 0.32 V |
| ✅ | `80` | 239.1 | 239.6 | 1.04 | 1.042 | 0.2 % | 0.18 V |
| ✅ | `83` | 239.1 | 239.6 | 1.04 | 1.042 | 0.2 % | 0.18 V |
| ✅ | `87` | 239.1 | 239.6 | 1.039 | 1.042 | 0.2 % | 0.17 V |
| ✅ | `91` | 239.1 | 239.6 | 1.039 | 1.042 | 0.2 % | 0.17 V |
| ✅ | `95` | 239.1 | 239.6 | 1.039 | 1.042 | 0.2 % | 0.17 V |
| ✅ | `158` | 239.1 | 239.6 | 1.039 | 1.042 | 0.2 % | 0.12 V |
| ✅ | `152` | 239.0 | 239.5 | 1.039 | 1.041 | 0.2 % | 0.17 V |
| ✅ | `277` | 238.8 | 239.5 | 1.038 | 1.041 | 0.3 % | 0.35 V |
| ✅ | `238` | 239.0 | 239.5 | 1.039 | 1.041 | 0.2 % | 0.21 V |
| ✅ | `252` | 239.0 | 239.5 | 1.039 | 1.041 | 0.2 % | 0.21 V |
| ✅ | `315` | 239.0 | 239.5 | 1.039 | 1.041 | 0.2 % | 0.21 V |
| ✅ | `126` | 239.1 | 239.5 | 1.04 | 1.041 | 0.2 % | 0.25 V |
| ✅ | `192` | 238.9 | 239.4 | 1.039 | 1.041 | 0.2 % | 0.16 V |
| ✅ | `368` | 238.8 | 239.4 | 1.038 | 1.041 | 0.3 % | 0.17 V |
| ✅ | `256` | 238.8 | 239.4 | 1.038 | 1.041 | 0.2 % | 0.16 V |
| ✅ | `357` | 238.8 | 239.4 | 1.038 | 1.041 | 0.2 % | 0.18 V |
| ✅ | `264` | 238.8 | 239.4 | 1.038 | 1.041 | 0.2 % | 0.15 V |
| ✅ | `350` | 238.7 | 239.3 | 1.038 | 1.041 | 0.3 % | 0.1 V |
| ✅ | `283` | 238.7 | 239.3 | 1.038 | 1.041 | 0.3 % | 0.15 V |
| ✅ | `369` | 238.7 | 239.3 | 1.038 | 1.041 | 0.3 % | 0.17 V |
| ✅ | `292` | 238.7 | 239.3 | 1.038 | 1.041 | 0.3 % | 0.17 V |
| ✅ | `474` | 238.4 | 239.3 | 1.037 | 1.04 | 0.4 % | 0.3 V |
| ✅ | `415` | 238.5 | 239.3 | 1.037 | 1.04 | 0.3 % | 0.21 V |
| ✅ | `486` | 238.5 | 239.3 | 1.037 | 1.04 | 0.3 % | 0.22 V |
| ✅ | `420` | 238.5 | 239.3 | 1.037 | 1.04 | 0.3 % | 0.21 V |
| ✅ | `472` | 238.5 | 239.3 | 1.037 | 1.04 | 0.3 % | 0.18 V |
| ✅ | `426` | 238.5 | 239.3 | 1.037 | 1.04 | 0.3 % | 0.22 V |
| ✅ | `488` | 238.5 | 239.3 | 1.037 | 1.04 | 0.4 % | 0.25 V |
| ✅ | `439` | 238.5 | 239.3 | 1.037 | 1.04 | 0.3 % | 0.24 V |
| ✅ | `623` | 238.3 | 239.3 | 1.036 | 1.04 | 0.4 % | 0.37 V |
| ✅ | `556` | 238.4 | 239.3 | 1.037 | 1.04 | 0.4 % | 0.33 V |
| ✅ | `561` | 238.4 | 239.3 | 1.036 | 1.04 | 0.4 % | 0.34 V |
| ✅ | `487` | 238.5 | 239.3 | 1.037 | 1.04 | 0.4 % | 0.26 V |
| ✅ | `601` | 238.4 | 239.3 | 1.037 | 1.04 | 0.4 % | 0.28 V |
| ✅ | `521` | 238.5 | 239.3 | 1.037 | 1.04 | 0.4 % | 0.27 V |
| ✅ | `496` | 238.5 | 239.3 | 1.037 | 1.04 | 0.4 % | 0.27 V |
| ✅ | `537` | 238.5 | 239.3 | 1.037 | 1.04 | 0.4 % | 0.31 V |
| ✅ | `489` | 238.5 | 239.3 | 1.037 | 1.04 | 0.4 % | 0.26 V |
| ✅ | `523` | 238.5 | 239.3 | 1.037 | 1.04 | 0.3 % | 0.25 V |
| ✅ | `482` | 238.5 | 239.2 | 1.037 | 1.04 | 0.3 % | 0.16 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |
| W | `grid` | `2` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |
| W | `grid` | `3` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 444.21 W (>1 % of load). pg=21.03 kW, pd=20.87 kW, p_loss=0.6 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-41.736 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-41.736 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-41.736 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 444.21 W (>1 % of load). pg=21.03 kW, pd=20.87 kW, p_loss=0.6 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.37 V at bus '623' — reflects the neutral shift under unbalanced loading.

