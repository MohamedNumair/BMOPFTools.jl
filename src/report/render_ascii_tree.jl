# report/render_ascii_tree.jl
#
# ASCII tree renderer for BMOPF networks.
#
# Algorithm: BFS from the source bus builds a spanning tree; DFS renders it
# with box-drawing characters. Two compression modes handle large networks:
#
#   fold_chains  – consecutive single-child un-annotated buses are collapsed
#                  into a "⋮ (N buses)" stub, keeping the tree width narrow.
#   max_depth    – subtrees beyond this depth (in compact mode) are replaced
#                  with a one-line "[+N buses, M loads]" summary.
#
# Example output (small LV network):
#
#   b1504 (SRC)
#   └── [tx3270: Dyn1 11.0kV/433V]── b1080
#       ├── b2165
#       │   └── [SW]── b2836
#       │       ├── b559 (L1,L2)
#       │       └── b251 (L3)
#       └── b683
#
#   Loads (3 total):
#     L1 = ld123_load_a   3.50 kW  WYE  phases: 1,2,3

"""
    render_ascii_tree(net, io; max_buses, max_depth, fold_chains)

Write an ASCII tree of the network graph to `io`.

**Node labels** – the source bus is tagged `SRC`; loads on a bus appear as
`L1,L2,…` and generators as `G1,G2,…` (numbered globally, mapped in the
legend printed after the tree). Transformer and switch edges are annotated.

**Large-network handling** – when the bus count exceeds `max_buses`:
- `fold_chains=true` (default) collapses unbranched corridors with no
  attached loads or generators into a `⋮ (N buses)` stub.
- Subtrees deeper than `max_depth` are replaced by a one-line summary.

**Legend** – a load/generator index is appended after the tree.
"""
function render_ascii_tree(net::Dict{String,Any}, io::IO;
                            max_buses::Int    = 200,
                            max_depth::Int    = 8,
                            fold_chains::Bool = true,
                            legend_limit::Int = 50)

    buses     = get(net, "bus",             Dict())
    lines     = get(net, "line",            Dict())
    switches  = get(net, "switch",          Dict())
    loads     = get(net, "load",            Dict())
    gens      = get(net, "generator",       Dict())
    sources   = get(net, "voltage_source",  Dict())
    xfmr_dict = get(net, "transformer",     Dict())

    n_buses = length(buses)
    compact = n_buses > max_buses

    # ── 1. Adjacency list ────────────────────────────────────────────────────
    # Each entry: (neighbor, edge_type, edge_id, is_open, edge_label)

    adj = Dict{String, Vector{NTuple{5,Any}}}()
    for bid in keys(buses)
        adj[bid] = NTuple{5,Any}[]
    end

    function add_edge!(a, b, etype, eid, is_open, label)
        (haskey(adj, a) && haskey(adj, b)) || return
        push!(adj[a], (b, etype, eid, is_open, label))
        push!(adj[b], (a, etype, eid, is_open, label))
    end

    for (lid, l) in lines
        add_edge!(get(l,"bus_from",""), get(l,"bus_to",""), :line, lid, false, "")
    end
    for (sid, sw) in switches
        is_open = get(sw, "open_switch", false)
        add_edge!(get(sw,"bus_from",""), get(sw,"bus_to",""), :switch, sid, is_open, "")
    end
    for subtype in ("single_phase","center_tap","wye_delta","delta_wye")
        for (tid, tx) in get(xfmr_dict, subtype, Dict())
            vg    = _derive_vector_group(subtype, tx)
            vf    = get(tx, "v_ref_from", nothing)
            vt    = get(tx, "v_ref_to",   nothing)
            ratio = (vf !== nothing && vt !== nothing) ?
                    " $(round(Float64(vf)/1000, digits=1))kV/$(round(Int, Float64(vt)))V" : ""
            add_edge!(get(tx,"bus_from",""), get(tx,"bus_to",""),
                      :transformer, tid, false, "$(tid): $vg$ratio")
        end
    end

    # ── 2. Bus annotations ────────────────────────────────────────────────────
    source_buses = Set{String}(get(s,"bus","") for (_, s) in sources)

    bus_loads = Dict{String,Vector{String}}()
    bus_gens  = Dict{String,Vector{String}}()
    for (lid, l) in loads
        push!(get!(bus_loads, get(l,"bus",""), String[]), lid)
    end
    for (gid, g) in gens
        push!(get!(bus_gens, get(g,"bus",""), String[]), gid)
    end

    all_load_ids = sort(collect(keys(loads)))
    all_gen_ids  = sort(collect(keys(gens)))
    load_num = Dict(lid => "L$i" for (i, lid) in enumerate(all_load_ids))
    gen_num  = Dict(gid => "G$i" for (i, gid) in enumerate(all_gen_ids))

    function is_annotated(bid)
        bid in source_buses ||
        !isempty(get(bus_loads, bid, String[])) ||
        !isempty(get(bus_gens,  bid, String[]))
    end

    # ── 3. BFS spanning tree ──────────────────────────────────────────────────
    root = isempty(source_buses) ? first(sort(collect(keys(buses)))) :
                                   first(sort(collect(source_buses)))

    parent      = Dict{String,Union{String,Nothing}}(root => nothing)
    parent_edge = Dict{String,Union{NTuple{5,Any},Nothing}}(root => nothing)
    bfs_order   = String[]
    children    = Dict{String,Vector{String}}()

    visited = Set{String}([root])
    queue   = [root]
    while !isempty(queue)
        cur = popfirst!(queue)
        push!(bfs_order, cur)
        children[cur] = String[]
        for e in sort(adj[cur], by = e -> e[1])
            nbr = e[1]
            nbr in visited && continue
            push!(visited, nbr)
            parent[nbr]      = cur
            parent_edge[nbr] = e
            push!(children[cur], nbr)
            push!(queue, nbr)
        end
    end

    unreachable = [b for b in keys(buses) if !haskey(parent, b)]

    # ── 4. Subtree statistics ─────────────────────────────────────────────────
    subtree_buses = Dict{String,Int}()
    subtree_loads = Dict{String,Int}()
    for bid in reverse(bfs_order)
        subtree_buses[bid] = 1 + sum(get(subtree_buses, c, 1)
                                     for c in get(children, bid, String[]); init=0)
        subtree_loads[bid] = length(get(bus_loads, bid, String[])) +
                             sum(subtree_loads[c] for c in get(children, bid, String[]); init=0)
    end

    # ── 5. Chain detection ────────────────────────────────────────────────────
    # A "chain" is a maximal run of buses where each internal bus has exactly
    # one child, no annotations, and its incoming edge is a plain line.
    # We replace each chain with: first_bus … ⋮ (N buses) … last_bus.
    # (Only applied when compact && fold_chains.)

    # chain_fold[bid] = number of un-annotated single-child buses to skip
    # before the next interesting node.
    chain_skip = Dict{String,Int}()  # bid → n buses folded after it

    if compact && fold_chains
        for bid in bfs_order
            kids = get(children, bid, String[])
            length(kids) == 1 || continue
            is_annotated(bid) && continue
            # Check the edge to this bus — don't fold across transformer/switch
            pe = parent_edge[bid]
            pe !== nothing && pe[2] != :line && continue
            # Walk the chain forward
            n_folded = 0
            cur = bid
            while true
                kk = get(children, cur, String[])
                length(kk) != 1 && break
                child = kk[1]
                is_annotated(child) && break
                ce = parent_edge[child]
                ce !== nothing && ce[2] != :line && break
                n_folded += 1
                cur = child
            end
            n_folded > 0 && (chain_skip[bid] = n_folded)
        end
    end

    # ── 6. Formatting helpers ─────────────────────────────────────────────────
    function fmt_bus(bid)
        tags = String[]
        bid in source_buses && push!(tags, "SRC")
        ls = [load_num[l] for l in get(bus_loads, bid, String[]) if haskey(load_num, l)]
        gs = [gen_num[g]  for g in get(bus_gens,  bid, String[]) if haskey(gen_num, g)]
        !isempty(ls) && push!(tags, join(ls, ","))
        !isempty(gs) && push!(tags, join(gs, ","))
        isempty(tags) ? bid : "$bid ($(join(tags, " ")))"
    end

    function fmt_edge(e::NTuple{5,Any})
        etype, is_open, label = e[2], e[4], e[5]
        etype == :transformer && return "[$(label)]── "
        etype == :switch       && return is_open ? "[SW:open]── " : "[SW]── "
        return ""
    end

    # ── 7. DFS renderer ──────────────────────────────────────────────────────
    # skip_set: buses already consumed by a chain fold (don't render individually)
    skip_set = Set{String}()

    function dfs(bid, prefix, is_last, depth)
        bid in skip_set && return

        edge  = parent_edge[bid]
        bchar = is_last ? "└── " : "├── "
        elabel = edge !== nothing ? fmt_edge(edge) : ""

        # Depth-based subtree collapse (compact mode)
        if compact && depth > max_depth && subtree_buses[bid] > 1
            nb = subtree_buses[bid]
            nl = subtree_loads[bid]
            println(io, "$(prefix)$(bchar)$(elabel)$(fmt_bus(bid)) [+$(nb-1) buses, $nl loads]")
            return
        end

        # Chain fold: skip N single-child un-annotated successors
        n_fold = get(chain_skip, bid, 0)
        if n_fold > 0
            println(io, "$(prefix)$(bchar)$(elabel)$(fmt_bus(bid))")
            # Walk n_fold buses and collect into skip_set
            cur = bid
            for _ in 1:n_fold
                child = get(children, cur, String[])[1]
                push!(skip_set, child)
                cur = child
            end
            child_prefix = prefix * (is_last ? "    " : "│   ")
            # Show fold stub, then continue from the end of the chain
            println(io, "$(child_prefix)⋮  ($n_fold buses)")
            # The "end of chain" bus is `cur`; render it next
            # Its children are the branches from the chain end
            chain_kids = get(children, cur, String[])
            for (i, ck) in enumerate(chain_kids)
                ck_is_last = i == length(chain_kids)
                dfs(ck, child_prefix, ck_is_last, depth + 1)
            end
            return
        end

        println(io, "$(prefix)$(bchar)$(elabel)$(fmt_bus(bid))")

        kids = get(children, bid, String[])
        for (i, child) in enumerate(kids)
            child_is_last = i == length(kids)
            child_prefix  = prefix * (is_last ? "    " : "│   ")
            dfs(child, child_prefix, child_is_last, depth + 1)
        end
    end

    # ── 8. Render ─────────────────────────────────────────────────────────────
    if compact
        println(io, "# Network graph  ($n_buses buses, compressed)")
    else
        println(io, "# Network graph  ($n_buses buses)")
    end
    println(io)

    println(io, fmt_bus(root))
    kids = get(children, root, String[])
    for (i, child) in enumerate(kids)
        dfs(child, "", i == length(kids), 1)
    end

    if !isempty(unreachable)
        println(io, "\n# Disconnected buses ($(length(unreachable)) — not reachable from source):")
        for bid in sort(unreachable)[1:min(10, length(unreachable))]
            println(io, "  $(fmt_bus(bid))")
        end
        length(unreachable) > 10 && println(io, "  … and $(length(unreachable)-10) more")
    end

    # ── 9. Legend ─────────────────────────────────────────────────────────────
    if !isempty(loads)
        println(io, "\nLoads ($(length(loads)) total):")
        shown = min(length(all_load_ids), legend_limit)
        for (i, lid) in enumerate(all_load_ids[1:shown])
            l    = get(loads, lid, Dict())
            p_w  = sum(Float64.(get(l, "p_nom", Float64[])); init=0.0)
            p_kw = round(p_w / 1000, digits=2)
            cfg  = get(l, "configuration", "WYE")
            tm   = get(l, "terminal_map", [])
            ph   = filter(t -> string(t) != "n", string.(tm))
            println(io, "  L$i = $(rpad(lid, 16)) $(lpad(p_kw, 6)) kW  $cfg  phases: $(join(ph,","))")
        end
        shown < length(all_load_ids) &&
            println(io, "  … and $(length(all_load_ids) - shown) more (pass legend_limit= to show all)")
    end

    if !isempty(gens)
        println(io, "\nGenerators ($(length(gens)) total):")
        for (i, gid) in enumerate(all_gen_ids)
            g     = get(gens, gid, Dict())
            p_max = sum(Float64.(get(g, "p_max", Float64[])); init=0.0)
            p_kw  = round(p_max / 1000, digits=2)
            println(io, "  G$i = $(rpad(gid, 16)) max $(lpad(p_kw, 6)) kW")
        end
    end
end
