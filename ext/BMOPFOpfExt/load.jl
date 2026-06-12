# Load constraints — constant-power model, rectangular IVR.
#
# Current variables crd/cid are indexed by phase conductor position (1-based)
# within the phase subset of terminal_map (neutral excluded from variables).
#
# ── WYE / SINGLE_PHASE ────────────────────────────────────────────────────
# For each phase k (position in the phase-only list):
#   t_ph = phase terminal, t_n = neutral terminal
#   P_k = (vr[t_ph] - vr[t_n]) * crd[k] + (vi[t_ph] - vi[t_n]) * cid[k]
#   Q_k = (vi[t_ph] - vi[t_n]) * crd[k] - (vr[t_ph] - vr[t_n]) * cid[k]
#
# Neutral current enforced by KCL (sum of phase currents flows back at neutral).
# KCL contributions: bus at t_ph -= crd[k], bus at t_n += crd[k].
#
# ── DELTA ─────────────────────────────────────────────────────────────────
# Element k connects terminal_map[k] (positive) to terminal_map[k%n+1] (negative).
#   P_k = (vr[t_pos] - vr[t_neg]) * crd[k] + (vi[t_pos] - vi[t_neg]) * cid[k]
#   Q_k = (vi[t_pos] - vi[t_neg]) * crd[k] - (vr[t_pos] - vr[t_neg]) * cid[k]
# KCL: at t_pos -= crd[k], at t_neg += crd[k].

function _add_load_constraints!(model, net, vars, kcl_r, kcl_i)
    vr = vars[:vr]; vi = vars[:vi]
    crd = vars[:crd]; cid = vars[:cid]

    for (lid, load) in get(net, "load", Dict())
        bus = get(load, "bus", "")
        tm  = Vector{String}(get(load, "terminal_map", String[]))
        cfg = get(load, "configuration", "WYE")
        p_nom = Float64.(get(load, "p_nom", Float64[]))
        q_nom = Float64.(get(load, "q_nom", Float64[]))

        if cfg in ("WYE", "SINGLE_PHASE")
            ph_pos = _phase_positions(tm)
            n_pos_idx = _neutral_pos(tm)
            t_n = n_pos_idx !== nothing ? tm[n_pos_idx] : nothing

            for (idx, ph) in enumerate(ph_pos)
                length(p_nom) >= idx || continue
                t_ph = tm[ph]
                vr_ph = vr[(bus, t_ph)]; vi_ph = vi[(bus, t_ph)]
                if t_n !== nothing
                    vr_n = vr[(bus, t_n)]; vi_n = vi[(bus, t_n)]
                    dvr = @expression(model, vr_ph - vr_n)
                    dvi = @expression(model, vi_ph - vi_n)
                else
                    dvr = vr_ph; dvi = vi_ph
                end

                # P: bilinear
                @constraint(model,
                    dvr * crd[(lid,idx)] + dvi * cid[(lid,idx)] == p_nom[idx])
                # Q: bilinear
                @constraint(model,
                    dvi * crd[(lid,idx)] - dvr * cid[(lid,idx)] == q_nom[idx])

                # KCL: phase terminal loses crd, neutral terminal gains crd
                _kcl_add!(kcl_r, kcl_i, bus, t_ph, -crd[(lid,idx)], -cid[(lid,idx)])
                if t_n !== nothing
                    _kcl_add!(kcl_r, kcl_i, bus, t_n, crd[(lid,idx)], cid[(lid,idx)])
                end
            end

        elseif cfg == "DELTA"
            n_c = length(tm)
            for k in 1:n_c
                length(p_nom) >= k || continue
                t_pos = tm[k]
                t_neg = tm[(k % n_c) + 1]
                vr_pos = vr[(bus, t_pos)]; vi_pos = vi[(bus, t_pos)]
                vr_neg = vr[(bus, t_neg)]; vi_neg = vi[(bus, t_neg)]
                dvr = @expression(model, vr_pos - vr_neg)
                dvi = @expression(model, vi_pos - vi_neg)

                @constraint(model,
                    dvr * crd[(lid,k)] + dvi * cid[(lid,k)] == p_nom[k])
                @constraint(model,
                    dvi * crd[(lid,k)] - dvr * cid[(lid,k)] == q_nom[k])

                _kcl_add!(kcl_r, kcl_i, bus, t_pos, -crd[(lid,k)], -cid[(lid,k)])
                _kcl_add!(kcl_r, kcl_i, bus, t_neg,  crd[(lid,k)],  cid[(lid,k)])
            end
        else
            @warn "Load '$lid': unknown configuration '$cfg' — skipping."
        end
    end
end
