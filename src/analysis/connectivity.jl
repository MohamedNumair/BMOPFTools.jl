"""
    connectivity_analysis(net, findings) -> Dict{String,Any}

Build an undirected graph of the network and compute:
- Number of connected components
- Radial vs meshed topology (cycle detection)
- Degree statistics
- Tree depth and longest path from voltage source
- Open-switch isolated sections
"""
function connectivity_analysis(net::Dict{String,Any},
                                findings::Vector{Finding})::Dict{String,Any}
    result = Dict{String,Any}()

    buses = get(net, "bus", Dict())
    n     = length(buses)
    if n == 0
        result["n_components"] = 0
        return result
    end

    # Assign stable integer indices to bus names
    bus_names = collect(keys(buses))
    bus_index = Dict(name => i for (i, name) in enumerate(bus_names))

    g = SimpleGraph(n)

    # SimpleGraph deduplicates parallel edges and drops self-loops, so count
    # branch elements separately — radiality must see every physical branch.
    n_branches = Ref(0)

    # Helper: add an edge if both endpoints are known buses
    function add_edge_safe!(bus_a, bus_b)
        (bus_a isa AbstractString && bus_b isa AbstractString) || return
        i = get(bus_index, bus_a, nothing)
        j = get(bus_index, bus_b, nothing)
        (i === nothing || j === nothing) && return
        n_branches[] += 1
        add_edge!(g, i, j)
    end

    # Lines
    for (_, l) in get(net, "line", Dict())
        add_edge_safe!(get(l, "bus_from", nothing), get(l, "bus_to", nothing))
    end

    # Closed switches only
    for (_, sw) in get(net, "switch", Dict())
        get(sw, "open_switch", false) && continue
        add_edge_safe!(get(sw, "bus_from", nothing), get(sw, "bus_to", nothing))
    end

    # Transformers (each winding pair is an edge)
    xfmr = get(net, "transformer", Dict())
    for subtype in ("single_phase", "center_tap", "wye_delta", "delta_wye")
        sub = get(xfmr, subtype, nothing)
        sub isa Dict || continue
        for (_, t) in sub
            add_edge_safe!(get(t, "bus_from", nothing), get(t, "bus_to", nothing))
        end
    end

    # Voltage source buses (connected to their bus)
    vsrc_buses = String[]
    for (_, vs) in get(net, "voltage_source", Dict())
        b = get(vs, "bus", nothing)
        b isa AbstractString && push!(vsrc_buses, b)
    end

    # Connected components
    comps = connected_components(g)
    n_comps = length(comps)
    result["n_components"] = n_comps
    result["is_connected"]  = (n_comps == 1)

    if n_comps > 1
        # label each component's buses
        comp_bus_lists = Vector{Vector{String}}()
        for comp in comps
            push!(comp_bus_lists, [bus_names[i] for i in comp])
        end
        result["components"] = comp_bus_lists
        push!(findings, Finding(ERROR, "E.CONN.DISCONNECTED", :connectivity, :network, nothing,
            "Network has $n_comps disconnected components.",
            Dict{String,Any}("n_components" => n_comps)))
    end

    # Degree statistics
    degrees = degree(g)
    result["degree_min"]    = minimum(degrees)
    result["degree_max"]    = maximum(degrees)
    result["degree_mean"]   = mean(degrees)
    result["degree_median"] = median(degrees)

    degree_1_buses = [bus_names[i] for i in 1:n if degrees[i] == 1]
    degree_2_buses = [bus_names[i] for i in 1:n if degrees[i] == 2]
    result["degree_1_buses"] = degree_1_buses   # end-nodes / laterals
    result["degree_2_buses"] = degree_2_buses   # pass-through nodes
    result["n_degree_1"]     = length(degree_1_buses)
    result["n_degree_2"]     = length(degree_2_buses)

    # Radial vs meshed: a forest on n vertices has exactly n - n_components
    # edges. Use the physical branch count, not ne(g), so parallel branches
    # between the same bus pair are detected as cycles.
    n_edges         = n_branches[]
    n_vertices      = nv(g)
    tree_edge_count = n_vertices - n_comps
    is_radial       = (n_edges == tree_edge_count)
    result["is_radial"]       = is_radial
    result["n_extra_edges"]   = n_edges - tree_edge_count  # 0 for radial

    if !is_radial
        push!(findings, Finding(WARNING, "W.CONN.MESHED", :connectivity, :network, nothing,
            "Network contains $(n_edges - tree_edge_count) extra edge(s) forming cycles — not purely radial.",
            Dict{String,Any}("extra_edges" => n_edges - tree_edge_count)))
    end

    # Tree depth from each voltage source bus
    if !isempty(vsrc_buses)
        result["source_buses"] = vsrc_buses
        max_depth   = 0
        max_path    = String[]
        for src in vsrc_buses
            src_idx = get(bus_index, src, nothing)
            src_idx === nothing && continue
            dists = gdistances(g, src_idx)
            finite_dists = filter(d -> d < typemax(Int), dists)
            isempty(finite_dists) && continue
            d = maximum(finite_dists)
            if d > max_depth
                max_depth = d
                # trace back the farthest bus
                farthest_idx = findfirst(==(d), dists)
                if farthest_idx !== nothing
                    max_path = _trace_path(g, src_idx, farthest_idx, bus_names)
                end
            end
        end
        result["tree_depth_max"]   = max_depth
        result["longest_path_buses"] = max_path
    end

    # Open switch isolated sections: buses only reachable through open switches
    open_sw_buses = String[]
    for (_, sw) in get(net, "switch", Dict())
        !get(sw, "open_switch", false) && continue
        b_to = get(sw, "bus_to", nothing)
        b_to isa AbstractString && push!(open_sw_buses, b_to)
    end
    result["open_switch_isolated_buses"] = unique(open_sw_buses)

    # Dangling buses: degree 1 with no load, generator, or shunt attached
    load_buses = Set(string(get(l, "bus", "")) for (_, l) in get(net, "load",      Dict()))
    gen_buses  = Set(string(get(g, "bus", "")) for (_, g) in get(net, "generator", Dict()))
    shunt_buses = Set(string(get(s, "bus", "")) for (_, s) in get(net, "shunt",    Dict()))
    vsrc_set   = Set(vsrc_buses)
    dangling   = [b for b in degree_1_buses
                  if !(b in load_buses) && !(b in gen_buses) &&
                     !(b in shunt_buses) && !(b in vsrc_set)]
    result["dangling_buses"] = dangling
    if !isempty(dangling)
        push!(findings, Finding(WARNING, "W.CONN.DANGLING", :connectivity, :bus, nothing,
            "$(length(dangling)) bus(es) are degree-1 with no attached load, generator, or shunt.",
            Dict{String,Any}("buses" => dangling)))
    end

    result
end

"""Simple BFS path reconstruction."""
function _trace_path(g::SimpleGraph, src::Int, dst::Int,
                     names::Vector{String})::Vector{String}
    prev = fill(-1, nv(g))
    visited = falses(nv(g))
    queue   = Int[src]
    visited[src] = true
    while !isempty(queue)
        v = popfirst!(queue)
        v == dst && break
        for w in neighbors(g, v)
            visited[w] && continue
            visited[w] = true
            prev[w] = v
            push!(queue, w)
        end
    end
    path = Int[]
    v = dst
    while v != -1
        push!(path, v)
        v = prev[v]
    end
    reverse!(path)
    [names[i] for i in path]
end
