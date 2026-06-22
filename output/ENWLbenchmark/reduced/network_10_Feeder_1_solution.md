# BMOPF Solution Profile: network_10_Feeder_1

**Generated:** 2026-06-22 15:15:39  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -102.2528  
**Solve time:** 0.066 s  
**Findings:** 0 errors · 3 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 19.948 kW |
| Total load | 19.902 kW |
| Total line losses | 77.87 W |
| Loss fraction | 0.4% |
| Power balance error | 31.57 W |
| Max neutral shift | 0.447 V (bus `246`) |

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
| ✅ | `116` | 230.0 V | 25 | 1.042 (`241`) | 1.044 (`sourcebus`) | 0.2 % (`241`) | 0.45 V (`246`) |

### Per-bus detail

**Zone `116`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `46` | 240.1 | 240.1 | 1.044 | 1.044 | 0.0 % | 0.05 V |
| ✅ | `241` | 239.6 | 240.1 | 1.042 | 1.044 | 0.2 % | 0.41 V |
| ✅ | `244` | 239.9 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.12 V |
| ✅ | `243` | 240.0 | 240.1 | 1.043 | 1.044 | 0.0 % | 0.23 V |
| ✅ | `247` | 239.9 | 240.1 | 1.043 | 1.044 | 0.1 % | 0.12 V |
| ✅ | `235` | 240.0 | 240.1 | 1.043 | 1.044 | 0.0 % | 0.1 V |
| ✅ | `246` | 239.7 | 240.1 | 1.042 | 1.044 | 0.2 % | 0.45 V |
| ✅ | `248` | 240.0 | 240.1 | 1.043 | 1.044 | 0.0 % | 0.07 V |
| ✅ | `125` | 239.8 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.11 V |
| ✅ | `119` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.1 V |
| ✅ | `122` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.12 V |
| ✅ | `128` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.12 V |
| ✅ | `116` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.12 V |
| ✅ | `127` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.14 V |
| ✅ | `130` | 239.9 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.14 V |
| ✅ | `121` | 239.8 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.26 V |
| ✅ | `124` | 239.8 | 240.0 | 1.043 | 1.044 | 0.1 % | 0.26 V |
| ✅ | `126` | 239.9 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.12 V |
| ✅ | `129` | 239.9 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.12 V |
| ✅ | `245` | 240.0 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.04 V |
| ✅ | `120` | 239.9 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.15 V |
| ✅ | `242` | 239.9 | 240.0 | 1.043 | 1.044 | 0.0 % | 0.06 V |
| ✅ | `132` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.14 V |
| ✅ | `123` | 239.9 | 240.0 | 1.043 | 1.043 | 0.0 % | 0.1 V |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `grid` | `1` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |
| W | `grid` | `2` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |
| W | `grid` | `3` | pg | -39.804 kW | [-39.804 kW, 39.804 kW] |

## 6. All Findings

- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-39.804 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-39.804 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-39.804 kW is within 1 % of its bound (active).
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 3 active constraint(s). Voltage: 0V / 0A. Thermal: 0V / 0A. Generator: 0V / 3A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 0.45 V at bus '246' — reflects the neutral shift under unbalanced loading.

