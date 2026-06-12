"""
    diversity_analysis(net, findings) -> Dict{String,Any}

Assess parameter diversity across component categories. Flags datasets
with high symmetry (low coefficient of variation, duplicate tuples) which
may indicate copy-paste or templated parameterisation.
"""
function diversity_analysis(net::Dict{String,Any},
                             findings::Vector{Finding})::Dict{String,Any}
    result = Dict{String,Any}()

    result["load"]      = _load_diversity(net, findings)
    result["generator"] = _generator_diversity(net, findings)
    result["line"]      = _line_diversity(net, findings)
    result["linecode"]  = _linecode_diversity(net, findings)
    result["transformer"] = _transformer_diversity(net, findings)
    result["bus"]       = _bus_diversity(net, findings)

    # Roll-up: count how many categories are flagged
    flagged = count(v -> get(v, "symmetry_flag", false), values(result))
    total   = count(v -> get(v, "analysed", false), values(result))
    result["symmetry_score"] = flagged == 0        ? "LOW" :
                               flagged <= total ÷ 2 ? "MODERATE" : "HIGH"
    result["n_flagged_categories"] = flagged
    result
end

# ---------------------------------------------------------------------------
# Per-category analyses
# ---------------------------------------------------------------------------

function _load_diversity(net::Dict{String,Any},
                          findings::Vector{Finding})::Dict{String,Any}
    loads = get(net, "load", Dict())
    r = Dict{String,Any}("analysed" => false)
    length(loads) < 2 && return r
    r["analysed"] = true

    p_vals = Float64[]
    q_vals = Float64[]
    pf_vals = Float64[]
    pq_tuples = Tuple{Vector{Float64},Vector{Float64}}[]
    configs = String[]

    for (_, l) in loads
        p = Float64.(get(l, "p_nom", Float64[]))
        q = Float64.(get(l, "q_nom", Float64[]))
        isempty(p) && continue
        append!(p_vals, p)
        append!(q_vals, q)
        push!(pq_tuples, (p, q))

        # per-element power factor
        for (pi, qi) in zip(p, q)
            s = hypot(pi, qi)
            s > 0 && push!(pf_vals, pi / s)
        end

        push!(configs, string(get(l, "configuration", "UNKNOWN")))
    end

    r["p_nom"] = _scalar_stats(p_vals)
    r["q_nom"] = _scalar_stats(q_vals)
    isempty(pf_vals) || (r["power_factor"] = _scalar_stats(pf_vals))

    # Duplicate (p_nom, q_nom) tuple check
    n_distinct = length(unique(pq_tuples))
    n_total    = length(pq_tuples)
    r["n_distinct_pq_tuples"] = n_distinct
    r["n_total_loads"]        = n_total

    flag = false
    if n_total >= 3 && n_distinct < n_total ÷ 2
        flag = true
        push!(findings, Finding(WARNING, "W.DIV.LOAD_SYMMETRIC", :diversity, :load, nothing,
            "$(n_total - n_distinct) of $n_total loads share identical (p_nom, q_nom) — possible copy-paste symmetry.",
            Dict{String,Any}("n_duplicates" => n_total - n_distinct,
                             "n_total"      => n_total)))
    end
    if haskey(r, "p_nom") && get(r["p_nom"], "cv", 1.0) < 0.05 && n_total >= 3
        flag = true
        push!(findings, Finding(INFO, "I.DIV.LOAD_CV_LOW", :diversity, :load, nothing,
            "Load p_nom has very low coefficient of variation ($(round(r["p_nom"]["cv"], digits=3))) — all loads nearly identical.",
            nothing))
    end

    # Phase imbalance for multi-phase loads
    imbalances = Float64[]
    for (id, l) in loads
        p = Float64.(get(l, "p_nom", Float64[]))
        length(p) < 2 && continue
        imb = (maximum(p) - minimum(p)) / max(mean(p), 1e-9)
        push!(imbalances, imb)
        if imb > 0.20
            push!(findings, Finding(INFO, "I.DIV.LOAD_IMBALANCE", :diversity, :load, id,
                "Load '$id' has phase imbalance of $(round(imb*100, digits=1))%.",
                Dict{String,Any}("imbalance_pct" => round(imb*100, digits=1))))
        end
    end
    isempty(imbalances) || (r["phase_imbalance"] = _scalar_stats(imbalances))

    # config breakdown
    cfg_counts = Dict{String,Int}()
    for c in configs
        cfg_counts[c] = get(cfg_counts, c, 0) + 1
    end
    r["configurations"] = cfg_counts
    r["symmetry_flag"] = flag
    r
