# Generator constraints and voltage source constraints.
#
# Generators: P/Q bounds expressed via bilinear power equations.
# Voltage sources: fix bus voltages and inject slack current (unconstrained).
#
# ── Generator (WYE / SINGLE_PHASE) ────────────────────────────────────────
# For phase conductor k (1-based in the phase subset of terminal_map):
#   P_k = (vr[t_ph] - vr[t_n]) * crg[k] + (vi[t_ph] - vi[t_n]) * cig[k]
#   Q_k = (vi[t_ph] - vi[t_n]) * crg[k] - (vr[t_ph] - vr[t_n]) * cig[k]
#   p_min[k] <= P_k <= p_max[k]
#   q_min[k] <= Q_k <= q_max[k]
# KCL: phase terminal += crg[k], neutral terminal -= crg[k].
#
# ── Voltage source ─────────────────────────────────────────────────────────
# Fix vr[bus, t] = v_mag[k]*cos(v_ang[k]), vi = v_mag[k]*sin(v_ang[k]).
# cr_src / ci_src are free variables that appear in KCL (slack injection).

"""
    _add_generator_constraints!(model, net, vars, kcl_r, kcl_i)

Add constant-power P/Q bound constraints for all generators and register generator
currents in the KCL accumulators.

For WYE/SINGLE_PHASE generators, real and reactive power per phase `k` are
related to the phase-to-neutral voltage and the current variables by:
```
  P_k = (vr_ph − vr_n)·crg[k] + (vi_ph − vi_n)·cig[k]
  Q_k = (vi_ph − vi_n)·crg[k] − (vr_ph − vr_n)·cig[k]
```
with `p_min[k] ≤ P_k ≤ p_max[k]` and `q_min[k] ≤ Q_k ≤ q_max[k]`.
DELTA generators use the same bilinear form with line-to-line voltage.
"""
function _add_generator_constraints!(model, net, vars, kcl_r, kcl_i)
    vr = vars[:vr]; vi = vars[:vi]
    crg = vars[:crg]; cig = vars[:cig]

    for (gid, gen) in get(net, "generator", Dict())
        bus       = get(gen, "bus", "")
        tm        = Vector{String}(get(gen, "terminal_map", String[]))
        cfg       = get(gen, "configuration", "WYE")
        p_min     = Float64.(get(gen, "p_min", Float64[]))
        p_max     = Float64.(get(gen, "p_max", Float64[]))
        q_min     = Float64.(get(gen, "q_min", Float64[]))
        q_max     = Float64.(get(gen, "q_max", Float64[]))
        i_max_g   = Float64.(get(gen, "i_max", Float64[]))
        s_max_g   = Float64.(get(gen, "s_max", Float64[]))

        if cfg in ("WYE", "SINGLE_PHASE")
            ph_pos    = _phase_positions(tm)
            n_pos_idx = _neutral_pos(tm)
            t_n       = n_pos_idx !== nothing ? tm[n_pos_idx] : nothing

            for (idx, ph) in enumerate(ph_pos)
                t_ph = tm[ph]
                vr_ph = vr[(bus, t_ph)]; vi_ph = vi[(bus, t_ph)]
                if t_n !== nothing
                    dvr = @expression(model, vr_ph - vr[(bus, t_n)])
                    dvi = @expression(model, vi_ph - vi[(bus, t_n)])
                else
                    dvr = vr_ph; dvi = vi_ph
                end

                p_expr = @expression(model, dvr*crg[(gid,idx)] + dvi*cig[(gid,idx)])
                q_expr = @expression(model, dvi*crg[(gid,idx)] - dvr*cig[(gid,idx)])

                length(p_min) >= idx && @constraint(model, p_expr >= p_min[idx])
                length(p_max) >= idx && @constraint(model, p_expr <= p_max[idx])
                length(q_min) >= idx && @constraint(model, q_expr >= q_min[idx])
                length(q_max) >= idx && @constraint(model, q_expr <= q_max[idx])

                # Current magnitude limit
                length(i_max_g) >= idx && @constraint(model,
                    crg[(gid,idx)]^2 + cig[(gid,idx)]^2 <= i_max_g[idx]^2)

                # Apparent power limit (via auxiliary variables to keep quadratic)
                if length(s_max_g) >= idx
                    pg_v = @variable(model, base_name = "pg_$(gid)_$(idx)")
                    qg_v = @variable(model, base_name = "qg_$(gid)_$(idx)")
                    @constraint(model, pg_v == p_expr)
                    @constraint(model, qg_v == q_expr)
                    @constraint(model, pg_v^2 + qg_v^2 <= s_max_g[idx]^2)
                end

                _kcl_add!(kcl_r, kcl_i, bus, t_ph,  crg[(gid,idx)],  cig[(gid,idx)])
                if t_n !== nothing
                    _kcl_add!(kcl_r, kcl_i, bus, t_n, -crg[(gid,idx)], -cig[(gid,idx)])
                end
            end

        elseif cfg == "DELTA"
            n_c = length(tm)
            for k in 1:n_c
                t_pos = tm[k]; t_neg = tm[(k % n_c) + 1]
                dvr = @expression(model, vr[(bus,t_pos)] - vr[(bus,t_neg)])
                dvi = @expression(model, vi[(bus,t_pos)] - vi[(bus,t_neg)])

                p_expr = @expression(model, dvr*crg[(gid,k)] + dvi*cig[(gid,k)])
                q_expr = @expression(model, dvi*crg[(gid,k)] - dvr*cig[(gid,k)])

                length(p_min) >= k && @constraint(model, p_expr >= p_min[k])
                length(p_max) >= k && @constraint(model, p_expr <= p_max[k])
                length(q_min) >= k && @constraint(model, q_expr >= q_min[k])
                length(q_max) >= k && @constraint(model, q_expr <= q_max[k])

                # Current magnitude limit
                length(i_max_g) >= k && @constraint(model,
                    crg[(gid,k)]^2 + cig[(gid,k)]^2 <= i_max_g[k]^2)

                # Apparent power limit (via auxiliary variables to keep quadratic)
                if length(s_max_g) >= k
                    pg_v = @variable(model, base_name = "pg_$(gid)_$(k)")
                    qg_v = @variable(model, base_name = "qg_$(gid)_$(k)")
                    @constraint(model, pg_v == p_expr)
                    @constraint(model, qg_v == q_expr)
                    @constraint(model, pg_v^2 + qg_v^2 <= s_max_g[k]^2)
                end

                _kcl_add!(kcl_r, kcl_i, bus, t_pos,  crg[(gid,k)],  cig[(gid,k)])
                _kcl_add!(kcl_r, kcl_i, bus, t_neg, -crg[(gid,k)], -cig[(gid,k)])
            end
        else
            @warn "Generator '$gid': unknown configuration '$cfg' — skipping."
        end
    end
