# BMOPF Solution Profile: LV1_14bus

**Generated:** 2026-06-22 09:28:47  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -19500.0349  
**Solve time:** 0.01 s  
**Findings:** 0 errors · 6 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 20.933 kW |
| Total load | 20.0 kW |
| Total line losses | 29.92 W |
| Loss fraction | 0.1% |
| Power balance error | 903.04 W |
| Max neutral shift | 0.254 V (bus `b2656`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 5 |

## 2. Voltage by Galvanic Zone

Per-unit magnitudes are relative to each zone's own voltage base; volts are not comparable across transformer boundaries.

| St | Zone | V base | Buses | Vm min (pu) | Vm max (pu) | Max imbalance | Max neutral shift |
|:--:|------|-------:|------:|------------:|------------:|--------------:|------------------:|
| ✅ | `b179` | 250.0 V | 6 | 1.0 (`b2656`) | 1.004 (`b2656`) | 0.4 % (`b2656`) | 0.25 V (`b2656`) |
| ✅ | `b2577` | 6.35 kV | 1 | 1.0 (`b2577`) | 1.0 (`b2577`) | 0.0 % | — |

### Per-bus detail

**Zone `b179`** (base 250.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `b2656` | 249.9 | 250.9 | 1.0 | 1.004 | 0.4 % | 0.25 V |
| ✅ | `b514` | 249.9 | 250.8 | 1.0 | 1.003 | 0.4 % | 0.05 V |
| ✅ | `b232` | 249.9 | 250.8 | 1.0 | 1.003 | 0.4 % | 0.05 V |
| ✅ | `b2734` | 249.9 | 250.8 | 1.0 | 1.003 | 0.4 % | 0.05 V |
| ✅ | `b179` | 249.9 | 250.8 | 1.0 | 1.003 | 0.4 % | 0.05 V |
| ✅ | `b3230` | 249.9 | 250.7 | 1.0 | 1.003 | 0.3 % | 0.19 V |

**Zone `b2577`** (base 6.35 kV):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `b2577` | 6350.9 | 6350.9 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_bat` | `1` | pg | 5.0 kW | [0.0 W, 5.0 kW] |
| W | `der_bat` | `2` | pg | 5.0 kW | [0.0 W, 5.0 kW] |
| W | `der_bat` | `3` | pg | 5.0 kW | [0.0 W, 5.0 kW] |
| W | `der_pv_b` | `2` | pg | 6.0 kW | [0.0 W, 6.0 kW] |
| W | `der_pv_a` | `1` | pg | 6.0 kW | [0.0 W, 6.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 903.04 W (>1 % of load). pg=20.93 kW, pd=20.0 kW, p_loss=0.03 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_bat`  
  Generator 'der_bat' phase '1': pg=5.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_bat`  
  Generator 'der_bat' phase '2': pg=5.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_bat`  
  Generator 'der_bat' phase '3': pg=5.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_pv_b`  
  Generator 'der_pv_b' phase '2': pg=6.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_pv_a`  
  Generator 'der_pv_a' phase '1': pg=6.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 903.04 W (>1 % of load). pg=20.93 kW, pd=20.0 kW, p_loss=0.03 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 5 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 5A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.25 V at bus 'b2656' — reflects the neutral shift under unbalanced loading.

