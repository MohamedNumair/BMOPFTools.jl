# Power-flow comparison tests: BMOPF component models vs OpenDSS reference.
#
# Strategy: for each 2-bus test case the feasibility OPF is run with no
# operational bounds.  When the elastic slack injections are ≈ 0, the solution
# satisfies all KCL/KVL constraints and is therefore a valid power flow.
# The resulting bus-terminal complex voltages are then compared directly with
# those returned by OpenDSS (via OpenDSSDirect.jl) on the same network.
#
# Node-name mapping:
#   OpenDSS "bus.1" / ".2" / ".3" / ".4"  →  BMOPF terminal "1"/"2"/"3"/"n"
#   OpenDSS "bus.0" (earth reference)       →  not a BMOPF terminal (skipped)
#
# Comparison tolerances:
#   · Lines and lossless / lightly-loaded transformers: atol=1.0 V, rtol=1e-3
#   · Three-phase transformers with realistic losses at ≥70% loading:
#       atol=0.1 V, rtol=1e-3
#     At 75% rated load on a 500 kVA / 0.415 kV unit the series drop is ≈10 V
#     on the LV side, so 0.1 V tolerance requires <1% model agreement — any
#     wrong sign, missing factor, or wrong impedance side would produce >1 V error.
#
# Parser note: BMOPF network dicts are constructed directly here (no external
# parser dependency).  When PowerIO.jl is available, replace the hand-crafted
# dicts with `from_dss(path)` calls and delete the inline dicts.

using OpenDSSDirect
using BMOPFTools
using Ipopt

const _PF_CMP_DIR = joinpath(@__DIR__, "data", "pf_comparison")

# ── Helpers ───────────────────────────────────────────────────────────────────

"""
    _ods_volts(dss_path) -> Dict{String, ComplexF64}

Load and solve the DSS file with OpenDSS.  Returns a dict mapping every
non-earth node name (e.g. `"src.1"`, `"lb.4"`) to its complex voltage in V.
"""
function _ods_volts(dss_path::String)::Dict{String,ComplexF64}
    OpenDSSDirect.dss("Clear")
    OpenDSSDirect.dss("Redirect \"$(normpath(dss_path))\"")
    names = Circuit.AllNodeNames()
    volts = Circuit.AllBusVolts()
    return Dict(n => v for (n, v) in zip(names, volts))
end

"""
    _ods_losses_W(dss_path) -> Float64

Load and solve the DSS file; return total circuit losses in watts.
"""
function _ods_losses_W(dss_path::String)::Float64
    OpenDSSDirect.dss("Clear")
    OpenDSSDirect.dss("Redirect \"$(normpath(dss_path))\"")
    return real(Circuit.Losses())
end

"""
    _bmopf_volts(net) -> (Dict{String, ComplexF64}, Float64)

Run the feasibility OPF on a BMOPF network dict and return `(volts, slack_A)`
where `volts` maps `"bus.node"` → complex voltage in V and `slack_A` is the
total elastic-slack magnitude in amperes.
"""
function _bmopf_volts(net::Dict{String,Any})
    res = solve_feasibility_opf(net; optimizer=Ipopt.Optimizer)
    slack_A = res["total_slack_magnitude_A"]
    volts = Dict{String,ComplexF64}()
    for (bid, t_dict) in res["bus"]
        for (t, tv) in t_dict
            node_str = t == "n" ? "4" : t
            volts[bid * "." * node_str] = tv["vr"] + im * tv["vi"]
        end
    end
    return volts, slack_A
end

"""
    _bmopf_losses_W(res) -> Float64

Compute total network losses (W) from a BMOPF feasibility-OPF result dict as:
  P_loss = Σ P_gen − Σ P_load
"""
function _bmopf_losses_W(res::Dict)::Float64
    p_gen  = sum(
        get(t, "pg", 0.0)
        for gd in values(get(res, "generator", Dict()))
        for t  in values(gd);
        init = 0.0)
    p_load = sum(
        get(t, "pd", 0.0)
        for ld in values(get(res, "load", Dict()))
        for t  in values(ld);
        init = 0.0)
    return p_gen - p_load
