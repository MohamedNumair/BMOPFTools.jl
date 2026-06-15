# Line and switch constraints.
#
# ── Lines (nominal Π model) ───────────────────────────────────────────────────
#
# Each line is modelled as a nominal Π equivalent:
#
#   from-bus ─┬─[Y_sh_fr/2]─ ─ ─[Z_series]─ ─ ─[Y_sh_to/2]─┬─ to-bus
#             └──(to ground)                   (to ground)──┘
#
# Series KVL (conductor k, total impedance Z = R + jX in Ω):
#   vr_fr[k] − vr_to[k]  =  Σ_j ( R[k,j]·cr_fr[j] − X[k,j]·ci_fr[j] )
#   vi_fr[k] − vi_to[k]  =  Σ_j ( R[k,j]·ci_fr[j] + X[k,j]·cr_fr[j] )
#
# Series current is identical at both ends (no current lost in the ideal
# series element):
#   cr_to[k] = −cr_fr[k],  ci_to[k] = −ci_fr[k]
#
# π-shunt current leaving bus b at conductor k (linear in voltage variables):
#   I^r_k = Σ_j ( G_kj · vr[b,t_j] − B_kj · vi[b,t_j] )
#   I^i_k = Σ_j ( G_kj · vi[b,t_j] + B_kj · vr[b,t_j] )
#
# KCL contributions (positive = into bus):
#   bus_from, tmfr[k]: −cr_fr[k] − I^r_sh_fr[k]   (series + shunt leave)
#   bus_to,   tmto[k]: −cr_to[k] − I^r_sh_to[k]   (series arrives, shunt leaves)
#
# Current magnitude limit (total current at each end):
#   |cr_fr[k] + I^r_sh_fr[k]|² + |ci_fr[k] + I^i_sh_fr[k]|² ≤ I_max[k]²
#   |cr_to[k] + I^r_sh_to[k]|² + |ci_to[k] + I^i_sh_to[k]|² ≤ I_max[k]²
#
# When G_from = B_from = G_to = B_to = 0 (no shunt), the π-shunt terms vanish,
# the two magnitude constraints are identical (since cr_to = −cr_fr), and the
# result reduces to the original series-only formulation.

"""
    _add_line_constraints!(model, net, vars, kcl_r, kcl_i)

Add nominal Π-model constraints for all lines and register their KCL
contributions.

For each line this adds:
- KVL across the series impedance (real and imaginary parts per conductor)
- Series current balance: `cr_to = −cr_fr`
- π-shunt KCL contributions at both buses (linear in voltage variables)
- Thermal current magnitude limits on the **total** current (series + π-shunt)
  at both the from- and to-ends

Shunt conductance (`G_from`, `G_to`) and susceptance (`B_from`, `B_to`) are
read from the linecode and scaled by line length. Missing or all-zero shunt
fields are a no-op.
"""
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

        # ── KVL + series current balance ──────────────────────────────────────
        for k in 1:n_map
            t_fr = tmfr[k]; t_to = tmto[k]
            @constraint(model,
                vr[(b_fr, t_fr)] - vr[(b_to, t_to)] ==
                sum(R[k,j]*cr_fr[(lid,j)] - X[k,j]*ci_fr[(lid,j)] for j in 1:n_map))
            @constraint(model,
                vi[(b_fr, t_fr)] - vi[(b_to, t_to)] ==
                sum(R[k,j]*ci_fr[(lid,j)] + X[k,j]*cr_fr[(lid,j)] for j in 1:n_map))
            @constraint(model, cr_to[(lid,k)] == -cr_fr[(lid,k)])
            @constraint(model, ci_to[(lid,k)] == -ci_fr[(lid,k)])
        end

        # ── π-shunt currents (linear in voltage variables) ────────────────────
        G_fr, B_fr, G_to, B_to = _line_pi_shunt(line, linecodes)

        ish_fr_r = [JuMP.AffExpr(0.0) for _ in 1:n_map]
        ish_fr_i = [JuMP.AffExpr(0.0) for _ in 1:n_map]
        ish_to_r = [JuMP.AffExpr(0.0) for _ in 1:n_map]
        ish_to_i = [JuMP.AffExpr(0.0) for _ in 1:n_map]

        _shunt_current!(ish_fr_r, ish_fr_i, vr, vi, G_fr, B_fr, b_fr, tmfr[1:n_map])
        _shunt_current!(ish_to_r, ish_to_i, vr, vi, G_to, B_to, b_to, tmto[1:n_map])

        # ── KCL: series currents + π-shunt currents, both leaving their bus ───
        for k in 1:n_map
            _kcl_add!(kcl_r, kcl_i, b_fr, tmfr[k],
                      -cr_fr[(lid,k)] - ish_fr_r[k],
                      -ci_fr[(lid,k)] - ish_fr_i[k])
            _kcl_add!(kcl_r, kcl_i, b_to, tmto[k],
                      -cr_to[(lid,k)] - ish_to_r[k],
                      -ci_to[(lid,k)] - ish_to_i[k])
        end

        # ── Thermal current limits on total current at each end ───────────────
        lc = get(linecodes, get(line, "linecode", ""), nothing)
        if lc !== nothing
            i_max = get(lc, "i_max", nothing)
            if i_max !== nothing
                for k in 1:min(n_map, length(i_max))
                    ilim = Float64(i_max[k])
                    cfr_r = @expression(model, cr_fr[(lid,k)] + ish_fr_r[k])
                    cfr_i = @expression(model, ci_fr[(lid,k)] + ish_fr_i[k])
                    cto_r = @expression(model, cr_to[(lid,k)] + ish_to_r[k])
                    cto_i = @expression(model, ci_to[(lid,k)] + ish_to_i[k])
                    @constraint(model, cfr_r^2 + cfr_i^2 <= ilim^2)
                    @constraint(model, cto_r^2 + cto_i^2 <= ilim^2)
                end
            end
        end
    end
