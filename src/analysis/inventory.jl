"""
    inventory_analysis(net, findings) -> Dict{String,Any}

Count components and compute summary statistics for each component type.
Returns a dict keyed by component type name; each value is a sub-dict with
at least a `"total"` count and type-specific breakdowns.
"""
function inventory_analysis(net::Dict{String,Any},
                             findings::Vector{Finding})::Dict{String,Any}
    result = Dict{String,Any}()

    # --- Simple component types ---
    for comp_type in ("linecode", "voltage_source", "shunt", "switch")
        components = get(net, comp_type, Dict())
        result[comp_type] = Dict{String,Any}("total" => length(components))
    end

    # --- Bus ---
    buses = get(net, "bus", Dict())
    by_phases = Dict{Int,Int}()
    for (_, b) in buses
        names = String.(get(b, "terminal_names", String[]))
        nn = _neutral_terminal(names)
        n_phases = count(t -> t != nn, names)
        by_phases[n_phases] = get(by_phases, n_phases, 0) + 1
    end
    result["bus"] = Dict{String,Any}(
        "total"      => length(buses),
        "by_n_phases" => by_phases
    )

    # --- Line ---
    lines = get(net, "line", Dict())
    with_lc = count(l -> haskey(l, "linecode"), values(lines))
    result["line"] = Dict{String,Any}(
        "total"        => length(lines),
        "with_linecode" => with_lc
    )

    # --- Load ---
    loads = get(net, "load", Dict())
    total_p   = 0.0
    total_q   = 0.0
    cfg_counts = Dict{String,Int}()
    for (_, l) in loads
        total_p += sum(Float64.(get(l, "p_nom", Float64[])))
        total_q += sum(Float64.(get(l, "q_nom", Float64[])))
        cfg = string(get(l, "configuration", "UNKNOWN"))
        cfg_counts[cfg] = get(cfg_counts, cfg, 0) + 1
    end
    result["load"] = Dict{String,Any}(
        "total"            => length(loads),
        "total_p_w"        => total_p,
        "total_q_var"      => total_q,
        "by_configuration" => cfg_counts
    )

    # --- Generator ---
    gens = get(net, "generator", Dict())
    total_p_cap = 0.0
    for (_, g) in gens
        total_p_cap += sum(Float64.(get(g, "p_max", Float64[])))
    end
    result["generator"] = Dict{String,Any}(
        "total"         => length(gens),
        "total_p_cap_w" => total_p_cap
    )

    # --- Transformer ---
    xfmr    = get(net, "transformer", Dict())
    by_type = Dict{String,Int}()
    total_xfmr = 0
    for subtype in ("single_phase", "center_tap", "wye_delta", "delta_wye")
        sub = get(xfmr, subtype, nothing)
        sub isa Dict || continue
        n = length(sub)
        n == 0 && continue
        by_type[subtype] = n
        total_xfmr += n
    end
    result["transformer"] = Dict{String,Any}(
        "total"   => total_xfmr,
        "by_type" => by_type
    )

    result
end
