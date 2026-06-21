# BMOPF Solution Profile: network_5_Feeder_7

**Generated:** 2026-06-21 16:43:59  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -103.9247  
**Solve time:** 0.044 s  
**Findings:** 0 errors · 4 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | -126.684 kW |
| Total load | 21.114 kW |
| Total line losses | 167.52 W |
| Loss fraction | 0.8% |
| Power balance error | 147.966 kW |
| Max neutral shift | 0.341 V (bus `79`) |

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
| ✅ | `103` | 240.0 V | 47 | 0.996 (`309`) | 1.0 (`sourcebus`) | 0.2 % (`79`) | 0.34 V (`79`) |

### Per-bus detail

**Zone `103`** (base 240.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `309` | 239.2 | 239.5 | 0.996 | 0.997 | 0.1 % | 0.25 V |
| ✅ | `287` | 239.3 | 239.5 | 0.996 | 0.997 | 0.1 % | 0.29 V |
| ✅ | `79` | 239.3 | 239.7 | 0.996 | 0.998 | 0.2 % | 0.34 V |
| ✅ | `304` | 239.3 | 239.5 | 0.996 | 0.997 | 0.1 % | 0.2 V |
| ✅ | `307` | 239.3 | 239.5 | 0.996 | 0.997 | 0.1 % | 0.2 V |
| ✅ | `313` | 239.3 | 239.5 | 0.996 | 0.997 | 0.1 % | 0.19 V |
| ✅ | `275` | 239.3 | 239.5 | 0.996 | 0.997 | 0.1 % | 0.2 V |
| ✅ | `303` | 239.3 | 239.4 | 0.996 | 0.997 | 0.1 % | 0.19 V |
| ✅ | `298` | 239.3 | 239.5 | 0.996 | 0.997 | 0.1 % | 0.19 V |
| ✅ | `243` | 239.3 | 239.5 | 0.996 | 0.997 | 0.1 % | 0.13 V |
| ✅ | `292` | 239.3 | 239.5 | 0.996 | 0.997 | 0.1 % | 0.18 V |
| ✅ | `297` | 239.3 | 239.5 | 0.996 | 0.997 | 0.1 % | 0.17 V |
| ✅ | `268` | 239.3 | 239.5 | 0.996 | 0.997 | 0.1 % | 0.18 V |
| ✅ | `267` | 239.3 | 239.5 | 0.996 | 0.997 | 0.1 % | 0.17 V |
| ✅ | `260` | 239.3 | 239.5 | 0.996 | 0.997 | 0.1 % | 0.17 V |
| ✅ | `234` | 239.3 | 239.5 | 0.996 | 0.997 | 0.1 % | 0.17 V |
| ✅ | `221` | 239.3 | 239.5 | 0.996 | 0.997 | 0.1 % | 0.19 V |
| ✅ | `209` | 239.3 | 239.5 | 0.997 | 0.997 | 0.1 % | 0.17 V |
| ✅ | `214` | 239.4 | 239.5 | 0.997 | 0.997 | 0.0 % | 0.17 V |
| ✅ | `203` | 239.4 | 239.5 | 0.997 | 0.997 | 0.1 % | 0.17 V |
| ✅ | `116` | 239.4 | 239.7 | 0.997 | 0.998 | 0.2 % | 0.24 V |
| ✅ | `230` | 239.4 | 239.4 | 0.997 | 0.997 | 0.0 % | 0.22 V |
| ✅ | `184` | 239.4 | 239.5 | 0.997 | 0.997 | 0.1 % | 0.16 V |
| ✅ | `193` | 239.4 | 239.5 | 0.997 | 0.997 | 0.1 % | 0.14 V |
| ✅ | `174` | 239.4 | 239.5 | 0.997 | 0.997 | 0.1 % | 0.17 V |
| ✅ | `68` | 239.4 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.22 V |
| ✅ | `152` | 239.4 | 239.5 | 0.997 | 0.997 | 0.0 % | 0.15 V |
| ✅ | `135` | 239.5 | 239.6 | 0.997 | 0.997 | 0.0 % | 0.13 V |
| ✅ | `251` | 239.5 | 239.6 | 0.997 | 0.997 | 0.0 % | 0.13 V |
| ✅ | `129` | 239.5 | 239.6 | 0.997 | 0.998 | 0.0 % | 0.12 V |
| ✅ | `123` | 239.5 | 239.6 | 0.997 | 0.998 | 0.0 % | 0.12 V |
| ✅ | `103` | 239.5 | 239.6 | 0.997 | 0.998 | 0.0 % | 0.13 V |
| ✅ | `63` | 239.5 | 239.8 | 0.997 | 0.999 | 0.1 % | 0.31 V |
| ✅ | `95` | 239.5 | 239.6 | 0.997 | 0.998 | 0.0 % | 0.12 V |
| ✅ | `77` | 239.5 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.18 V |
| ✅ | `92` | 239.5 | 239.6 | 0.997 | 0.997 | 0.0 % | 0.12 V |
| ✅ | `84` | 239.5 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.11 V |
| ✅ | `67` | 239.6 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.12 V |
| ✅ | `64` | 239.6 | 239.7 | 0.997 | 0.998 | 0.1 % | 0.12 V |
| ✅ | `69` | 239.6 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.12 V |
| ✅ | `61` | 239.6 | 239.8 | 0.998 | 0.998 | 0.1 % | 0.13 V |
| ✅ | `55` | 239.7 | 239.8 | 0.998 | 0.999 | 0.1 % | 0.13 V |
| ✅ | `57` | 239.7 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.16 V |
| ✅ | `53` | 239.7 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.11 V |
| ✅ | `60` | 239.7 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.09 V |
| ✅ | `52` | 239.8 | 239.9 | 0.998 | 0.999 | 0.1 % | 0.09 V |
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.0 | 1.0 | 0.0 % | — |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -42.228 kW | [-42.228 kW, 42.228 kW] |
| W | `grid` | `2` | pg | -42.228 kW | [-42.228 kW, 42.228 kW] |
| W | `grid` | `3` | pg | -42.228 kW | [-42.228 kW, 42.228 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 147.966 kW (>1 % of load). pg=-126.68 kW, pd=21.11 kW, p_loss=0.17 kW.

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-42.228 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-42.228 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-42.228 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 147.966 kW (>1 % of load). pg=-126.68 kW, pd=21.11 kW, p_loss=0.17 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.34 V at bus '79' — reflects the neutral shift under unbalanced loading.

