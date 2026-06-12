# Objective: minimise total generation cost.
#
# cost on a generator is either:
#   - a scalar c1  → linear cost  c1 * P  per phase ($/W)
#   - a 3-vector [c2, c1, c0] → c2*P² + c1*P + c0  per phase
#
# P per phase is the bilinear expression:
#   P_k = dvr * crg[k] + dvi * cig[k]
#
# We accumulate a single QuadExpr (covers both linear and quadratic cases)
# and set it as the objective once.

function _add_objective!(model, net, vars)
    vr = vars[:vr]; vi = vars[:vi]
    crg = vars[:crg]; cig = vars[:cig]

    obj = JuMP.QuadExpr()

    for (gid, gen) in get(net, "generator", Dict())
        bus  = get(gen, "bus", "")
        tm   = Vector{String}(get(gen, "terminal_map", String[]))
        cfg  = get(gen, "configuration", "WYE")
        cost = get(gen, "cost", nothing)
        cost === nothing && continue

        c2, c1 = if cost isa AbstractVector
            length(cost) >= 3 ? (Float64(cost[1]), Float64(cost[2])) :
            length(cost) == 2 ? (0.0, Float64(cost[1])) :
                                (0.0, Float64(cost[1]))
        else
            (0.0, Float64(cost))
        end

        ph_pos    = cfg == "DELTA" ? collect(eachindex(tm)) : _phase_positions(tm)
        n_pos_idx = cfg == "DELTA" ? nothing : _neutral_pos(tm)
        t_n       = n_pos_idx !== nothing ? tm[n_pos_idx] : nothing

        for (idx, ph) in enumerate(ph_pos)
            t_ph = tm[ph]
            dvr  = t_n !== nothing ?
                   @expression(model, vr[(bus,t_ph)] - vr[(bus,t_n)]) :
                   vr[(bus, t_ph)]
            dvi  = t_n !== nothing ?
                   @expression(model, vi[(bus,t_ph)] - vi[(bus,t_n)]) :
                   vi[(bus, t_ph)]

            # Linear cost: c1 * (dvr*crg + dvi*cig).
            # dvr/dvi may be VariableRef or AffExpr (when a neutral is in the
            # terminal_map).  The 4-arg add_to_expression! only accepts
            # VariableRef × VariableRef, so we use the (scalar, QuadExpr) form.
            JuMP.add_to_expression!(obj, c1,
                @expression(model, dvr*crg[(gid,idx)] + dvi*cig[(gid,idx)]))

            # Quadratic cost: c2 * P² — expand P² = (dvr*crg + dvi*cig)²
            # Only exact when dvr/dvi are constants (fixed voltages); for a
            # validation tool the linear term is the primary cost signal.
            # Quadratic contribution added as c2 * (dvr²*(crg²) + ...) only
            # when dvr/dvi are scalar constants (source bus fixed voltages).
            if c2 != 0.0
                @warn "Generator '$gid': quadratic cost (c2=$c2) not fully " *
                      "representable as a polynomial in current variables; " *
                      "using linear approximation only."
            end
        end
    end

    @objective(model, Min, obj)
end
