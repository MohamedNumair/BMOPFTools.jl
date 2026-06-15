"""
    provenance_analysis(net, findings) -> Dict{String,Any}

Detect signatures of how the dataset was produced, and make implicit
modeling assumptions explicit:

1. **Linecode impedance classification** — per linecode, classify the phase
   block of the series impedance matrix:
   - `decoupled`        — diagonal matrix: positive-sequence-only data; the
                          three phases are mathematically independent.
   - `exactly_balanced` — equal self and equal mutual entries: constructed
                          from sequence parameters (r1,x1,r0,x0) or under a
                          transposition assumption. The implied Z1/Z0 are
                          recovered and reported.
   - `near_balanced`    — balanced within 1%: possibly physical (twisted /
                          bundled symmetric cable construction).
   - `distinct`         — consistent with first-principles geometry (Carson).
   Also checks reciprocity (Z symmetric) and passivity (R block PSD).

2. **Wires per voltage level** — 3-wire vs 4-wire classification. A 3-wire
   LV level is flagged as likely Kron-reduced (LV is physically 4-wire);
   3-wire MV is normal. A 4-wire network whose neutrals are all perfectly
   grounded is exactly Kron-reducible (redundant variables).

3. **Neutral grounding** — builds the neutral-conductor continuity graph and
   verifies every neutral section reaches a grounding (perfect grounding,
   grounding shunt, or a source that references the neutral). Floating
   neutral sections leave the zero-sequence path undefined.

The summary string under `"convention"` states the inferred modeling
convention explicitly; renderers print it in the report.
"""
function provenance_analysis(net::Dict{String,Any},
                              findings::Vector{Finding})::Dict{String,Any}
    result = Dict{String,Any}()
    vl = voltage_level_analysis(net, Finding[])   # duplicate findings discarded
    result["linecodes"]           = _classify_linecodes(net, findings)
    result["wires_by_level"]      = _wires_by_level(net, findings, vl)
    result["grounding"]           = _grounding_analysis(net, findings)
    result["opendss_defaults"]    = _check_opendss_defaults(net, findings,
                                                              result["linecodes"])
    result["impedance_transform"] = _classify_impedance_transformation(
                                        net, findings, result["linecodes"])
    result["earthing_zones"]      = _earthing_zones(net, vl)
    _check_regulator_patterns(net, findings, vl)
    _check_bus_shunts(net, findings)
    result["redundant_voltage_bounds"]    = _check_bus_voltage_bound_redundancy(net, findings)
    result["inconsistent_bounds"]         = _check_bus_voltage_bound_consistency(net, findings)
    result["inapplicable_voltage_bounds"] = _check_bus_voltage_bound_applicability(net, findings)
    result["overlapping_voltage_bounds"]  = _check_bus_voltage_bound_overlap(net, findings)
    result["i_max_incomplete"]            = _check_i_max_completeness(net, findings)
    result["convention"]          = _convention_statement(result)
    result
end

# ---------------------------------------------------------------------------
# 1. Linecode impedance classification
# ---------------------------------------------------------------------------