end

"""
    _cmp_volts(V_ods, V_bm; label="", atol=1.0, rtol=1e-3)

Assert that every node present in both dicts agrees within tolerance.
Nodes with |V_ref| < 1e-4 V (effectively the earth reference) are skipped.
At least one node must be compared.
"""
function _cmp_volts(V_ods::Dict, V_bm::Dict;
                    label::String="", atol::Float64=1.0, rtol::Float64=1e-3)
    n = 0
    for (node, V_ref) in V_ods
        haskey(V_bm, node)   || continue
        abs(V_ref) < 1e-4    && continue
        V_calc = V_bm[node]
        ok = isapprox(V_calc, V_ref; atol=atol, rtol=rtol)
        if !ok
            err = abs(V_calc - V_ref)
            @warn "$(label)node $node: |BMOPF − ODS| = $(round(err, digits=3)) V " *
                  "(ODS=$(round(abs(V_ref),digits=3)) V, " *
                  "BMOPF=$(round(abs(V_calc),digits=3)) V)"
        end
        @test ok
        n += 1
    end
    @test n > 0
end

# ── Network constructors ──────────────────────────────────────────────────────
# Each function returns a BMOPF network dict that mirrors its .dss fixture.
# TODO: replace these with `from_dss(path)` once PowerIO.jl is available.

function _net_1ph_line()
    # pf_1ph_line.dss: src ──[1-ph line, 0.5 km, r1=0.5 Ω/km, x1=0.2 Ω/km]── lb
    # Single conductor, earth return (no explicit neutral).
    # Total series impedance: R = 0.25 Ω, X = 0.10 Ω
    # Load: 10 kW + 3 kVAr phase-to-earth
    Dict{String,Any}(
        "bus" => Dict{String,Any}(
            "src" => Dict{String,Any}(
                "terminal_names" => ["1"]),
            "lb"  => Dict{String,Any}(
                "terminal_names" => ["1"])),
        "voltage_source" => Dict{String,Any}(
            "source" => Dict{String,Any}(
                "bus"          => "src",
                "terminal_map" => ["1"],
                "v_magnitude"  => [240.0],
                "v_angle"      => [0.0])),
        "linecode" => Dict{String,Any}(
            "sp1w" => Dict{String,Any}(
                "R_series_1_1" => 0.500 / 1000.0,
                "X_series_1_1" => 0.200 / 1000.0)),
        "line" => Dict{String,Any}(
            "l1" => Dict{String,Any}(
                "bus_from"         => "src",
                "bus_to"           => "lb",
                "linecode"         => "sp1w",
                "length"           => 500.0,
                "terminal_map_from"=> ["1"],
                "terminal_map_to"  => ["1"])),
        "load" => Dict{String,Any}(
            "ld1" => Dict{String,Any}(
                "bus"           => "lb",
                "terminal_map"  => ["1"],
                "configuration" => "WYE",
                "p_nom"         => [10_000.0],
                "q_nom"         => [3_000.0])))
end

