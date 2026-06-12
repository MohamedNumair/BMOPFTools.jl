# Transformer constraints — four-wire rectangular IVR formulation.
#
# All constraints are linear (no nonlinearity introduced by transformers).
#
# ── single_phase / center_tap (treated identically: per-phase YY) ──────────
#   N = v_ref_from / v_ref_to
#   Voltage : vr[from, tmfr[k]] = N * vr[to, tmto[k]]
#   Current : N * cr_xf[fr,k] + cr_xf[to,k] = 0
#   KCL     : bus_from -= cr_xf[fr,k], bus_to -= cr_xf[to,k]
#
# ── wye_delta / delta_wye ───────────────────────────────────────────────────
#   Define n_eff such that the delta LINE voltage = n_eff × wye PHASE-TO-NEUTRAL
#   voltage (measuring wye phases relative to the wye neutral terminal):
#
#     Dy (delta=primary/HV): n_eff = N × √3   where N = v_ref_from/v_ref_to
#     Yd (wye=primary/HV):   n_eff = √3 / N
#
#   Voltage (k cyclic 1..n_ph, k_next = k%n_ph+1):
#     vr[del,k] − vr[del,k_next] = n_eff × (vr[wye,k] − vr[wye,neutral])
#
#   Current (ampere-turns balance, k_prev = (k-2+n_ph)%n_ph+1):
#     n_eff × cr[del,k] = cr[wye,k] − cr[wye,k_prev]
#
#   Neutral KCL at transformer star point:
#     cr[wye,neutral] = −(cr[wye,1] + cr[wye,2] + cr[wye,3])

function _add_transformer_constraints!(model, net, vars, kcl_r, kcl_i)
    vr = vars[:vr]; vi = vars[:vi]
    cr_xf = vars[:cr_xf]; ci_xf = vars[:ci_xf]
    xfmr_dict = get(net, "transformer", Dict())

    for subtype in ("single_phase", "center_tap")
        for (tid, xfmr) in get(xfmr_dict, subtype, Dict())
            _add_yy_transformer!(model, tid, xfmr, vr, vi, cr_xf, ci_xf, kcl_r, kcl_i)
        end
    end

    for (tid, xfmr) in get(xfmr_dict, "wye_delta", Dict())
        _add_yd_transformer!(model, tid, xfmr, vr, vi, cr_xf, ci_xf, kcl_r, kcl_i;
                              wye_is_from=true)
    end
    for (tid, xfmr) in get(xfmr_dict, "delta_wye", Dict())
        _add_yd_transformer!(model, tid, xfmr, vr, vi, cr_xf, ci_xf, kcl_r, kcl_i;
                              wye_is_from=false)
    end
end

# ── YY (per-phase) ──────────────────────────────────────────────────────────

function _add_yy_transformer!(model, tid, xfmr, vr, vi, cr_xf, ci_xf, kcl_r, kcl_i)
    b_fr  = get(xfmr, "bus_from", "")
    b_to  = get(xfmr, "bus_to",   "")
    tmfr  = Vector{String}(get(xfmr, "terminal_map_from", String[]))
    tmto  = Vector{String}(get(xfmr, "terminal_map_to",   String[]))
    N     = _xfmr_turns_ratio(xfmr)
    n_c   = min(length(tmfr), length(tmto))

    for k in 1:n_c
        t_fr = tmfr[k]; t_to = tmto[k]
        # Voltage ratio
        @constraint(model, vr[(b_fr, t_fr)] == N * vr[(b_to, t_to)])
        @constraint(model, vi[(b_fr, t_fr)] == N * vi[(b_to, t_to)])
        # Current ratio: N * I_fr + I_to = 0
        @constraint(model, N * cr_xf[(tid,"fr",k)] + cr_xf[(tid,"to",k)] == 0)
        @constraint(model, N * ci_xf[(tid,"fr",k)] + ci_xf[(tid,"to",k)] == 0)
        # KCL
        _kcl_add!(kcl_r, kcl_i, b_fr, t_fr, -cr_xf[(tid,"fr",k)], -ci_xf[(tid,"fr",k)])
        _kcl_add!(kcl_r, kcl_i, b_to, t_to, -cr_xf[(tid,"to",k)], -ci_xf[(tid,"to",k)])
    end
end

# ── YD / DY ─────────────────────────────────────────────────────────────────