end

function _generator_diversity(net::Dict{String,Any},
                               findings::Vector{Finding})::Dict{String,Any}
    gens = get(net, "generator", Dict())
    r = Dict{String,Any}("analysed" => false)
    length(gens) < 2 && return r
    r["analysed"] = true

    p_max_vals = Float64[]
    cost_vals  = Float64[]
    for (_, g) in gens
        pm = Float64.(get(g, "p_max", Float64[]))
        append!(p_max_vals, pm)
        if haskey(g, "cost")
            c = g["cost"]
            c isa AbstractVector ? append!(cost_vals, Float64.(c)) :
                                   push!(cost_vals, Float64(c))
        end
    end

    isempty(p_max_vals) || (r["p_max"] = _scalar_stats(p_max_vals))
    isempty(cost_vals)  || (r["cost"]  = _scalar_stats(cost_vals))
    r["symmetry_flag"] = false
    r
end

function _line_diversity(net::Dict{String,Any},
                          findings::Vector{Finding})::Dict{String,Any}
    lines = get(net, "line", Dict())
    r = Dict{String,Any}("analysed" => false)
    length(lines) < 2 && return r
    r["analysed"] = true

    lengths = Float64[]
    for (_, l) in lines
        haskey(l, "length") && push!(lengths, Float64(l["length"]))
    end
    isempty(lengths) || (r["length"] = _scalar_stats(lengths))

    # Count (linecode, similar_length) near-duplicates
    flag = false
    lc_groups = Dict{String,Vector{Float64}}()
    for (_, l) in lines
        lc  = get(l, "linecode", nothing)
        lc === nothing && continue
        len = Float64(get(l, "length", 0.0))
        push!(get!(lc_groups, string(lc), Float64[]), len)
    end
    for (lc, lens) in lc_groups
        if length(lens) >= 3
            similar = count(l -> abs(l - median(lens)) / max(median(lens), 1.0) <= 0.10, lens)
            if similar >= length(lens) * 0.8
                flag = true
                push!(findings, Finding(INFO, "I.DIV.LINE_SYMMETRIC", :diversity, :line, nothing,
                    "$(similar) lines share linecode '$lc' with similar length (±10%) — electrically near-identical.",
                    Dict{String,Any}("linecode" => lc, "n_similar" => similar)))
            end
        end
    end

    r["symmetry_flag"] = flag
    r
end

function _linecode_diversity(net::Dict{String,Any},
                              findings::Vector{Finding})::Dict{String,Any}
    linecodes = get(net, "linecode", Dict())
    r = Dict{String,Any}("analysed" => false)
    length(linecodes) < 2 && return r
    r["analysed"] = true

    r11_vals = Float64[]
    for (_, lc) in linecodes
        haskey(lc, "R_series_1_1") && push!(r11_vals, Float64(lc["R_series_1_1"]))
    end
    isempty(r11_vals) || (r["R_series_1_1"] = _scalar_stats(r11_vals))

    # Off-diagonal fill: how many linecodes have mutual coupling terms
    n_with_offdiag = count(lc -> _has_offdiagonal(lc), values(linecodes))
    r["n_with_mutual_coupling"] = n_with_offdiag
    r["pct_with_mutual_coupling"] = length(linecodes) > 0 ?
        round(100.0 * n_with_offdiag / length(linecodes), digits=1) : 0.0

    r["symmetry_flag"] = false
    r
end

