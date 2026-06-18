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
- `"switch"`     — `switch_id => terminal_name => {cr, ci [A], cm [A]}`
- `"load"`       — `load_id => terminal_name => {crd, cid [A], pd [W], qd [var]}`
- `"generator"`  — `gen_id => terminal_name => {crg, cig [A], pg [W], qg [var]}`
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
    line_res = Dict{String,Any}()
    for (lid, line) in get(net, "line", Dict())
        tm_fr = string.(get(line, "terminal_map_from", String[]))
        cond  = Dict{String,Any}()
        for (k, t_fr) in enumerate(tm_fr)
            cr_fr = val(cr_fr_v[(lid, k)])
            ci_fr = val(ci_fr_v[(lid, k)])
            cr_to = val(cr_to_v[(lid, k)])
            ci_to = val(ci_to_v[(lid, k)])
            cond[t_fr] = Dict{String,Any}(
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
        ph_pos    = cfg == "DELTA" ? collect(eachindex(tm)) : _phase_positions(tm)
        n_pos_idx = cfg == "DELTA" ? nothing : _neutral_pos(tm)
        t_n       = n_pos_idx !== nothing ? tm[n_pos_idx] : nothing

        ph_results = Dict{String,Any}()
        for (idx, ph) in enumerate(ph_pos)
            t_ph = tm[ph]
            cr = val(crd_v[(lid, idx)]); ci = val(cid_v[(lid, idx)])
            vr_t = feasible ? val(vr_v[(bus, t_ph)]) : NaN
            vi_t = feasible ? val(vi_v[(bus, t_ph)]) : NaN
            vr_n = (t_n !== nothing && feasible) ? val(vr_v[(bus, t_n)]) : 0.0
            vi_n = (t_n !== nothing && feasible) ? val(vi_v[(bus, t_n)]) : 0.0
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
        ph_pos    = cfg == "DELTA" ? collect(eachindex(tm)) : _phase_positions(tm)
        n_pos_idx = cfg == "DELTA" ? nothing : _neutral_pos(tm)
        t_n       = n_pos_idx !== nothing ? tm[n_pos_idx] : nothing

        ph_results = Dict{String,Any}()
        for (idx, ph) in enumerate(ph_pos)
            t_ph = tm[ph]
            cr = val(crg_v[(gid, idx)]); ci = val(cig_v[(gid, idx)])
            vr_t = feasible ? val(vr_v[(bus, t_ph)]) : NaN
            vi_t = feasible ? val(vi_v[(bus, t_ph)]) : NaN
            vr_n = (t_n !== nothing && feasible) ? val(vr_v[(bus, t_n)]) : 0.0
            vi_n = (t_n !== nothing && feasible) ? val(vi_v[(bus, t_n)]) : 0.0
            dvr = vr_t - vr_n; dvi = vi_t - vi_n
            pg  = dvr*cr + dvi*ci
            qg  = dvi*cr - dvr*ci
            ph_results[t_ph] = Dict{String,Any}(
                "crg" => cr, "cig" => ci, "pg" => pg, "qg" => qg)
        end
        gen_res[gid] = ph_results
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
            n_fr = length(get(xfmr, "terminal_map_from", String[]))
            n_to = length(get(xfmr, "terminal_map_to",   String[]))
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

    # Note: cr_src/ci_src are declared as JuMP variables but are never added to
    # the KCL accumulators and carry no constraints.  The voltage source only
    # fixes voltages; all current injection at the source bus comes from the
    # explicit generator there (or the auto-injected _auto_slack generator).
    # Exposing these unconstrained variables in the result would be misleading,
    # so voltage_source does not appear as a result section.

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
        "transformer"        => xfmr_res,
        "initialisation"     => init_res,
    )
end