function _classify_linecodes(net::Dict{String,Any},
                              findings::Vector{Finding})::Dict{String,Any}
    linecodes = get(net, "linecode", Dict())
    by_lc = Dict{String,Any}()
    verdict_counts = Dict{String,Int}()
    seq_ids = String[]
    dec_ids = String[]

    for (id, lc) in linecodes
        lc isa Dict || continue
        R = _pattern_keys_to_matrix(lc, "R_series_")
        R === nothing && continue
        X = _pattern_keys_to_matrix(lc, "X_series_")
        n = size(R, 1)
        Xm = (X isa AbstractMatrix && size(X) == size(R)) ? X : zeros(n, n)

        entry = Dict{String,Any}("n_conductors" => n)

        # Reciprocity: the impedance matrix of a passive line is symmetric
        scale = max(maximum(abs.(R)), maximum(abs.(Xm)), 1e-300)
        asym  = max(maximum(abs.(R - transpose(R))),
                    maximum(abs.(Xm - transpose(Xm)))) / scale
        entry["reciprocity_error"] = asym
        if asym > 1e-6
            push!(findings, Finding(ERROR, "E.PROV.NONRECIPROCAL", :provenance,
                :linecode, id,
                "Linecode '$id' impedance matrix is not symmetric (relative " *
                "asymmetry $(round(asym, sigdigits=3))) — violates reciprocity; " *
                "likely data corruption.",
                Dict{String,Any}("asymmetry" => asym)))
        end

        # Passivity: R block must be positive semidefinite
        Rsym = Symmetric((R + transpose(R)) / 2)
        ev   = eigvals(Rsym)
        entry["r_eig_min"] = minimum(ev)
        if minimum(ev) < -1e-9 * max(maximum(abs.(ev)), 1e-12)
            push!(findings, Finding(ERROR, "E.PROV.NONPASSIVE", :provenance,
                :linecode, id,
                "Linecode '$id' resistance matrix has a negative eigenvalue " *
                "($(round(minimum(ev), sigdigits=3))) — non-passive; the line " *
                "would generate power.",
                Dict{String,Any}("r_eigenvalues" => collect(ev))))
        end

        # X block: series reactance is inductive at power frequency —
        # positive diagonals, and the inductance matrix is PSD (energy
        # argument). Both properties survive Kron reduction (Schur
        # complements of sectorial matrices stay sectorial).
        if X isa AbstractMatrix && size(X) == size(R)
            xdiag = [Xm[i, i] for i in 1:n]
            bad = [i for i in 1:n if xdiag[i] <= 0]
            if !isempty(bad)
                push!(findings, Finding(WARNING, "W.PROV.X_NONINDUCTIVE",
                    :provenance, :linecode, id,
                    "Linecode '$id' has non-positive series self-reactance on " *
                    "diagonal entr$(length(bad) == 1 ? "y" : "ies") $(bad) — " *
                    "likely a sign flip or X/B confusion.",
                    Dict{String,Any}("entries" => bad)))
            end
            evx = eigvals(Symmetric((Xm + transpose(Xm)) / 2))
            entry["x_eig_min"] = minimum(evx)
            if minimum(evx) < -1e-9 * max(maximum(abs.(evx)), 1e-12)
                push!(findings, Finding(WARNING, "W.PROV.X_NOT_PSD",
                    :provenance, :linecode, id,
                    "Linecode '$id' reactance matrix has a negative eigenvalue " *
                    "($(round(minimum(evx), sigdigits=3))) — the implied " *
                    "inductance matrix is not physically realisable.",
                    Dict{String,Any}("x_eigenvalues" => collect(evx))))
            end
        end

        # Mutual resistance sign (soft): Carson's earth-return term makes
        # off-diagonal R positive for lines parameterised from geometry
        if n >= 2
            negm = [(i, j) for i in 1:n for j in i+1:n if R[i, j] < -1e-12]
            if !isempty(negm)
                entry["negative_mutual_r"] = negm
                push!(findings, Finding(INFO, "I.PROV.NEGATIVE_MUTUAL_R",
                    :provenance, :linecode, id,
                    "Linecode '$id' has negative mutual resistance entr" *
                    "$(length(negm) == 1 ? "y" : "ies") $(negm) — unusual; " *
                    "Carson-derived matrices have positive mutuals.",
                    Dict{String,Any}("entries" => negm)))
            end
            # Carson fingerprint: report mutual-R statistics
            muts = [R[i, j] for i in 1:n for j in i+1:n]
            entry["mutual_r_mean"]   = sum(muts) / length(muts)
            entry["mutual_r_spread"] = maximum(muts) - minimum(muts)
        end

        # Shunt admittance blocks: G must be passive (PSD, nonneg diag);
        # B comes from the Maxwell capacitance matrix — nonneg diagonals,
        # non-positive off-diagonals, PSD
        for (prefix, isG) in (("G_from_", true), ("G_to_", true),
                               ("B_from_", false), ("B_to_", false))
            M = _pattern_keys_to_matrix(lc, prefix)
            M isa AbstractMatrix || continue
            scaleM = max(maximum(abs.(M)), 1e-300)
            if maximum(abs.(M - transpose(M))) / scaleM > 1e-6
                push!(findings, Finding(ERROR, "E.PROV.NONRECIPROCAL",
                    :provenance, :linecode, id,
                    "Linecode '$id' $(prefix)block is not symmetric — " *
                    "violates reciprocity.", nothing))
            end
            nm = size(M, 1)
            if isG
                evg = eigvals(Symmetric((M + transpose(M)) / 2))
                if any(M[i, i] < -1e-12 for i in 1:nm) ||
                   minimum(evg) < -1e-9 * max(maximum(abs.(evg)), 1e-12)
                    push!(findings, Finding(ERROR, "E.PROV.NEGATIVE_G",
                        :provenance, :linecode, id,
                        "Linecode '$id' $(prefix)conductance block is not " *
                        "positive semidefinite — an active (power-generating) " *
                        "shunt.", nothing))
                end
            else
                evb = eigvals(Symmetric((M + transpose(M)) / 2))
                scaleB = max(maximum(abs.(M)), 1e-300)
                bad_diag = any(M[i, i] < -1e-9 * scaleB for i in 1:nm)
                bad_eig  = minimum(evb) < -1e-9 * max(maximum(abs.(evb)), 1e-12)
                pos_off  = any(M[i, j] > 1e-9 * scaleB
                               for i in 1:nm for j in 1:nm if i != j)
                if bad_diag || bad_eig
                    # PSD and nonnegative diagonals are invariant (capacitance
                    # matrix energy argument, preserved by Schur complements)
                    push!(findings, Finding(WARNING, "W.PROV.B_SIGN",
                        :provenance, :linecode, id,
                        "Linecode '$id' $(prefix)susceptance block is not " *
                        "positive semidefinite / has negative diagonals — " *
                        "not a physical capacitance matrix.",
                        nothing))
                elseif pos_off
                    # the Maxwell sign pattern (off-diag ≤ 0) is typical but
                    # NOT invariant: screen elimination / bundling can flip
                    # small mutuals positive while preserving PSD
                    push!(findings, Finding(INFO, "I.PROV.B_OFFDIAG",
                        :provenance, :linecode, id,
                        "Linecode '$id' $(prefix)block has positive mutual " *
                        "susceptance — deviates from the Maxwell sign pattern; " *
                        "typical of screen-eliminated/bundled cable reductions, " *
                        "otherwise a sign-convention suspect.",
                        nothing))
                end
            end
        end

        # Balance classification on the phase block (conductors 1–3)
        if n >= 3
            Z = complex.(R, Xm)[1:3, 1:3]
            verdict, detail = _classify_balance(Z)
            merge!(entry, detail)
            entry["verdict"] = verdict
            verdict == "exactly_balanced" && push!(seq_ids, id)
            verdict == "decoupled"        && push!(dec_ids, id)
        else
            entry["verdict"] = "not_applicable"
        end

        verdict_counts[entry["verdict"]] = get(verdict_counts, entry["verdict"], 0) + 1
        by_lc[id] = entry
    end

    if !isempty(seq_ids)
        push!(findings, Finding(INFO, "I.PROV.SEQ_DERIVED", :provenance,
            :linecode, nothing,
            "$(length(seq_ids)) linecode(s) have exactly balanced impedance " *
            "matrices (equal self, equal mutual entries) — likely constructed " *
            "from sequence parameters (r1,x1,r0,x0) or a transposition " *
            "assumption, not from conductor geometry: $(join(sort(seq_ids), ", ")).",
            Dict{String,Any}("linecodes" => sort(seq_ids))))
    end
    if !isempty(dec_ids)
        push!(findings, Finding(INFO, "I.PROV.DECOUPLED_PHASES", :provenance,
            :linecode, nothing,
            "$(length(dec_ids)) linecode(s) have zero mutual coupling " *
            "(diagonal impedance matrix) — positive-sequence-only data; the " *
            "phases decouple into independent single-phase networks: " *
            "$(join(sort(dec_ids), ", ")).",
            Dict{String,Any}("linecodes" => sort(dec_ids))))
    end

    Dict{String,Any}("by_linecode" => by_lc, "verdict_counts" => verdict_counts)
end

"""
Classify the 3×3 phase block of a complex series impedance matrix.
Spreads are normalized by the largest self-impedance magnitude so that
deviations that are negligible relative to the self term don't block a
balanced verdict.
"""
function _classify_balance(Z::AbstractMatrix)
    d = [Z[1,1], Z[2,2], Z[3,3]]
    o = [Z[1,2], Z[1,3], Z[2,3]]
    dscale = max(maximum(abs.(d)), 1e-300)

    diag_spread = maximum(abs(d[i] - d[j]) for i in 1:3 for j in i+1:3) / dscale
    off_spread  = maximum(abs(o[i] - o[j]) for i in 1:3 for j in i+1:3) / dscale
    mutual_ratio = maximum(abs.(o)) / dscale

    detail = Dict{String,Any}(
        "diag_spread"          => diag_spread,
        "offdiag_spread"       => off_spread,
        "mutual_to_self_ratio" => mutual_ratio
    )

    verdict = if mutual_ratio < 1e-6 && diag_spread < 1e-6
        "decoupled"
    elseif diag_spread < 1e-9 && off_spread < 1e-9
        "exactly_balanced"
    elseif diag_spread < 1e-2 && off_spread < 1e-2
        "near_balanced"
    else
        "distinct"
    end

    if verdict in ("exactly_balanced", "near_balanced")
        zs = sum(d) / 3
        zm = sum(o) / 3
        z1 = zs - zm
        z0 = zs + 2zm
        detail["z1"] = Dict{String,Any}("r" => real(z1), "x" => imag(z1))
        detail["z0"] = Dict{String,Any}("r" => real(z0), "x" => imag(z0))
        detail["z0_z1_ratio"] = abs(z0) / max(abs(z1), 1e-300)
    end

    (verdict, detail)
end

# ---------------------------------------------------------------------------
# 1b. Impedance transformation classification for 3-wire linecodes
# ---------------------------------------------------------------------------
# Three-wire LV linecodes are either Kron-reduced from a 4-wire Carson matrix
# or constructed via one of two impedance approximations described in:
#   Geth, Heidari, Koirala (2022) ACM e-Energy. doi:10.1145/3538637.3538844
#
# Detection uses the structure of the R and X blocks independently:
#
#   kron_reduced          — R and/or X off-diagonals are non-uniform ("distinct")
#                           and/or R_mutual/R_self << 0.5. This is the signature
#                           of a Schur-complement elimination of the neutral row/col
#                           from the original Carson-geometry 4-wire matrix.
#
#   phase_to_neutral      — R block is exactly circulant (all diagonals equal,
#                           all off-diagonals equal) with mutual/self ≈ 0.5;
#                           X block is NOT circulant. R_neutral was folded into
#                           phase self-terms; X retains the original geometry.
#
#   modified_phase_to_neutral — BOTH R and X are exactly circulant with
#                           mutual/self ≈ 0.5. X was also symmetrised; this
#                           introduces additional modelling error.

