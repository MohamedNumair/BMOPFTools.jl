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

    # --- terminal map conventions ---
    _check_terminal_map_conventions!(net, findings, result)

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

# ---------------------------------------------------------------------------
# Terminal map convention checks
# ---------------------------------------------------------------------------
#
# Three rules:
#  E.TMAP.PHASE_TO_NEUTRAL — any terminal in a component's map that occupies
#    a phase position but resolves to the bus neutral. "Phase position" is any
#    slot that is not the expected neutral slot: for nodal WYE/SINGLE_PHASE
#    components the neutral slot is the last entry; for DELTA components and
#    lines/switches there is no neutral slot at all. Transformer maps are
#    exempt (non-trivial neutral involvement is expected).
#
#  I.TMAP.CROSS_PHASE_LINE — terminal_map_from != terminal_map_to on a line
#    or switch, implying cross-phase / transposed wiring.
#
#  I.TMAP.PERMUTED_ORDER — the terminal map entries appear in a different
#    relative order than they do in the bus's terminal_names (permuted
#    connection). Phase subsetting is fine; only ordering is flagged.
#    Transformers are exempt.

function _check_terminal_map_conventions!(net, findings, result)
    buses = get(net, "bus", Dict())

    # Helper: neutral terminal name for a bus (nothing if not identified)
    bus_neutral(bid) = begin
        b = get(buses, bid, nothing)
        b isa Dict ? _neutral_terminal(b) : nothing
    end

    # Helper: relative order of terminals as they appear in terminal_names
    # Returns true if `tm` entries appear in the same relative order as in
    # `terminal_names` (subsequence check, ignoring elements not in tm).
    function _ordered_subsequence(tm, terminal_names)
        # Filter terminal_names to only those appearing in tm, then check
        # if that filtered list equals tm.
        tm_set = Set(tm)
        filtered = [t for t in terminal_names if t in tm_set]
        filtered == tm
    end

    n_phase_neutral = 0
    n_cross_phase   = 0
    n_permuted      = 0

    # ── Nodal elements ───────────────────────────────────────────────────────
    # Shunts are exempt from the "all entries neutral" check: a shunt whose
    # terminal_map is purely ["n"] is a neutral-to-ground admittance (NER/
    # grounding impedance), which is a standard and legitimate earthing model.
    for comp_type in ("load", "generator", "shunt", "voltage_source")
        for (id, c) in get(net, comp_type, Dict())
            c isa Dict || continue
            bid = get(c, "bus", nothing)
            bid isa AbstractString || continue
            nn  = bus_neutral(bid)
            nn === nothing && continue   # bus has no identified neutral

            tm  = Vector{String}(get(c, "terminal_map", String[]))
            isempty(tm) && continue
            cfg = get(c, "configuration", nothing)

            # Determine the expected neutral slot: last position for WYE and
            # SINGLE_PHASE; none for DELTA.
            neutral_slot = if cfg == "DELTA"
                nothing
            else
                length(tm)   # last position is the expected return/neutral
            end

            # Flag when the map contains no phase conductors at all (every
            # entry is the neutral). Shunts are exempt: terminal_map=["n"] is
            # a valid neutral-to-ground earthing admittance.
            if comp_type != "shunt" && all(string(t) == nn for t in tm)
                n_phase_neutral += 1
                push!(findings, Finding(ERROR, "E.TMAP.PHASE_TO_NEUTRAL", :spec,
                    Symbol(comp_type), id,
                    "$comp_type '$id': terminal_map $tm contains no phase " *
                    "conductors — all entries resolve to neutral '$nn' of bus '$bid'.",
                    Dict{String,Any}("bus" => bid, "neutral" => nn,
                                     "terminal_map" => tm)))
            else
                for (pos, t) in enumerate(tm)
                    string(t) == nn || continue
                    # This entry is the neutral terminal — flag only if it
                    # occupies a phase slot (not the expected trailing slot).
                    if neutral_slot === nothing || pos != neutral_slot
                        n_phase_neutral += 1
                        push!(findings, Finding(ERROR, "E.TMAP.PHASE_TO_NEUTRAL", :spec,
                            Symbol(comp_type), id,
                            "$comp_type '$id': terminal at position $pos is wired " *
                            "to neutral '$nn' of bus '$bid', which is a phase " *
                            "position$(neutral_slot === nothing ? " (DELTA has no neutral slot)" :
                                       " (expected neutral at position $neutral_slot)").",
                            Dict{String,Any}("bus" => bid, "neutral" => nn,
                                             "position" => pos, "terminal_map" => tm)))
                    end
                end
            end

            # Ordering check against bus terminal_names
            b = buses[bid]
            tn = Vector{String}(get(b, "terminal_names", String[]))
            isempty(tn) && continue
            if !_ordered_subsequence(tm, tn)
                n_permuted += 1
                push!(findings, Finding(INFO, "I.TMAP.PERMUTED_ORDER", :spec,
                    Symbol(comp_type), id,
                    "$comp_type '$id' terminal_map $tm is a permutation of the " *
                    "expected order from bus '$bid' terminal_names $tn — check " *
                    "whether phases are wired in the intended order.",
                    Dict{String,Any}("bus" => bid, "terminal_map" => tm,
                                     "terminal_names" => tn)))
            end
        end
    end

    # ── Lines and switches ────────────────────────────────────────────────────
    for comp_type in ("line", "switch")
        for (id, c) in get(net, comp_type, Dict())
            c isa Dict || continue

            tmf = Vector{String}(get(c, "terminal_map_from", String[]))
            tmt = Vector{String}(get(c, "terminal_map_to",   String[]))

            # Cross-phase check
            if !isempty(tmf) && !isempty(tmt) && tmf != tmt
                n_cross_phase += 1
                push!(findings, Finding(INFO, "I.TMAP.CROSS_PHASE_LINE", :spec,
                    Symbol(comp_type), id,
                    "$comp_type '$id' has different from/to terminal maps " *
                    "(from=$tmf, to=$tmt) — implies cross-phase or transposed " *
                    "wiring, which is rare in distribution networks.",
                    Dict{String,Any}("terminal_map_from" => tmf,
                                     "terminal_map_to"   => tmt)))
            end

            # Phase-to-neutral check on each end
            for (side, tm, bus_key) in (("from", tmf, "bus_from"),
                                         ("to",   tmt, "bus_to"))
                bid = get(c, bus_key, nothing)
                bid isa AbstractString || continue
                nn  = bus_neutral(bid)
                nn === nothing && continue
                isempty(tm) && continue
                # For lines/switches there is no "expected" neutral slot — any
                # neutral in the map is flagged only when it also appears in
                # the other end's map at the same position (symmetric neutral
                # return is fine). Asymmetric neutral involvement is flagged
                # via the cross-phase rule already. Here we catch the case
                # where ALL entries are the neutral (degenerate map).
                if all(string(t) == nn for t in tm)
                    n_phase_neutral += 1
                    push!(findings, Finding(ERROR, "E.TMAP.PHASE_TO_NEUTRAL", :spec,
                        Symbol(comp_type), id,
                        "$comp_type '$id' $side terminal map $tm consists " *
                        "entirely of neutral '$nn' at bus '$bid'.",
                        Dict{String,Any}("bus" => bid, "neutral" => nn,
                                         "side" => side, "terminal_map" => tm)))
                end
            end

            # Ordering check on each end against bus terminal_names
            for (tm, bus_key) in ((tmf, "bus_from"), (tmt, "bus_to"))
                bid = get(c, bus_key, nothing)
                bid isa AbstractString || continue
                b = get(buses, bid, nothing)
                b isa Dict || continue
                tn = Vector{String}(get(b, "terminal_names", String[]))
                isempty(tn) || isempty(tm) && continue
                if !_ordered_subsequence(tm, tn)
                    n_permuted += 1
                    push!(findings, Finding(INFO, "I.TMAP.PERMUTED_ORDER", :spec,
                        Symbol(comp_type), id,
                        "$comp_type '$id' terminal map $tm is a permutation of " *
                        "the expected order from bus '$bid' terminal_names $tn.",
                        Dict{String,Any}("bus" => bid, "terminal_map" => tm,
                                         "terminal_names" => tn)))
                end
            end
        end
    end

    result["n_phase_to_neutral"] = n_phase_neutral
    result["n_cross_phase_lines"] = n_cross_phase
    result["n_permuted_terminal_maps"] = n_permuted
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