function _net_3ph_line()
    # pf_3ph_line.dss: src ──[4-wire line, 0.5 km]── lb
    # linecode 4w: phase self 0.5/0.2 Ω/km, neutral self 0.5/0.2, mutual 0.02/0.05 Ω/km
    # source: 3-phase balanced 0.415 kV (line), i.e. 239.6 V / phase at 0°/−120°/+120°
    # grounding reactor at src.4: R=0.001 Ω → shunt G=1000 S
    # loads: unbalanced 15/10/20 kW + 5/3/7 kVAr phase-to-neutral
    v_ph = 415.0 / sqrt(3)
    Dict{String,Any}(
        "bus" => Dict{String,Any}(
            "src" => Dict{String,Any}(
                "terminal_names"  => ["1", "2", "3", "n"],
                "neutral_terminal"=> "n"),
            "lb"  => Dict{String,Any}(
                "terminal_names"  => ["1", "2", "3", "n"],
                "neutral_terminal"=> "n")),
        "voltage_source" => Dict{String,Any}(
            "source" => Dict{String,Any}(
                "bus"          => "src",
                "terminal_map" => ["1", "2", "3"],
                "v_magnitude"  => [v_ph, v_ph, v_ph],
                "v_angle"      => [0.0, -2π/3, 2π/3])),
        "shunt" => Dict{String,Any}(
            "grnd" => Dict{String,Any}(
                "bus"          => "src",
                "terminal_map" => ["n"],
                "G_1_1"        => 1000.0,
                "B_1_1"        => 0.0)),
        "linecode" => Dict{String,Any}(
            "4w" => Dict{String,Any}(
                "R_series_1_1" => 0.500 / 1000.0,
                "R_series_1_2" => 0.020 / 1000.0,
                "R_series_1_3" => 0.020 / 1000.0,
                "R_series_1_4" => 0.020 / 1000.0,
                "R_series_2_1" => 0.020 / 1000.0,
                "R_series_2_2" => 0.500 / 1000.0,
                "R_series_2_3" => 0.020 / 1000.0,
                "R_series_2_4" => 0.020 / 1000.0,
                "R_series_3_1" => 0.020 / 1000.0,
                "R_series_3_2" => 0.020 / 1000.0,
                "R_series_3_3" => 0.500 / 1000.0,
                "R_series_3_4" => 0.020 / 1000.0,
                "R_series_4_1" => 0.020 / 1000.0,
                "R_series_4_2" => 0.020 / 1000.0,
                "R_series_4_3" => 0.020 / 1000.0,
                "R_series_4_4" => 0.500 / 1000.0,
                "X_series_1_1" => 0.200 / 1000.0,
                "X_series_1_2" => 0.050 / 1000.0,
                "X_series_1_3" => 0.050 / 1000.0,
                "X_series_1_4" => 0.050 / 1000.0,
                "X_series_2_1" => 0.050 / 1000.0,
                "X_series_2_2" => 0.200 / 1000.0,
                "X_series_2_3" => 0.050 / 1000.0,
                "X_series_2_4" => 0.050 / 1000.0,
                "X_series_3_1" => 0.050 / 1000.0,
                "X_series_3_2" => 0.050 / 1000.0,
                "X_series_3_3" => 0.200 / 1000.0,
                "X_series_3_4" => 0.050 / 1000.0,
                "X_series_4_1" => 0.050 / 1000.0,
                "X_series_4_2" => 0.050 / 1000.0,
                "X_series_4_3" => 0.050 / 1000.0,
                "X_series_4_4" => 0.200 / 1000.0)),
        "line" => Dict{String,Any}(
            "l1" => Dict{String,Any}(
                "bus_from"         => "src",
                "bus_to"           => "lb",
                "linecode"         => "4w",
                "length"           => 500.0,
                "terminal_map_from"=> ["1", "2", "3", "n"],
                "terminal_map_to"  => ["1", "2", "3", "n"])),
        "load" => Dict{String,Any}(
            "ld1" => Dict{String,Any}(
                "bus"           => "lb",
                "terminal_map"  => ["1", "n"],
                "configuration" => "WYE",
                "p_nom"         => [15_000.0],
                "q_nom"         => [5_000.0]),
            "ld2" => Dict{String,Any}(
                "bus"           => "lb",
                "terminal_map"  => ["2", "n"],
                "configuration" => "WYE",
                "p_nom"         => [10_000.0],
                "q_nom"         => [3_000.0]),
            "ld3" => Dict{String,Any}(
                "bus"           => "lb",
                "terminal_map"  => ["3", "n"],
                "configuration" => "WYE",
                "p_nom"         => [20_000.0],
                "q_nom"         => [7_000.0])))
end