function _add_yd_transformer!(model, tid, xfmr, vr, vi, cr_xf, ci_xf, kcl_r, kcl_i;
                               wye_is_from::Bool)
    N = _xfmr_turns_ratio(xfmr)   # v_ref_from / v_ref_to

    if wye_is_from
        b_wye    = get(xfmr, "bus_from", "")
        b_del    = get(xfmr, "bus_to",   "")
        tm_wye   = Vector{String}(get(xfmr, "terminal_map_from", String[]))
        tm_del   = Vector{String}(get(xfmr, "terminal_map_to",   String[]))
        side_wye = "fr"; side_del = "to"
        n_eff    = sqrt(3.0) / N   # Yd: delta is LV secondary
    else
        b_del    = get(xfmr, "bus_from", "")
        b_wye    = get(xfmr, "bus_to",   "")
        tm_del   = Vector{String}(get(xfmr, "terminal_map_from", String[]))
        tm_wye   = Vector{String}(get(xfmr, "terminal_map_to",   String[]))
        side_del = "fr"; side_wye = "to"
        n_eff    = N * sqrt(3.0)   # Dy: delta is HV primary
    end

    n_ph     = length(tm_del)
    n_wye    = length(tm_wye)
    n_pos    = _neutral_pos(tm_wye)
    ph_idx   = _phase_positions(tm_wye)
    n_ph_eff = min(n_ph, length(ph_idx))

    length(ph_idx) < n_ph && @warn "Transformer '$tid': wye-side phase count < delta conductors."

    t_wye_neutral = n_pos !== nothing ? tm_wye[n_pos] : nothing

    # ── Voltage constraints ───────────────────────────────────────────────────
    for k in 1:n_ph_eff
        k_next     = (k % n_ph_eff) + 1
        t_del_k    = tm_del[k]
        t_del_next = tm_del[k_next]
        t_wye_k    = tm_wye[ph_idx[k]]

        vr_pn = t_wye_neutral !== nothing ?
            @expression(model, vr[(b_wye, t_wye_k)] - vr[(b_wye, t_wye_neutral)]) :
            vr[(b_wye, t_wye_k)]
        vi_pn = t_wye_neutral !== nothing ?
            @expression(model, vi[(b_wye, t_wye_k)] - vi[(b_wye, t_wye_neutral)]) :
            vi[(b_wye, t_wye_k)]

        @constraint(model, vr[(b_del, t_del_k)] - vr[(b_del, t_del_next)] == n_eff * vr_pn)
        @constraint(model, vi[(b_del, t_del_k)] - vi[(b_del, t_del_next)] == n_eff * vi_pn)
    end

    # ── Current constraints ───────────────────────────────────────────────────
    for k in 1:n_ph_eff
        k_prev  = ((k - 2 + n_ph_eff) % n_ph_eff) + 1
        ph_pos  = ph_idx[k]
        ph_prev = ph_idx[k_prev]
        @constraint(model,
            n_eff * cr_xf[(tid, side_del, k)] ==
            cr_xf[(tid, side_wye, ph_pos)] - cr_xf[(tid, side_wye, ph_prev)])
        @constraint(model,
            n_eff * ci_xf[(tid, side_del, k)] ==
            ci_xf[(tid, side_wye, ph_pos)] - ci_xf[(tid, side_wye, ph_prev)])
    end

    # ── Neutral: KCL at transformer star point ────────────────────────────────
    if n_pos !== nothing
        cr_sum = JuMP.AffExpr(0.0)
        ci_sum = JuMP.AffExpr(0.0)
        for k in 1:n_ph_eff
            JuMP.add_to_expression!(cr_sum, cr_xf[(tid, side_wye, ph_idx[k])])
            JuMP.add_to_expression!(ci_sum, ci_xf[(tid, side_wye, ph_idx[k])])
        end
        @constraint(model, cr_xf[(tid, side_wye, n_pos)] + cr_sum == 0)
        @constraint(model, ci_xf[(tid, side_wye, n_pos)] + ci_sum == 0)
    end

    # ── KCL contributions ─────────────────────────────────────────────────────
    for k in 1:n_wye
        t = tm_wye[k]
        _kcl_add!(kcl_r, kcl_i, b_wye, t,
                  -cr_xf[(tid, side_wye, k)], -ci_xf[(tid, side_wye, k)])
    end
    for k in 1:n_ph
        t = tm_del[k]
        _kcl_add!(kcl_r, kcl_i, b_del, t,
                  -cr_xf[(tid, side_del, k)], -ci_xf[(tid, side_del, k)])
    end
end
