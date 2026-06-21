# BMOPF Solution Profile: network_4_Feeder_2

**Generated:** 2026-06-21 16:43:56  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -96.3277  
**Solve time:** 0.038 s  
**Findings:** 3 errors · 1 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -100.476 kW |
| Total load | 16.746 kW |
| Total line losses | 204.3 W |
| Loss fraction | 1.2% |
| Power balance error | 117.426 kW |
| Max neutral shift | 0.444 V (bus `170`) |

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
| ✅ | `149` | 240.0 V | 35 | 0.994 (`386`) | 1.0 (`sourcebus`) | 0.2 % (`170`) | 0.44 V (`170`) |

### Per-bus detail

**Zone `149`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `386` | 238.6 | 238.9 | 0.994 | 0.995 | 0.1 % | 0.07 V |
| ✅ | `372` | 238.7 | 238.9 | 0.994 | 0.994 | 0.1 % | 0.06 V |
| ✅ | `390` | 238.7 | 238.9 | 0.994 | 0.995 | 0.1 % | 0.08 V |
| ✅ | `384` | 238.7 | 238.9 | 0.994 | 0.995 | 0.1 % | 0.07 V |
| ✅ | `381` | 238.7 | 238.9 | 0.994 | 0.995 | 0.1 % | 0.07 V |
| ✅ | `328` | 238.7 | 239.1 | 0.994 | 0.995 | 0.2 % | 0.34 V |
| ✅ | `379` | 238.7 | 238.9 | 0.994 | 0.995 | 0.1 % | 0.16 V |
| ✅ | `374` | 238.7 | 238.9 | 0.994 | 0.995 | 0.1 % | 0.08 V |
| ✅ | `331` | 238.7 | 239.0 | 0.994 | 0.995 | 0.1 % | 0.19 V |
| ✅ | `370` | 238.7 | 238.9 | 0.994 | 0.994 | 0.1 % | 0.05 V |
| ✅ | `376` | 238.7 | 238.8 | 0.994 | 0.994 | 0.1 % | 0.11 V |
| ✅ | `366` | 238.7 | 238.9 | 0.994 | 0.994 | 0.1 % | 0.04 V |
| ✅ | `365` | 238.7 | 238.9 | 0.994 | 0.994 | 0.1 % | 0.03 V |
| ✅ | `358` | 238.7 | 238.9 | 0.994 | 0.995 | 0.1 % | 0.02 V |
| ✅ | `357` | 238.7 | 238.9 | 0.994 | 0.995 | 0.1 % | 0.06 V |
| ✅ | `350` | 238.7 | 238.9 | 0.994 | 0.995 | 0.1 % | 0.05 V |
| ✅ | `343` | 238.7 | 239.0 | 0.994 | 0.995 | 0.1 % | 0.11 V |
| ✅ | `348` | 238.8 | 238.9 | 0.994 | 0.995 | 0.1 % | 0.05 V |
| ✅ | `340` | 238.8 | 238.9 | 0.994 | 0.995 | 0.1 % | 0.08 V |
| ✅ | `336` | 238.8 | 239.0 | 0.994 | 0.995 | 0.1 % | 0.11 V |
| ✅ | `327` | 238.8 | 239.0 | 0.994 | 0.995 | 0.1 % | 0.15 V |
| ✅ | `325` | 238.8 | 239.1 | 0.994 | 0.995 | 0.1 % | 0.17 V |
| ✅ | `270` | 239.0 | 239.1 | 0.995 | 0.995 | 0.0 % | 0.1 V |
| ✅ | `252` | 239.0 | 239.2 | 0.995 | 0.996 | 0.1 % | 0.15 V |
| ✅ | `263` | 239.0 | 239.2 | 0.995 | 0.996 | 0.1 % | 0.15 V |
| ✅ | `170` | 239.1 | 239.5 | 0.995 | 0.997 | 0.2 % | 0.44 V |
| ✅ | `200` | 239.1 | 239.4 | 0.996 | 0.997 | 0.1 % | 0.2 V |
| ✅ | `158` | 239.3 | 239.5 | 0.996 | 0.997 | 0.1 % | 0.23 V |
| ✅ | `157` | 239.3 | 239.7 | 0.996 | 0.998 | 0.2 % | 0.27 V |
| ✅ | `208` | 239.4 | 239.6 | 0.997 | 0.998 | 0.1 % | 0.21 V |
| ✅ | `154` | 239.4 | 239.6 | 0.997 | 0.998 | 0.1 % | 0.2 V |
| ✅ | `151` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.19 V |
| ✅ | `162` | 239.4 | 239.6 | 0.997 | 0.998 | 0.1 % | 0.17 V |
| ✅ | `149` | 239.5 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.18 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| **E** | `grid` | `1` | pg | -33.492 kW | [-33.492 kW, 33.492 kW] |
| **E** | `grid` | `2` | pg | -33.492 kW | [-33.492 kW, 33.492 kW] |
| **E** | `grid` | `3` | pg | -33.492 kW | [-33.492 kW, 33.492 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 117.426 kW (>1 % of load). pg=-100.48 kW, pd=16.75 kW, p_loss=0.2 kW.

## 6. All Findings

- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '1': pg=-33.492 kW violates [-33.492 kW, 33.492 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '2': pg=-33.492 kW violates [-33.492 kW, 33.492 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '3': pg=-33.492 kW violates [-33.492 kW, 33.492 kW].
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 117.426 kW (>1 % of load). pg=-100.48 kW, pd=16.75 kW, p_loss=0.2 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 3 violation(s), 0 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 3V / 0A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.44 V at bus '170' — reflects the neutral shift under unbalanced loading.