function _transformer_diversity(net::Dict{String,Any},
                                 findings::Vector{Finding})::Dict{String,Any}
    xfmr = get(net, "transformer", Dict())
    r = Dict{String,Any}("analysed" => false)

    all_xfmrs = Dict{String,Any}()
    for subtype in ("single_phase", "center_tap", "wye_delta", "delta_wye")
        sub = get(xfmr, subtype, nothing)
        sub isa Dict || continue
        merge!(all_xfmrs, sub)
    end
    length(all_xfmrs) < 2 && return r
    r["analysed"] = true

    s_ratings  = Float64[]
    turn_ratios = Float64[]
    for (_, t) in all_xfmrs
        haskey(t, "s_rating") && push!(s_ratings, Float64(t["s_rating"]))
        vf = get(t, "v_ref_from", nothing)
        vt = get(t, "v_ref_to",   nothing)
        (vf !== nothing && vt !== nothing && Float64(vf) > 0) &&
            push!(turn_ratios, Float64(vt) / Float64(vf))
    end

    isempty(s_ratings)   || (r["s_rating"]    = _scalar_stats(s_ratings))
    isempty(turn_ratios) || (r["turns_ratio"]  = _scalar_stats(turn_ratios))
    r["n_distinct_s_ratings"]   = length(unique(s_ratings))
    r["n_distinct_turns_ratios"] = length(unique(round.(turn_ratios, digits=3)))
    r["symmetry_flag"] = false
    r
end

function _bus_diversity(net::Dict{String,Any},
                         findings::Vector{Finding})::Dict{String,Any}
    buses = get(net, "bus", Dict())
    r = Dict{String,Any}("analysed" => false)
    length(buses) < 2 && return r
    r["analysed"] = true

    v_min_vals = Float64[]
    v_max_vals = Float64[]
    for (_, b) in buses
        haskey(b, "v_min") && push!(v_min_vals, Float64(b["v_min"]))
        haskey(b, "v_max") && push!(v_max_vals, Float64(b["v_max"]))
    end

    n_with_bounds = count(b -> haskey(b, "v_min") || haskey(b, "v_max"), values(buses))
    r["n_with_voltage_bounds"] = n_with_bounds
    r["pct_with_voltage_bounds"] = round(100.0 * n_with_bounds / length(buses), digits=1)

    flag = false
    if !isempty(v_min_vals) && length(unique(round.(v_min_vals, digits=1))) == 1
        flag = true
        push!(findings, Finding(INFO, "I.DIV.BUS_UNIFORM_VMIN", :diversity, :bus, nothing,
            "All buses with v_min have identical value $(v_min_vals[1]) V — no spatial variation in lower voltage bounds.",
            nothing))
    end
    if !isempty(v_max_vals) && length(unique(round.(v_max_vals, digits=1))) == 1
        flag = true
        push!(findings, Finding(INFO, "I.DIV.BUS_UNIFORM_VMAX", :diversity, :bus, nothing,
            "All buses with v_max have identical value $(v_max_vals[1]) V — no spatial variation in upper voltage bounds.",
            nothing))
    end

    r["symmetry_flag"] = flag
    r
end

# ---------------------------------------------------------------------------
# Shared statistics helpers
# ---------------------------------------------------------------------------

function _scalar_stats(vals::Vector{Float64})::Dict{String,Any}
    isempty(vals) && return Dict{String,Any}()
    μ = mean(vals)
    σ = length(vals) > 1 ? std(vals) : 0.0
    Dict{String,Any}(
        "min"    => minimum(vals),
        "max"    => maximum(vals),
        "mean"   => μ,
        "std"    => σ,
        "median" => median(vals),
        "cv"     => μ > 0 ? σ / μ : 0.0,
        "n"      => length(vals)
    )
end

function _has_offdiagonal(lc::Dict{String,Any})::Bool
    for k in keys(lc)
        startswith(k, "R_series_") || startswith(k, "X_series_") || continue
        m = match(r"_(\d)_(\d)$", k)
        m === nothing && continue
        m[1] != m[2] && Float64(lc[k]) != 0.0 && return true
    end
    false
end
