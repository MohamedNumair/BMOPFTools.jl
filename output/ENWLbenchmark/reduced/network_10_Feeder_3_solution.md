# BMOPF Solution Profile: network_10_Feeder_3

**Generated:** 2026-06-22 15:15:39  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -96.9621  
**Solve time:** 0.104 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 16.843 kW |
| Total load | 16.632 kW |
| Total line losses | 480.37 W |
| Loss fraction | 2.9% |
| Power balance error | 269.24 W |
| Max neutral shift | 1.002 V (bus `337`) |

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
| ✅ | `285` | 230.0 V | 38 | 1.036 (`401`) | 1.044 (`sourcebus`) | 0.1 % (`343`) | 1.0 V (`337`) |

### Per-bus detail

**Zone `285`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `285` | 238.5 | 238.7 | 1.037 | 1.038 | 0.1 % | 0.83 V |
| ✅ | `292` | 238.5 | 238.7 | 1.037 | 1.038 | 0.1 % | 0.84 V |
| ✅ | `331` | 238.4 | 238.6 | 1.037 | 1.037 | 0.1 % | 0.89 V |
| ✅ | `334` | 238.4 | 238.6 | 1.037 | 1.037 | 0.1 % | 0.92 V |
| ✅ | `337` | 238.4 | 238.6 | 1.037 | 1.037 | 0.1 % | 1.0 V |
| ✅ | `338` | 238.4 | 238.6 | 1.036 | 1.037 | 0.1 % | 0.93 V |
| ✅ | `343` | 238.3 | 238.6 | 1.036 | 1.037 | 0.1 % | 0.99 V |
| ✅ | `335` | 238.4 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.83 V |
| ✅ | `333` | 238.4 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.87 V |
| ✅ | `336` | 238.4 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.87 V |
| ✅ | `342` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.87 V |
| ✅ | `349` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.9 V |
| ✅ | `341` | 238.4 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.87 V |
| ✅ | `346` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.85 V |
| ✅ | `340` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.86 V |
| ✅ | `348` | 238.4 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.88 V |
| ✅ | `357` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.79 V |
| ✅ | `347` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.86 V |
| ✅ | `353` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.85 V |
| ✅ | `358` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.85 V |
| ✅ | `363` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.86 V |
| ✅ | `364` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.85 V |
| ✅ | `354` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.86 V |
| ✅ | `359` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.86 V |
| ✅ | `368` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.86 V |
| ✅ | `365` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.84 V |
| ✅ | `360` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.85 V |
| ✅ | `387` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.84 V |
| ✅ | `389` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.85 V |
| ✅ | `391` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.85 V |
| ✅ | `395` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.86 V |
| ✅ | `397` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.92 V |
| ✅ | `392` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.85 V |
| ✅ | `396` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.85 V |
| ✅ | `401` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.8 V |
| ✅ | `393` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.82 V |
| ✅ | `390` | 238.3 | 238.5 | 1.036 | 1.037 | 0.1 % | 0.83 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -33.264 kW | [-33.264 kW, 33.264 kW] |
| W | `grid` | `2` | pg | -33.264 kW | [-33.264 kW, 33.264 kW] |
| W | `grid` | `3` | pg | -33.264 kW | [-33.264 kW, 33.264 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 269.24 W (>1 % of load). pg=16.84 kW, pd=16.63 kW, p_loss=0.48 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-33.264 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-33.264 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-33.264 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 269.24 W (>1 % of load). pg=16.84 kW, pd=16.63 kW, p_loss=0.48 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.0 V at bus '337' — reflects the neutral shift under unbalanced loading.

