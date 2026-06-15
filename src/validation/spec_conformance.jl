# validation/spec_conformance.jl
#
# Conformance checks against the IEEE Task Force data model specification
# ("Mathematical Model and Data Model for Up-To-Four-Wire Distribution
# System OPF") that the JSON Schema cannot express, plus benchmark-readiness
# assessment with augmentation suggestions.

# Spec §3.4 / Table 4: required terminal-map arity per load configuration
const _CONFIG_ARITY = Dict{String,Int}(
    "SINGLE_PHASE" => 2,   # between any two nodes
    "WYE"          => 4,   # three phases + midpoint return
    "DELTA"        => 3
)

# Spec §4.2: terminal-map arities (from, to) per transformer subtype
const _XFMR_ARITY = Dict{String,Tuple{Int,Int}}(
    "single_phase" => (2, 2),
    "center_tap"   => (2, 3),
    "wye_delta"    => (4, 3),
    "delta_wye"    => (3, 4)
)

"""
    spec_conformance_check(net, findings) -> Dict{String,Any}

Check conformance with the TF data model beyond what the JSON Schema can
express:

- exactly one voltage source (spec Eq. 17);
- load/generator configuration strings and configuration ↔ terminal-map
  arity consistency (SINGLE_PHASE = 2, WYE = 4, DELTA = 3 terminals);
- transformer terminal-map arities per subtype;
- linecode impedance matrices stored with all n² entries (spec §4.1.1
  row-first format) rather than upper-triangular shorthand.
"""
function spec_conformance_check(net::Dict{String,Any},
                                 findings::Vector{Finding})::Dict{String,Any}
    result = Dict{String,Any}()
    n_issues = 0

    # --- terminal identifiers were non-string in the source file ---
    tc = get(get(net, "_meta", Dict()), "terminal_coercions", nothing)
    if tc isa Dict
        n_issues += 1
        push!(findings, Finding(WARNING, "W.SPEC.TERMINAL_TYPES", :spec,
            :network, nothing,
            "$(tc["n"]) terminal identifier(s) in the source file were not " *
            "strings (spec requires strings); coerced at parse via " *
            "$(tc["mode"] == "aliases" ? "the 1→\"1\", 2→\"2\", 3→\"3\", 4→\"n\" convention" :
              "verbatim decimal strings (exotic terminals present — supply an explicit terminal_aliases mapping if this is wrong)").",
            Dict{String,Any}("n" => tc["n"], "mode" => tc["mode"])))
    end

    # --- exactly one voltage source ---
    n_src = length(get(net, "voltage_source", Dict()))
    result["n_voltage_sources"] = n_src
    if n_src != 1
        n_issues += 1
        push!(findings, Finding(WARNING, "W.SPEC.N_SOURCES", :spec,
            :voltage_source, nothing,
            "Spec requires exactly one voltage source; found $n_src.",
            Dict{String,Any}("n" => n_src)))
    end

    # --- nodal element configuration / arity ---
    for (comp_type, allowed) in (("load", keys(_CONFIG_ARITY)),
                                  ("generator", ("WYE",)))
        for (id, c) in get(net, comp_type, Dict())
            c isa Dict || continue
            cfg = get(c, "configuration", nothing)
            cfg isa AbstractString || continue
            if !(cfg in keys(_CONFIG_ARITY))
                n_issues += 1
                push!(findings, Finding(WARNING, "W.SPEC.BAD_CONFIG", :spec,
                    Symbol(comp_type), id,
                    "$comp_type '$id' has configuration '$cfg' — spec allows " *
                    "SINGLE_PHASE, WYE, DELTA.", nothing))
                continue
            end
            if comp_type == "generator" && cfg != "WYE"
                push!(findings, Finding(INFO, "I.SPEC.GEN_CONFIG_FUTURE", :spec,
                    :generator, id,
                    "Generator '$id' configuration '$cfg' is marked " *
                    "future-support in the spec (Table 4); only WYE is " *
                    "currently supported.", nothing))
            end
            arity = _CONFIG_ARITY[cfg]
            tm = get(c, "terminal_map", String[])
            if length(tm) != arity
                n_issues += 1
                push!(findings, Finding(WARNING, "W.SPEC.CONFIG_ARITY", :spec,
                    Symbol(comp_type), id,
                    "$comp_type '$id': configuration $cfg requires $arity " *
                    "terminal(s), terminal_map has $(length(tm)).",
                    Dict{String,Any}("configuration" => cfg,
                                     "arity" => length(tm))))
            end
        end
    end

    # --- transformer terminal-map arities ---
    xfmr = get(net, "transformer", Dict())
    for (subtype, (a_from, a_to)) in _XFMR_ARITY
        sub = get(xfmr, subtype, nothing)
        sub isa Dict || continue
        for (id, t) in sub
            nf = length(get(t, "terminal_map_from", String[]))
            nt = length(get(t, "terminal_map_to",   String[]))
            if nf != a_from || nt != a_to
                n_issues += 1
                push!(findings, Finding(WARNING, "W.SPEC.XFMR_TMAP_ARITY", :spec,
                    :transformer, id,
                    "transformer ($subtype) '$id': spec requires terminal maps " *
                    "of length ($a_from, $a_to); found ($nf, $nt).",
                    Dict{String,Any}("subtype" => subtype,
                                     "from" => nf, "to" => nt)))
            end
        end
    end

    # --- linecode matrix storage: full row-first vs upper-triangular ---
    triangular = String[]
    for (id, lc) in get(net, "linecode", Dict())
        lc isa Dict || continue
        for prefix in ("R_series_", "X_series_")
            entries = Set{Tuple{Int,Int}}()
            n = 0
            for k in keys(lc)
                startswith(k, prefix) || continue
                m = match(r"^(\d+)_(\d+)$", k[length(prefix)+1:end])
                m === nothing && continue
                i, j = parse(Int, m[1]), parse(Int, m[2])
                push!(entries, (i, j))
                n = max(n, i, j)
            end
            n == 0 && continue
            # triangular shorthand: some entries missing, but every missing
            # (i,j) has its transpose present
            mirrored = all(((i, j) in entries) || ((j, i) in entries)
                           for i in 1:n, j in 1:n)
            if length(entries) < n^2 && mirrored
                push!(triangular, id)
                break
            end
        end
    end
    unique!(triangular)
    if !isempty(triangular)
        push!(findings, Finding(INFO, "I.SPEC.MATRIX_TRIANGULAR", :spec,
            :linecode, nothing,
            "$(length(triangular)) linecode(s) store impedance matrices " *
            "upper-triangular; spec §4.1.1 defines full row-first storage: " *
            "$(join(sort(triangular), ", ")).",
            Dict{String,Any}("linecodes" => sort(triangular))))
    end
    result["n_triangular_linecodes"] = length(triangular)
    result["n_conformance_issues"]   = n_issues
    result