function _classify_impedance_transformation(net::Dict{String,Any},
                                             findings::Vector{Finding},
                                             lc_result::Dict{String,Any})::Dict{String,Any}
    linecodes = get(net, "linecode", Dict())
    by_lc     = get(lc_result, "by_linecode", Dict())

    # Only 3-conductor linecodes are relevant
    three_wire = [(id, lc) for (id, lc) in linecodes
                  if lc isa Dict && get(get(by_lc, id, Dict()), "n_conductors", 0) == 3]
    isempty(three_wire) && return Dict{String,Any}()

    # Check whether a 3×3 matrix is circulant (all diagonal entries equal and all
    # off-diagonal entries equal) relative to the diagonal scale.
    function _is_circulant(M::AbstractMatrix, tol=1e-2)
        diags = [M[i, i] for i in 1:3]
        offs  = [M[i, j] for i in 1:3 for j in 1:3 if i ≠ j]
        scale = max(maximum(abs.(diags)), 1e-300)
        maximum(abs(d - diags[1]) for d in diags) / scale < tol &&
        maximum(abs(o - offs[1])  for o in offs)  / scale < tol
    end

    classified = Dict{String,String}()

    for (id, lc) in three_wire
        R = _pattern_keys_to_matrix(lc, "R_series_")
        X = _pattern_keys_to_matrix(lc, "X_series_")
        (R isa AbstractMatrix && size(R, 1) >= 3) || continue

        diag_R = [R[i, i] for i in 1:3]
        off_R  = [R[i, j] for i in 1:3 for j in 1:3 if i ≠ j]
        mean_diag_R = sum(diag_R) / 3
        mean_off_R  = sum(off_R)  / 6
        r_mutual_ratio = mean_diag_R > 0 ? mean_off_R / mean_diag_R : NaN

        r_circ = _is_circulant(R)
        x_circ = X isa AbstractMatrix && size(X, 1) >= 3 && _is_circulant(X)
        half_r = !isnan(r_mutual_ratio) && abs(r_mutual_ratio - 0.5) < 0.06

        transform = if r_circ && x_circ && half_r
            "modified_phase_to_neutral"
        elseif r_circ && half_r
            "phase_to_neutral"
        else
            "kron_reduced"
        end
        classified[id] = transform
    end

    isempty(classified) && return Dict{String,Any}()

    by_type = Dict{String,Vector{String}}()
    for (id, t) in classified
        push!(get!(by_type, t, String[]), id)
        sort!(by_type[t])
    end

    _desc = Dict{String,String}(
        "kron_reduced" =>
            "Kron reduction — neutral row/column eliminated from the original " *
            "four-wire Carson impedance matrix via Schur complement. Exact when " *
            "every neutral is perfectly grounded; approximate with finite grounding. " *
            "Zero-sequence behaviour is not captured by the three-wire representation.",
        "phase_to_neutral" =>
            "phase-to-neutral approximation — R block is circulant with " *
            "mutual ≈ ½ self (neutral resistance folded into phase self-terms); " *
            "X block retains the original geometric structure. Valid approximation " *
            "for equal phase/neutral conductors; error grows with grounding impedance.",
        "modified_phase_to_neutral" =>
            "modified phase-to-neutral approximation — both R and X blocks are " *
            "circulant with mutual ≈ ½ self. X is further symmetrised relative to " *
            "the standard phase-to-neutral form, introducing additional modelling " *
            "error particularly for asymmetric cable geometries.",
    )
    _code = Dict{String,String}(
        "kron_reduced"              => "I.PROV.IMPEDANCE_TRANSFORM_KR",
        "phase_to_neutral"          => "I.PROV.IMPEDANCE_TRANSFORM_PN",
        "modified_phase_to_neutral" => "I.PROV.IMPEDANCE_TRANSFORM_MPN",
    )

    for (type, ids) in sort(collect(by_type), by = first)
        push!(findings, Finding(INFO, _code[type], :provenance, :linecode, nothing,
            "$(length(ids)) three-wire linecode(s) match the impedance signature " *
            "of $(_desc[type]): $(join(ids, ", ")).",
            Dict{String,Any}("transform_type" => type,
                             "linecodes"       => ids)))
    end

    Dict{String,Any}("by_linecode" => classified, "by_type" => by_type)
end

# ---------------------------------------------------------------------------
# 2. Wires per voltage level — Kron-reduction likelihood
# ---------------------------------------------------------------------------

function _wires_by_level(net::Dict{String,Any},
                          findings::Vector{Finding},
                          vl::Dict{String,Any})::Dict{String,Any}
    buses = get(net, "bus", Dict())
    out = Dict{String,Any}()
    isempty(buses) && return out

    levels = get(vl, "levels", Dict())

    neutral_of = _bus_neutral_map(buses)

    for (label, info) in levels
        ids = get(info, "buses", String[])
        isempty(ids) && continue
        n_with_n = count(b -> get(neutral_of, b, nothing) !== nothing, ids)
        nominal_v = Float64(get(info, "nominal_v", 0.0))
        is_lv = nominal_v < 1000.0

        # Single-terminal loads without a neutral: implicit ground return
        level_set = Set(ids)
        implicit_loads = String[]
        for (lid, l) in get(net, "load", Dict())
            b = get(l, "bus", "")
            b in level_set || continue
            tm = get(l, "terminal_map", String[])
            nn = get(neutral_of, b, nothing)
            (nn !== nothing && nn in tm) && continue
            length(tm) == 1 && push!(implicit_loads, lid)
        end

        wires = n_with_n == 0           ? "3-wire" :
                n_with_n == length(ids) ? "4-wire" : "mixed"

        out[label] = Dict{String,Any}(
            "nominal_v"               => nominal_v,
            "n_buses"                 => length(ids),
            "n_with_neutral"          => n_with_n,
            "wires"                   => wires,
            "is_lv"                   => is_lv,
            "n_implicit_ground_loads" => length(implicit_loads)
        )

        if is_lv && n_with_n == 0 && length(ids) > 1
            extra = isempty(implicit_loads) ? "" :
                " $(length(implicit_loads)) load(s) connect phase-to-ground, " *
                "corroborating an implicit neutral."
            push!(findings, Finding(INFO, "I.PROV.KRON_LIKELY", :provenance,
                :network, nothing,
                "Voltage level $label is modeled 3-wire, but LV networks are " *
                "physically 4-wire — this level is likely Kron-reduced " *
                "(neutral eliminated assuming a ground path at every bus).$extra",
                Dict{String,Any}("level" => label,
                                 "implicit_ground_loads" => implicit_loads)))
        end
    end

    out
end

# ---------------------------------------------------------------------------
# 3. Neutral grounding — continuity and floating sections
# ---------------------------------------------------------------------------

