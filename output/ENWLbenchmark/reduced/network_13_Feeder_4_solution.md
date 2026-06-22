# BMOPF Solution Profile: network_13_Feeder_4

**Generated:** 2026-06-22 15:15:55  
**Status:** `LOCALLY_SOLVED`  
**Objective:** -817.8899  
**Solve time:** 0.566 s  
**Findings:** 0 errors · 155 warnings · 2 info  

---

## 1. Solution Summary

| Field | Value |
|-------|-------|
| Status | `LOCALLY_SOLVED` |
| Total generation | 154.978 kW |
| Total load | 147.834 kW |
| Total line losses | 10.974 kW |
| Loss fraction | 7.4% |
| Power balance error | 3.83 kW |
| Max neutral shift | 12.285 V (bus `511`) |

### Bound status

| Category | Violated | Active (≤1 %) |
|----------|:--------:|:-------------:|
| Voltage  | 0 | 120 |
| Thermal  | 0 | 5 |
| Generator| 0 | 29 |

## 2. Voltage by Galvanic Zone

Per-unit magnitudes are relative to each zone's own voltage base; volts are not comparable across transformer boundaries.

| St | Zone | V base | Buses | Vm min (pu) | Vm max (pu) | Max imbalance | Max neutral shift |
|:--:|------|-------:|------:|------------:|------------:|--------------:|------------------:|
| ✅ | `241` | 230.0 V | 178 | 1.002 (`534`) | 1.044 (`sourcebus`) | 3.4 % (`534`) | 12.28 V (`511`) |

### Per-bus detail

**Zone `241`** (base 230.0 V):