function _net_1ph_xfmr()
    # pf_1ph_xfmr.dss: hv ──[1-ph YY xfmr, 11 kV / 0.24 kV, 50 kVA]── lv
    # %r=1.0 per winding, xhl=4.0%, %noloadloss=0.3, %imag=1.5
    # load: 30 kW + 10 kVAr on lv
    #
    # Impedance conversion (single_phase subtype, WYE-WYE):
    #   v_ref_from = 11 000 V, v_ref_to = 240 V, s_rating = 50 000 VA
    #   z_base_from = 11000² / 50000 = 2420 Ω
    #   z_base_to   =   240² / 50000 = 1.152 Ω
    #   r_series_from = 0.01 × 2420 = 24.2 Ω
    #   r_series_to   = 0.01 × 1.152 = 0.01152 Ω
    #   x_series_from = 0.04 × 2420 = 96.8 Ω  (all xsc on winding 1)
    #   x_series_to   = 0.0
    #
    # No-load branch (on from side):
    #   y_base = s / v_ref_from² = 50000 / 11000² = 4.132e-7 S
    #   G = noloadloss × y_base = 0.003 × 4.132e-7 = 1.240e-9 S
    #   |Y| = cmag × y_base = 0.015 × 4.132e-7 = 6.198e-9 S
    #   B = sqrt(|Y|² − G²) ≈ 6.073e-9 S
    s   = 50_000.0
    vf  = 11_000.0
    vt  =    240.0
    zbf = vf^2 / s
    zbt = vt^2 / s
    yb  = s / vf^2
    nl  = 0.003
    cm  = 0.015
    G_nl = nl * yb
    Y_nl = cm * yb
    B_nl = sqrt(max(Y_nl^2 - G_nl^2, 0.0))

    Dict{String,Any}(
        "bus" => Dict{String,Any}(
            "hv" => Dict{String,Any}(
                "terminal_names"  => ["1", "n"],
                "neutral_terminal"=> "n"),
            "lv" => Dict{String,Any}(
                "terminal_names"  => ["1", "n"],
                "neutral_terminal"=> "n")),
        "voltage_source" => Dict{String,Any}(
            "source" => Dict{String,Any}(
                "bus"          => "hv",
                "terminal_map" => ["1"],
                "v_magnitude"  => [11_000.0],
                "v_angle"      => [0.0])),
        "shunt" => Dict{String,Any}(
            "grnd_hv" => Dict{String,Any}(
                "bus"          => "hv",
                "terminal_map" => ["n"],
                "G_1_1"        => 1000.0,
                "B_1_1"        => 0.0),
            "grnd_lv" => Dict{String,Any}(
                "bus"          => "lv",
                "terminal_map" => ["n"],
                "G_1_1"        => 1000.0,
                "B_1_1"        => 0.0)),
        "transformer" => Dict{String,Any}(
            "single_phase" => Dict{String,Any}(
                "t1" => Dict{String,Any}(
                    "bus_from"         => "hv",
                    "bus_to"           => "lv",
                    "terminal_map_from"=> ["1", "n"],
                    "terminal_map_to"  => ["1", "n"],
                    "v_ref_from"       => vf,
                    "v_ref_to"         => vt,
                    "s_rating"         => s,
                    "r_series_from"    => 0.01 * zbf,
                    "r_series_to"      => 0.01 * zbt,
                    "x_series_from"    => 0.04 * zbf,
                    "x_series_to"      => 0.0,
                    "g_no_load"        => G_nl,
                    "b_no_load"        => B_nl))),
        "load" => Dict{String,Any}(
            "ld1" => Dict{String,Any}(
                "bus"           => "lv",
                "terminal_map"  => ["1", "n"],
                "configuration" => "WYE",
                "p_nom"         => [30_000.0],
                "q_nom"         => [10_000.0])))
end

