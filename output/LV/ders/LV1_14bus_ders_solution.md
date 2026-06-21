# BMOPF Solution Profile: LV1_14bus

**Generated:** 2026-06-22 09:27:00  
**Status:** `LOCALLY_SOLVED`  
**Objective:** 189.8603  
**Solve time:** 0.013 s  
**Findings:** 0 errors · 7 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 20.79 kW |
| Total load | 20.0 kW |
| Total line losses | 75.81 W |
| Loss fraction | 0.4% |
| Power balance error | 714.08 W |
| Max neutral shift | 0.446 V (bus `b2656`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 0 |
| Thermal  | 0 | 0 |
| Generator| 0 | 4 |

## 2. Voltage by Galvanic Zone

Per-unit magnitudes are relative to each zone's own voltage base; volts are not comparable across transformer boundaries.

| St | Zone | V base | Buses | Vm min (pu) | Vm max (pu) | Max imbalance | Max neutral shift |
|:--:|------|-------:|------:|------------:|------------:|--------------:|------------------:|
| ✅ | `b179` | 250.0 V | 6 | 0.998 (`b2656`) | 1.004 (`b3230`) | 0.6 % (`b3230`) | 0.45 V (`b2656`) |
| ✅ | `b2577` | 6.35 kV | 1 | 1.0 (`b2577`) | 1.0 (`b2577`) | 0.0 % | — |

### Per-bus detail

**Zone `b179`** (base 250.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `b3230` | 249.5 | 251.0 | 0.998 | 1.004 | 0.6 % | 0.35 V |
| ✅ | `b2656` | 249.5 | 251.0 | 0.998 | 1.004 | 0.6 % | 0.45 V |
| ✅ | `b232` | 249.5 | 250.9 | 0.998 | 1.004 | 0.6 % | 0.05 V |
| ✅ | `b514` | 249.5 | 250.9 | 0.998 | 1.004 | 0.6 % | 0.05 V |
| ✅ | `b2734` | 249.5 | 250.9 | 0.998 | 1.004 | 0.6 % | 0.05 V |
| ✅ | `b179` | 249.5 | 250.9 | 0.998 | 1.004 | 0.6 % | 0.05 V |

**Zone `b2577`** (base 6.35 kV):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `b2577` | 6350.9 | 6350.9 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_b2656` | `2` | pg | 5.0 kW | [0.0 W, 5.0 kW] |
| W | `der_b2656` | `2` | qg | -2.422 kW | [-2.422 kW, 2.422 kW] |
| W | `der_b3230` | `1` | pg | 5.0 kW | [0.0 W, 5.0 kW] |
| W | `der_b3230` | `1` | qg | -2.422 kW | [-2.422 kW, 2.422 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 714.08 W (>1 % of load). pg=20.79 kW, pd=20.0 kW, p_loss=0.08 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_b2656`  
  Generator 'der_b2656' phase '2': pg=5.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_b2656`  
  Generator 'der_b2656' phase '2': qg=-2.422 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_b3230`  
  Generator 'der_b3230' phase '1': pg=5.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_b3230`  
  Generator 'der_b3230' phase '1': qg=-2.422 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.INV_ACTIVE` — inverter/`pv_b2656`  
  Inverter 'pv_b2656' phase '2': pg=6.8 kW is within 1 % of its P bound.
- **WARN** `W.SOL.INV_ACTIVE` — inverter/`pv_b3230`  
  Inverter 'pv_b3230' phase '1': pg=6.8 kW is within 1 % of its P bound.
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 714.08 W (>1 % of load). pg=20.79 kW, pd=20.0 kW, p_loss=0.08 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 4 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 4A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.45 V at bus 'b2656' — reflects the neutral shift under unbalanced loading.