| St | Bus | Vm min (V) | Vm max (V) | Vm min (pu) | Vm max (pu) | Imbalance | Neutral |
|:--:|-----|-----------:|-----------:|------------:|------------:|----------:|--------:|
| ✅ | `sourcebus` | 240.2 | 240.2 | 1.044 | 1.044 | 0.0 % | — |
| ✅ | `87` | 239.6 | 240.2 | 1.042 | 1.044 | 0.2 % | 1.32 V |
| ✅ | `54` | 239.8 | 240.1 | 1.043 | 1.044 | 0.1 % | 1.03 V |
| ✅ | `241` | 238.4 | 240.0 | 1.036 | 1.044 | 0.7 % | 4.72 V |
| ✅ | `307` | 237.8 | 239.4 | 1.034 | 1.041 | 0.7 % | 6.25 V |
| ✅ | `497` | 236.7 | 238.6 | 1.029 | 1.037 | 0.8 % | 11.35 V |
| ✅ | `511` | 236.3 | 238.6 | 1.027 | 1.037 | 1.0 % | 12.28 V |
| ✅ | `509` | 237.1 | 238.6 | 1.031 | 1.037 | 0.6 % | 8.96 V |
| ✅ | `513` | 237.1 | 238.6 | 1.031 | 1.037 | 0.6 % | 10.66 V |
| ✅ | `512` | 237.1 | 238.5 | 1.031 | 1.037 | 0.6 % | 8.49 V |
| ✅ | `494` | 237.1 | 238.5 | 1.031 | 1.037 | 0.6 % | 8.18 V |
| ✅ | `515` | 237.1 | 238.5 | 1.031 | 1.037 | 0.6 % | 8.17 V |
| ✅ | `518` | 237.1 | 238.5 | 1.031 | 1.037 | 0.6 % | 8.16 V |
| ✅ | `500` | 237.1 | 238.5 | 1.031 | 1.037 | 0.6 % | 8.16 V |
| ✅ | `503` | 237.1 | 238.5 | 1.031 | 1.037 | 0.6 % | 8.15 V |
| ✅ | `484` | 237.1 | 238.5 | 1.031 | 1.037 | 0.6 % | 8.03 V |
| ✅ | `517` | 237.0 | 238.5 | 1.03 | 1.037 | 0.7 % | 7.98 V |
| ✅ | `499` | 237.0 | 238.5 | 1.03 | 1.037 | 0.7 % | 7.98 V |
| ✅ | `508` | 237.0 | 238.5 | 1.03 | 1.037 | 0.7 % | 7.98 V |
| ✅ | `502` | 237.0 | 238.5 | 1.03 | 1.037 | 0.7 % | 7.97 V |
| ✅ | `505` | 236.7 | 238.5 | 1.029 | 1.037 | 0.8 % | 7.89 V |
| ✅ | `514` | 236.2 | 238.5 | 1.027 | 1.037 | 1.0 % | 7.73 V |
| ✅ | `493` | 235.8 | 238.5 | 1.025 | 1.037 | 1.2 % | 7.61 V |
| ✅ | `501` | 237.1 | 238.5 | 1.031 | 1.037 | 0.6 % | 10.65 V |
| ✅ | `496` | 235.7 | 238.5 | 1.025 | 1.037 | 1.2 % | 7.6 V |
| ✅ | `519` | 237.1 | 238.5 | 1.031 | 1.037 | 0.6 % | 10.64 V |
| ✅ | `506` | 237.2 | 238.5 | 1.031 | 1.037 | 0.5 % | 10.85 V |
| ✅ | `510` | 237.1 | 238.4 | 1.031 | 1.037 | 0.6 % | 7.95 V |
| ✅ | `507` | 237.1 | 238.4 | 1.031 | 1.037 | 0.6 % | 7.94 V |
| ✅ | `498` | 237.1 | 238.4 | 1.031 | 1.037 | 0.6 % | 7.94 V |
| ✅ | `516` | 237.1 | 238.4 | 1.031 | 1.036 | 0.6 % | 7.93 V |
| ✅ | `534` | 230.4 | 238.3 | 1.002 | 1.036 | 3.4 % | 8.7 V |
| ✅ | `634` | 230.4 | 238.3 | 1.002 | 1.036 | 3.4 % | 8.7 V |
| ✅ | `570` | 230.5 | 238.3 | 1.002 | 1.036 | 3.4 % | 8.68 V |
| ✅ | `540` | 230.5 | 238.3 | 1.002 | 1.036 | 3.4 % | 8.67 V |
| ✅ | `640` | 230.5 | 238.3 | 1.002 | 1.036 | 3.4 % | 8.67 V |
| ✅ | `619` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.68 V |
| ✅ | `578` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.66 V |
| ✅ | `601` | 230.6 | 238.3 | 1.002 | 1.036 | 3.3 % | 8.65 V |
| ✅ | `598` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.65 V |
| ✅ | `529` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.65 V |
| ✅ | `629` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.65 V |
| ✅ | `576` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.66 V |
| ✅ | `653` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.65 V |
| ✅ | `602` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.64 V |
| ✅ | `621` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.65 V |
| ✅ | `574` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.65 V |
| ✅ | `609` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.64 V |
| ✅ | `607` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.65 V |
| ✅ | `599` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.65 V |
| ✅ | `587` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.64 V |
| ✅ | `596` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.64 V |
| ✅ | `614` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.64 V |
| ✅ | `667` | 230.7 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.65 V |
| ✅ | `539` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.64 V |
| ✅ | `639` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.64 V |
| ✅ | `659` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.64 V |
| ✅ | `557` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.64 V |
| ✅ | `657` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.64 V |
| ✅ | `600` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.64 V |
| ✅ | `558` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.64 V |
| ✅ | `658` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.64 V |
| ✅ | `577` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.64 V |
| ✅ | `617` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `530` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `630` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `648` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `610` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `674` | 230.7 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.64 V |
| ✅ | `550` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `650` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `551` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `553` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `572` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `624` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `586` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `541` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `589` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `546` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `563` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `591` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `646` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `663` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `613` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `644` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `531` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `538` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `545` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `562` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `580` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `594` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `631` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `638` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `645` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `662` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `604` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `561` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `569` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `597` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `552` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `555` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `560` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `566` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `652` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `660` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `666` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `584` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `603` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `620` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `535` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `536` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `549` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `556` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `575` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `588` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `592` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `628` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `635` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `636` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `649` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `656` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `532` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `581` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `626` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `632` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `533` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `564` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `595` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `623` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `633` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `605` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `622` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `554` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `567` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `615` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `625` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `654` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `565` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `608` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `618` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `665` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `568` | 230.7 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.64 V |
| ✅ | `547` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `647` | 230.6 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `543` | 230.7 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `643` | 230.7 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `537` | 230.7 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `637` | 230.7 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `611` | 230.7 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `492` | 230.7 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `573` | 230.7 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.63 V |
| ✅ | `525` | 230.7 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.62 V |
| ✅ | `559` | 230.7 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.61 V |
| ✅ | `585` | 230.7 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.61 V |
| ✅ | `548` | 230.7 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.61 V |
| ✅ | `583` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `651` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `642` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `542` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `627` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `527` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `641` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `616` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `606` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `544` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `582` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `593` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `590` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `661` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `655` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `579` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `528` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `612` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `526` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `664` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `571` | 230.8 | 238.3 | 1.003 | 1.036 | 3.3 % | 8.6 V |
| ✅ | `504` | 237.1 | 238.3 | 1.031 | 1.036 | 0.5 % | 10.42 V |
| ✅ | `495` | 237.1 | 238.3 | 1.031 | 1.036 | 0.5 % | 10.51 V |

