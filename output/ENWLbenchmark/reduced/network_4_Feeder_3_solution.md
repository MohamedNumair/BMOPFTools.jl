# BMOPF Solution Profile: network_4_Feeder_3

**Generated:** 2026-06-21 16:43:56  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -76.1266  
**Solve time:** 0.045 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -102.204 kW |
| Total load | 17.034 kW |
| Total line losses | 199.6 W |
| Loss fraction | 1.2% |
| Power balance error | 119.438 kW |
| Max neutral shift | 0.595 V (bus `93`) |

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
| ✅ | `102` | 240.0 V | 39 | 0.994 (`107`) | 1.0 (`sourcebus`) | 0.4 % (`107`) | 0.6 V (`93`) |

### Per-bus detail

**Zone `102`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `107` | 238.7 | 239.7 | 0.994 | 0.998 | 0.4 % | 0.58 V |
| ✅ | `212` | 238.7 | 239.6 | 0.994 | 0.997 | 0.4 % | 0.53 V |
| ✅ | `242` | 238.7 | 239.6 | 0.994 | 0.997 | 0.4 % | 0.47 V |
| ✅ | `239` | 238.7 | 239.6 | 0.994 | 0.997 | 0.4 % | 0.44 V |
| ✅ | `200` | 238.7 | 239.6 | 0.994 | 0.997 | 0.4 % | 0.43 V |
| ✅ | `225` | 238.7 | 239.6 | 0.994 | 0.997 | 0.4 % | 0.43 V |
| ✅ | `234` | 238.7 | 239.6 | 0.994 | 0.997 | 0.3 % | 0.43 V |
| ✅ | `196` | 238.7 | 239.6 | 0.994 | 0.997 | 0.4 % | 0.43 V |
| ✅ | `178` | 238.7 | 239.6 | 0.994 | 0.998 | 0.4 % | 0.36 V |
| ✅ | `194` | 238.7 | 239.6 | 0.994 | 0.997 | 0.3 % | 0.47 V |
| ✅ | `185` | 238.7 | 239.6 | 0.994 | 0.997 | 0.3 % | 0.4 V |
| ✅ | `180` | 238.7 | 239.6 | 0.994 | 0.997 | 0.3 % | 0.4 V |
| ✅ | `183` | 238.7 | 239.6 | 0.994 | 0.997 | 0.3 % | 0.38 V |
| ✅ | `175` | 238.7 | 239.6 | 0.994 | 0.997 | 0.3 % | 0.39 V |
| ✅ | `171` | 238.7 | 239.6 | 0.994 | 0.998 | 0.3 % | 0.36 V |
| ✅ | `130` | 238.8 | 239.6 | 0.994 | 0.998 | 0.3 % | 0.32 V |
| ✅ | `126` | 238.8 | 239.6 | 0.994 | 0.998 | 0.3 % | 0.31 V |
| ✅ | `125` | 238.8 | 239.6 | 0.994 | 0.998 | 0.3 % | 0.33 V |
| ✅ | `121` | 238.8 | 239.6 | 0.994 | 0.998 | 0.3 % | 0.31 V |
| ✅ | `127` | 238.8 | 239.6 | 0.994 | 0.998 | 0.3 % | 0.29 V |
| ✅ | `119` | 238.8 | 239.6 | 0.994 | 0.998 | 0.3 % | 0.32 V |
| ✅ | `120` | 238.8 | 239.7 | 0.994 | 0.998 | 0.3 % | 0.33 V |
| ✅ | `114` | 238.9 | 239.7 | 0.994 | 0.998 | 0.3 % | 0.33 V |
| ✅ | `93` | 238.9 | 239.8 | 0.994 | 0.999 | 0.4 % | 0.6 V |
| ✅ | `105` | 238.9 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.34 V |
| ✅ | `112` | 238.9 | 239.6 | 0.995 | 0.998 | 0.3 % | 0.22 V |
| ✅ | `102` | 238.9 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.38 V |
| ✅ | `99` | 238.9 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.39 V |
| ✅ | `96` | 238.9 | 239.7 | 0.995 | 0.998 | 0.3 % | 0.38 V |
| ✅ | `87` | 239.0 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.39 V |
| ✅ | `95` | 239.0 | 239.8 | 0.995 | 0.998 | 0.3 % | 0.37 V |
| ✅ | `84` | 239.1 | 239.8 | 0.995 | 0.999 | 0.3 % | 0.4 V |
| ✅ | `89` | 239.1 | 239.9 | 0.995 | 0.999 | 0.3 % | 0.49 V |
| ✅ | `82` | 239.2 | 239.9 | 0.996 | 0.999 | 0.3 % | 0.36 V |
| ✅ | `73` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.26 V |
| ✅ | `90` | 239.4 | 239.9 | 0.997 | 0.999 | 0.2 % | 0.1 V |
| ✅ | `67` | 239.5 | 240.0 | 0.997 | 0.999 | 0.2 % | 0.24 V |
| ✅ | `52` | 239.6 | 240.0 | 0.998 | 0.999 | 0.2 % | 0.19 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -34.068 kW | [-34.068 kW, 34.068 kW] |
| W | `grid` | `2` | pg | -34.068 kW | [-34.068 kW, 34.068 kW] |
| W | `grid` | `3` | pg | -34.068 kW | [-34.068 kW, 34.068 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 119.438 kW (>1 % of load). pg=-102.2 kW, pd=17.03 kW, p_loss=0.2 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-34.068 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-34.068 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-34.068 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 119.438 kW (>1 % of load). pg=-102.2 kW, pd=17.03 kW, p_loss=0.2 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.6 V at bus '93' — reflects the neutral shift under unbalanced loading.