function _grounding_analysis(net::Dict{String,Any},
                              findings::Vector{Finding})::Dict{String,Any}
    buses = get(net, "bus", Dict())
    neutral_of = _bus_neutral_map(buses)
    nbuses = sort([id for (id, nn) in neutral_of if nn !== nothing])
    res = Dict{String,Any}("n_buses_with_neutral" => length(nbuses))
    if isempty(nbuses)
        res["n_grounding_points"]  = 0
        res["n_neutral_components"] = 0
        res["n_floating"]          = 0
        return res
    end
    nbus_set = Set(nbuses)

    # Does this terminal list reference the bus's neutral?
    uses_neutral(bus, tm) = begin
        nn = get(neutral_of, bus, nothing)
        nn !== nothing && nn in tm
    end

    # Grounding points: perfect grounding, grounding shunt on the neutral,
    # or a voltage source that references the neutral (pins its potential).
    grounded = Set{String}()
    n_perfect = 0
    for (id, b) in buses
        if uses_neutral(id, get(b, "perfectly_grounded_terminals", String[]))
            push!(grounded, id)
            n_perfect += 1
        end
    end
    for comp_type in ("shunt", "voltage_source")
        for (_, c) in get(net, comp_type, Dict())
            b = get(c, "bus", nothing)
            b isa AbstractString || continue
            uses_neutral(b, get(c, "terminal_map", String[])) && push!(grounded, b)
        end
    end
    intersect!(grounded, nbus_set)

    # Neutral continuity graph: lines and closed switches whose terminal
    # maps carry "n" on both ends. Transformer windings are separate
    # circuits — the neutral does not continue through them.
    adj = Dict{String,Vector{String}}()
    n_neutral_branches = 0
    for comp_type in ("line", "switch")
        for (_, c) in get(net, comp_type, Dict())
            comp_type == "switch" && get(c, "open_switch", false) && continue
            f = get(c, "bus_from", nothing); t = get(c, "bus_to", nothing)
            (f isa AbstractString && t isa AbstractString) || continue
            (uses_neutral(f, get(c, "terminal_map_from", String[])) &&
             uses_neutral(t, get(c, "terminal_map_to",   String[]))) || continue
            n_neutral_branches += 1
            push!(get!(adj, f, String[]), t)
            push!(get!(adj, t, String[]), f)
        end
    end
    res["n_neutral_branches"] = n_neutral_branches
    res["n_grounding_points"] = length(grounded)
    res["all_perfectly_grounded"] = n_perfect >= length(nbuses)

    # Buses whose neutral terminal is actually used by a shunt component
    neutral_users = Set{String}()
    for comp_type in ("load", "generator")
        for (_, c) in get(net, comp_type, Dict())
            b = get(c, "bus", nothing)
            b isa AbstractString || continue
            uses_neutral(b, get(c, "terminal_map", String[])) && push!(neutral_users, b)
        end
    end

    if n_neutral_branches == 0
        # The dataset does not model neutral conductors at all — "n" is a
        # local ground reference (Kron-style convention).
        res["n_neutral_components"] = length(nbuses)
        res["n_floating"] = 0
        res["convention"] = "implicit"
        ungrounded_users = sort(collect(setdiff(neutral_users, grounded)))
        if !isempty(ungrounded_users)
            push!(findings, Finding(WARNING, "W.PROV.IMPLICIT_GROUNDING",
                :provenance, :network, nothing,
                "No branch carries a neutral conductor, but " *
                "$(length(ungrounded_users)) bus(es) have components " *
                "referencing terminal 'n' without an explicit grounding — " *
                "the model implicitly assumes every bus is grounded " *
                "(Kron-style convention). Make this assumption explicit.",
                Dict{String,Any}("buses" => ungrounded_users)))
        end
        return res
    end
    res["convention"] = "explicit"

    # Connected components of the neutral graph; each must reach a grounding
    visited = Set{String}()
    n_components = 0
    floating = Vector{Vector{String}}()
    for start in sort(nbuses)
        start in visited && continue
        n_components += 1
        comp = String[]
        queue = String[start]
        push!(visited, start)
        while !isempty(queue)
            b = popfirst!(queue)
            push!(comp, b)
            for nb in get(adj, b, String[])
                (nb in visited || !(nb in nbus_set)) && continue
                push!(visited, nb)
                push!(queue, nb)
            end
        end
        any(b -> b in grounded, comp) || push!(floating, sort(comp))
    end
    res["n_neutral_components"] = n_components
    res["n_floating"]           = length(floating)
    res["floating_components"]  = floating

    for comp in floating
        used = any(b -> b in neutral_users, comp)
        sev  = used ? ERROR : WARNING
        code = used ? "E.PROV.FLOATING_NEUTRAL" : "W.PROV.FLOATING_NEUTRAL"
        push!(findings, Finding(sev, code, :provenance, :bus, nothing,
            "Neutral section spanning $(length(comp)) bus(es) has no path to " *
            "ground$(used ? " and is used by loads/generators — the " *
            "zero-sequence path is undefined (ill-posed for 4-wire analysis)" :
            "") : $(join(comp, ", ")).",
            Dict{String,Any}("buses" => comp, "used" => used)))
    end

    if res["all_perfectly_grounded"] && n_neutral_branches > 0
        push!(findings, Finding(INFO, "I.PROV.KRON_REDUCIBLE", :provenance,
            :network, nothing,
            "Every bus neutral is perfectly grounded (rg = 0): Kron reduction " *
            "is exact, so the explicit neutral conductors are numerically " *
            "redundant — either reduce the model or revisit the perfect-" *
            "grounding assumption.",
            nothing))
    end

    res
end

"""
Sign/definiteness checks on bus-shunt admittance matrices: reciprocity and
G-block passivity. The B block carries no sign constraint (grounding
reactors are negative, capacitor banks positive), only symmetry.
"""
function _check_bus_shunts(net::Dict{String,Any}, findings::Vector{Finding})
    for (id, s) in get(net, "shunt", Dict())
        s isa Dict || continue
        for (prefix, isG) in (("G_", true), ("B_", false))
            M = _pattern_keys_to_matrix(s, prefix)
            M isa AbstractMatrix || continue
            scaleM = max(maximum(abs.(M)), 1e-300)
            if maximum(abs.(M - transpose(M))) / scaleM > 1e-6
                push!(findings, Finding(ERROR, "E.PROV.NONRECIPROCAL",
                    :provenance, :shunt, id,
                    "Shunt '$id' $(prefix)block is not symmetric — violates " *
                    "reciprocity (note: a delta capacitor bank's admittance is " *
                    "Y·(M∆)ᵀM∆, which is symmetric).", nothing))
            end
            if isG
                evg = eigvals(Symmetric((M + transpose(M)) / 2))
                if any(M[i, i] < -1e-12 for i in 1:size(M, 1)) ||
                   minimum(evg) < -1e-9 * max(maximum(abs.(evg)), 1e-12)
                    push!(findings, Finding(ERROR, "E.PROV.NEGATIVE_G",
                        :provenance, :shunt, id,
                        "Shunt '$id' conductance block is not positive " *
                        "semidefinite — an active (power-generating) element.",
                        nothing))
                end
            end
        end
    end
end

function _check_bus_voltage_bound_redundancy(net::Dict{String,Any},
                                              findings::Vector{Finding})::Dict{String,Any}
    affected = String[]
    for (bid, bus) in get(net, "bus", Dict())
        has_ground = get(bus, "v_min",   nothing) !== nothing ||
                     get(bus, "v_max",   nothing) !== nothing
        has_pn     = get(bus, "vpn_min", nothing) !== nothing ||
                     get(bus, "vpn_max", nothing) !== nothing
        (has_ground && has_pn) || continue

        grounded_set = Set(string.(get(bus, "perfectly_grounded_terminals", String[])))
        nt = _neutral_terminal(bus)
        (nt !== nothing && nt in grounded_set) || continue

        push!(affected, bid)
        push!(findings, Finding(WARNING, "W.PROV.REDUNDANT_VOLTAGE_BOUNDS",
            :provenance, :bus, bid,
            "Bus '$bid' has both phase-to-ground (`v_min`/`v_max`) and " *
            "phase-to-neutral (`vpn_min`/`vpn_max`) voltage bounds, but its " *
            "neutral terminal '$nt' is perfectly grounded — the two sets of " *
            "bounds are equivalent. Remove one to avoid duplicate constraints.",
            Dict{String,Any}("neutral_terminal" => nt)))
    end
    Dict{String,Any}("n" => length(affected), "ids" => affected)