## 2. Voltage Bounds

| Sev | Bus | Terminal/Seq | Flavour | Value | Bound |
|-----|-----|-------------|---------|-------|-------|
| W | `650` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `619` | `vneg` | vneg | 4.57 V | [−∞, 4.6] V |
| W | `599` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `630` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `591` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `543` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `557` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `566` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `536` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `576` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `531` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `584` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `605` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `596` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `662` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `659` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `620` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `561` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `666` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `586` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `635` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `631` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `665` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `541` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `530` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `602` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `632` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `594` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `657` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `553` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `552` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `614` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `658` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `644` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `550` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `660` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `533` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `600` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `577` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `598` | `vneg` | vneg | 4.57 V | [−∞, 4.6] V |
| W | `539` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `613` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `643` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `622` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `610` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `633` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `607` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `601` | `vneg` | vneg | 4.57 V | [−∞, 4.6] V |
| W | `634` | `vneg` | vneg | 4.6 V | [−∞, 4.6] V |
| W | `574` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `617` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `556` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `560` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `629` | `vneg` | vneg | 4.57 V | [−∞, 4.6] V |
| W | `565` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `558` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `538` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `546` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `568` | `vneg` | vneg | 4.55 V | [−∞, 4.6] V |
| W | `545` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `547` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `569` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `551` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `618` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `589` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `549` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `564` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `625` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `624` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `578` | `vneg` | vneg | 4.57 V | [−∞, 4.6] V |
| W | `537` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `648` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `674` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `615` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `609` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `640` | `vneg` | vneg | 4.58 V | [−∞, 4.6] V |
| W | `595` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `570` | `vneg` | vneg | 4.59 V | [−∞, 4.6] V |
| W | `645` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `554` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `581` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `623` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `636` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `562` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `638` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `654` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `647` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `652` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `637` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `511` | `vneg` | vneg | 4.6 V | [−∞, 4.6] V |
| W | `492` | `vneg` | vneg | 4.55 V | [−∞, 4.6] V |
| W | `626` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `588` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `555` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `534` | `vneg` | vneg | 4.6 V | [−∞, 4.6] V |
| W | `572` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `663` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `608` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `628` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `646` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `653` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `580` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `575` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `587` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `649` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `567` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `540` | `vneg` | vneg | 4.58 V | [−∞, 4.6] V |
| W | `621` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `604` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `597` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `611` | `vneg` | vneg | 4.55 V | [−∞, 4.6] V |
| W | `532` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `535` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `667` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `529` | `vneg` | vneg | 4.57 V | [−∞, 4.6] V |
| W | `656` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `563` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `603` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `592` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |
| W | `639` | `vneg` | vneg | 4.56 V | [−∞, 4.6] V |

## 3. Thermal Limits

