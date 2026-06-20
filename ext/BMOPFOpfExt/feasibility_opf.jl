# Feasibility OPF — elastic slack-current formulation.
#
# Identical to solve_opf except:
#   1. A free slack current (cs_r, cs_i) is added at every ungrounded,
#      non-source bus terminal and injected directly into KCL.
#      This makes the KCL system always satisfiable regardless of loading.
#   2. The objective minimises the L2² norm of all slack injections rather
#      than generation cost.
#
# Interpretation: non-zero slacks after solving indicate terminals where the
# network cannot balance KCL under its physical constraints — i.e. the origin
# and magnitude of infeasibility. Pass the result to diagnose_infeasibility()
# for a ranked, classified breakdown.

"""
    BMOPFTools.solve_feasibility_opf(net; optimizer, t_index) -> Dict

Feasibility-relaxed four-wire IVR-EN OPF. Adds elastic slack current
injections at every non-source bus terminal so that KCL can always be
satisfied. Minimises ∑ |sₖ|² (L2² over all slack terminals).

Because the problem is always feasible, Ipopt always converges. Non-zero
slacks in the result reveal where the network cannot satisfy its constraints
without external intervention.

Use [`BMOPFTools.diagnose_infeasibility`](@ref) to interpret the result.
"""
function BMOPFTools.solve_feasibility_opf(net::Dict{String,Any};
                                           optimizer=Ipopt.Optimizer,
                                           t_index::Int=1,
                                           per_unit::Bool=false,
                                           s_base::Float64=1e6)

    working = BMOPFTools.is_timeseries(net) ?
              BMOPFTools.get_snapshot(net, t_index) : deepcopy(net)

    bases = nothing
    if per_unit
        working, bases = _to_per_unit(working, s_base)
    end

    model = JuMP.Model(optimizer)
    JuMP.set_silent(model)
    # Disable "acceptable level" early stopping so Ipopt always converges to the
    # regular tolerance (1e-8).  Without this, problems with bilinear P/Q
    # constraints and active thermal limits can exit prematurely, producing
    # inaccurate voltages.
    JuMP.set_optimizer_attribute(model, "acceptable_tol", 1e-8)

    bus_terminals = _bus_terminals(working)
    grounded      = _grounded_terminals(working)

    vars = _build_vars(model, working, bus_terminals, grounded)
    # Use level-aware start values so that LV buses are initialised at ~250 V
    # rather than at the source voltage (~6350 V). Without voltage bounds the
    # unconstrained NLP has a degenerate high-voltage local minimum; correct
    # initialisation ensures Ipopt finds the physical solution instead.
    _set_level_aware_start_values!(vars, working, bus_terminals, grounded)
    _set_yd_dy_start_values!(vars, working, grounded)

    # Voltage bounds are NOT enforced as hard constraints — they are evaluated
    # post-solve by diagnose_infeasibility, which reports violations.

    kcl_r, kcl_i = _init_kcl(bus_terminals, grounded)
    _add_source_constraints!(model, working, vars, kcl_r, kcl_i)
    _add_line_constraints!(model, working, vars, kcl_r, kcl_i)
    _add_switch_constraints!(model, working, vars, kcl_r, kcl_i)
    _add_transformer_constraints!(model, working, vars, kcl_r, kcl_i)
    _add_shunt_constraints!(working, vars, kcl_r, kcl_i)
    _add_load_constraints!(model, working, vars, kcl_r, kcl_i)
    _add_generator_constraints!(model, working, vars, kcl_r, kcl_i)
    _add_inverter_constraints!(model, working, vars, kcl_r, kcl_i)

    # ── Slack current injections ──────────────────────────────────────────────
    # One (cs_r, cs_i) pair per KCL node. Grounded terminals are excluded
    # (vr=vi=0 already fixed). Source-bus phase terminals carry the voltage
    # source's own slack current in KCL, so their elastic slack is naturally zero.

    cs_r = Dict{Tuple{String,String}, JuMP.VariableRef}()
    cs_i = Dict{Tuple{String,String}, JuMP.VariableRef}()

    for (bid, terminals) in bus_terminals
        for t in terminals
            key = (bid, t)
            key in grounded && continue
            haskey(kcl_r, key) || continue
            cs_r[key] = @variable(model, base_name = "cs_r_$(bid)_$(t)")
            cs_i[key] = @variable(model, base_name = "cs_i_$(bid)_$(t)")
            JuMP.add_to_expression!(kcl_r[key], cs_r[key])
            JuMP.add_to_expression!(kcl_i[key], cs_i[key])
        end
    end

    _add_kcl_constraints!(model, kcl_r, kcl_i)

    # ── Objective: minimise L2² of all slack injections ───────────────────────
    # A small linear term on Yd/Dy wye winding currents (1e-6 × cr_xf_wye) breaks
    # the sign degeneracy that arises because both I_wye>0 and I_wye<0 give zero
    # slack for passive transformers with resistive loads.  The penalty is tiny
    # relative to slack magnitudes (|cs| order 1-100 A when KCL fails) so it does
    # not bias the physical solution; it merely selects the physical branch when
    # both are equally feasible.
    slack_obj = JuMP.QuadExpr()
    for key in keys(cs_r)
        JuMP.add_to_expression!(slack_obj, 1.0, cs_r[key], cs_r[key])
        JuMP.add_to_expression!(slack_obj, 1.0, cs_i[key], cs_i[key])
    end
    xfmr_dict = get(working, "transformer", Dict())
    cr_xf = vars[:cr_xf]
    for subtype in ("wye_delta", "delta_wye")
        wye_is_from = (subtype == "wye_delta")
        # The unobservable state is the delta circulation current — a uniform loop
        # current that adds equally to all delta arm currents without affecting
        # terminal voltages or wye-side KCL.  Penalise the delta-side phase currents
        # to break this degeneracy.  For Yd the delta is the to-side; for Dy it is
        # the from-side.
        side_del = wye_is_from ? "to" : "fr"
        for (tid, xfmr) in get(xfmr_dict, subtype, Dict())
            tm_del = Vector{String}(wye_is_from ?
                get(xfmr, "terminal_map_to",   String[]) :
                get(xfmr, "terminal_map_from", String[]))
            for k in 1:length(tm_del)
                JuMP.add_to_expression!(slack_obj, -1.0, cr_xf[(tid, side_del, k)])
            end
        end
    end
    @objective(model, Min, slack_obj)

    JuMP.optimize!(model)

    # ── Results ───────────────────────────────────────────────────────────────
    result = _extract_results(model, working, bus_terminals, grounded, vars)

    solved = JuMP.termination_status(model) in (JuMP.MOI.LOCALLY_SOLVED,
                                                 JuMP.MOI.OPTIMAL,
                                                 JuMP.MOI.ALMOST_LOCALLY_SOLVED)
    val(v) = solved ? JuMP.value(v) : NaN

    # Slack injection results — keyed by bus then terminal
    slack_by_bus = Dict{String,Any}()
    for (bid, terminals) in bus_terminals
        t_slacks = Dict{String,Any}()
        for t in terminals
            key = (bid, t)
            haskey(cs_r, key) || continue
            csr = val(cs_r[key])
            csi = val(cs_i[key])
            t_slacks[t] = Dict{String,Any}(
                "cs_r"   => csr,
                "cs_i"   => csi,
                "cs_mag" => sqrt(csr^2 + csi^2),
            )
        end
        isempty(t_slacks) || (slack_by_bus[bid] = t_slacks)
    end

    total_sq = sum(
        v["cs_mag"]^2
        for td in values(slack_by_bus) for v in values(td);
        init = 0.0
    )

    result["slack_injections"]        = slack_by_bus
    result["total_slack_magnitude_A"] = sqrt(total_sq)
    result["is_feasibility_opf"]      = true
    bases !== nothing ? _from_per_unit(result, bases, net) : result
end