end

function _check_i_max_completeness(net::Dict{String,Any},
                                    findings::Vector{Finding})::Dict{String,Any}
    linecodes  = get(net, "linecode", Dict())
    incomplete = String[]
    for (lid, line) in get(net, "line", Dict())
        lcid = get(line, "linecode", nothing)
        lcid === nothing && continue
        lc = get(linecodes, lcid, nothing)
        lc === nothing && continue
        i_max = get(lc, "i_max", nothing)
        i_max === nothing && continue   # no limit defined — not a violation

        n_fr = length(get(line, "terminal_map_from", String[]))
        n_to = length(get(line, "terminal_map_to",   String[]))
        n_c  = min(n_fr, n_to)
        length(i_max) < n_c && push!(incomplete, lid)
    end
    if !isempty(incomplete)
        push!(findings, Finding(WARNING, "W.PROV.I_MAX_INCOMPLETE",
            :provenance, :line, nothing,
            "$(length(incomplete)) line(s) have fewer `i_max` entries in their " *
            "linecode than conductors — current limits will not be enforced on " *
            "all conductors (the neutral conductor may be unprotected).",
            Dict{String,Any}("lines" => incomplete)))
    end
    Dict{String,Any}("n" => length(incomplete), "ids" => incomplete)
end

function _check_bus_voltage_bound_consistency(net::Dict{String,Any},
                                               findings::Vector{Finding})::Dict{String,Any}
    affected = String[]
    pairs = [("v_min", "v_max"), ("vpn_min", "vpn_max"),
             ("vpp_min", "vpp_max"), ("vpos_min", "vpos_max"),
             ("va_diff_min", "va_diff_max")]
    for (bid, bus) in get(net, "bus", Dict())
        issues = String[]
        for (lo, hi) in pairs
            vlo = get(bus, lo, nothing)
            vhi = get(bus, hi, nothing)
            if vlo !== nothing && vhi !== nothing && Float64(vlo) > Float64(vhi)
                push!(issues, "$lo ($vlo) > $hi ($vhi)")
            end
        end
        if !isempty(issues)
            push!(affected, bid)
            push!(findings, Finding(ERROR, "E.PROV.INCONSISTENT_BOUNDS",
                :provenance, :bus, bid,
                "Bus '$bid' has voltage bounds where min > max — the OPF will be " *
                "infeasible: " * join(issues, "; ") * ".",
                Dict{String,Any}("issues" => issues)))
        end
    end
    Dict{String,Any}("n" => length(affected), "ids" => affected)
end

function _check_bus_voltage_bound_applicability(net::Dict{String,Any},
                                                 findings::Vector{Finding})::Dict{String,Any}
    affected = String[]
    for (bid, bus) in get(net, "bus", Dict())
        all_terms    = string.(get(bus, "terminal_names", String[]))
        grounded_set = Set(string.(get(bus, "perfectly_grounded_terminals", String[])))
        nt           = _neutral_terminal(bus)
        has_neutral  = nt !== nothing
        n_phase      = count(t -> t ∉ grounded_set && t != nt, all_terms)

        issues = String[]
        if !has_neutral && (haskey(bus, "vpn_min") || haskey(bus, "vpn_max"))
            push!(issues, "vpn_min/vpn_max requires a neutral terminal")
        end
        if !has_neutral && haskey(bus, "vn_max")
            push!(issues, "vn_max requires a neutral terminal")
        end
        has_seq = any(k -> haskey(bus, k),
                      ("vpos_min", "vpos_max", "vneg_max", "vzero_max"))
        if has_seq && n_phase != 3
            push!(issues, "sequence bounds (vpos/vneg/vzero) require exactly 3 phase " *
                          "terminals (found $n_phase)")
        end
        if n_phase < 2 && (haskey(bus, "vpp_min") || haskey(bus, "vpp_max"))
            push!(issues, "vpp_min/vpp_max requires at least 2 phase terminals")
        end
        if n_phase < 2 && (haskey(bus, "va_diff_min") || haskey(bus, "va_diff_max"))
            push!(issues, "va_diff_min/va_diff_max (bus) requires at least 2 phase terminals")
        end
        if !isempty(issues)
            push!(affected, bid)
            push!(findings, Finding(WARNING, "W.PROV.INAPPLICABLE_VOLTAGE_BOUNDS",
                :provenance, :bus, bid,
                "Bus '$bid' has voltage bounds that cannot be enforced and will be " *
                "silently ignored in the OPF: " * join(issues, "; ") * ".",
                Dict{String,Any}("issues" => issues)))
        end
    end
    Dict{String,Any}("n" => length(affected), "ids" => affected)
end

function _check_bus_voltage_bound_overlap(net::Dict{String,Any},
                                           findings::Vector{Finding})::Dict{String,Any}
    bound_groups = [
        ("phase-to-ground",      ["v_min",     "v_max"]),
        ("phase-to-neutral",     ["vpn_min",   "vpn_max"]),
        ("phase-to-phase",       ["vpp_min",   "vpp_max"]),
        ("positive-sequence",    ["vpos_min",  "vpos_max"]),
        ("negative-sequence",    ["vneg_max"]),
        ("zero-sequence",        ["vzero_max"]),
        ("neutral-to-ground",    ["vn_max"]),
        ("intra-bus-angle",      ["va_diff_min", "va_diff_max"]),
    ]
    affected = String[]
    for (bid, bus) in get(net, "bus", Dict())
        active = [label for (label, keys) in bound_groups
                  if any(haskey(bus, k) for k in keys)]
        length(active) <= 1 && continue
        push!(affected, bid)
        push!(findings, Finding(INFO, "I.PROV.OVERLAPPING_VOLTAGE_BOUNDS",
            :provenance, :bus, bid,
            "Bus '$bid' has $(length(active)) voltage bound types active " *
            "($(join(active, ", "))) — all are enforced simultaneously, which is " *
            "valid but adds constraints and may slow the solver.",
            Dict{String,Any}("bound_types" => active)))
    end
    Dict{String,Any}("n" => length(affected), "ids" => affected)
end

# Per-bus neutral terminal name (or nothing), via the convention helper
function _bus_neutral_map(buses)::Dict{String,Union{String,Nothing}}
    Dict{String,Union{String,Nothing}}(
        id => _neutral_terminal(b)
        for (id, b) in buses)
end

# ---------------------------------------------------------------------------
# OpenDSS default fingerprints
# ---------------------------------------------------------------------------
# When a .dss file omits a property, OpenDSS substitutes a documented default.
# After conversion these look like deliberate data — except the values are
# very specific (mostly US/60 Hz flavored) and essentially never coincide
# with real engineering values elsewhere. Matching them flags fields the
# original modeler most likely never set.

const _DSS_Z1_DEFAULT = (0.058 + im * 0.1206) / 304.8   # Ω/kft → Ω/m
const _DSS_Z0_DEFAULT = (0.1784 + im * 0.4047) / 304.8
const _DSS_NORMAMPS   = 400.0
const _DSS_EMERGAMPS  = 600.0
const _DSS_XHL_PU     = 0.07     # xhl = 7 %
const _DSS_RW_PU      = 0.004    # %r = 0.2 per winding, two windings
const _DSS_PF_TAN     = tan(acos(0.88))
const _DSS_KV_LL      = (115_000.0, 12_470.0)   # basekv / kv defaults (V, LL)

