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
# ── wye_delta ──────────────────────────────────────────────────────────────
#   Primary (from) : n_ph phase terminals + 1 neutral; terminal_map_from
#   Secondary (to) : n_ph delta terminals; terminal_map_to
#   N = v_ref_from / v_ref_to  (treating both refs as same basis)
#
#   Voltage (k = 1..n_ph, k_next = k%n_ph + 1, phase positions in tmfr):
#     N * vr[to, tmto[k]] = vr[from, tmfr_ph[k]] - vr[from, tmfr_ph[k_next]]
#
#   Current (T^T of voltage transform, power-conservative):
#     N * cr_xf[fr,ph_k] = cr_xf[to, k_prev] - cr_xf[to, k]
#     cr_xf[fr, neutral_pos] = 0   (delta winding blocks zero-sequence current)
#
# ── delta_wye ──────────────────────────────────────────────────────────────
#   Symmetric to wye_delta with from↔to swapped.

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
    if wye_is_from
        b_wye  = get(xfmr, "bus_from", "")
        b_del  = get(xfmr, "bus_to",   "")
        tm_wye = Vector{String}(get(xfmr, "terminal_map_from", String[]))
        tm_del = Vector{String}(get(xfmr, "terminal_map_to",   String[]))
        side_wye = "fr"; side_del = "to"
    else
        b_del  = get(xfmr, "bus_from", "")
        b_wye  = get(xfmr, "bus_to",   "")
        tm_del = Vector{String}(get(xfmr, "terminal_map_from", String[]))
        tm_wye = Vector{String}(get(xfmr, "terminal_map_to",   String[]))
        side_del = "fr"; side_wye = "to"
    end

    N      = _xfmr_turns_ratio(xfmr)   # v_ref_from / v_ref_to
    n_ph   = length(tm_del)             # number of delta (phase) conductors
    n_wye  = length(tm_wye)

    # Identify phase positions and neutral position on the wye side
    n_pos  = _neutral_pos(tm_wye)       # position of neutral in tm_wye (or nothing)
    ph_idx = _phase_positions(tm_wye)   # positions of phase conductors

    length(ph_idx) < n_ph && @warn "Transformer '$tid': wye-side phase count < delta conductors."
    n_ph_eff = min(n_ph, length(ph_idx))

    # Voltage constraints:
    #   N * vr_del[k] = vr_wye[ph_k] - vr_wye[ph_k_next]
    for k in 1:n_ph_eff
        k_next = (k % n_ph_eff) + 1
        t_del  = tm_del[k]
        t_wye_k    = tm_wye[ph_idx[k]]
        t_wye_next = tm_wye[ph_idx[k_next]]
        @constraint(model,
            N * vr[(b_del, t_del)] == vr[(b_wye, t_wye_k)] - vr[(b_wye, t_wye_next)])
        @constraint(model,
            N * vi[(b_del, t_del)] == vi[(b_wye, t_wye_k)] - vi[(b_wye, t_wye_next)])
    end

    # Current constraints (from T^T power-conservation derivation):
    #   N * I_wye[k] = I_del[k_prev] - I_del[k]
    #   where k_prev = ((k-2+n_ph)%n_ph) + 1
    for k in 1:n_ph_eff
        k_prev = ((k - 2 + n_ph_eff) % n_ph_eff) + 1
        ph_pos = ph_idx[k]
        @constraint(model,
            N * cr_xf[(tid, side_wye, ph_pos)] ==
            cr_xf[(tid, side_del, k_prev)] - cr_xf[(tid, side_del, k)])
        @constraint(model,
            N * ci_xf[(tid, side_wye, ph_pos)] ==
            ci_xf[(tid, side_del, k_prev)] - ci_xf[(tid, side_del, k)])
    end

    # Neutral carries no current through delta winding
    if n_pos !== nothing
        fix(cr_xf[(tid, side_wye, n_pos)], 0.0; force=true)
        fix(ci_xf[(tid, side_wye, n_pos)], 0.0; force=true)
    end

    # KCL contributions
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
