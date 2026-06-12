# validation/redundancy.jl

"""
    redundancy_check(net, findings) -> Dict{String,Any}

Identify redundant or trivial elements that do not contribute to
the OPF problem and may indicate data quality issues.
"""
function redundancy_check(net::Dict{String,Any},
                           findings::Vector{Finding})::Dict{String,Any}
    result = Dict{String,Any}()

    result["zero_loads"]         = _check_zero_loads(net, findings)
    result["mergeable_lines"]    = _check_mergeable_lines(net, findings)
    result["zero_shunts"]        = _check_zero_shunts(net, findings)
    result["unused_linecodes"]   = _check_unused_linecodes(net, findings)
    result["duplicate_linecodes"] = _check_duplicate_linecodes(net, findings)

    result
end

function _check_zero_loads(net, findings)
    zero_loads = String[]
    for (id, l) in get(net, "load", Dict())
        p = Float64.(get(l, "p_nom", Float64[]))
        q = Float64.(get(l, "q_nom", Float64[]))
        p_sum = isempty(p) ? 0.0 : sum(abs, p)
        q_sum = isempty(q) ? 0.0 : sum(abs, q)
        if p_sum == 0.0 && q_sum == 0.0
            push!(zero_loads, id)
        end
    end
    if !isempty(zero_loads)
        push!(findings, Finding(WARNING, "W.RED.ZERO_LOADS", :redundancy, :load, nothing,
            "$(length(zero_loads)) load(s) have p_nom=0 and q_nom=0 — electrically inert.",
            Dict{String,Any}("loads" => zero_loads)))
    end
    Dict{String,Any}("n" => length(zero_loads), "ids" => zero_loads)
end

function _check_mergeable_lines(net, findings)
    # A line is mergeable if its internal buses (both endpoints) have line-degree 2,
    # no other branch elements (switches, transformers), and no shunt elements
    # (loads, generators, shunts, sources) attached.
    buses = get(net, "bus", Dict())
    lines = get(net, "line", Dict())

    # Count line connections per bus; index lines by bus for chain growth
    bus_degree   = Dict{String,Int}(id => 0 for id in keys(buses))
    bus_elements = Dict{String,Int}(id => 0 for id in keys(buses))
    lines_at_bus = Dict{String,Vector{String}}()

    for (id, l) in lines
        for b in (get(l, "bus_from", nothing), get(l, "bus_to", nothing))
            b isa AbstractString && haskey(bus_degree, b) || continue
            bus_degree[b] += 1
            push!(get!(lines_at_bus, b, String[]), id)
        end
    end

    # Other branch elements block merging: a bus where a switch or transformer
    # tees off is a junction, not a pass-through point.
    for (_, sw) in get(net, "switch", Dict())
        for b in (get(sw, "bus_from", nothing), get(sw, "bus_to", nothing))
            b isa AbstractString && haskey(bus_elements, b) && (bus_elements[b] += 1)
        end
    end
    xfmr = get(net, "transformer", Dict())
    for subtype in ("single_phase", "center_tap", "wye_delta", "delta_wye")
        sub = get(xfmr, subtype, nothing)
        sub isa Dict || continue
        for (_, t) in sub
            for b in (get(t, "bus_from", nothing), get(t, "bus_to", nothing))
                b isa AbstractString && haskey(bus_elements, b) && (bus_elements[b] += 1)
            end
        end
    end

    for comp_type in ("load", "generator", "shunt", "voltage_source")
        for (_, c) in get(net, comp_type, Dict())
            b = get(c, "bus", nothing)
            b isa AbstractString && haskey(bus_elements, b) && (bus_elements[b] += 1)
        end
    end

    # Identify degree-2 pass-through buses with no element attachments
    passthrough = Set(id for id in keys(buses)
                      if bus_degree[id] == 2 && bus_elements[id] == 0)

    # Find line pairs sharing a pass-through bus
    mergeable_groups = Vector{Vector{String}}()
    visited_lines = Set{String}()

    for (id, l) in lines
        id in visited_lines && continue
        f, t = get(l, "bus_from", ""), get(l, "bus_to", "")

        if f in passthrough || t in passthrough
            # Grow the chain in both directions
            chain = [id]
            push!(visited_lines, id)
            _grow_chain!(chain, t, passthrough, lines, lines_at_bus, visited_lines)
            _grow_chain!(chain, f, passthrough, lines, lines_at_bus, visited_lines)
            length(chain) > 1 && push!(mergeable_groups, chain)
        end
    end

    if !isempty(mergeable_groups)
        total = sum(length, mergeable_groups)
        push!(findings, Finding(INFO, "I.RED.MERGEABLE_LINES", :redundancy, :line, nothing,
            "$(length(mergeable_groups)) group(s) of series lines ($total lines total) " *
            "can be merged — intermediate buses have no other connections.",
            Dict{String,Any}("n_groups" => length(mergeable_groups),
                             "groups"   => mergeable_groups)))
    end

    Dict{String,Any}(
        "n_groups"  => length(mergeable_groups),
        "groups"    => mergeable_groups
    )