end

"""
    _add_line_angle_constraints!(model, net, vars)

Enforce per-line angle-difference bounds (`va_diff_min`, `va_diff_max`, radians) between
the from- and to-end voltages on each conductor. Only called from `solve_opf` (operational
limits, not the feasibility formulation).

For each conductor k:
  s = vr_fr·vi_to − vi_fr·vr_to   (imaginary part of V_fr · conj(V_to))
  c = vr_fr·vr_to + vi_fr·vi_to   (real part)
  tan(va_diff_min)·c ≤ s ≤ tan(va_diff_max)·c
"""
function _add_line_angle_constraints!(model, net, vars)
    vr = vars[:vr]; vi = vars[:vi]

    for (lid, line) in get(net, "line", Dict())
        va_diff_min = get(line, "va_diff_min", nothing)
        va_diff_max = get(line, "va_diff_max", nothing)
        (va_diff_min === nothing && va_diff_max === nothing) && continue

        tan_min = va_diff_min !== nothing ? tan(Float64(va_diff_min)) : nothing
        tan_max = va_diff_max !== nothing ? tan(Float64(va_diff_max)) : nothing

        b_fr  = line["bus_from"]
        b_to  = line["bus_to"]
        tmfr  = Vector{String}(get(line, "terminal_map_from", String[]))
        tmto  = Vector{String}(get(line, "terminal_map_to",   String[]))
        n_c   = min(length(tmfr), length(tmto))

        for k in 1:n_c
            t_fr = tmfr[k]; t_to = tmto[k]
            haskey(vr, (b_fr, t_fr)) || continue
            haskey(vr, (b_to, t_to)) || continue
            s = @expression(model, vr[(b_fr,t_fr)]*vi[(b_to,t_to)] - vi[(b_fr,t_fr)]*vr[(b_to,t_to)])
            c = @expression(model, vr[(b_fr,t_fr)]*vr[(b_to,t_to)] + vi[(b_fr,t_fr)]*vi[(b_to,t_to)])
            tan_min !== nothing && @constraint(model, tan_min * c <= s)
            tan_max !== nothing && @constraint(model, s <= tan_max * c)
        end
    end
end

"""
    _add_switch_constraints!(model, net, vars, kcl_r, kcl_i)

Add constraints for all switches and register switch currents in the KCL
accumulators.

A *closed* switch short-circuits its two terminals (zero-impedance coupling):
  `vr[from,k] == vr[to,k]`,  `vi[from,k] == vi[to,k]`

An *open* switch has its current fixed to zero by `_add_switch_variables!`; no
voltage coupling is imposed (terminals are electrically disconnected).
"""
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
                @constraint(model, vr[(b_fr, tmfr[k])] == vr[(b_to, tmto[k])])
                @constraint(model, vi[(b_fr, tmfr[k])] == vi[(b_to, tmto[k])])
            end
            _kcl_add!(kcl_r, kcl_i, b_fr, tmfr[k], -cr_sw[(sid,k)], -ci_sw[(sid,k)])
            _kcl_add!(kcl_r, kcl_i, b_to, tmto[k],  cr_sw[(sid,k)],  ci_sw[(sid,k)])
        end
    end
end
