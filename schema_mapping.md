# BMOPF ↔ PMD ENGINEERING Model Field Mapping

This document records the authoritative field mapping between the BMOPF
JSON schema and the PowerModelsDistribution (PMD) ENGINEERING data model.

## Key conventions

| Concern | BMOPF | PMD ENGINEERING |
|---------|-------|-----------------|
| Terminal names | Strings (`"1"`,`"2"`,`"3"`,`"n"`) | Integers (`1,2,3,4`) |
| Neutral terminal | `"n"` | `4` |
| Voltage units | SI (V) | Scaled by `voltage_scale_factor` (default kV → set to 1.0 for SI) |
| Power units | SI (W, var) | Scaled by `power_scale_factor` |
| Voltage angle | Radians | Degrees |
| Switch state | `open_switch::Bool` | `state` (0=OPEN, 1=CLOSED) — inverted |
| Configuration enum | String `"WYE"/"DELTA"/"SINGLE_PHASE"` | PMD `ConnConfig` Enum |
| Time series | Same reference-based convention as PMD | Root-level `"time_series"` dict |
| Extra PMD fields | Stored under `"_pmd"` sub-dict per component | n/a |

## Component mappings

### bus
| BMOPF | PMD | Notes |
|-------|-----|-------|
| `terminal_names` | `terminals` | String → Int mapping |
| `perfectly_grounded_terminals` | `grounded` + `rg=0` + `xg=0` | Perfect ground = zero impedance |
| `v_min` (V) | `vm_lb` (p.u.) | Needs voltage base |
| `v_max` (V) | `vm_ub` (p.u.) | Needs voltage base |
| `vpn_min/max`, `vpp_min/max`, `vsym_min/max` | *(no equivalent)* | BMOPF-only constraints |

### line
| BMOPF | PMD | Notes |
|-------|-----|-------|
| `bus_from` | `f_bus` | Direct |
| `bus_to` | `t_bus` | Direct |
| `terminal_map_from` | `f_connections` | String → Int |
| `terminal_map_to` | `t_connections` | String → Int |
| `linecode` | `linecode` | Direct string ref |
| `length` (m) | `length` | Unit convention: PMD often uses km; BMOPF uses m |

### linecode
| BMOPF | PMD | Notes |
|-------|-----|-------|
| `R_series{ij}` (Ω/m) | `rs` matrix (Ω/m) | Flat keys → matrix |
| `X_series{ij}` (Ω/m) | `xs` matrix | |
| `G_from{ij}` (S/m) | `g_fr` matrix | |
| `G_to{ij}` (S/m) | `g_to` matrix | |
| `B_from{ij}` (S/m) | `b_fr` matrix | |
| `B_to{ij}` (S/m) | `b_to` matrix | |
| `i_max` | `cm_ub` | |
| `s_max` | `sm_ub` | |

### voltage_source
| BMOPF | PMD | Notes |
|-------|-----|-------|
| `bus` | `bus` | Direct |
| `terminal_map` | `connections` | String → Int |
| `v_magnitude` (V) | `vm` (p.u. or kV) | Scale by voltage base |
| `v_angle` (rad) | `va` (degrees) | × 180/π |

### load
| BMOPF | PMD | Notes |
|-------|-----|-------|
| `bus` | `bus` | Direct |
| `terminal_map` | `connections` | String → Int |
| `configuration` | `configuration` | String → ConnConfig Enum |
| `p_nom` (W) | `pd_nom` | Scale by `power_scale_factor` |
| `q_nom` (var) | `qd_nom` | Scale by `power_scale_factor` |

### generator
| BMOPF | PMD | Notes |
|-------|-----|-------|
| `bus` | `bus` | Direct |
| `terminal_map` | `connections` | String → Int |
| `configuration` | `configuration` | String → ConnConfig Enum |
| `p_min/p_max` | `pg_lb/pg_ub` | Scale by power factor |
| `q_min/q_max` | `qg_lb/qg_ub` | Scale by power factor |
| `cost` ($/kWh) | *(MATHEMATICAL model only)* | Not in ENGINEERING model |

### shunt
| BMOPF | PMD | Notes |
|-------|-----|-------|
| `bus` | `bus` | Direct |
| `terminal_map` | `connections` | String → Int |
| `G{ij}` (S) | `gs` matrix | Flat keys → matrix |
| `B{ij}` (S) | `bs` matrix | Flat keys → matrix |

### switch
| BMOPF | PMD | Notes |
|-------|-----|-------|
| `bus_from` | `f_bus` | Direct |
| `bus_to` | `t_bus` | Direct |
| `open_switch` (bool) | `state` (0/1) | Inverted: `true` → `0` |
| `terminal_map_from/to` | `f_connections/t_connections` | String → Int |
| `i_max` | `cm_ub` | Direct |

### transformer
| BMOPF subtype | PMD `configuration` | Notes |
|---------------|---------------------|-------|
| `single_phase` | `["WYE","WYE"]`, nwinding=2 | |
| `center_tap` | `["WYE","WYE","WYE"]`, nwinding=3 | |
| `wye_delta` | `["WYE","DELTA"]` | Series Z on wye side |
| `delta_wye` | `["DELTA","WYE"]` | Series Z on wye side |

| BMOPF | PMD | Notes |
|-------|-----|-------|
| `bus_from/bus_to` | `bus` (array) | PMD uses a vector |
| `terminal_map_from/to` | `connections` (array of arrays) | |
| `v_ref_from/to` (V) | `vm_nom` (array, kV) | Unit conversion |
| `s_rating` (VA) | `sm_nom` (array, kVA/MVA) | Per winding |
| `r_series_from/to` (Ω) | `rw` (p.u.) | Needs per-unit conversion via s_rating, v_ref |
| `x_series_from/to` (Ω) | `xsc` (p.u.) | Short-circuit reactance between winding pairs |
