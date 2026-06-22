# BMOPF Solution Profile: network_21_Feeder_1

**Generated:** 2026-06-22 14:52:45  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -114.7413  
**Solve time:** 0.049 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 20.967 kW |
| Total load | 20.868 kW |
| Total line losses | 372.32 W |
| Loss fraction | 1.8% |
| Power balance error | 272.88 W |
| Max neutral shift | 0.491 V (bus `623`) |

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
| ✅ | `107` | 240.0 V | 49 | 0.994 (`623`) | 1.0 (`sourcebus`) | 0.4 % (`623`) | 0.49 V (`623`) |

### Per-bus detail

**Zone `107`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `623` | 238.7 | 239.5 | 0.994 | 0.997 | 0.4 % | 0.49 V |
| ✅ | `561` | 238.7 | 239.5 | 0.994 | 0.997 | 0.3 % | 0.45 V |
| ✅ | `556` | 238.7 | 239.5 | 0.994 | 0.997 | 0.3 % | 0.44 V |
| ✅ | `474` | 238.7 | 239.5 | 0.994 | 0.997 | 0.3 % | 0.46 V |
| ✅ | `601` | 238.8 | 239.5 | 0.994 | 0.997 | 0.3 % | 0.37 V |
| ✅ | `521` | 238.8 | 239.5 | 0.994 | 0.997 | 0.3 % | 0.36 V |
| ✅ | `488` | 238.8 | 239.5 | 0.994 | 0.997 | 0.3 % | 0.38 V |
| ✅ | `537` | 238.8 | 239.5 | 0.994 | 0.997 | 0.3 % | 0.3 V |
| ✅ | `496` | 238.8 | 239.5 | 0.994 | 0.997 | 0.3 % | 0.36 V |
| ✅ | `523` | 238.8 | 239.5 | 0.994 | 0.997 | 0.3 % | 0.36 V |
| ✅ | `489` | 238.8 | 239.5 | 0.994 | 0.997 | 0.3 % | 0.36 V |
| ✅ | `487` | 238.8 | 239.5 | 0.994 | 0.997 | 0.3 % | 0.37 V |
| ✅ | `439` | 238.8 | 239.5 | 0.994 | 0.997 | 0.3 % | 0.37 V |
| ✅ | `472` | 238.8 | 239.5 | 0.994 | 0.997 | 0.3 % | 0.34 V |
| ✅ | `426` | 238.8 | 239.5 | 0.994 | 0.997 | 0.3 % | 0.36 V |
| ✅ | `482` | 238.8 | 239.5 | 0.994 | 0.997 | 0.3 % | 0.37 V |
| ✅ | `420` | 238.8 | 239.5 | 0.994 | 0.997 | 0.3 % | 0.36 V |
| ✅ | `486` | 238.8 | 239.5 | 0.994 | 0.997 | 0.3 % | 0.36 V |
| ✅ | `415` | 238.8 | 239.5 | 0.994 | 0.997 | 0.3 % | 0.37 V |
| ✅ | `369` | 239.0 | 239.6 | 0.995 | 0.997 | 0.2 % | 0.32 V |
| ✅ | `292` | 239.0 | 239.6 | 0.995 | 0.997 | 0.2 % | 0.31 V |
| ✅ | `350` | 239.0 | 239.6 | 0.995 | 0.997 | 0.2 % | 0.28 V |
| ✅ | `283` | 239.0 | 239.6 | 0.995 | 0.997 | 0.2 % | 0.29 V |
| ✅ | `264` | 239.1 | 239.6 | 0.995 | 0.998 | 0.2 % | 0.28 V |
| ✅ | `357` | 239.1 | 239.6 | 0.995 | 0.998 | 0.2 % | 0.25 V |
| ✅ | `277` | 239.1 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.37 V |
| ✅ | `368` | 239.1 | 239.6 | 0.996 | 0.998 | 0.2 % | 0.28 V |
| ✅ | `256` | 239.1 | 239.6 | 0.996 | 0.998 | 0.2 % | 0.27 V |
| ✅ | `192` | 239.2 | 239.6 | 0.996 | 0.998 | 0.2 % | 0.27 V |
| ✅ | `315` | 239.2 | 239.7 | 0.996 | 0.998 | 0.2 % | 0.25 V |
| ✅ | `252` | 239.2 | 239.7 | 0.996 | 0.998 | 0.2 % | 0.27 V |
| ✅ | `238` | 239.2 | 239.7 | 0.996 | 0.998 | 0.2 % | 0.28 V |
| ✅ | `152` | 239.3 | 239.7 | 0.996 | 0.998 | 0.2 % | 0.26 V |
| ✅ | `158` | 239.3 | 239.7 | 0.996 | 0.998 | 0.2 % | 0.46 V |
| ✅ | `95` | 239.3 | 239.7 | 0.996 | 0.998 | 0.2 % | 0.26 V |
| ✅ | `91` | 239.3 | 239.7 | 0.996 | 0.998 | 0.2 % | 0.26 V |
| ✅ | `135` | 239.3 | 239.7 | 0.996 | 0.998 | 0.2 % | 0.29 V |
| ✅ | `87` | 239.3 | 239.7 | 0.996 | 0.998 | 0.2 % | 0.25 V |
| ✅ | `126` | 239.3 | 239.6 | 0.997 | 0.998 | 0.1 % | 0.1 V |
| ✅ | `83` | 239.3 | 239.7 | 0.997 | 0.998 | 0.2 % | 0.25 V |
| ✅ | `80` | 239.4 | 239.7 | 0.997 | 0.998 | 0.2 % | 0.25 V |
| ✅ | `178` | 239.4 | 239.8 | 0.997 | 0.998 | 0.2 % | 0.29 V |
| ✅ | `184` | 239.4 | 239.8 | 0.997 | 0.998 | 0.2 % | 0.48 V |
| ✅ | `163` | 239.4 | 239.8 | 0.997 | 0.998 | 0.2 % | 0.26 V |
| ✅ | `133` | 239.4 | 239.8 | 0.997 | 0.998 | 0.2 % | 0.28 V |
| ✅ | `124` | 239.4 | 239.8 | 0.997 | 0.998 | 0.2 % | 0.27 V |
| ✅ | `107` | 239.4 | 239.8 | 0.997 | 0.998 | 0.2 % | 0.26 V |
| ✅ | `77` | 239.4 | 239.8 | 0.997 | 0.998 | 0.2 % | 0.25 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |
| W | `grid` | `2` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |
| W | `grid` | `3` | pg | -41.736 kW | [-41.736 kW, 41.736 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 272.88 W (>1 % of load). pg=20.97 kW, pd=20.87 kW, p_loss=0.37 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-41.736 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-41.736 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-41.736 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 272.88 W (>1 % of load). pg=20.97 kW, pd=20.87 kW, p_loss=0.37 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.49 V at bus '623' — reflects the neutral shift under unbalanced loading.