# total per-unit series impedance of a transformer on its own rating base
function _xfmr_pu(t::Dict{String,Any}, subtype::String)
    s  = get(t, "s_rating", nothing)
    vf = get(t, "v_ref_from", nothing)
    vt = get(t, "v_ref_to",   nothing)
    (s === nothing || vf === nothing || vt === nothing) && return nothing
    s, vf, vt = Float64(s), Float64(vf), Float64(vt)
    (s > 0 && vf > 0 && vt > 0) || return nothing
    if subtype in ("wye_delta", "delta_wye")
        v_wye = subtype == "wye_delta" ? vf : vt
        zb = v_wye^2 / s
        r = haskey(t, "r_series") ? Float64(t["r_series"]) / zb : nothing
        x = haskey(t, "x_series") ? Float64(t["x_series"]) / zb : nothing
        return (r, x)
    else
        zbf, zbt = vf^2 / s, vt^2 / s
        r = haskey(t, "r_series_from") && haskey(t, "r_series_to") ?
            Float64(t["r_series_from"]) / zbf + Float64(t["r_series_to"]) / zbt :
            nothing
        x = haskey(t, "x_series_from") && haskey(t, "x_series_to") ?
            Float64(t["x_series_from"]) / zbf + Float64(t["x_series_to"]) / zbt :
            nothing
        return (r, x)
    end
end

# Coerce a `_pmd`-carried matrix (Matrix, nested vectors, or flat row-major
# vector) into a square Float64 matrix; symmetric inputs make orientation moot
function _as_square(x)
    x isa AbstractMatrix && return Float64.(x)
    if x isa AbstractVector
        isempty(x) && return nothing
        if x[1] isa AbstractVector
            return _to_matrix(x)
        end
        n = isqrt(length(x))
        n * n == length(x) || return nothing
        return reshape(Float64.(x), n, n)
    end
    nothing
end

function _check_opendss_defaults(net::Dict{String,Any},
                                  findings::Vector{Finding},
                                  lc_result::Dict{String,Any})::Dict{String,Any}
    res = Dict{String,Any}()
    n_hits = 0

    # --- default line constants (via recovered sequence parameters) ---
    dz = String[]
    for (id, e) in get(lc_result, "by_linecode", Dict())
        haskey(e, "z1") || continue
        z1 = complex(e["z1"]["r"], e["z1"]["x"])
        z0 = complex(e["z0"]["r"], e["z0"]["x"])
        if isapprox(z1, _DSS_Z1_DEFAULT; rtol=1e-3) &&
           isapprox(z0, _DSS_Z0_DEFAULT; rtol=1e-3)
            push!(dz, id)
        end
    end
    if !isempty(dz)
        n_hits += length(dz)
        push!(findings, Finding(WARNING, "W.PROV.DSS_DEFAULT_Z", :provenance,
            :linecode, nothing,
            "$(length(dz)) linecode(s) match the OpenDSS default line constants " *
            "(r1=0.058, x1=0.1206, r0=0.1784, x0=0.4047 Ω/kft — a fictitious " *
            "60 Hz overhead line); the source files likely omitted impedance " *
            "data: $(join(sort(dz), ", ")).",
            Dict{String,Any}("linecodes" => sort(dz))))
    end
    res["default_z_linecodes"] = sort(dz)

    # --- default ampacities (normamps 400 / emergamps 600) ---
    amp_hits = String[]
    for ct in ("linecode", "line", "switch")
        for (id, c) in get(net, ct, Dict())
            c isa Dict || continue
            v = get(c, "i_max", nothing)
            v === nothing && continue
            vals = v isa AbstractVector ? Float64.(v) : [Float64(v)]
            # i_max maps from normamps; emergamps (600) does not reach i_max,
            # and 600 A is a common genuine rating — fingerprint 400 only
            any(==(_DSS_NORMAMPS), vals) && push!(amp_hits, "$ct/$id")
        end
    end
    if !isempty(amp_hits)
        n_hits += length(amp_hits)
        push!(findings, Finding(INFO, "I.PROV.DSS_DEFAULT_AMPS", :provenance,
            :linecode, nothing,
            "$(length(amp_hits)) component(s) have i_max exactly 400 A or " *
            "600 A — the OpenDSS normamps/emergamps defaults; ratings were " *
            "likely never engineered.",
            Dict{String,Any}("components" => sort(amp_hits))))
    end

    # --- transformer defaults (xhl = 7 %, %r = 0.2/winding) ---
    xfmr_hits = String[]
    for subtype in ("single_phase", "center_tap", "wye_delta", "delta_wye")
        sub = get(get(net, "transformer", Dict()), subtype, nothing)
        sub isa Dict || continue
        for (id, t) in sub
            pu = _xfmr_pu(t, subtype)
            pu === nothing && continue
            r_pu, x_pu = pu
            hit_x = x_pu !== nothing && isapprox(x_pu, _DSS_XHL_PU; rtol=1e-3)
            hit_r = r_pu !== nothing && isapprox(r_pu, _DSS_RW_PU;  rtol=1e-3)
            (hit_x || hit_r) && push!(xfmr_hits,
                "$id ($(hit_x ? "xhl=7%" : "")$(hit_x && hit_r ? ", " : "")$(hit_r ? "%r=0.2" : ""))")
        end
    end
    if !isempty(xfmr_hits)
        n_hits += length(xfmr_hits)
        push!(findings, Finding(INFO, "I.PROV.DSS_DEFAULT_XFMR", :provenance,
            :transformer, nothing,
            "$(length(xfmr_hits)) transformer(s) have impedance matching the " *
            "OpenDSS defaults — likely unspecified in the source: " *
            "$(join(sort(xfmr_hits), "; ")).",
            Dict{String,Any}("transformers" => sort(xfmr_hits))))
    end

    # --- default load power factor (pf = 0.88) ---
    pf_hits = String[]
    for (id, l) in get(net, "load", Dict())
        l isa Dict || continue
        p = get(l, "p_nom", nothing); q = get(l, "q_nom", nothing)
        (p isa AbstractVector && q isa AbstractVector &&
         length(p) == length(q) && !isempty(p)) || continue
        pairs = [(Float64(p[i]), Float64(q[i])) for i in eachindex(p)
                 if Float64(p[i]) > 0]
        isempty(pairs) && continue
        all(isapprox(qq / pp, _DSS_PF_TAN; rtol=1e-3) for (pp, qq) in pairs) &&
            push!(pf_hits, id)
    end
    if !isempty(pf_hits)
        n_hits += length(pf_hits)
        push!(findings, Finding(INFO, "I.PROV.DSS_DEFAULT_PF", :provenance,
            :load, nothing,
            "$(length(pf_hits)) load(s) have power factor exactly 0.88 — the " *
            "OpenDSS default; reactive demand was likely never specified.",
            Dict{String,Any}("loads" => sort(pf_hits))))
    end

    # --- default voltages (basekv 115, kv 12.47) ---
    kv_hits = String[]
    for (id, vs) in get(net, "voltage_source", Dict())
        vm = get(vs, "v_magnitude", nothing)
        vm isa AbstractVector && !isempty(vm) || continue
        vmax = maximum(Float64.(vm))
        any(isapprox(vmax, kv / sqrt(3); rtol=1e-4) for kv in _DSS_KV_LL) &&
            push!(kv_hits, "voltage_source/$id")
    end
    for subtype in ("single_phase", "center_tap", "wye_delta", "delta_wye")
        sub = get(get(net, "transformer", Dict()), subtype, nothing)
        sub isa Dict || continue
        for (id, t) in sub
            for f in ("v_ref_from", "v_ref_to")
                v = get(t, f, nothing)
                v === nothing && continue
                any(isapprox(Float64(v), kv; rtol=1e-4) for kv in _DSS_KV_LL) &&
                    push!(kv_hits, "transformer/$id ($f)")
            end
        end
    end
    if !isempty(kv_hits)
        n_hits += length(kv_hits)
        push!(findings, Finding(INFO, "I.PROV.DSS_DEFAULT_KV", :provenance,
            :network, nothing,
            "$(length(kv_hits)) component(s) sit exactly at an OpenDSS default " *
            "voltage (115 kV / 12.47 kV) — suspicious outside US test feeders: " *
            "$(join(sort(kv_hits), ", ")).",
            Dict{String,Any}("components" => sort(kv_hits))))
    end

    # --- default source impedance (MVAsc3 = 2000, X1R1 = 4) ---
    srcz_hits = String[]
    for (id, vs) in get(net, "voltage_source", Dict())
        pmd = get(vs, "_pmd", nothing)
        pmd isa Dict || continue
        Rs = _as_square(get(pmd, "rs", nothing))
        Xs = _as_square(get(pmd, "xs", nothing))
        (Rs isa AbstractMatrix && Xs isa AbstractMatrix &&
         size(Rs) == size(Xs) && size(Rs, 1) >= 3) || continue
        vm = get(vs, "v_magnitude", nothing)
        vm isa AbstractVector && !isempty(vm) || continue
        kV_LL = maximum(Float64.(vm)) * sqrt(3)
        Z = complex.(Rs, Xs)[1:3, 1:3]
        zs = (Z[1,1] + Z[2,2] + Z[3,3]) / 3
        zm = (Z[1,2] + Z[1,3] + Z[2,3]) / 3
        z1 = zs - zm
        zmag_def = kV_LL^2 / 2000e6                 # MVAsc3 default
        r1_def = zmag_def / sqrt(17)                # X1R1 = 4
        z1_def = complex(r1_def, 4r1_def)
        isapprox(z1, z1_def; rtol=5e-2) && push!(srcz_hits, id)
    end
    if !isempty(srcz_hits)
        n_hits += length(srcz_hits)
        push!(findings, Finding(WARNING, "W.PROV.DSS_DEFAULT_SOURCE_Z",
            :provenance, :voltage_source, nothing,
            "$(length(srcz_hits)) voltage source(s) have Thévenin impedance " *
            "matching the OpenDSS default (MVAsc3=2000, X1R1=4) — the fault " *
            "level is fictitious; the source files likely omitted it: " *
            "$(join(sort(srcz_hits), ", ")).",
            Dict{String,Any}("sources" => sort(srcz_hits))))
    end

    # --- default lengths (1.0): scattered = leak, universal = convention ---
    lens = [Float64(get(l, "length", NaN))
            for (_, l) in get(net, "line", Dict()) if haskey(l, "length")]
    n_one = count(==(1.0), lens)
    res["length_normalized"] = length(lens) >= 3 && n_one / length(lens) >= 0.9
    if n_one > 0 && !res["length_normalized"] && n_one / max(length(lens), 1) <= 0.5
        n_hits += n_one
        push!(findings, Finding(INFO, "I.PROV.DSS_DEFAULT_LENGTH", :provenance,
            :line, nothing,
            "$n_one of $(length(lens)) line(s) have length exactly 1.0 among " *
            "otherwise varied lengths — the OpenDSS default; these lengths " *
            "were likely never set.",
            nothing))
    end

    res["n_default_hits"] = n_hits
    res
