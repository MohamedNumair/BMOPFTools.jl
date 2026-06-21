# BMOPF Solution Profile: network_23_Feeder_3

**Generated:** 2026-06-21 16:43:35  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -6.3657  
**Solve time:** 0.007 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -13.644 kW |
| Total load | 2.274 kW |
| Total line losses | 8.72 W |
| Loss fraction | 0.4% |
| Power balance error | 15.927 kW |
| Max neutral shift | 0.251 V (bus `57`) |

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
| ✅ | `36` | 240.0 V | 5 | 0.999 (`57`) | 1.0 (`57`) | 0.1 % (`57`) | 0.25 V (`57`) |

### Per-bus detail

**Zone `36`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `57` | 239.9 | 240.2 | 0.999 | 1.0 | 0.1 % | 0.25 V |
| ✅ | `58` | 240.1 | 240.2 | 1.0 | 1.0 | 0.0 % | 0.03 V |
| ✅ | `56` | 240.1 | 240.2 | 1.0 | 1.0 | 0.0 % | 0.05 V |
| ✅ | `36` | 240.1 | 240.2 | 1.0 | 1.0 | 0.0 % | 0.03 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -4.548 kW | [-4.548 kW, 4.548 kW] |
| W | `grid` | `2` | pg | -4.548 kW | [-4.548 kW, 4.548 kW] |
| W | `grid` | `3` | pg | -4.548 kW | [-4.548 kW, 4.548 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 15.927 kW (>1 % of load). pg=-13.64 kW, pd=2.27 kW, p_loss=0.01 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-4.548 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-4.548 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-4.548 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 15.927 kW (>1 % of load). pg=-13.64 kW, pd=2.27 kW, p_loss=0.01 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.25 V at bus '57' — reflects the neutral shift under unbalanced loading.