end

"""
    _add_source_constraints!(net, vars, kcl_r, kcl_i)

Fix bus voltages at voltage-source terminals and inject unconstrained slack current
`cr_src / ci_src` into the KCL accumulators.

Each terminal is fixed to the rectangular value `v_mag·cos(v_ang)`, `v_mag·sin(v_ang)`.
The slack current absorbs whatever KCL imbalance the rest of the network demands,
making the source bus the power-flow slack bus.
"""
function _add_source_constraints!(net, vars, kcl_r, kcl_i)
    vr = vars[:vr]; vi = vars[:vi]
    cr_src = vars[:cr_src]; ci_src = vars[:ci_src]

    for (sid, vs) in get(net, "voltage_source", Dict())
        bus    = get(vs, "bus", "")
        tm     = Vector{String}(get(vs, "terminal_map", String[]))
        v_mag  = Float64.(get(vs, "v_magnitude", Float64[]))
        v_ang  = Float64.(get(vs, "v_angle",     Float64[]))

        for (k, t) in enumerate(tm)
            if length(v_mag) >= k && length(v_ang) >= k
                fix(vr[(bus, t)], v_mag[k] * cos(v_ang[k]); force=true)
                fix(vi[(bus, t)], v_mag[k] * sin(v_ang[k]); force=true)
            end
            # Slack injection: cr_src/ci_src are free — KCL determines their value.
            _kcl_add!(kcl_r, kcl_i, bus, t, cr_src[(sid,k)], ci_src[(sid,k)])
        end
    end
end
