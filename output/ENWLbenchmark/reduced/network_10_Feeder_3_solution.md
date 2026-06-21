# BMOPF Solution Profile: network_10_Feeder_3

**Generated:** 2026-06-21 16:42:39  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -96.9621  
**Solve time:** 0.031 s  
**Findings:** 3 errors · 1 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -99.792 kW |
| Total load | 16.632 kW |
| Total line losses | 198.34 W |
| Loss fraction | 1.2% |
| Power balance error | 116.622 kW |
| Max neutral shift | 0.477 V (bus `343`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 3 | 0 |

## 2. Voltage by Galvanic Zone

Per-unit magnitudes are relative to each zone's own voltage base; volts are not comparable across transformer boundaries.

| St | Zone | V base | Buses | Vm min (pu) | Vm max (pu) | Max imbalance | Max neutral shift |
|:--:|------|-------:|------:|------------:|------------:|--------------:|------------------:|
| ✅ | `285` | 240.0 V | 38 | 0.995 (`343`) | 1.0 (`sourcebus`) | 0.3 % (`343`) | 0.48 V (`343`) |

### Per-bus detail

**Zone `285`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `343` | 239.0 | 239.6 | 0.995 | 0.998 | 0.3 % | 0.48 V |
| ✅ | `349` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.41 V |
| ✅ | `401` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.31 V |
| ✅ | `391` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.33 V |
| ✅ | `396` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.31 V |
| ✅ | `392` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.31 V |
| ✅ | `397` | 239.0 | 239.4 | 0.995 | 0.997 | 0.2 % | 0.25 V |
| ✅ | `395` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.3 V |
| ✅ | `389` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.32 V |
| ✅ | `387` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.33 V |
| ✅ | `390` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.34 V |
| ✅ | `393` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.36 V |
| ✅ | `363` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.36 V |
| ✅ | `342` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.37 V |
| ✅ | `360` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.34 V |
| ✅ | `365` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.34 V |
| ✅ | `368` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.34 V |
| ✅ | `358` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.35 V |
| ✅ | `364` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.35 V |
| ✅ | `359` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.35 V |
| ✅ | `354` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.35 V |
| ✅ | `353` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.35 V |
| ✅ | `347` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.35 V |
| ✅ | `357` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.34 V |
| ✅ | `340` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.35 V |
| ✅ | `346` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.35 V |
| ✅ | `348` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.34 V |
| ✅ | `336` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.36 V |
| ✅ | `341` | 239.0 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.36 V |
| ✅ | `338` | 239.1 | 239.6 | 0.995 | 0.998 | 0.2 % | 0.38 V |
| ✅ | `333` | 239.1 | 239.6 | 0.995 | 0.997 | 0.2 % | 0.36 V |
| ✅ | `335` | 239.1 | 239.6 | 0.995 | 0.997 | 0.2 % | 0.35 V |
| ✅ | `334` | 239.1 | 239.6 | 0.995 | 0.998 | 0.2 % | 0.37 V |
| ✅ | `337` | 239.1 | 239.6 | 0.995 | 0.998 | 0.2 % | 0.36 V |
| ✅ | `331` | 239.1 | 239.6 | 0.995 | 0.998 | 0.2 % | 0.36 V |
| ✅ | `292` | 239.2 | 239.6 | 0.996 | 0.998 | 0.2 % | 0.33 V |
| ✅ | `285` | 239.2 | 239.6 | 0.996 | 0.998 | 0.2 % | 0.33 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| **E** | `grid` | `1` | pg | -33.264 kW | [-33.264 kW, 33.264 kW] |
| **E** | `grid` | `2` | pg | -33.264 kW | [-33.264 kW, 33.264 kW] |
| **E** | `grid` | `3` | pg | -33.264 kW | [-33.264 kW, 33.264 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 116.622 kW (>1 % of load). pg=-99.79 kW, pd=16.63 kW, p_loss=0.2 kW.

## 6. All Findings

- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '1': pg=-33.264 kW violates [-33.264 kW, 33.264 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '2': pg=-33.264 kW violates [-33.264 kW, 33.264 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '3': pg=-33.264 kW violates [-33.264 kW, 33.264 kW].
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 116.622 kW (>1 % of load). pg=-99.79 kW, pd=16.63 kW, p_loss=0.2 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 3 violation(s), 0 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 3V / 0A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.48 V at bus '343' — reflects the neutral shift under unbalanced loading.