end

"""
    benchmark_readiness_check(net, findings) -> Dict{String,Any}

Assess whether the case defines a non-trivial, well-posed OPF benchmark per
the TF spec (generation-cost objective, Eq. 135), and list the augmentation
steps needed to make it one.
"""
function benchmark_readiness_check(net::Dict{String,Any},
                                    findings::Vector{Finding})::Dict{String,Any}
    result = Dict{String,Any}()
    suggestions = String[]

    # --- objective well-posedness ---
    gens = get(net, "generator", Dict())
    with_cost = [id for (id, g) in gens if g isa Dict && haskey(g, "cost")]
    non_slack = [id for id in with_cost if !get(gens[id], "_slack", false)]
    result["n_generators"]        = length(gens)
    result["n_with_cost"]         = length(with_cost)
    result["objective_wellposed"] = !isempty(with_cost)
    result["only_slack_generation"] = !isempty(with_cost) && isempty(non_slack)

    if isempty(with_cost)
        push!(suggestions,
            "no generator with a cost — the generation-cost objective is " *
            "degenerate; add an explicit slack generator at the source bus " *
            "(from_pmd does this by default) or dispatchable DERs")
    elseif isempty(non_slack)
        push!(suggestions,
            "only slack generation — dispatch is trivial (loss minimisation); " *
            "add dispatchable DERs with diverse costs and p/q bounds")
    end

    # --- voltage bound coverage, incl. the spec's richer bound types ---
    buses = get(net, "bus", Dict())
    n_buses = length(buses)
    n_vb   = count(b -> haskey(b, "v_min")    || haskey(b, "v_max"),    values(buses))
    n_vpn  = count(b -> haskey(b, "vpn_min")  || haskey(b, "vpn_max"),  values(buses))
    n_vpp  = count(b -> haskey(b, "vpp_min")  || haskey(b, "vpp_max"),  values(buses))
    n_vpos = count(b -> haskey(b, "vpos_min") || haskey(b, "vpos_max"), values(buses))
    result["pct_v_bounds"]   = n_buses > 0 ? round(100.0 * n_vb / n_buses, digits=1) : 0.0
    result["n_vpn_bounds"]   = n_vpn
    result["n_vpp_bounds"]   = n_vpp
    result["n_vpos_bounds"]  = n_vpos

    if n_buses > 0 && n_vb == 0
        push!(suggestions,
            "no voltage magnitude bounds on any bus — voltage is " *
            "unconstrained; add v_min/v_max (phase-to-ground)")
    end
    if n_buses > 0 && n_vpos == 0 && n_vpn == 0
        push!(suggestions,
            "no phase-to-neutral or sequence voltage bounds (vpn_*/vpos_*) — " *
            "sequence bounds also improve solver robustness for 4-wire OPF")
    end

    # --- thermal limit coverage ---
    lines     = get(net, "line", Dict())
    linecodes = get(net, "linecode", Dict())
    n_lines = length(lines)
    n_thermal = count(lines) do (_, l)
        lc = get(linecodes, string(get(l, "linecode", "")), Dict())
        haskey(l, "i_max") || haskey(l, "s_max") ||
        haskey(lc, "i_max") || haskey(lc, "s_max")
    end
    result["pct_thermal_limits"] = n_lines > 0 ?
        round(100.0 * n_thermal / n_lines, digits=1) : 0.0
    if n_lines > 0 && n_thermal < n_lines
        push!(suggestions,
            "$(n_lines - n_thermal) of $n_lines lines lack thermal limits — " *
            "add i_max/s_max (e.g. correlated with conductor cross-section)")
    end

    result["suggestions"] = suggestions
    if !isempty(suggestions)
        push!(findings, Finding(INFO, "I.BENCH.AUGMENTATION", :benchmark,
            :network, nothing,
            "Case needs augmentation to be a non-trivial OPF benchmark: " *
            join(suggestions, "; ") * ".",
            Dict{String,Any}("suggestions" => suggestions)))
    end
    result
end