function _net_yd_xfmr()
    # pf_yd_xfmr.dss: hv ──[Yd xfmr, 11 kV wye / 0.415 kV delta, 500 kVA]── lv
    # %r=1.0 per winding, xhl=4.0%, %noloadloss=0.3, %imag=1.5
    # HV neutral earthed via R=0.001 Ω reactor → shunt G=1000 S at hv.n
    # LV delta: near-solid ground (R=0.001 Ω, G≈1000 S) at lv.1 to anchor
    #   common mode deterministically — mirrors ODS Reactor.grnd_lv.
    # loads: unbalanced (3:1:2) delta loads to expose per-phase errors
    #
    # Impedance conversion (wye_delta subtype):
    #   v_ref_from = 11 000 V (wye, line voltage used as base per OpenDSS)
    #   v_ref_to   =    415 V (delta, line voltage)
    #   s_rating   = 500 000 VA
    #   z_base_from = 11000² / 500000 = 242 Ω
    #   z_base_to   =   415² / 500000 = 0.34445 Ω
    #   r_series_from = 0.01 × 242 = 2.42 Ω  (wye winding, no √3 factor)
    #   r_series_to   = 0.01 × 0.34445 × √3 = 5.966e-3 Ω  (delta winding)
    #   x_series_from = 0.04/2 × 242 = 4.84 Ω  (half xsc on from side)
    #   x_series_to   = 0.04/2 × 0.34445 × √3 = 1.193e-2 Ω  (half xsc on to side)
    s   = 500_000.0
    vf  = 11_000.0
    vt  =    415.0
    zbf = vf^2 / s
    zbt = vt^2 / s
    yb  = s / vf^2
    nl  = 0.003
    cm  = 0.015
    G_nl = nl * yb
    Y_nl = cm * yb
    B_nl = sqrt(max(Y_nl^2 - G_nl^2, 0.0))

    Dict{String,Any}(
        "bus" => Dict{String,Any}(
            "hv" => Dict{String,Any}(
                "terminal_names"  => ["1", "2", "3", "n"],
                "neutral_terminal"=> "n"),
            "lv" => Dict{String,Any}(
                "terminal_names"  => ["1", "2", "3"])),
        "voltage_source" => Dict{String,Any}(
            "source" => Dict{String,Any}(
                "bus"          => "hv",
                "terminal_map" => ["1", "2", "3"],
                "v_magnitude"  => [vf/sqrt(3), vf/sqrt(3), vf/sqrt(3)],
                "v_angle"      => [0.0, -2π/3, 2π/3])),
        "shunt" => Dict{String,Any}(
            "grnd_hv" => Dict{String,Any}(
                "bus"          => "hv",
                "terminal_map" => ["n"],
                "G_1_1"        => 1000.0,
                "B_1_1"        => 0.0),
            "grnd_lv" => Dict{String,Any}(
                "bus"          => "lv",
                "terminal_map" => ["1"],
                "G_1_1"        => 1000.0,
                "B_1_1"        => 0.0)),
        "transformer" => Dict{String,Any}(
            "wye_delta" => Dict{String,Any}(
                "t1" => Dict{String,Any}(
                    "bus_from"         => "hv",
                    "bus_to"           => "lv",
                    "terminal_map_from"=> ["1", "2", "3", "n"],
                    "terminal_map_to"  => ["1", "2", "3"],
                    "v_ref_from"       => vf,
                    "v_ref_to"         => vt,
                    "s_rating"         => s,
                    "r_series_from"    => 0.01 * zbf,
                    "r_series_to"      => 0.01 * zbt * sqrt(3),
                    "x_series_from"    => 0.04 / 2 * zbf,
                    "x_series_to"      => 0.04 / 2 * zbt * sqrt(3),
                    "g_no_load"        => G_nl,
                    "b_no_load"        => B_nl))),
        "load" => Dict{String,Any}(
            "ld1" => Dict{String,Any}(
                "bus"           => "lv",
                "terminal_map"  => ["1", "2"],
                "configuration" => "DELTA",
                "p_nom"         => [180_000.0],
                "q_nom"         => [60_000.0]),
            "ld2" => Dict{String,Any}(
                "bus"           => "lv",
                "terminal_map"  => ["2", "3"],
                "configuration" => "DELTA",
                "p_nom"         => [60_000.0],
                "q_nom"         => [20_000.0]),
            "ld3" => Dict{String,Any}(
                "bus"           => "lv",
                "terminal_map"  => ["3", "1"],
                "configuration" => "DELTA",
                "p_nom"         => [120_000.0],
                "q_nom"         => [40_000.0])))
