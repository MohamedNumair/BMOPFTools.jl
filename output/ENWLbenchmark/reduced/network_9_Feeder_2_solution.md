# BMOPF Solution Profile: network_9_Feeder_2

**Generated:** 2026-06-21 16:44:09  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -110.3514  
**Solve time:** 0.047 s  
**Findings:** 3 errors · 1 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -119.412 kW |
| Total load | 19.902 kW |
| Total line losses | 108.88 W |
| Loss fraction | 0.5% |
| Power balance error | 139.423 kW |
| Max neutral shift | 0.226 V (bus `96`) |

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
| ✅ | `100` | 240.0 V | 24 | 0.999 (`96`) | 1.0 (`sourcebus`) | 0.1 % (`96`) | 0.23 V (`96`) |

### Per-bus detail

**Zone `100`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `96` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.23 V |
| ✅ | `93` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.22 V |
| ✅ | `97` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.2 V |
| ✅ | `109` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.2 V |
| ✅ | `91` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.2 V |
| ✅ | `105` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.18 V |
| ✅ | `94` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.17 V |
| ✅ | `100` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.17 V |
| ✅ | `103` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.17 V |
| ✅ | `106` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.16 V |
| ✅ | `111` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.17 V |
| ✅ | `102` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.17 V |
| ✅ | `108` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.17 V |
| ✅ | `99` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.17 V |
| ✅ | `90` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.16 V |
| ✅ | `110` | 239.9 | 240.1 | 0.999 | 0.999 | 0.1 % | 0.16 V |
| ✅ | `107` | 239.9 | 240.1 | 0.999 | 0.999 | 0.1 % | 0.16 V |
| ✅ | `98` | 239.9 | 240.1 | 0.999 | 0.999 | 0.1 % | 0.16 V |
| ✅ | `101` | 239.9 | 240.1 | 0.999 | 0.999 | 0.1 % | 0.16 V |
| ✅ | `95` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.13 V |
| ✅ | `104` | 239.9 | 240.0 | 0.999 | 0.999 | 0.0 % | 0.11 V |
| ✅ | `92` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.18 V |
| ✅ | `89` | 239.9 | 240.1 | 0.999 | 1.0 | 0.1 % | 0.16 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| **E** | `grid` | `1` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |
| **E** | `grid` | `2` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |
| **E** | `grid` | `3` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 139.423 kW (>1 % of load). pg=-119.41 kW, pd=19.9 kW, p_loss=0.11 kW.

## 6. All Findings

- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '1': pg=-39.804 kW violates [-39.804 kW, 39.804 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '2': pg=-39.804 kW violates [-39.804 kW, 39.804 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '3': pg=-39.804 kW violates [-39.804 kW, 39.804 kW].
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 139.423 kW (>1 % of load). pg=-119.41 kW, pd=19.9 kW, p_loss=0.11 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 3 violation(s), 0 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 3V / 0A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.23 V at bus '96' — reflects the neutral shift under unbalanced loading.

