# Extract the JuMP solution into a plain Dict{String,Any}.
#
# All physical quantities are in SI: V, A, W, var.
# Voltage magnitude/angle and power are derived from vr/vi/cr/ci for convenience.

"""
    _extract_results(model, net, bus_terminals, grounded, vars) -> Dict{String,Any}

Pack the JuMP solution into a plain `Dict{String,Any}`.  All quantities are in
SI units (V, A, W, var).  When the solver did not find a feasible point every
numeric field contains `NaN`.

Returned top-level keys
-----------------------
- `"termination_status"` — string form of `JuMP.termination_status`
- `"objective"`          — objective value (cost units)
- `"solve_time"`         — solver wall-clock time (s)
- `"bus"`        — `bus_id => terminal => {vr, vi, vm [V], va [rad]}`
- `"line"`       — `line_id => terminal_name => {cr_fr, ci_fr, cr_to, ci_to [A], cm_fr, cm_to [A]}`
                   (total per-end current: series + π-shunt half-section)
- `"switch"`     — `switch_id => terminal_name => {cr, ci [A], cm [A]}`
- `"load"`       — `load_id => terminal_name => {crd, cid [A], pd [W], qd [var]}`
- `"generator"`  — `gen_id => terminal_name => {crg, cig [A], pg [W], qg [var]}`
- `"inverter"`   — `inv_id => terminal_name => {cri, cii [A], pg [W], qg [var]}`
- `"transformer"`— `xfmr_id => {"fr" => {k => {cr, ci [A]}}, "to" => {k => {cr, ci [A]}}}`
- `"voltage_source"` — `src_id => terminal => {cr, ci [A], ps [W], qs [var]}`
- `"initialisation"` — `bus_id => terminal => {vr_init, vi_init, vm_init [V], va_init [rad]}`
  Ipopt start values set before `optimize!`. Always present; used by `profile_solution`
  to flag wrong-voltage-level and large-error initialisation.

Line and switch conductors are keyed by terminal name (using `terminal_map_from`
for lines, `terminal_map_from` for switches), not by position index.  When
`terminal_map_from` and `terminal_map_to` differ in length the to-side uses
`terminal_map_to`.

Transformer results use winding-side keys `"fr"` and `"to"`, each mapping to a
positional index (string `"1"`, `"2"`, ...) because the two winding terminal
maps may have different lengths and terminal-name sets.
"""
# Numeric π-shunt current (A) leaving `bus` at each of `terminals`, evaluated at
# the solved voltages. The result-side counterpart of `_shunt_current!`: it
# returns Float64 values rather than accumulating AffExpr terms into the model.
# Grounded terminals (absent from `vr_v`) have zero voltage and contribute
# nothing, matching the model-build convention.
function _shunt_current_value(vr_v, vi_v, val,
                              G::Union{Matrix{Float64},Nothing},
                              B::Union{Matrix{Float64},Nothing},
                              bus::String, terminals::Vector{String})
    n  = length(terminals)
    cr = zeros(Float64, n); ci = zeros(Float64, n)
    (G === nothing && B === nothing) && return cr, ci
    for k in 1:n, j in 1:n
        key_j = (bus, terminals[j])
        haskey(vr_v, key_j) || continue   # grounded — voltage is zero
        g_kj = (G !== nothing && k <= size(G,1) && j <= size(G,2)) ? G[k,j] : 0.0
        b_kj = (B !== nothing && k <= size(B,1) && j <= size(B,2)) ? B[k,j] : 0.0
        (iszero(g_kj) && iszero(b_kj)) && continue
        vrj = val(vr_v[key_j]); vij = val(vi_v[key_j])
        cr[k] += g_kj*vrj - b_kj*vij
        ci[k] += g_kj*vij + b_kj*vrj
    end
    cr, ci
end