end

function _net_dy_xfmr()
    # pf_dy_xfmr.dss: hv ──[Dy xfmr, 11 kV delta / 0.415 kV wye, 500 kVA]── lv
    # %r=1.0 per winding, xhl=4.0%, %noloadloss=0.3, %imag=1.5
    # LV neutral earthed via R=0.3 Ω reactor → shunt G=1/0.3 S
    # loads: unbalanced wye-to-neutral 120 kW + 40 kVAr each phase (3:3:3 here, balanced)
    #
    # Impedance conversion (delta_wye subtype):
    #   v_ref_from = 11 000 V (delta, line voltage)
    #   v_ref_to   =    415 V (wye, line voltage)
    #   s_rating   = 500 000 VA
    #   z_base_from = 11000² / 500000 = 242 Ω
    #   z_base_to   =   415² / 500000 = 0.34445 Ω
    #   r_series_from = 0.01 × 242 × √3 = 4.193 Ω  (delta winding)
    #   r_series_to   = 0.01 × 0.34445 = 3.4445e-3 Ω  (wye winding)
    #   x_series_from = 0.04/2 × 242 × √3 = 8.386 Ω  (half xsc on from/delta side)
    #   x_series_to   = 0.04/2 × 0.34445 = 6.889e-3 Ω  (half xsc on to/wye side)
    s   = 500_000.0
    vf  = 11_000.0
    vt  =    415.0
    zbf = vf^2 / s
    zbt = vt^2 / s
    yb  = s / vf^2
    nl  = 0.003
    cm  = 0.015
    G_nl = nl * yb
    Y_nl = cm * yb
    B_nl = sqrt(max(Y_nl^2 - G_nl^2, 0.0))

    Dict{String,Any}(
        "bus" => Dict{String,Any}(
            "hv" => Dict{String,Any}(
                "terminal_names" => ["1", "2", "3"]),
            "lv" => Dict{String,Any}(
                "terminal_names"  => ["1", "2", "3", "n"],
                "neutral_terminal"=> "n")),
        "voltage_source" => Dict{String,Any}(
            "source" => Dict{String,Any}(
                "bus"          => "hv",
                "terminal_map" => ["1", "2", "3"],
                "v_magnitude"  => [vf/sqrt(3), vf/sqrt(3), vf/sqrt(3)],
                "v_angle"      => [0.0, -2π/3, 2π/3])),
        "shunt" => Dict{String,Any}(
            "grnd_lv" => Dict{String,Any}(
                "bus"          => "lv",
                "terminal_map" => ["n"],
                "G_1_1"        => 1.0 / 0.3,
                "B_1_1"        => 0.0)),
        "transformer" => Dict{String,Any}(
            "delta_wye" => Dict{String,Any}(
                "t1" => Dict{String,Any}(
                    "bus_from"         => "hv",
                    "bus_to"           => "lv",
                    "terminal_map_from"=> ["1", "2", "3"],
                    "terminal_map_to"  => ["1", "2", "3", "n"],
                    "v_ref_from"       => vf,
                    "v_ref_to"         => vt,
                    "s_rating"         => s,
                    "r_series_from"    => 0.01 * zbf * sqrt(3),
                    "r_series_to"      => 0.01 * zbt,
                    "x_series_from"    => 0.04 / 2 * zbf * sqrt(3),
                    "x_series_to"      => 0.04 / 2 * zbt,
                    "g_no_load"        => G_nl,
                    "b_no_load"        => B_nl))),
        "load" => Dict{String,Any}(
            "ld1" => Dict{String,Any}(
                "bus"           => "lv",
                "terminal_map"  => ["1", "n"],
                "configuration" => "WYE",
                "p_nom"         => [120_000.0],
                "q_nom"         => [40_000.0]),
            "ld2" => Dict{String,Any}(
                "bus"           => "lv",
                "terminal_map"  => ["2", "n"],
                "configuration" => "WYE",
                "p_nom"         => [120_000.0],
                "q_nom"         => [40_000.0]),
            "ld3" => Dict{String,Any}(
                "bus"           => "lv",
                "terminal_map"  => ["3", "n"],
                "configuration" => "WYE",
                "p_nom"         => [120_000.0],
                "q_nom"         => [40_000.0])))
