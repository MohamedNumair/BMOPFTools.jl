# validation/domain_rules.jl
#
# Domain-level plausibility checks — things the JSON Schema cannot express.
# Thresholds are configurable per network voltage class (MV/LV mixed).

"""
    domain_rules_check(net, findings) -> Dict{String,Any}

Check numerical plausibility of field values. All thresholds are
configurable via the `thresholds` keyword (see `_DEFAULT_THRESHOLDS`).
"""
function domain_rules_check(net::Dict{String,Any},
                             findings::Vector{Finding};
                             thresholds::Dict=_DEFAULT_THRESHOLDS)::Dict{String,Any}
    result = Dict{String,Any}()
    n_checks = Ref(0)

    _check_bus_voltage_bounds(net, findings, thresholds, n_checks)
    _check_load_power_factor(net, findings, thresholds, n_checks)
    _check_generator_cost(net, findings, thresholds, n_checks)
    _check_line_impedance(net, findings, thresholds, n_checks)
    _check_transformer_ratings(net, findings, thresholds, n_checks)
    _check_nonnegative_fields(net, findings, n_checks)
    _check_zero_limits(net, findings, n_checks)
    _check_zero_length(net, findings, n_checks)
    _check_angle_units(net, findings, n_checks)
    _check_negative_loads(net, findings, n_checks)

    result["n_checks_run"] = n_checks[]
    result
end

const _DEFAULT_THRESHOLDS = Dict{String,Any}(
    # Power factor
    "pf_min"            => 0.70,
    # Generator cost
    "cost_max_per_kwh"  => 10.0,   # $/kWh — flag if unrealistically high
    # Line series resistance: Ω/m; flag near-zero diagonal
    "r_series_min"      => 1e-9,
    # Transformer: max step ratio in either direction (33/0.4 kV ≈ 83,
    # 132/11 kV = 12; anything beyond 1000:1 is suspect)
    "xfmr_ratio_max"    => 1000.0
)

function _check_bus_voltage_bounds(net, findings, thresh, n_checks)
    for (id, b) in get(net, "bus", Dict())
        vmin = get(b, "v_min", nothing)
        vmax = get(b, "v_max", nothing)
        vmin === nothing && vmax === nothing && continue
        n_checks[] += 1

        if vmin !== nothing && Float64(vmin) < 0
            push!(findings, Finding(ERROR, "E.DOM.VMIN_NEGATIVE", :domain_rules, :bus, id,
                "Bus '$id': v_min = $(vmin) V is negative.",
                Dict{String,Any}("v_min" => vmin)))
        end
        if vmax !== nothing && Float64(vmax) <= 0
            push!(findings, Finding(ERROR, "E.DOM.VMAX_NONPOSITIVE", :domain_rules, :bus, id,
                "Bus '$id': v_max = $(vmax) V is ≤ 0.",
                Dict{String,Any}("v_max" => vmax)))
        end
    end
end

function _check_load_power_factor(net, findings, thresh, n_checks)
    pf_min = Float64(thresh["pf_min"])
    for (id, l) in get(net, "load", Dict())
        p = Float64.(get(l, "p_nom", Float64[]))
        q = Float64.(get(l, "q_nom", Float64[]))
        isempty(p) && continue
        n_checks[] += 1
        for (pi, qi) in zip(p, q)
            s = hypot(pi, qi)
            s <= 0 && continue
            pf = pi / s
            if pf < pf_min
                push!(findings, Finding(WARNING, "W.DOM.LOAD_PF_LOW", :domain_rules, :load, id,
                    "Load '$id' has power factor $(round(pf, digits=3)) < $pf_min.",
                    Dict{String,Any}("pf" => pf, "threshold" => pf_min)))
                break  # one warning per load
            end
        end
    end
end

function _check_generator_cost(net, findings, thresh, n_checks)
    cost_max = Float64(thresh["cost_max_per_kwh"])
    for (id, g) in get(net, "generator", Dict())
        haskey(g, "cost") || continue
        n_checks[] += 1
        # spec: cost is per-phase ($/kWh); scalar shorthand also accepted
        c = g["cost"]
        costs = c isa AbstractVector ? Float64.(c) : [Float64(c)]
        if any(<(0), costs)
            push!(findings, Finding(WARNING, "W.DOM.GEN_COST_NEGATIVE", :domain_rules,
                :generator, id,
                "Generator '$id' has negative cost $(minimum(costs)) \$/kWh.",
                Dict{String,Any}("cost" => costs)))
        elseif any(>(cost_max), costs)
            push!(findings, Finding(WARNING, "W.DOM.GEN_COST_HIGH", :domain_rules,
                :generator, id,
                "Generator '$id' cost $(maximum(costs)) \$/kWh exceeds threshold $cost_max \$/kWh.",
                Dict{String,Any}("cost" => costs, "threshold" => cost_max)))
        end
    end
end

function _check_line_impedance(net, findings, thresh, n_checks)
    r_min = Float64(thresh["r_series_min"])
    linecodes = get(net, "linecode", Dict())
    for (id, lc) in linecodes
        lc isa Dict || continue
        R = _pattern_keys_to_matrix(lc, "R_series_")
        R isa AbstractMatrix || continue
        n_checks[] += 1
        low = [i for i in 1:size(R, 1) if R[i, i] < r_min]
        if !isempty(low)
            push!(findings, Finding(WARNING, "W.DOM.LC_ZERO_R", :domain_rules,
                :linecode, id,
                "Linecode '$id' has near-zero or negative self-resistance on " *
                "diagonal entr$(length(low) == 1 ? "y" : "ies") $(low) " *
                "(superconducting?).",
                Dict{String,Any}("entries" => low, "threshold" => r_min)))
        end
    end
