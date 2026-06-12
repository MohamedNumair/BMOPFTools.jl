# Line and switch constraints.
#
# Lines — KVL (rectangular form) and optional current magnitude limits.
# Shunt admittance (G_from, B_from, G_to, B_to) is not modelled here;
# most LV/MV distribution linecodes don't specify it.
#
# Series impedance (total, Ω) for conductor k, equation pair:
#   vr_from[k] - vr_to[k] = sum_j ( R[k,j]*cr_fr[j] - X[k,j]*ci_fr[j] )
#   vi_from[k] - vi_to[k] = sum_j ( R[k,j]*ci_fr[j] + X[k,j]*cr_fr[j] )
#
# No-shunt current balance: cr_to[k] = -cr_fr[k]
#
# KCL contributions:
#   bus_from terminal tmfr[k] : -cr_fr[k]
#   bus_to   terminal tmto[k] : +cr_to[k]   (= -cr_fr[k] via the above)

function _add_line_constraints!(model, net, vars, kcl_r, kcl_i)
    linecodes = get(net, "linecode", Dict())
    vr = vars[:vr]; vi = vars[:vi]
    cr_fr = vars[:cr_fr]; ci_fr = vars[:ci_fr]
    cr_to = vars[:cr_to]; ci_to = vars[:ci_to]

    for (lid, line) in get(net, "line", Dict())
        R, X, n_c = _line_z_matrix(line, linecodes)
        if n_c == 0
            @warn "Line '$lid': missing or unknown linecode — skipping KVL."
            continue
        end

        b_fr  = line["bus_from"]
        b_to  = line["bus_to"]
        tmfr  = Vector{String}(get(line, "terminal_map_from", String[]))
        tmto  = Vector{String}(get(line, "terminal_map_to",   String[]))
        n_map = min(length(tmfr), length(tmto), n_c)

        for k in 1:n_map
            t_fr = tmfr[k]; t_to = tmto[k]
            # KVL — real part
            @constraint(model,
                vr[(b_fr, t_fr)] - vr[(b_to, t_to)] ==
                sum(R[k,j]*cr_fr[(lid,j)] - X[k,j]*ci_fr[(lid,j)] for j in 1:n_map))
            # KVL — imaginary part
            @constraint(model,
                vi[(b_fr, t_fr)] - vi[(b_to, t_to)] ==
                sum(R[k,j]*ci_fr[(lid,j)] + X[k,j]*cr_fr[(lid,j)] for j in 1:n_map))
            # No-shunt current balance
            @constraint(model, cr_to[(lid,k)] == -cr_fr[(lid,k)])
            @constraint(model, ci_to[(lid,k)] == -ci_fr[(lid,k)])
        end

        # Current magnitude limits (per conductor, from the linecode)
        lc = get(linecodes, get(line, "linecode", ""), nothing)
        if lc !== nothing
            i_max = get(lc, "i_max", nothing)
            if i_max !== nothing
                for k in 1:min(n_map, length(i_max))
                    ilim = Float64(i_max[k])
                    @constraint(model,
                        cr_fr[(lid,k)]^2 + ci_fr[(lid,k)]^2 <= ilim^2)
                end
            end
        end

        # KCL contributions:
        #   cr_fr leaves bus_from → subtract; cr_to leaves bus_to → subtract.
        #   Since cr_to = -cr_fr, subtracting cr_to injects +cr_fr into bus_to.
        for k in 1:n_map
            _kcl_add!(kcl_r, kcl_i, b_fr, tmfr[k], -cr_fr[(lid,k)], -ci_fr[(lid,k)])
            _kcl_add!(kcl_r, kcl_i, b_to, tmto[k], -cr_to[(lid,k)], -ci_to[(lid,k)])
        end
    end
end

function _add_switch_constraints!(model, net, vars, kcl_r, kcl_i)
    vr = vars[:vr]; vi = vars[:vi]
    cr_sw = vars[:cr_sw]; ci_sw = vars[:ci_sw]

    for (sid, sw) in get(net, "switch", Dict())
        b_fr  = sw["bus_from"]
        b_to  = sw["bus_to"]
        tmfr  = Vector{String}(get(sw, "terminal_map_from", String[]))
        tmto  = Vector{String}(get(sw, "terminal_map_to",   String[]))
        is_open = get(sw, "open_switch", false)
        n_c = min(length(tmfr), length(tmto))

        for k in 1:n_c
            if !is_open
                # Closed: equate voltages (zero-impedance branch)
                @constraint(model, vr[(b_fr, tmfr[k])] == vr[(b_to, tmto[k])])
                @constraint(model, vi[(b_fr, tmfr[k])] == vi[(b_to, tmto[k])])
            end
            # cr_sw leaves bus_from; bus_to receives the same current (closed switch).
            _kcl_add!(kcl_r, kcl_i, b_fr, tmfr[k], -cr_sw[(sid,k)], -ci_sw[(sid,k)])
            _kcl_add!(kcl_r, kcl_i, b_to, tmto[k],  cr_sw[(sid,k)],  ci_sw[(sid,k)])
        end
    end
end
