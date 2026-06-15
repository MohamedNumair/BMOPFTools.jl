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
# Comparison tolerance: isapprox(atol=1.0 V, rtol=1e-3).
#   · For 240 V systems  → 1.0 V absolute (≈ 0.4 %) is the binding criterion.
#   · For 11 kV systems  → 0.1 % relative (≈ 6.4 V) is the binding criterion.
# Both are far above numerical noise (~0.01 V) and well below any realistic
# modelling error (wrong sign/ratio ≫ 1 % of nominal).
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
    _cmp_volts(V_ods, V_bm; label="")

Assert that every node present in both dicts agrees within tolerance.
Nodes with |V_ref| < 1e-4 V (effectively the earth reference, if it ever
appears) are skipped.  At least one node must be compared.
"""
function _cmp_volts(V_ods::Dict, V_bm::Dict; label::String="")
    n = 0
    for (node, V_ref) in V_ods
        haskey(V_bm, node)   || continue
        abs(V_ref) < 1e-4    && continue   # skip degenerate earth-ref nodes
        V_calc = V_bm[node]
        ok = isapprox(V_calc, V_ref; atol=1.0, rtol=1e-3)
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
    path = joinpath(_PF_CMP_DIR, "pf_yd_xfmr.dss")
    V_ods          = _ods_volts(path)
    V_bm, slack_A  = _bmopf_volts(path)

    @test slack_A < 1e-3

    eng = parse_file(path; kron_reduce=false)
    net = from_pmd(eng)
    @test haskey(get(net, "transformer", Dict()), "wye_delta")

    _cmp_volts(V_ods, V_bm; label="Yd-xfmr: ")
end

@testset "PF comparison — delta-wye transformer (delta_wye Dy)" begin
    path = joinpath(_PF_CMP_DIR, "pf_dy_xfmr.dss")
    V_ods          = _ods_volts(path)
    V_bm, slack_A  = _bmopf_volts(path)

    @test slack_A < 1e-3

    eng = parse_file(path; kron_reduce=false)
    net = from_pmd(eng)
    @test haskey(get(net, "transformer", Dict()), "delta_wye")

    _cmp_volts(V_ods, V_bm; label="Dy-xfmr: ")
end