end

function _check_zero_limits(net, findings, n_checks)
    # A literal zero limit forces zero flow. Source tools often use 0 to
    # mean "no limit" — classic semantic abuse worth surfacing.
    for (comp_type, csym) in (("linecode", :linecode), ("line", :line),
                               ("switch", :switch))
        for (id, c) in get(net, comp_type, Dict())
            c isa Dict || continue
            for field in ("i_max", "s_max")
                haskey(c, field) || continue
                n_checks[] += 1
                v = c[field]
                vals = v isa AbstractVector ? Float64.(v) : [Float64(v)]
                if any(==(0.0), vals)
                    push!(findings, Finding(WARNING, "W.DOM.ZERO_LIMIT",
                        :domain_rules, csym, id,
                        "$comp_type '$id' has a zero entry in $field — read " *
                        "literally this forces zero flow; if it means 'no " *
                        "limit', drop the field instead.",
                        Dict{String,Any}("field" => field, "values" => vals)))
                end
            end
        end
    end
end

function _check_zero_length(net, findings, n_checks)
    for (id, l) in get(net, "line", Dict())
        l isa Dict || continue
        haskey(l, "length") || continue
        n_checks[] += 1
        if Float64(l["length"]) == 0.0
            push!(findings, Finding(WARNING, "W.DOM.ZERO_LENGTH", :domain_rules,
                :line, id,
                "Line '$id' has zero length — degenerate impedance; model " *
                "low-impedance sections with the lossless switch object instead.",
                nothing))
        end
    end
end

function _check_angle_units(net, findings, n_checks)
    # v_angle is radians per the data model; magnitudes beyond 2π are a
    # near-certain degrees-in-a-radians-field unit error
    for (id, vs) in get(net, "voltage_source", Dict())
        vs isa Dict || continue
        va = get(vs, "v_angle", nothing)
        va === nothing && continue
        n_checks[] += 1
        vals = va isa AbstractVector ? Float64.(va) : [Float64(va)]
        if any(a -> abs(a) > 2π, vals)
            push!(findings, Finding(WARNING, "W.DOM.ANGLE_UNITS", :domain_rules,
                :voltage_source, id,
                "Voltage source '$id' has |v_angle| > 2π — angles are radians " *
                "in the data model; this looks like degrees.",
                Dict{String,Any}("v_angle" => vals)))
        end
    end
end

function _check_negative_loads(net, findings, n_checks)
    neg = String[]
    for (id, l) in get(net, "load", Dict())
        l isa Dict || continue
        p = get(l, "p_nom", nothing)
        p === nothing && continue
        n_checks[] += 1
        vals = p isa AbstractVector ? Float64.(p) : [Float64(p)]
        any(<(0.0), vals) && push!(neg, id)
    end
    if !isempty(neg)
        push!(findings, Finding(INFO, "I.DOM.NEGATIVE_LOAD", :domain_rules,
            :load, nothing,
            "$(length(neg)) load(s) have negative p_nom — embedded generation " *
            "modeled as negative load; consider explicit generator objects: " *
            "$(join(sort(neg), ", ")).",
            Dict{String,Any}("loads" => sort(neg))))
    end
end

function _check_transformer_ratings(net, findings, thresh, n_checks)
    ratio_max = Float64(thresh["xfmr_ratio_max"])
    xfmr = get(net, "transformer", Dict())
    for subtype in ("single_phase", "center_tap", "wye_delta", "delta_wye")
        sub = get(xfmr, subtype, nothing)
        sub isa Dict || continue
        for (id, t) in sub
            vf = get(t, "v_ref_from", nothing)
            vt = get(t, "v_ref_to",   nothing)
            (vf === nothing || vt === nothing) && continue
            n_checks[] += 1
            vf, vt = Float64(vf), Float64(vt)
            (vf <= 0 || vt <= 0) && continue
            # direction-agnostic step ratio: 11kV/433V and 433V/11kV are the
            # same physical transformer
            step = max(vt / vf, vf / vt)
            if step > ratio_max
                push!(findings, Finding(WARNING, "W.DOM.XFMR_RATIO_OOB", :domain_rules,
                    :transformer, id,
                    "Transformer '$id' step ratio $(round(step, digits=1)):1 exceeds " *
                    "plausibility threshold $(ratio_max):1.",
                    Dict{String,Any}("step_ratio" => step,
                                     "v_ref_from" => vf, "v_ref_to" => vt)))
            end
        end
    end
end

function _check_nonnegative_fields(net, findings, n_checks)
    # Schema already enforces nonnegative_number via minimum:0, but JSON Schema
    # validation may not have run. Spot-check key fields.
    nonneg_checks = [
        ("line",    "length",        :line),
        ("linecode","R_series_1_1",  :linecode),
        ("linecode","X_series_1_1",  :linecode),
    ]
    for (comp_type, field, csym) in nonneg_checks
        for (id, comp) in get(net, comp_type, Dict())
            haskey(comp, field) || continue
            n_checks[] += 1
            val = comp[field]
            if val isa Number && Float64(val) < 0
                push!(findings, Finding(ERROR, "E.DOM.NEGATIVE_VALUE", :domain_rules,
                    csym, id,
                    "$comp_type '$id': $field = $val must be non-negative.",
                    Dict{String,Any}("field" => field, "value" => val)))
            end
        end
    end
end
