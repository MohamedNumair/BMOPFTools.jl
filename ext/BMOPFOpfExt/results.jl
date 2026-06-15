# Extract the JuMP solution into a plain Dict{String,Any}.
#
# All physical quantities remain in SI: V, A, W, var.
# Voltage magnitude and angle are derived from vr/vi for convenience.

"""
    _extract_results(model, net, bus_terminals, grounded, vars) -> Dict{String,Any}

Pack the JuMP solution into a plain `Dict{String,Any}`.  All quantities are in SI
units (V, A, W, var).

Returned top-level keys:
- `"termination_status"` — string form of `JuMP.termination_status`
- `"objective"`          — objective value
- `"solve_time"`         — solver wall-clock time (s)
- `"bus"`                — `bus_id => terminal => {vr, vi, vm [V], va [rad]}`
- `"line"`               — `line_id => conductor_index => {cr_fr, ci_fr, cr_to, ci_to, cm_fr [A]}`
- `"generator"`          — `gen_id => terminal => {crg, cig [A], pg [W], qg [var]}`
- `"voltage_source"`     — `src_id => terminal => {cr, ci [A]}`

When the solver did not find a feasible point, all numeric fields contain `NaN`.
"""
function _extract_results(model, net, bus_terminals, grounded, vars)
    status = string(JuMP.termination_status(model))
    obj    = JuMP.objective_value(model)
    tsolve = JuMP.solve_time(model)

    vr_v = vars[:vr]; vi_v = vars[:vi]
    crg_v = vars[:crg]; cig_v = vars[:cig]
    cr_src_v = vars[:cr_src]; ci_src_v = vars[:ci_src]
    cr_fr_v = vars[:cr_fr]; ci_fr_v = vars[:ci_fr]
    cr_to_v = vars[:cr_to]; ci_to_v = vars[:ci_to]

    feasible = JuMP.termination_status(model) in (
        JuMP.MOI.LOCALLY_SOLVED, JuMP.MOI.OPTIMAL, JuMP.MOI.ALMOST_LOCALLY_SOLVED)

    # Helper: safely get variable value (returns NaN if not solved)
    val(v) = feasible ? JuMP.value(v) : NaN

    # Bus results
    bus_res = Dict{String,Any}()
    for (bid, terminals) in bus_terminals
        t_dict = Dict{String,Any}()
        for t in terminals
            key = (bid, t)
            vr_t = (bid, t) in grounded ? 0.0 : val(vr_v[key])
            vi_t = (bid, t) in grounded ? 0.0 : val(vi_v[key])
            t_dict[t] = Dict{String,Any}(
                "vr" => vr_t,
                "vi" => vi_t,
                "vm" => sqrt(vr_t^2 + vi_t^2),
                "va" => atan(vi_t, vr_t),
            )
        end
        bus_res[bid] = t_dict
    end

    # Line results
    line_res = Dict{String,Any}()
    for (lid, line) in get(net, "line", Dict())
        tm_fr = get(line, "terminal_map_from", String[])
        n_c   = length(tm_fr)
        cond  = Dict{String,Any}()
        for k in 1:n_c
            cond[string(k)] = Dict{String,Any}(
                "cr_fr" => val(cr_fr_v[(lid,k)]),
                "ci_fr" => val(ci_fr_v[(lid,k)]),
                "cr_to" => val(cr_to_v[(lid,k)]),
                "ci_to" => val(ci_to_v[(lid,k)]),
                "cm_fr" => sqrt(val(cr_fr_v[(lid,k)])^2 + val(ci_fr_v[(lid,k)])^2),
            )
        end
        line_res[lid] = cond
    end

    # Generator results
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
            cr = val(crg_v[(gid,idx)]); ci = val(cig_v[(gid,idx)])
            vr_t = feasible ? val(vr_v[(bus,t_ph)]) : NaN
            vi_t = feasible ? val(vi_v[(bus,t_ph)]) : NaN
            vr_n = (t_n !== nothing && feasible) ? val(vr_v[(bus,t_n)]) : 0.0
            vi_n = (t_n !== nothing && feasible) ? val(vi_v[(bus,t_n)]) : 0.0
            dvr = vr_t - vr_n; dvi = vi_t - vi_n
            pg  = dvr*cr + dvi*ci
            qg  = dvi*cr - dvr*ci
            ph_results[t_ph] = Dict{String,Any}(
                "crg" => cr, "cig" => ci, "pg" => pg, "qg" => qg)
        end
        gen_res[gid] = ph_results
    end

    # Voltage source results
    src_res = Dict{String,Any}()
    for (sid, vs) in get(net, "voltage_source", Dict())
        tm = Vector{String}(get(vs, "terminal_map", String[]))
        t_dict = Dict{String,Any}()
        for (k, t) in enumerate(tm)
            t_dict[t] = Dict{String,Any}(
                "cr" => val(cr_src_v[(sid,k)]),
                "ci" => val(ci_src_v[(sid,k)]),
            )
        end
        src_res[sid] = t_dict
    end

    Dict{String,Any}(
        "termination_status" => status,
        "objective"          => obj,
        "solve_time"         => tsolve,
        "bus"                => bus_res,
        "line"               => line_res,
        "generator"          => gen_res,
        "voltage_source"     => src_res,
    )
end