function _extract_results(model, net, bus_terminals, grounded, vars)
    status = string(JuMP.termination_status(model))
    obj    = JuMP.objective_value(model)
    tsolve = JuMP.solve_time(model)

    vr_v    = vars[:vr];    vi_v    = vars[:vi]
    crg_v   = vars[:crg];   cig_v   = vars[:cig]
    crd_v   = vars[:crd];   cid_v   = vars[:cid]
    cr_fr_v = vars[:cr_fr]; ci_fr_v = vars[:ci_fr]
    cr_to_v = vars[:cr_to]; ci_to_v = vars[:ci_to]
    cr_sw_v = vars[:cr_sw]; ci_sw_v = vars[:ci_sw]
    cr_xf_v = vars[:cr_xf]; ci_xf_v = vars[:ci_xf]

    feasible = JuMP.termination_status(model) in (
        JuMP.MOI.LOCALLY_SOLVED, JuMP.MOI.OPTIMAL, JuMP.MOI.ALMOST_LOCALLY_SOLVED)

    val(v) = feasible ? JuMP.value(v) : NaN

    # ── Bus voltages ─────────────────────────────────────────────────────────
    bus_res = Dict{String,Any}()
    for (bid, terminals) in bus_terminals
        t_dict = Dict{String,Any}()
        for t in terminals
            vr_t = (bid, t) in grounded ? 0.0 : val(vr_v[(bid, t)])
            vi_t = (bid, t) in grounded ? 0.0 : val(vi_v[(bid, t)])
            t_dict[t] = Dict{String,Any}(
                "vr" => vr_t,
                "vi" => vi_t,
                "vm" => sqrt(vr_t^2 + vi_t^2),
                "va" => atan(vi_t, vr_t),
            )
        end
        bus_res[bid] = t_dict
    end

    # ── Line currents (keyed by terminal name, not position) ─────────────────
    # Reported quantities are the TOTAL per-end terminal currents (series +
    # π-shunt half-section), positive leaving their bus into the branch — exactly
    # the quantity the thermal limits are enforced on. The series-current
    # variables alone satisfy cr_to = −cr_fr, so the totals differ (cm_fr ≠
    # cm_to) only when the linecode carries a non-zero shunt admittance.
    linecodes = get(net, "linecode", Dict())
    line_res  = Dict{String,Any}()
    for (lid, line) in get(net, "line", Dict())
        tm_fr = string.(get(line, "terminal_map_from", String[]))
        tm_to = string.(get(line, "terminal_map_to", tm_fr))
        b_fr  = string(get(line, "bus_from", ""))
        b_to  = string(get(line, "bus_to",   ""))
        n_map = min(length(tm_fr), length(tm_to))

        # π-shunt currents leaving each bus (zero when the linecode has no shunt)
        G_fr, B_fr, G_to, B_to = _line_pi_shunt(line, linecodes)
        ish_fr_r, ish_fr_i = _shunt_current_value(vr_v, vi_v, val, G_fr, B_fr, b_fr, tm_fr[1:n_map])
        ish_to_r, ish_to_i = _shunt_current_value(vr_v, vi_v, val, G_to, B_to, b_to, tm_to[1:n_map])

        cond = Dict{String,Any}()
        for k in 1:n_map
            cr_fr = val(cr_fr_v[(lid, k)]) + ish_fr_r[k]
            ci_fr = val(ci_fr_v[(lid, k)]) + ish_fr_i[k]
            cr_to = val(cr_to_v[(lid, k)]) + ish_to_r[k]
            ci_to = val(ci_to_v[(lid, k)]) + ish_to_i[k]
            cond[tm_fr[k]] = Dict{String,Any}(
                "cr_fr" => cr_fr,
                "ci_fr" => ci_fr,
                "cr_to" => cr_to,
                "ci_to" => ci_to,
                "cm_fr" => sqrt(cr_fr^2 + ci_fr^2),
                "cm_to" => sqrt(cr_to^2 + ci_to^2),
            )
        end
        line_res[lid] = cond
    end

    # ── Switch currents (keyed by from-terminal name) ─────────────────────────
    switch_res = Dict{String,Any}()
    for (sid, sw) in get(net, "switch", Dict())
        tm_fr = string.(get(sw, "terminal_map_from", String[]))
        n_c   = length(tm_fr)
        cond  = Dict{String,Any}()
        for k in 1:n_c
            t = k <= length(tm_fr) ? tm_fr[k] : string(k)
            cr = val(cr_sw_v[(sid, k)])
            ci = val(ci_sw_v[(sid, k)])
            cond[t] = Dict{String,Any}(
                "cr" => cr,
                "ci" => ci,
                "cm" => sqrt(cr^2 + ci^2),
            )
        end
        switch_res[sid] = cond
    end

    # ── Load currents and absorbed power ─────────────────────────────────────
    load_res = Dict{String,Any}()
    for (lid, load) in get(net, "load", Dict())
        bus = get(load, "bus", "")
        tm  = Vector{String}(get(load, "terminal_map", String[]))
        cfg = get(load, "configuration", "WYE")
        is_delta  = cfg == "DELTA"
        n_c       = length(tm)
        ph_pos    = is_delta ? collect(eachindex(tm)) : _phase_positions(tm)
        n_pos_idx = is_delta ? nothing : _neutral_pos(tm)
        t_n       = n_pos_idx !== nothing ? tm[n_pos_idx] : nothing

        ph_results = Dict{String,Any}()
        for (idx, ph) in enumerate(ph_pos)
            t_ph = tm[ph]
            cr = val(crd_v[(lid, idx)]); ci = val(cid_v[(lid, idx)])
            vr_t = feasible ? val(vr_v[(bus, t_ph)]) : NaN
            vi_t = feasible ? val(vi_v[(bus, t_ph)]) : NaN
            # Reference: line-to-line (next phase) for DELTA, neutral for WYE.
            if is_delta
                t_ref = tm[(ph % n_c) + 1]
                vr_n  = feasible ? val(vr_v[(bus, t_ref)]) : NaN
                vi_n  = feasible ? val(vi_v[(bus, t_ref)]) : NaN
            else
                vr_n = (t_n !== nothing && feasible) ? val(vr_v[(bus, t_n)]) : 0.0
                vi_n = (t_n !== nothing && feasible) ? val(vi_v[(bus, t_n)]) : 0.0
            end
            dvr = vr_t - vr_n; dvi = vi_t - vi_n
            pd  =  dvr*cr + dvi*ci
            qd  =  dvi*cr - dvr*ci
            ph_results[t_ph] = Dict{String,Any}(
                "crd" => cr, "cid" => ci, "pd" => pd, "qd" => qd)
        end
        load_res[lid] = ph_results
    end

    # ── Generator currents and produced power ─────────────────────────────────
    gen_res = Dict{String,Any}()
    for (gid, gen) in get(net, "generator", Dict())
        bus  = get(gen, "bus", "")
        tm   = Vector{String}(get(gen, "terminal_map", String[]))
        cfg  = get(gen, "configuration", "WYE")
        is_delta  = cfg == "DELTA"
        n_c       = length(tm)
        ph_pos    = is_delta ? collect(eachindex(tm)) : _phase_positions(tm)
        n_pos_idx = is_delta ? nothing : _neutral_pos(tm)
        t_n       = n_pos_idx !== nothing ? tm[n_pos_idx] : nothing

        ph_results = Dict{String,Any}()
        for (idx, ph) in enumerate(ph_pos)
            t_ph = tm[ph]
            cr = val(crg_v[(gid, idx)]); ci = val(cig_v[(gid, idx)])
            vr_t = feasible ? val(vr_v[(bus, t_ph)]) : NaN
            vi_t = feasible ? val(vi_v[(bus, t_ph)]) : NaN
            # Reference: line-to-line (next phase) for DELTA, neutral for WYE.
            if is_delta
                t_ref = tm[(ph % n_c) + 1]
                vr_n  = feasible ? val(vr_v[(bus, t_ref)]) : NaN
                vi_n  = feasible ? val(vi_v[(bus, t_ref)]) : NaN
            else
                vr_n = (t_n !== nothing && feasible) ? val(vr_v[(bus, t_n)]) : 0.0
                vi_n = (t_n !== nothing && feasible) ? val(vi_v[(bus, t_n)]) : 0.0
            end
            dvr = vr_t - vr_n; dvi = vi_t - vi_n
            pg  = dvr*cr + dvi*ci
            qg  = dvi*cr - dvr*ci
            ph_results[t_ph] = Dict{String,Any}(
                "crg" => cr, "cig" => ci, "pg" => pg, "qg" => qg)
        end
        gen_res[gid] = ph_results
    end

    # ── Inverter currents and produced power ─────────────────────────────────
    inv_res = Dict{String,Any}()
    cri_v = vars[:cri]; cii_v = vars[:cii]
    profiles_net = get(net, "control_profile", Dict())

    for (inv_id, inv) in get(net, "inverter", Dict())
        inv isa Dict || continue
        bus  = get(inv, "bus", "")
        tm   = Vector{String}(get(inv, "terminal_map", String[]))
        topo = get(inv, "topology", "FOUR_LEG")

        # Resolve PF for reporting
        pf_val = nothing
        cp_id  = get(inv, "control_profile", nothing)
        if cp_id isa String
            cp = get(profiles_net, cp_id, nothing)
            if cp isa Dict
                pf_obj = get(cp, "power_factor", nothing)
                if pf_obj isa Dict
                    raw = get(pf_obj, "pf", nothing)
                    raw isa Number && (pf_val = Float64(raw))
                end
            end
        end

        ph_results = Dict{String,Any}()

        if topo == "SINGLE_PHASE" && length(tm) >= 2
            t_ph  = tm[1]; t_ref = tm[2]
            cr = val(cri_v[(inv_id,1)]); ci = val(cii_v[(inv_id,1)])
            vr_t  = feasible ? val(vr_v[(bus, t_ph)])  : NaN
            vi_t  = feasible ? val(vi_v[(bus, t_ph)])  : NaN
            vr_r  = feasible ? val(vr_v[(bus, t_ref)]) : NaN
            vi_r  = feasible ? val(vi_v[(bus, t_ref)]) : NaN
            dvr = vr_t - vr_r; dvi = vi_t - vi_r
            pg = dvr*cr + dvi*ci
            qg = dvi*cr - dvr*ci
            ph_results[t_ph] = Dict{String,Any}(
                "cri" => cr, "cii" => ci, "pg" => pg, "qg" => qg)

        elseif topo == "FOUR_LEG"
            ph_pos    = _phase_positions(tm)
            n_pos_idx = _neutral_pos(tm)
            t_n       = n_pos_idx !== nothing ? tm[n_pos_idx] : nothing

            for (idx, ph) in enumerate(ph_pos)
                t_ph = tm[ph]
                cr = val(cri_v[(inv_id,idx)]); ci = val(cii_v[(inv_id,idx)])
                vr_t = feasible ? val(vr_v[(bus, t_ph)]) : NaN
                vi_t = feasible ? val(vi_v[(bus, t_ph)]) : NaN
                vr_n = (t_n !== nothing && feasible) ? val(vr_v[(bus, t_n)]) : 0.0
                vi_n = (t_n !== nothing && feasible) ? val(vi_v[(bus, t_n)]) : 0.0
                dvr = vr_t - vr_n; dvi = vi_t - vi_n
                pg = dvr*cr + dvi*ci
                qg = dvi*cr - dvr*ci
                ph_results[t_ph] = Dict{String,Any}(
                    "cri" => cr, "cii" => ci, "pg" => pg, "qg" => qg)
            end

        elseif topo == "THREE_LEG"
            n_c = length(tm)
            for k in 1:n_c
                t_pos = tm[k]; t_neg = tm[(k % n_c) + 1]
                cr = val(cri_v[(inv_id,k)]); ci = val(cii_v[(inv_id,k)])
                vr_p = feasible ? val(vr_v[(bus, t_pos)]) : NaN
                vi_p = feasible ? val(vi_v[(bus, t_pos)]) : NaN
                vr_n = feasible ? val(vr_v[(bus, t_neg)]) : NaN
                vi_n = feasible ? val(vi_v[(bus, t_neg)]) : NaN
                dvr = vr_p - vr_n; dvi = vi_p - vi_n
                pg = dvr*cr + dvi*ci
                qg = dvi*cr - dvr*ci
                ph_results[t_pos] = Dict{String,Any}(
                    "cri" => cr, "cii" => ci, "pg" => pg, "qg" => qg)
            end
        end

        inv_res[inv_id] = ph_results
    end

    # ── Transformer currents (positional: "fr"/"to" => "1","2",...) ──────────
    # Terminal maps on the two winding sides may differ in length and in naming,
    # so these are indexed by position string rather than terminal name.
    xfmr_res = Dict{String,Any}()
    xfmr_dict = get(net, "transformer", Dict())
    for subtype in ("single_phase", "center_tap", "wye_delta", "delta_wye")
        sub = get(xfmr_dict, subtype, nothing)
        sub isa Dict || continue
        for (tid, xfmr) in sub
            tmfr_r = Vector{String}(get(xfmr, "terminal_map_from", String[]))
            tmto_r = Vector{String}(get(xfmr, "terminal_map_to",   String[]))
            if subtype == "single_phase"
                n_fr = length(BMOPFTools._phase_positions(tmfr_r))
                n_to = length(BMOPFTools._phase_positions(tmto_r))
            else
                n_fr = length(tmfr_r)
                n_to = length(tmto_r)
            end
            fr_dict = Dict{String,Any}()
            to_dict = Dict{String,Any}()
            for k in 1:n_fr
                cr = val(cr_xf_v[(tid, "fr", k)])
                ci = val(ci_xf_v[(tid, "fr", k)])
                fr_dict[string(k)] = Dict{String,Any}("cr" => cr, "ci" => ci,
                                                       "cm" => sqrt(cr^2 + ci^2))
            end
            for k in 1:n_to
                cr = val(cr_xf_v[(tid, "to", k)])
                ci = val(ci_xf_v[(tid, "to", k)])
                to_dict[string(k)] = Dict{String,Any}("cr" => cr, "ci" => ci,
                                                       "cm" => sqrt(cr^2 + ci^2))
            end
            xfmr_res[tid] = Dict{String,Any}("fr" => fr_dict, "to" => to_dict)
        end
    end

    # ── Voltage-source slack currents and imported power ──────────────────────
    # The source injects cr_src/ci_src into KCL; with fixed terminal voltages the
    # per-phase power is exact. Positive ps/qs = power imported into the network.
    cr_src_v = vars[:cr_src]; ci_src_v = vars[:ci_src]
    src_res = Dict{String,Any}()
    for (sid, vs) in get(net, "voltage_source", Dict())
        vs isa Dict || continue
        bus  = get(vs, "bus", "")
        tm   = Vector{String}(get(vs, "terminal_map", String[]))
        cfg  = get(vs, "configuration", "WYE")
        cfg in ("WYE", "SINGLE_PHASE") || continue
        ph_pos    = _phase_positions(tm)
        n_pos_idx = _neutral_pos(tm)
        t_n = if n_pos_idx !== nothing
            tm[n_pos_idx]
        else
            bt = get(get(net, "bus", Dict()), bus, Dict())
            BMOPFTools._neutral_terminal(bt)
        end

        ph_results = Dict{String,Any}()
        for (idx, ph) in enumerate(ph_pos)
            t_ph = tm[ph]
            cr = val(cr_src_v[(sid, idx)]); ci = val(ci_src_v[(sid, idx)])
            vr_t = feasible ? val(vr_v[(bus, t_ph)]) : NaN
            vi_t = feasible ? val(vi_v[(bus, t_ph)]) : NaN
            vr_n = (t_n !== nothing && feasible) ? val(vr_v[(bus, t_n)]) : 0.0
            vi_n = (t_n !== nothing && feasible) ? val(vi_v[(bus, t_n)]) : 0.0
            dvr = vr_t - vr_n; dvi = vi_t - vi_n
            ps  = dvr*cr + dvi*ci
            qs  = dvi*cr - dvr*ci
            ph_results[t_ph] = Dict{String,Any}(
                "cr" => cr, "ci" => ci, "cm" => sqrt(cr^2 + ci^2),
                "ps" => ps, "qs" => qs)
        end
        src_res[sid] = ph_results
    end

    # ── Initialisation start values ──────────────────────────────────────────
    # Capture the start values set by _set_voltage_start_values! /
    # _set_level_aware_start_values! before the solver overwrites them.
    # JuMP.start_value returns nothing for fixed (grounded) terminals — these
    # are always 0 V and are recorded as such.
    init_res = Dict{String,Any}()
    for (bid, terminals) in bus_terminals
        t_dict = Dict{String,Any}()
        for t in terminals
            vr_i = if (bid, t) in grounded
                0.0
            else
                something(JuMP.start_value(vr_v[(bid, t)]), 0.0)
            end
            vi_i = if (bid, t) in grounded
                0.0
            else
                something(JuMP.start_value(vi_v[(bid, t)]), 0.0)
            end
            t_dict[t] = Dict{String,Any}(
                "vr_init" => vr_i,
                "vi_init" => vi_i,
                "vm_init" => sqrt(vr_i^2 + vi_i^2),
                "va_init" => atan(vi_i, vr_i),
            )
        end
        init_res[bid] = t_dict
    end

    Dict{String,Any}(
        "termination_status" => status,
        "objective"          => obj,
        "solve_time"         => tsolve,
        "bus"                => bus_res,
        "line"               => line_res,
        "switch"             => switch_res,
        "load"               => load_res,
        "generator"          => gen_res,
        "inverter"           => inv_res,
        "transformer"        => xfmr_res,
        "voltage_source"     => src_res,
        "initialisation"     => init_res,
    )
end