end

# ── Test cases ────────────────────────────────────────────────────────────────

@testset "PF comparison — single-phase 2-wire line" begin
    path = joinpath(_PF_CMP_DIR, "pf_1ph_line.dss")
    V_ods          = _ods_volts(path)
    V_bm, slack_A  = _bmopf_volts(_net_1ph_line())

    @test slack_A < 1e-3

    _cmp_volts(V_ods, V_bm; label="1ph-line: ")
end

@testset "PF comparison — three-phase 4-wire unbalanced line" begin
    path = joinpath(_PF_CMP_DIR, "pf_3ph_line.dss")
    V_ods          = _ods_volts(path)
    V_bm, slack_A  = _bmopf_volts(_net_3ph_line())

    @test slack_A < 1e-3

    _cmp_volts(V_ods, V_bm; label="3ph-line: ")
end

@testset "PF comparison — single-phase transformer (single_phase YY)" begin
    path = joinpath(_PF_CMP_DIR, "pf_1ph_xfmr.dss")
    net            = _net_1ph_xfmr()
    V_ods          = _ods_volts(path)
    V_bm, slack_A  = _bmopf_volts(net)

    @test slack_A < 1e-3
    @test haskey(get(net, "transformer", Dict()), "single_phase")

    _cmp_volts(V_ods, V_bm; label="1ph-xfmr: ")
end

@testset "PF comparison — wye-delta transformer (wye_delta Yd)" begin
    path = joinpath(_PF_CMP_DIR, "pf_yd_xfmr.dss")
    net   = _net_yd_xfmr()
    V_ods = _ods_volts(path)

    res     = solve_feasibility_opf(net; optimizer=Ipopt.Optimizer)
    V_bm    = Dict(bid * "." * (t == "n" ? "4" : t) => tv["vr"] + im*tv["vi"]
                   for (bid, td) in res["bus"] for (t, tv) in td)
    slack_A = res["total_slack_magnitude_A"]

    @test slack_A < 1e-3
    @test haskey(get(net, "transformer", Dict()), "wye_delta")

    _cmp_volts(V_ods, V_bm; label="Yd-xfmr: ", atol=0.1)

    P_ods = _ods_losses_W(path)
    P_bm  = _bmopf_losses_W(res)
    @test isapprox(P_bm, P_ods; rtol=0.05)
end

@testset "PF comparison — delta-wye transformer (delta_wye Dy)" begin
    path = joinpath(_PF_CMP_DIR, "pf_dy_xfmr.dss")
    net   = _net_dy_xfmr()
    V_ods = _ods_volts(path)

    res     = solve_feasibility_opf(net; optimizer=Ipopt.Optimizer)
    V_bm    = Dict(bid * "." * (t == "n" ? "4" : t) => tv["vr"] + im*tv["vi"]
                   for (bid, td) in res["bus"] for (t, tv) in td)
    slack_A = res["total_slack_magnitude_A"]

    @test slack_A < 1e-3
    @test haskey(get(net, "transformer", Dict()), "delta_wye")

    _cmp_volts(V_ods, V_bm; label="Dy-xfmr: ", atol=0.1)

    P_ods = _ods_losses_W(path)
    P_bm  = _bmopf_losses_W(res)
    @test isapprox(P_bm, P_ods; rtol=0.05)
end