end

function _grow_chain!(chain, start_bus, passthrough, lines, lines_at_bus, visited)
    current_bus = start_bus
    while current_bus in passthrough
        next_line = nothing
        for id in get(lines_at_bus, current_bus, String[])
            id in visited && continue
            l = lines[id]
            f, t = get(l, "bus_from", ""), get(l, "bus_to", "")
            next_line = (id, f == current_bus ? t : f)
            break
        end
        next_line === nothing && break
        push!(chain, next_line[1])
        push!(visited, next_line[1])
        current_bus = next_line[2]
    end
end

function _check_zero_shunts(net, findings)
    zero_shunts = String[]
    for (id, s) in get(net, "shunt", Dict())
        # Inert if every G_i_j / B_i_j matrix entry is zero
        all_zero = all(
            Float64(v) == 0.0
            for (k, v) in s
            if match(r"^[GB]_\d+_\d+$", k) !== nothing
        )
        all_zero && push!(zero_shunts, id)
    end
    if !isempty(zero_shunts)
        push!(findings, Finding(INFO, "I.RED.ZERO_SHUNTS", :redundancy, :shunt, nothing,
            "$(length(zero_shunts)) shunt(s) have all-zero G and B — electrically inert.",
            Dict{String,Any}("shunts" => zero_shunts)))
    end
    Dict{String,Any}("n" => length(zero_shunts), "ids" => zero_shunts)
end

function _check_unused_linecodes(net, findings)
    defined  = Set(keys(get(net, "linecode", Dict())))
    used     = Set(string(get(l, "linecode", ""))
                   for (_, l) in get(net, "line", Dict())
                   if haskey(l, "linecode"))
    unused   = setdiff(defined, used)
    if !isempty(unused)
        push!(findings, Finding(INFO, "I.RED.UNUSED_LINECODES", :redundancy, :linecode, nothing,
            "$(length(unused)) linecode(s) defined but not referenced by any line.",
            Dict{String,Any}("linecodes" => collect(unused))))
    end
    Dict{String,Any}("n" => length(unused), "ids" => collect(unused))
end

function _check_duplicate_linecodes(net, findings)
    linecodes = get(net, "linecode", Dict())
    # Compare R_series_1_1 and X_series_1_1 as a fingerprint. Linecodes
    # missing both fields are skipped — absent data is not evidence of
    # duplication.
    fingerprints = Dict{Tuple,Vector{String}}()
    for (id, lc) in linecodes
        haskey(lc, "R_series_1_1") || haskey(lc, "X_series_1_1") || continue
        r = round(Float64(get(lc, "R_series_1_1", 0.0)), digits=9)
        x = round(Float64(get(lc, "X_series_1_1", 0.0)), digits=9)
        push!(get!(fingerprints, (r, x), String[]), id)
    end
    dups = [(fp, ids) for (fp, ids) in fingerprints if length(ids) > 1]
    if !isempty(dups)
        push!(findings, Finding(INFO, "I.RED.DUPLICATE_LINECODES", :redundancy,
            :linecode, nothing,
            "$(length(dups)) group(s) of linecodes share identical R_series_1_1/X_series_1_1.",
            Dict{String,Any}("n_groups" => length(dups),
                             "groups"   => [ids for (_, ids) in dups])))
    end
    Dict{String,Any}("n_duplicate_groups" => length(dups),
                     "groups" => [ids for (_, ids) in dups])
end
