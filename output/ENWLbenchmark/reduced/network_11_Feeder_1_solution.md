# BMOPF Solution Profile: network_11_Feeder_1

**Generated:** 2026-06-21 16:42:39  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -137.2117  
**Solve time:** 0.102 s  
**Findings:** 3 errors · 1 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -150.84 kW |
| Total load | 25.14 kW |
| Total line losses | 183.58 W |
| Loss fraction | 0.7% |
| Power balance error | 176.164 kW |
| Max neutral shift | 0.471 V (bus `141`) |

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
| ✅ | `117` | 240.0 V | 41 | 0.996 (`141`) | 1.0 (`sourcebus`) | 0.3 % (`141`) | 0.47 V (`141`) |

### Per-bus detail

**Zone `117`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `141` | 239.1 | 239.8 | 0.996 | 0.998 | 0.3 % | 0.47 V |
| ✅ | `142` | 239.2 | 239.8 | 0.996 | 0.998 | 0.2 % | 0.34 V |
| ✅ | `214` | 239.3 | 239.7 | 0.996 | 0.998 | 0.2 % | 0.23 V |
| ✅ | `202` | 239.3 | 239.7 | 0.996 | 0.998 | 0.2 % | 0.23 V |
| ✅ | `139` | 239.3 | 239.8 | 0.996 | 0.998 | 0.2 % | 0.27 V |
| ✅ | `138` | 239.3 | 239.8 | 0.996 | 0.998 | 0.2 % | 0.26 V |
| ✅ | `140` | 239.3 | 239.8 | 0.996 | 0.998 | 0.2 % | 0.26 V |
| ✅ | `135` | 239.4 | 239.8 | 0.997 | 0.998 | 0.2 % | 0.24 V |
| ✅ | `132` | 239.4 | 239.8 | 0.997 | 0.998 | 0.2 % | 0.23 V |
| ✅ | `205` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.15 V |
| ✅ | `208` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.14 V |
| ✅ | `211` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.14 V |
| ✅ | `199` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.16 V |
| ✅ | `200` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.11 V |
| ✅ | `203` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.11 V |
| ✅ | `212` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.12 V |
| ✅ | `209` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.12 V |
| ✅ | `206` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.12 V |
| ✅ | `210` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.12 V |
| ✅ | `198` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.13 V |
| ✅ | `204` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.11 V |
| ✅ | `213` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.14 V |
| ✅ | `201` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.14 V |
| ✅ | `207` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.15 V |
| ✅ | `176` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.13 V |
| ✅ | `97` | 239.5 | 239.8 | 0.997 | 0.998 | 0.1 % | 0.11 V |
| ✅ | `126` | 239.5 | 239.8 | 0.997 | 0.998 | 0.1 % | 0.1 V |
| ✅ | `123` | 239.5 | 239.8 | 0.997 | 0.998 | 0.1 % | 0.09 V |
| ✅ | `124` | 239.5 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.17 V |
| ✅ | `120` | 239.5 | 239.8 | 0.997 | 0.998 | 0.1 % | 0.07 V |
| ✅ | `121` | 239.5 | 239.7 | 0.997 | 0.998 | 0.0 % | 0.11 V |
| ✅ | `127` | 239.5 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.04 V |
| ✅ | `117` | 239.5 | 239.8 | 0.997 | 0.998 | 0.1 % | 0.06 V |
| ✅ | `128` | 239.5 | 239.8 | 0.997 | 0.998 | 0.1 % | 0.04 V |
| ✅ | `122` | 239.5 | 239.8 | 0.997 | 0.998 | 0.1 % | 0.04 V |
| ✅ | `125` | 239.5 | 239.8 | 0.997 | 0.998 | 0.1 % | 0.1 V |
| ✅ | `76` | 239.5 | 239.8 | 0.997 | 0.998 | 0.1 % | 0.07 V |
| ✅ | `73` | 239.6 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.06 V |
| ✅ | `85` | 239.6 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.06 V |
| ✅ | `88` | 239.6 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.08 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| **E** | `grid` | `1` | pg | -50.28 kW | [-50.28 kW, 50.28 kW] |
| **E** | `grid` | `2` | pg | -50.28 kW | [-50.28 kW, 50.28 kW] |
| **E** | `grid` | `3` | pg | -50.28 kW | [-50.28 kW, 50.28 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 176.164 kW (>1 % of load). pg=-150.84 kW, pd=25.14 kW, p_loss=0.18 kW.

## 6. All Findings

- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '1': pg=-50.28 kW violates [-50.28 kW, 50.28 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '2': pg=-50.28 kW violates [-50.28 kW, 50.28 kW].
- **ERROR** `E.SOL.GEN_VIOLATION` — generator/`grid`  
  Generator 'grid' phase '3': pg=-50.28 kW violates [-50.28 kW, 50.28 kW].
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 176.164 kW (>1 % of load). pg=-150.84 kW, pd=25.14 kW, p_loss=0.18 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 3 violation(s), 0 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 3V / 0A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.47 V at bus '141' — reflects the neutral shift under unbalanced loading.

