# Transformer constraints — four-wire rectangular IVR formulation.
#
# All transformer constraints are linear.
#
# ── single_phase / center_tap (per-phase YY) ───────────────────────────────
#   N = v_ref_from / v_ref_to
#   Voltage : vr[from, tmfr[k]] = N * vr[to, tmto[k]]
#   Current : N * cr_xf[fr,k] + cr_xf[to,k] = 0
#   KCL     : bus_from -= cr_xf[fr,k], bus_to -= cr_xf[to,k]
#
# ── wye_delta (Yd) ─────────────────────────────────────────────────────────
#   Wye side (from) : n_ph phase terminals + 1 neutral
#   Delta side (to) : n_ph terminals
#   N = v_ref_from / v_ref_to  (both v_ref as phase-to-neutral equivalents)
#   n_eff = √3 / N             (effective turns ratio per winding)
#
#   Voltage (k = 1..n_ph, k_next = k%n_ph + 1):
#     vr_del[k] - vr_del[k_next] = n_eff * (vr_wye_ph[k] - vr_wye_neutral)
#
#   Current (T^T of voltage transform, power-conservative):
#     n_eff * cr_xf[del,k] = cr_xf[wye,ph_k] - cr_xf[wye,ph_{k_prev}]
#
#   Neutral KCL at transformer star point:
#     cr_xf[wye,neutral] + Σ_k cr_xf[wye,ph_k] = 0
#
# ── delta_wye (Dy) ─────────────────────────────────────────────────────────
#   Symmetric to wye_delta with from↔to swapped; n_eff = N * √3.

"""
    _add_transformer_constraints!(model, net, vars, kcl_r, kcl_i)

Dispatch transformer constraints for all subtypes in the network:
- `single_phase` and `center_tap` → `_add_yy_transformer!` (per-phase YY)
- `wye_delta`                     → `_add_yd_transformer!` with `wye_is_from=true`
- `delta_wye`                     → `_add_yd_transformer!` with `wye_is_from=false`
"""
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

"""
    _add_yy_transformer!(model, tid, xfmr, vr, vi, cr_xf, ci_xf, kcl_r, kcl_i)

Add per-phase wye-wye (YY) transformer constraints.

With turns ratio N = v_ref_from / v_ref_to:
  `vr[from,k] = N · vr[to,k]`,  `vi[from,k] = N · vi[to,k]`
  `N · cr_xf[fr,k] + cr_xf[to,k] = 0`

Used for both `single_phase` and `center_tap` transformer subtypes.
"""
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

"""
    _add_yd_transformer!(model, tid, xfmr, vr, vi, cr_xf, ci_xf, kcl_r, kcl_i; wye_is_from)

Add wye-delta (Yd) or delta-wye (Dy) transformer constraints.

`wye_is_from=true`  → wye side is `bus_from` (Yd: wye is HV primary).
`wye_is_from=false` → wye side is `bus_to`   (Dy: delta is HV primary).

The effective per-winding turns ratio accounts for the √3 factor introduced by the
delta connection geometry (phase-to-neutral `v_ref` on both sides as convention):
```
  n_eff = √3 / N   (Yd, wye is HV,    N = V_wye_ref / V_del_ref)
  n_eff = N · √3   (Dy, delta is HV,  N = V_del_ref / V_wye_ref)
```

Voltage constraints (k = 1..n_ph, k_next = (k % n_ph) + 1):
```
  vr_del[k] − vr_del[k_next] = n_eff · (vr_wye_ph[k] − vr_wye_neutral)
```

Current constraints (T^T of voltage transform, power-conservative):
```
  n_eff · cr_xf[del,k] = cr_xf[wye, ph_k] − cr_xf[wye, ph_{k_prev}]
```

Neutral KCL at the transformer star point:
```
  cr_xf[wye,neutral] + Σ_k cr_xf[wye,ph_k] = 0
```
"""
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
    end

    N     = _xfmr_turns_ratio(xfmr)   # v_ref_from / v_ref_to (phase-to-neutral convention)
    n_eff = wye_is_from ? sqrt(3) / N : N * sqrt(3)

    n_ph  = length(tm_del)             # number of delta (phase) conductors
    n_wye = length(tm_wye)

    n_pos  = _neutral_pos(tm_wye)       # position of neutral in tm_wye (or nothing)
    ph_idx = _phase_positions(tm_wye)   # positions of phase conductors in tm_wye

    length(ph_idx) < n_ph && @warn "Transformer '$tid': wye-side phase count < delta conductors."

    t_wye_neutral = n_pos !== nothing ? tm_wye[n_pos] : nothing

    # Voltage constraints:
    #   vr_del[k] - vr_del[k_next] = n_eff * (vr_wye_ph[k] - vr_wye_neutral)
    for k in 1:n_ph_eff
        k_next = (k % n_ph_eff) + 1
        t_del_k    = tm_del[k]
        t_del_next = tm_del[k_next]
        t_wye_ph   = tm_wye[ph_idx[k]]

        if n_pos !== nothing
            t_wye_n = tm_wye[n_pos]
            @constraint(model,
                vr[(b_del, t_del_k)] - vr[(b_del, t_del_next)] ==
                n_eff * (vr[(b_wye, t_wye_ph)] - vr[(b_wye, t_wye_n)]))
            @constraint(model,
                vi[(b_del, t_del_k)] - vi[(b_del, t_del_next)] ==
                n_eff * (vi[(b_wye, t_wye_ph)] - vi[(b_wye, t_wye_n)]))
        else
            # No neutral terminal: neutral voltage is implicitly zero (grounded elsewhere)
            @constraint(model,
                vr[(b_del, t_del_k)] - vr[(b_del, t_del_next)] ==
                n_eff * vr[(b_wye, t_wye_ph)])
            @constraint(model,
                vi[(b_del, t_del_k)] - vi[(b_del, t_del_next)] ==
                n_eff * vi[(b_wye, t_wye_ph)])
        end
    end

    # Current constraints (from T^T power-conservation derivation):
    #   n_eff * I_del[k] = I_wye[ph_k] - I_wye[ph_{k_prev}]
    for k in 1:n_ph_eff
        k_prev = ((k - 2 + n_ph_eff) % n_ph_eff) + 1
        ph_pos  = ph_idx[k]
        ph_prev = ph_idx[k_prev]
        @constraint(model,
            n_eff * cr_xf[(tid, side_del, k)] ==
            cr_xf[(tid, side_wye, ph_pos)] - cr_xf[(tid, side_wye, ph_prev)])
        @constraint(model,
            n_eff * ci_xf[(tid, side_del, k)] ==
            ci_xf[(tid, side_wye, ph_pos)] - ci_xf[(tid, side_wye, ph_prev)])
    end

    # Neutral KCL at the transformer star point:
    #   I_neutral + Σ I_phase = 0
    if n_pos !== nothing
        @constraint(model,
            cr_xf[(tid, side_wye, n_pos)] +
            sum(cr_xf[(tid, side_wye, ph)] for ph in ph_idx) == 0)
        @constraint(model,
            ci_xf[(tid, side_wye, n_pos)] +
            sum(ci_xf[(tid, side_wye, ph)] for ph in ph_idx) == 0)
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
