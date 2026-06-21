# BMOPF Solution Profile: network_7_Feeder_6

**Generated:** 2026-06-21 16:44:08  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -120.6772  
**Solve time:** 0.117 s  
**Findings:** 3 errors · 1 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -126.684 kW |
| Total load | 21.114 kW |
| Total line losses | 278.8 W |
| Loss fraction | 1.3% |
| Power balance error | 148.077 kW |
| Max neutral shift | 1.025 V (bus `194`) |

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
| ✅ | `100` | 240.0 V | 28 | 0.994 (`194`) | 1.0 (`sourcebus`) | 0.4 % (`194`) | 1.03 V (`194`) |

### Per-bus detail

**Zone `100`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `194` | 238.8 | 239.8 | 0.994 | 0.999 | 0.4 % | 1.03 V |
| ✅ | `197` | 238.8 | 239.8 | 0.994 | 0.999 | 0.4 % | 1.0 V |
| ✅ | `190` | 238.8 | 239.8 | 0.994 | 0.999 | 0.4 % | 1.0 V |
| ✅ | `196` | 238.8 | 239.8 | 0.994 | 0.999 | 0.4 % | 0.99 V |
| ✅ | `193` | 238.8 | 239.8 | 0.994 | 0.999 | 0.4 % | 0.99 V |
| ✅ | `192` | 238.8 | 239.8 | 0.994 | 0.999 | 0.4 % | 0.99 V |
| ✅ | `198` | 238.8 | 239.8 | 0.994 | 0.999 | 0.4 % | 0.99 V |
| ✅ | `191` | 238.8 | 239.8 | 0.994 | 0.999 | 0.4 % | 0.99 V |
| ✅ | `195` | 238.8 | 239.8 | 0.994 | 0.999 | 0.4 % | 1.0 V |
| ✅ | `186` | 238.8 | 239.8 | 0.994 | 0.999 | 0.4 % | 0.98 V |
| ✅ | `182` | 239.4 | 239.8 | 0.997 | 0.999 | 0.2 % | 0.49 V |
| ✅ | `113` | 239.6 | 239.8 | 0.998 | 0.999 | 0.1 % | 0.3 V |
| ✅ | `100` | 239.6 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.3 V |
| ✅ | `107` | 239.6 | 239.8 | 0.998 | 0.999 | 0.1 % | 0.29 V |
| ✅ | `108` | 239.6 | 239.8 | 0.998 | 0.999 | 0.1 % | 0.24 V |
| ✅ | `97` | 239.6 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.18 V |
| ✅ | `96` | 239.6 | 239.8 | 0.998 | 0.999 | 0.1 % | 0.25 V |
| ✅ | `103` | 239.6 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.21 V |
| ✅ | `101` | 239.6 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.04 V |
| ✅ | `98` | 239.7 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.04 V |
| ✅ | `93` | 239.7 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.2 V |
| ✅ | `152` | 239.7 | 239.8 | 0.998 | 0.998 | 0.0 % | 0.19 V |
| ✅ | `99` | 239.7 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.21 V |
| ✅ | `146` | 239.7 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.21 V |
| ✅ | `153` | 239.7 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.24 V |
| ✅ | `102` | 239.7 | 239.8 | 0.998 | 0.999 | 0.1 % | 0.29 V |
| ✅ | `78` | 239.7 | 239.8 | 0.998 | 0.999 | 0.1 % | 0.21 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| **E** | `grid` | `1` | pg | -42.228 kW | [-42.228 kW, 42.228 kW] |
| **E** | `grid` | `2` | pg | -42.228 kW | [-42.228 kW, 42.228 kW] |
| **E** | `grid` | `3` | pg | -42.228 kW | [-42.228 kW, 42.228 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 148.077 kW (>1 % of load). pg=-126.68 kW, pd=21.11 kW, p_loss=0.28 kW.

## 6. All Findings

- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '1': pg=-42.228 kW violates [-42.228 kW, 42.228 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '2': pg=-42.228 kW violates [-42.228 kW, 42.228 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '3': pg=-42.228 kW violates [-42.228 kW, 42.228 kW].
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 148.077 kW (>1 % of load). pg=-126.68 kW, pd=21.11 kW, p_loss=0.28 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 3 violation(s), 0 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 3V / 0A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 1.03 V at bus '194' — reflects the neutral shift under unbalanced loading.