| Sev | Component | ID | Terminal | cm (A) | i\_max (A) |
|-----|-----------|----|---------:|-------:|----------:|
| W | line | `line505` | `1` | 75.0 | 75.0 |
| W | line | `line505` | `n` | 75.0 | 75.0 |
| W | line | `line301` | `2` | 167.0 | 167.0 |
| W | line | `line491` | `2` | 75.0 | 75.0 |
| W | line | `line491` | `n` | 75.0 | 75.0 |

## 4. Generator Dispatch

| Sev | Generator | Terminal | Field | Value | Bound |
|-----|-----------|----------|-------|-------|-------|
| W | `der_571` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_582` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_542` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_593` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_585` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_651` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_583` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_548` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_661` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_627` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `grid` | `1` | pg | -295.668 kW | [-295.668 kW, 295.668 kW] |
| W | `grid` | `2` | pg | -295.668 kW | [-295.668 kW, 295.668 kW] |
| W | `grid` | `3` | pg | -295.668 kW | [-295.668 kW, 295.668 kW] |
| W | `der_664` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_606` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_579` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_573` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_525` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_544` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_526` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_527` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_590` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_642` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_641` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_612` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_559` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_655` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_616` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |
| W | `der_528` | `2` | pg | 4.0 kW | [0.0 W, 4.0 kW] |

## 5. Constraint Residuals

> ⚠ Network power balance error: |pg_total − pd_total − p_loss| = 3.83 kW (>1 % of load). pg=154.98 kW, pd=147.83 kW, p_loss=10.97 kW.

## 6. All Findings

- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`650`  
  Bus '650': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`619`  
  Bus '619': vneg=4.57 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`599`  
  Bus '599': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`630`  
  Bus '630': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`591`  
  Bus '591': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`543`  
  Bus '543': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`557`  
  Bus '557': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`566`  
  Bus '566': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`536`  
  Bus '536': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`576`  
  Bus '576': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`531`  
  Bus '531': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`584`  
  Bus '584': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`605`  
  Bus '605': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`596`  
  Bus '596': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`662`  
  Bus '662': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`659`  
  Bus '659': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`620`  
  Bus '620': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`561`  
  Bus '561': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`666`  
  Bus '666': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`586`  
  Bus '586': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`635`  
  Bus '635': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`631`  
  Bus '631': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`665`  
  Bus '665': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`541`  
  Bus '541': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`530`  
  Bus '530': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`602`  
  Bus '602': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`632`  
  Bus '632': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`594`  
  Bus '594': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`657`  
  Bus '657': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`553`  
  Bus '553': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`552`  
  Bus '552': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`614`  
  Bus '614': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`658`  
  Bus '658': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`644`  
  Bus '644': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`550`  
  Bus '550': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`660`  
  Bus '660': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`533`  
  Bus '533': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`600`  
  Bus '600': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`577`  
  Bus '577': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`598`  
  Bus '598': vneg=4.57 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`539`  
  Bus '539': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`613`  
  Bus '613': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`643`  
  Bus '643': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`622`  
  Bus '622': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`610`  
  Bus '610': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`633`  
  Bus '633': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`607`  
  Bus '607': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`601`  
  Bus '601': vneg=4.57 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`634`  
  Bus '634': vneg=4.6 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`574`  
  Bus '574': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`617`  
  Bus '617': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`556`  
  Bus '556': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`560`  
  Bus '560': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`629`  
  Bus '629': vneg=4.57 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`565`  
  Bus '565': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`558`  
  Bus '558': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`538`  
  Bus '538': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`546`  
  Bus '546': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`568`  
  Bus '568': vneg=4.55 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`545`  
  Bus '545': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`547`  
  Bus '547': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`569`  
  Bus '569': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`551`  
  Bus '551': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`618`  
  Bus '618': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`589`  
  Bus '589': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`549`  
  Bus '549': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`564`  
  Bus '564': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`625`  
  Bus '625': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`624`  
  Bus '624': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`578`  
  Bus '578': vneg=4.57 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`537`  
  Bus '537': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`648`  
  Bus '648': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`674`  
  Bus '674': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`615`  
  Bus '615': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`609`  
  Bus '609': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`640`  
  Bus '640': vneg=4.58 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`595`  
  Bus '595': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`570`  
  Bus '570': vneg=4.59 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`645`  
  Bus '645': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`554`  
  Bus '554': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`581`  
  Bus '581': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`623`  
  Bus '623': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`636`  
  Bus '636': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`562`  
  Bus '562': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`638`  
  Bus '638': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`654`  
  Bus '654': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`647`  
  Bus '647': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`652`  
  Bus '652': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`637`  
  Bus '637': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`511`  
  Bus '511': vneg=4.6 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`492`  
  Bus '492': vneg=4.55 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`626`  
  Bus '626': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`588`  
  Bus '588': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`555`  
  Bus '555': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`534`  
  Bus '534': vneg=4.6 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`572`  
  Bus '572': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`663`  
  Bus '663': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`608`  
  Bus '608': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`628`  
  Bus '628': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`646`  
  Bus '646': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`653`  
  Bus '653': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`580`  
  Bus '580': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`575`  
  Bus '575': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`587`  
  Bus '587': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`649`  
  Bus '649': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`567`  
  Bus '567': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`540`  
  Bus '540': vneg=4.58 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`621`  
  Bus '621': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`604`  
  Bus '604': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`597`  
  Bus '597': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`611`  
  Bus '611': vneg=4.55 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`532`  
  Bus '532': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`535`  
  Bus '535': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`667`  
  Bus '667': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`529`  
  Bus '529': vneg=4.57 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`656`  
  Bus '656': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`563`  
  Bus '563': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`603`  
  Bus '603': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`592`  
  Bus '592': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.VOLT_ACTIVE` — bus/`639`  
  Bus '639': vneg=4.56 V is near its bound (active).
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line505`  
  Line 'line505' conductor '1': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line505`  
  Line 'line505' conductor 'n': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line301`  
  Line 'line301' conductor '2': cm_fr=167.0 A is within 1 % of i_max=167.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line491`  
  Line 'line491' conductor '2': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.THERMAL_ACTIVE` — line/`line491`  
  Line 'line491' conductor 'n': cm_fr=75.0 A is within 1 % of i_max=75.0 A.
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_571`  
  Generator 'der_571' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_582`  
  Generator 'der_582' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_542`  
  Generator 'der_542' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_593`  
  Generator 'der_593' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_585`  
  Generator 'der_585' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_651`  
  Generator 'der_651' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_583`  
  Generator 'der_583' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_548`  
  Generator 'der_548' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_661`  
  Generator 'der_661' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_627`  
  Generator 'der_627' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '1': pg=-295.668 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '2': pg=-295.668 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`grid`  
  Generator 'grid' phase '3': pg=-295.668 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_664`  
  Generator 'der_664' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_606`  
  Generator 'der_606' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_579`  
  Generator 'der_579' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_573`  
  Generator 'der_573' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_525`  
  Generator 'der_525' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_544`  
  Generator 'der_544' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_526`  
  Generator 'der_526' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_527`  
  Generator 'der_527' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_590`  
  Generator 'der_590' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_642`  
  Generator 'der_642' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_641`  
  Generator 'der_641' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_612`  
  Generator 'der_612' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_559`  
  Generator 'der_559' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_655`  
  Generator 'der_655' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_616`  
  Generator 'der_616' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.GEN_ACTIVE` — generator/`der_528`  
  Generator 'der_528' phase '2': pg=4.0 kW is within 1 % of its bound (active).
- **WARN** `W.SOL.POWER_BALANCE`  
  Network power balance error: |pg_total − pd_total − p_loss| = 3.83 kW (>1 % of load). pg=154.98 kW, pd=147.83 kW, p_loss=10.97 kW.
- INFO `I.SOL.BINDING_SUMMARY`  
  Solution bound summary: 0 violation(s), 154 active constraint(s). Voltage: 0V / 120A. Thermal: 0V / 5A. Generator: 0V / 29A.
- INFO `I.SOL.NEUTRAL_SHIFT`  
  Maximum neutral terminal voltage: 12.28 V at bus '511' — reflects the neutral shift under unbalanced loading.