end

# ---------------------------------------------------------------------------
# Galvanic islands (shared with integrity checks)
# ---------------------------------------------------------------------------

"""
Connected components over lines and closed switches only — transformer
windings are galvanic separations. Returns sorted bus-id vectors.
"""
function _galvanic_islands(net::Dict{String,Any})::Vector{Vector{String}}
    busset = Set(keys(get(net, "bus", Dict())))
    adj = Dict{String,Vector{String}}()
    for comp_type in ("line", "switch")
        for (_, c) in get(net, comp_type, Dict())
            comp_type == "switch" && get(c, "open_switch", false) && continue
            f = get(c, "bus_from", nothing); t = get(c, "bus_to", nothing)
            (f isa AbstractString && t isa AbstractString &&
             f in busset && t in busset) || continue
            push!(get!(adj, f, String[]), t)
            push!(get!(adj, t, String[]), f)
        end
    end
    visited = Set{String}()
    islands = Vector{Vector{String}}()
    for start in sort(collect(busset))
        start in visited && continue
        comp = String[]
        queue = String[start]
        push!(visited, start)
        while !isempty(queue)
            b = popfirst!(queue)
            push!(comp, b)
            for nb in get(adj, b, String[])
                nb in visited && continue
                push!(visited, nb)
                push!(queue, nb)
            end
        end
        push!(islands, sort(comp))
    end
    islands
end

# ---------------------------------------------------------------------------
# Earthing system classification per galvanic island
# ---------------------------------------------------------------------------

const _EARTH_SOLID_OHM = 1.0      # |Z| below this: "solid"
const _EARTH_T_I_OHM   = 200.0    # |Z| above this (or absent): isolated (I)

# bus => smallest |Z| of any neutral-earthing path at that bus
function _bus_neutral_earthing(net::Dict{String,Any},
                                neutral_of)::Dict{String,Float64}
    earth = Dict{String,Float64}()
    upd!(b, z) = (earth[b] = min(get(earth, b, Inf), z))
    for (id, b) in get(net, "bus", Dict())
        nn = get(neutral_of, id, nothing)
        nn !== nothing &&
            nn in string.(get(b, "perfectly_grounded_terminals", String[])) &&
            upd!(id, 0.0)
    end
    for (_, vs) in get(net, "voltage_source", Dict())
        b = get(vs, "bus", nothing)
        b isa AbstractString || continue
        nn = get(neutral_of, b, nothing)
        nn !== nothing && nn in string.(get(vs, "terminal_map", String[])) &&
            upd!(b, 0.0)
    end
    for (_, s) in get(net, "shunt", Dict())
        b = get(s, "bus", nothing)
        b isa AbstractString || continue
        nn = get(neutral_of, b, nothing)
        (nn !== nothing && nn in string.(get(s, "terminal_map", String[]))) || continue
        y = complex(Float64(get(s, "G_1_1", 0.0)), Float64(get(s, "B_1_1", 0.0)))
        abs(y) > 0 && upd!(b, abs(1 / y))
    end
    earth
end

