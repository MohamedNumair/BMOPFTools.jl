# BMOPF Solution Profile: network_7_Feeder_6

**Generated:** 2026-06-22 15:17:43  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -120.6772  
**Solve time:** 0.066 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 21.243 kW |
| Total load | 21.114 kW |
| Total line losses | 343.63 W |
| Loss fraction | 1.6% |
| Power balance error | 214.37 W |
| Max neutral shift | 1.216 V (bus `194`) |

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
| ✅ | `100` | 230.0 V | 28 | 1.038 (`194`) | 1.044 (`sourcebus`) | 0.5 % (`194`) | 1.22 V (`194`) |

### Per-bus detail

**Zone `100`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `182` | 239.2 | 239.8 | 1.04 | 1.043 | 0.2 % | 0.65 V |
| ✅ | `78` | 239.5 | 239.8 | 1.041 | 1.043 | 0.1 % | 0.34 V |
| ✅ | `186` | 238.7 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.17 V |
| ✅ | `195` | 238.7 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.17 V |
| ✅ | `191` | 238.7 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.17 V |
| ✅ | `198` | 238.7 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.18 V |
| ✅ | `192` | 238.7 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.18 V |
| ✅ | `193` | 238.7 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.18 V |
| ✅ | `196` | 238.7 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.18 V |
| ✅ | `190` | 238.7 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.19 V |
| ✅ | `197` | 238.7 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.19 V |
| ✅ | `194` | 238.6 | 239.8 | 1.038 | 1.043 | 0.5 % | 1.22 V |
| ✅ | `113` | 239.5 | 239.8 | 1.041 | 1.042 | 0.1 % | 0.39 V |
| ✅ | `107` | 239.5 | 239.8 | 1.041 | 1.042 | 0.1 % | 0.39 V |
| ✅ | `108` | 239.5 | 239.8 | 1.041 | 1.042 | 0.1 % | 0.4 V |
| ✅ | `96` | 239.5 | 239.8 | 1.041 | 1.042 | 0.1 % | 0.37 V |
| ✅ | `102` | 239.5 | 239.8 | 1.041 | 1.042 | 0.1 % | 0.34 V |
| ✅ | `99` | 239.5 | 239.8 | 1.041 | 1.042 | 0.1 % | 0.33 V |
| ✅ | `93` | 239.5 | 239.8 | 1.041 | 1.042 | 0.1 % | 0.33 V |
| ✅ | `103` | 239.5 | 239.8 | 1.041 | 1.042 | 0.1 % | 0.35 V |
| ✅ | `97` | 239.5 | 239.8 | 1.041 | 1.042 | 0.1 % | 0.35 V |
| ✅ | `100` | 239.4 | 239.8 | 1.041 | 1.042 | 0.1 % | 0.41 V |
| ✅ | `146` | 239.5 | 239.7 | 1.041 | 1.042 | 0.1 % | 0.39 V |
| ✅ | `153` | 239.5 | 239.7 | 1.041 | 1.042 | 0.1 % | 0.48 V |
| ✅ | `152` | 239.5 | 239.7 | 1.041 | 1.042 | 0.1 % | 0.37 V |
| ✅ | `98` | 239.5 | 239.7 | 1.041 | 1.042 | 0.1 % | 0.22 V |
| ✅ | `101` | 239.5 | 239.7 | 1.041 | 1.042 | 0.1 % | 0.18 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -42.228 kW | [-42.228 kW, 42.228 kW] |
| W | `grid` | `2` | pg | -42.228 kW | [-42.228 kW, 42.228 kW] |
| W | `grid` | `3` | pg | -42.228 kW | [-42.228 kW, 42.228 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 214.37 W (>1 % of load). pg=21.24 kW, pd=21.11 kW, p_loss=0.34 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-42.228 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-42.228 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-42.228 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 214.37 W (>1 % of load). pg=21.24 kW, pd=21.11 kW, p_loss=0.34 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.22 V at bus '194' — reflects the neutral shift under unbalanced loading.

