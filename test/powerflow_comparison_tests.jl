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
# Note: center_tap transformers are not tested here because from_pmd only
# captures windings 1 and 2 of the 3-winding OpenDSS representation,
# discarding the third winding's connection.

using OpenDSSDirect
using PowerModelsDistribution: parse_file
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
    # Circuit.Losses() returns (total_P_W, total_Q_var) as a pair
    p_w, _ = Circuit.Losses()
    return p_w
end

"""
    _bmopf_volts(dss_path) -> (Dict{String, ComplexF64}, Float64)

Convert the DSS file to BMOPF JSON via PMD, run the feasibility OPF, and
return `(volts, slack_A)` where `volts` maps `"bus.node"` → complex voltage
in V and `slack_A` is the total elastic-slack magnitude in amperes.
"""
function _bmopf_volts(dss_path::String)
    eng = parse_file(dss_path; kron_reduce=false)
    net = from_pmd(eng)
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
This is the power-balance definition of losses: whatever the source injects
minus what loads absorb is dissipated in lines, transformers, and shunts.
Returns NaN if the result is infeasible or any required field is missing.
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
        abs(V_ref) < 1e-4    && continue   # skip degenerate earth-ref nodes
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
    @test n > 0  # ensure at least one node was actually compared
end

# ── Test cases ────────────────────────────────────────────────────────────────

@testset "PF comparison — single-phase 2-wire line" begin
    path = joinpath(_PF_CMP_DIR, "pf_1ph_line.dss")
    V_ods          = _ods_volts(path)
    V_bm, slack_A  = _bmopf_volts(path)

    @test slack_A < 1e-3   # near-zero slack ⟹ valid power flow

    _cmp_volts(V_ods, V_bm; label="1ph-line: ")
end

@testset "PF comparison — three-phase 4-wire unbalanced line" begin
    path = joinpath(_PF_CMP_DIR, "pf_3ph_line.dss")
    V_ods          = _ods_volts(path)
    V_bm, slack_A  = _bmopf_volts(path)

    @test slack_A < 1e-3   # near-zero slack ⟹ valid power flow

    _cmp_volts(V_ods, V_bm; label="3ph-line: ")
end

@testset "PF comparison — single-phase transformer (single_phase YY)" begin
    path = joinpath(_PF_CMP_DIR, "pf_1ph_xfmr.dss")
    V_ods          = _ods_volts(path)
    V_bm, slack_A  = _bmopf_volts(path)

    @test slack_A < 1e-3

    # Verify subtype classified correctly
    eng = parse_file(path; kron_reduce=false)
    net = from_pmd(eng)
    @test haskey(get(net, "transformer", Dict()), "single_phase")

    _cmp_volts(V_ods, V_bm; label="1ph-xfmr: ")
end

@testset "PF comparison — wye-delta transformer (wye_delta Yd)" begin
    # Fixture: 500 kVA, 11 kV / 0.415 kV, %r=1.0/wdg, xhl=4.0%,
    # %noloadloss=0.3, %imag=1.5.  Total load ≈ 360 kW (72 % rated),
    # 3:1:2 inter-phase ratio → series drop ≈ 10 V and inter-phase spread
    # ≈ 5 V on LV delta; 0.1 V tolerance requires <1 % model agreement.
    path = joinpath(_PF_CMP_DIR, "pf_yd_xfmr.dss")
    V_ods         = _ods_volts(path)

    eng = parse_file(path; kron_reduce=false)
    net = from_pmd(eng)
    res = solve_feasibility_opf(net; optimizer=Ipopt.Optimizer)

    V_bm    = Dict(bid * "." * (t == "n" ? "4" : t) => tv["vr"] + im*tv["vi"]
                   for (bid, td) in res["bus"] for (t, tv) in td)
    slack_A = res["total_slack_magnitude_A"]

    @test slack_A < 1e-3   # near-zero slack ⟹ valid power flow
    @test haskey(get(net, "transformer", Dict()), "wye_delta")

    # Tighter tolerance: series drop is several volts at 72% loading, so
    # 0.1 V / 415 V ≈ 0.02% — any modelling error in the T-model would exceed this.
    _cmp_volts(V_ods, V_bm; label="Yd-xfmr: ", atol=0.1)

    # Loss cross-check: BMOPF total losses (P_gen − P_load) must agree with
    # OpenDSS circuit losses within 5%.  Exercises both series branches and the
    # no-load shunt (g/b_no_load ≈ 1.5 kW core loss at rated voltage).
    P_ods = _ods_losses_W(path)
    P_bm  = _bmopf_losses_W(res)
    @test isapprox(P_bm, P_ods; rtol=0.05)
end

@testset "PF comparison — delta-wye transformer (delta_wye Dy)" begin
    # Fixture: 500 kVA, 11 kV / 0.415 kV, %r=1.0/wdg, xhl=4.0%,
    # %noloadloss=0.3, %imag=1.5.  Total load ≈ 360 kW (72 % rated),
    # 3:1:2 inter-phase ratio → large neutral displacement on grounded LV wye;
    # 0.1 V tolerance makes per-phase constraint errors detectable.
    path = joinpath(_PF_CMP_DIR, "pf_dy_xfmr.dss")
    V_ods         = _ods_volts(path)

    eng = parse_file(path; kron_reduce=false)
    net = from_pmd(eng)
    res = solve_feasibility_opf(net; optimizer=Ipopt.Optimizer)

    V_bm    = Dict(bid * "." * (t == "n" ? "4" : t) => tv["vr"] + im*tv["vi"]
                   for (bid, td) in res["bus"] for (t, tv) in td)
    slack_A = res["total_slack_magnitude_A"]

    @test slack_A < 1e-3   # near-zero slack ⟹ valid power flow
    @test haskey(get(net, "transformer", Dict()), "delta_wye")

    # Tighter tolerance: same reasoning as Yd case above.
    _cmp_volts(V_ods, V_bm; label="Dy-xfmr: ", atol=0.1)

    # Loss cross-check: same as Yd.
    P_ods = _ods_losses_W(path)
    P_bm  = _bmopf_losses_W(res)
    @test isapprox(P_bm, P_ods; rtol=0.05)
end