"""
Classify the likely earthing system per galvanic island, from the
network-side evidence the data model carries. The protective-earth side of
installations is **not representable** in a power-flow data model, so TT
cannot be distinguished from TN-S when the neutral is earthed at the source
only — the tag is explicit about that ambiguity. MV islands use MV
vocabulary (solidly/impedance-earthed/isolated) instead of TT/TN/IT.
"""
function _earthing_zones(net::Dict{String,Any},
                          vl::Dict{String,Any})::Vector{Dict{String,Any}}
    buses = get(net, "bus", Dict())
    isempty(buses) && return Dict{String,Any}[]
    neutral_of = _bus_neutral_map(buses)
    earth = _bus_neutral_earthing(net, neutral_of)
    vmap  = get(vl, "bus_voltage_map", Dict())

    zones = Dict{String,Any}[]
    for isl in _galvanic_islands(net)
        islset = Set(isl)
        vs_ = [Float64(get(vmap, b, NaN)) for b in isl]
        known = filter(!isnan, vs_)
        vnom = isempty(known) ? NaN : maximum(known)
        is_lv = !isnan(vnom) && vnom < 1000.0
        wires4 = all(get(neutral_of, b, nothing) !== nothing for b in isl)

        # infeed reference points: source buses and in-island wye-winding
        # buses whose map carries the neutral (the star point bond)
        star_buses = String[]
        for (_, vs) in get(net, "voltage_source", Dict())
            b = get(vs, "bus", nothing)
            b isa AbstractString && b in islset && push!(star_buses, b)
        end
        xfmr = get(net, "transformer", Dict())
        for subtype in ("single_phase", "center_tap", "wye_delta", "delta_wye")
            sub = get(xfmr, subtype, nothing)
            sub isa Dict || continue
            for (_, t) in sub
                for (bk, mk) in (("bus_from", "terminal_map_from"),
                                  ("bus_to",   "terminal_map_to"))
                    b = get(t, bk, nothing)
                    (b isa AbstractString && b in islset) || continue
                    nn = get(neutral_of, b, nothing)
                    nn !== nothing && nn in string.(get(t, mk, String[])) &&
                        push!(star_buses, b)
                end
            end
        end
        star_set = Set(star_buses)
        star_R = isempty(star_buses) ? Inf :
                 minimum(get(earth, b, Inf) for b in star_buses)
        downstream = [b for b in isl if haskey(earth, b) && !(b in star_set)]
        n_down = length(downstream)

        kind = star_R < _EARTH_SOLID_OHM ? "solid" :
               star_R <= _EARTH_T_I_OHM  ? "impedance" : "none"
        rstr = kind == "impedance" ? " (R≈$(round(star_R, sigdigits=2)) Ω)" : ""

        tag = if !is_lv
            kind == "solid"     ? "solidly earthed" :
            kind == "impedance" ? "impedance-earthed$rstr" :
            n_down > 0          ? "earthed downstream only (nonstandard)" :
                                  "isolated"
        elseif kind == "none" && n_down == 0
            "IT (isolated / high-impedance earthed)"
        elseif kind == "none" && n_down > 0
            "nonstandard: neutral earthed downstream only"
        elseif !wires4
            "indeterminate (3-wire / Kron-style implicit grounding)"
        elseif n_down >= 1
            "TN-C-S / multi-earthed (PME/MEN-style)$rstr"
        else
            "TN-S or TT (source-earthed only$rstr — protective-earth side " *
            "not representable in the data model)"
        end

        push!(zones, Dict{String,Any}(
            "buses"              => isl,
            "n_buses"            => length(isl),
            "nominal_v"          => vnom,
            "wires"              => wires4 ? "4-wire" : "≤3-wire",
            "star_earthing"      => kind,
            "star_R_ohm"         => star_R,
            "n_downstream_earths" => n_down,
            "tag"                => tag))
    end
    sort!(zones, by = z -> -(isnan(z["nominal_v"]) ? -Inf : z["nominal_v"]))
    zones
end

# ---------------------------------------------------------------------------
# Regulator / autotransformer encodings
# ---------------------------------------------------------------------------
# OpenDSS has no first-class regulator branch: modelers encode them either as
# a near-1:1 wye transformer (+RegControl), or — per the EPRI autotransformer
# guidance — as two windings on the SAME bus (common + ~10% series winding,
# kVA rated at the series winding) with a negligible-impedance jumper. The
# BMOPF data model has no regulator object, so these patterns deserve a flag:
# a controllable device has been frozen into (or hidden inside) a transformer.

function _check_regulator_patterns(net::Dict{String,Any},
                                    findings::Vector{Finding},
                                    vl::Dict{String,Any})
    vmap = get(vl, "bus_voltage_map", Dict())
    xfmr = get(net, "transformer", Dict())
    for subtype in ("single_phase", "center_tap", "wye_delta", "delta_wye")
        sub = get(xfmr, subtype, nothing)
        sub isa Dict || continue
        for (id, t) in sub
            f = get(t, "bus_from", nothing); b = get(t, "bus_to", nothing)
            evidence = String[]

            # Pattern B: explicit autotransformer — windings on one bus
            if f isa AbstractString && f == b
                push!(evidence, "both windings on bus '$f' (explicit " *
                                "autotransformer encoding)")
            end

            # Pattern A: near-1:1 regulator transformer (never delta-coupled)
            vf = get(t, "v_ref_from", nothing); vt = get(t, "v_ref_to", nothing)
            if isempty(evidence) && subtype == "single_phase" &&
               vf !== nothing && vt !== nothing && Float64(vf) > 0
                ratio = Float64(vt) / Float64(vf)
                if 0.85 <= ratio <= 1.176
                    corroborating = String[]
                    uf = get(vmap, f, nothing); ut = get(vmap, b, nothing)
                    if uf !== nothing && ut !== nothing &&
                       abs(uf - ut) / max(uf, 1.0) < 0.05
                        push!(corroborating, "connects buses at the same voltage level")
                    end
                    pu = _xfmr_pu(t, subtype)
                    if pu !== nothing && pu[2] !== nothing && pu[2] < 0.005
                        push!(corroborating,
                              "very low impedance (x≈$(round(pu[2]*100, sigdigits=2)) %)")
                    end
                    tm = get(get(t, "_pmd", Dict()), "tm_set", nothing)
                    if tm !== nothing &&
                       any(any(abs(Float64(x) - 1.0) > 1e-6 for x in w)
                           for w in tm if w isa AbstractVector)
                        push!(corroborating, "non-unity tap setting")
                    end
                    if !isempty(corroborating)
                        push!(evidence,
                              "near-unity ratio ($(round(ratio, digits=3))); " *
                              join(corroborating, "; "))
                    end
                end
            end

            if !isempty(evidence)
                push!(findings, Finding(WARNING, "W.PROV.REGULATOR_PATTERN",
                    :provenance, :transformer, id,
                    "transformer ($subtype) '$id' looks like a voltage " *
                    "regulator/autotransformer encoding: $(join(evidence, "; ")). " *
                    "The data model has no regulator object — verify whether a " *
                    "fixed-tap snapshot is intended; the control capability is " *
                    "otherwise silently lost.",
                    Dict{String,Any}("evidence" => evidence)))
            end
        end
    end
end

# ---------------------------------------------------------------------------
# Convention statement
# ---------------------------------------------------------------------------

function _convention_statement(result::Dict{String,Any})::String
    parts = String[]
    wl = get(result, "wires_by_level", Dict())
    for (label, info) in sort(collect(wl), by = x -> -x[2]["nominal_v"])
        w = info["wires"]
        note = w == "3-wire" && info["is_lv"] ? " (likely Kron-reduced)" : ""
        push!(parts, "$label: $w$note")
    end

    g = get(result, "grounding", Dict())
    if get(g, "n_buses_with_neutral", 0) > 0
        conv = get(g, "convention", "")
        ng   = get(g, "n_grounding_points", 0)
        nfl  = get(g, "n_floating", 0)
        gdesc = conv == "implicit" ? "implicit (Kron-style) grounding" :
                get(g, "all_perfectly_grounded", false) ?
                    "perfectly grounded at every bus (Kron-reducible)" :
                "$(ng) grounding point(s)" * (nfl > 0 ? ", $nfl floating neutral section(s)" : "")
        push!(parts, gdesc)
    end

    get(get(result, "opendss_defaults", Dict()), "length_normalized", false) &&
        push!(parts, "length-normalized lines")

    isempty(parts) ? "undetermined" : join(parts, "; ")
end
