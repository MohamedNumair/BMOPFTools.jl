# Transformer constraints — four-wire rectangular IVR formulation.
#
# All transformer constraints are linear.
#
# ── single_phase (per-phase YY) ────────────────────────────────────────────
#   N = v_ref_from / v_ref_to
#   Voltage : vr_fr − N·vr_to = R·cr_series − X·ci_series
#   Current : N·I_series_fr + I_to = 0
#   Shunt   : I_mag = (G + jB)·V_fr  added to KCL at from terminals
#
# ── center_tap (split-phase, North American distribution) ──────────────────
#   from: bus_fr  terminal_map_from = ["1","n"]      (HV phase + neutral)
#   to:   bus_lv  terminal_map_to   = ["1","n","2"]  (leg-1, center-tap, leg-2)
#   N = v_ref_from / v_ref_to  (v_ref_to is the 120 V leg rating)
#
#   T-model: primary impedance (R1,X1) on HV; per-leg secondary (R2,X2) on each LV branch.
#   This correctly captures load-asymmetry: unequal leg currents → unequal leg voltages.
#
#   Voltage (HV-side form, legs independently):
#     (V_fr[1]−V_fr[n]) − N·(V_lv[1]−V_lv[n]) = R1·I_s − X1·jI_s + N·(R2·I_leg1 − X2·jI_leg1)
#     (V_fr[1]−V_fr[n]) − N·(V_lv[n]−V_lv[2]) = R1·I_s − X1·jI_s + N·(R2·I_leg2 − X2·jI_leg2)
#
#   Current (power conservation):
#     N·I_s + I_leg1 + I_leg2 = 0
#
#   Center-tap KCL (n terminal, not a floating node):
#     I_n + I_leg1 + I_leg2 = 0
#
#   KCL contributions: bus_fr -= I_fr (series + shunt), bus_lv -= I_lv_k
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
- `single_phase` → `_add_yy_transformer!` (per-phase YY with Γ-model losses)
- `center_tap`   → `_add_center_tap_transformer!` (split-phase with T-model: per-leg LV impedance)
- `wye_delta`    → `_add_yd_transformer!` with `wye_is_from=true`
- `delta_wye`    → `_add_yd_transformer!` with `wye_is_from=false`
"""
function _add_transformer_constraints!(model, net, vars, kcl_r, kcl_i)
    vr = vars[:vr]; vi = vars[:vi]
    cr_xf = vars[:cr_xf]; ci_xf = vars[:ci_xf]
    xfmr_dict = get(net, "transformer", Dict())

    for (tid, xfmr) in get(xfmr_dict, "single_phase", Dict())
        _add_yy_transformer!(model, tid, xfmr, vr, vi, cr_xf, ci_xf, kcl_r, kcl_i)
    end
    for (tid, xfmr) in get(xfmr_dict, "center_tap", Dict())
        _add_center_tap_transformer!(model, tid, xfmr, vr, vi, cr_xf, ci_xf, kcl_r, kcl_i)
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

Add per-phase wye-wye (YY) transformer constraints using a Γ-equivalent model.

`cr_xf[(tid,"fr",k)]` / `ci_xf[(tid,"fr",k)]` are the **series** (ideal-core)
currents.  The from-side terminal current is series + magnetising shunt:

  I_term_fr = I_series + I_mag,   I_mag = (G + jB) · V_fr

where `G = g_no_load`, `B = b_no_load` are the total no-load admittance (S)
referred to the from side, shared equally across the `n_c` per-phase pairs.

Series impedance (Ω), referred to the from side (Γ convention):

  R = r_series_from + N² · r_series_to
  X = x_series_from + N² · x_series_to

Voltage constraints (replaces ideal `V_fr = N·V_to`):

  vr_fr − N·vr_to = R·cr_series − X·ci_series
  vi_fr − N·vi_to = R·ci_series + X·cr_series

Current coupling (ideal core, unchanged):

  N·I_series_fr + I_to = 0

KCL contributions use the terminal current (series + shunt).
`i_max_from` limits the terminal current; `i_max_to` limits `I_to`.

When all loss parameters are absent or zero the model collapses to the
previous ideal transformer.

Used for both `single_phase` and `center_tap` transformer subtypes.
"""
function _add_yy_transformer!(model, tid, xfmr, vr, vi, cr_xf, ci_xf, kcl_r, kcl_i)
    b_fr       = get(xfmr, "bus_from", "")
    b_to       = get(xfmr, "bus_to",   "")
    tmfr       = Vector{String}(get(xfmr, "terminal_map_from", String[]))
    tmto       = Vector{String}(get(xfmr, "terminal_map_to",   String[]))
    N          = _xfmr_turns_ratio(xfmr)
    # Only phase conductors get independent winding constraints.
    # The neutral is the return path: its voltage is determined by KCL, not by
    # an additional winding equation. Use _phase_positions to exclude it.
    ph_fr      = _phase_positions(tmfr)
    ph_to      = _phase_positions(tmto)
    n_pos_fr   = _neutral_pos(tmfr)
    n_pos_to   = _neutral_pos(tmto)
    t_n_fr     = n_pos_fr !== nothing ? tmfr[n_pos_fr] : nothing
    t_n_to     = n_pos_to !== nothing ? tmto[n_pos_to] : nothing
    n_c        = min(length(ph_fr), length(ph_to))
    i_max_fr   = Float64.(get(xfmr, "i_max_from", Float64[]))
    i_max_to_v = Float64.(get(xfmr, "i_max_to",   Float64[]))

    # Series impedance referred to the from side (Ω). Zero when absent.
    r_fr = Float64(get(xfmr, "r_series_from", 0.0))
    x_fr = Float64(get(xfmr, "x_series_from", 0.0))
    r_to = Float64(get(xfmr, "r_series_to",   0.0))
    x_to = Float64(get(xfmr, "x_series_to",   0.0))
    R = r_fr + N^2 * r_to
    X = x_fr + N^2 * x_to

    # No-load admittance (S) at the from terminals, split equally per phase pair.
    # OpenDSS places the no-load branch on winding 1 (from side).
    G_total = Float64(get(xfmr, "g_no_load", 0.0))
    B_total = Float64(get(xfmr, "b_no_load", 0.0))
    G = n_c > 0 ? G_total / n_c : 0.0
    B = n_c > 0 ? B_total / n_c : 0.0

    has_series = (R != 0.0 || X != 0.0)
    has_shunt  = (G != 0.0 || B != 0.0)

    for k in 1:n_c
        # Index into the phase-only position lists; k is the k-th phase conductor.
        pos_fr = ph_fr[k]
        pos_to = ph_to[k]
        t_fr   = tmfr[pos_fr]
        t_to   = tmto[pos_to]

        # Voltage: (V_ph_fr − V_n_fr) − N·(V_ph_to − V_n_to) = Z·I_series
        # When no neutral exists on a side, the neutral voltage is implicitly 0.
        if has_series
            vr_fr_pn = t_n_fr !== nothing ?
                @expression(model, vr[(b_fr, t_fr)] - vr[(b_fr, t_n_fr)]) : vr[(b_fr, t_fr)]
            vi_fr_pn = t_n_fr !== nothing ?
                @expression(model, vi[(b_fr, t_fr)] - vi[(b_fr, t_n_fr)]) : vi[(b_fr, t_fr)]
            vr_to_pn = t_n_to !== nothing ?
                @expression(model, vr[(b_to, t_to)] - vr[(b_to, t_n_to)]) : vr[(b_to, t_to)]
            vi_to_pn = t_n_to !== nothing ?
                @expression(model, vi[(b_to, t_to)] - vi[(b_to, t_n_to)]) : vi[(b_to, t_to)]
            @constraint(model,
                vr_fr_pn - N * vr_to_pn ==
                R * cr_xf[(tid,"fr",k)] - X * ci_xf[(tid,"fr",k)])
            @constraint(model,
                vi_fr_pn - N * vi_to_pn ==
                R * ci_xf[(tid,"fr",k)] + X * cr_xf[(tid,"fr",k)])
        else
            vr_fr_pn = t_n_fr !== nothing ?
                @expression(model, vr[(b_fr, t_fr)] - vr[(b_fr, t_n_fr)]) : vr[(b_fr, t_fr)]
            vi_fr_pn = t_n_fr !== nothing ?
                @expression(model, vi[(b_fr, t_fr)] - vi[(b_fr, t_n_fr)]) : vi[(b_fr, t_fr)]
            vr_to_pn = t_n_to !== nothing ?
                @expression(model, vr[(b_to, t_to)] - vr[(b_to, t_n_to)]) : vr[(b_to, t_to)]
            vi_to_pn = t_n_to !== nothing ?
                @expression(model, vi[(b_to, t_to)] - vi[(b_to, t_n_to)]) : vi[(b_to, t_to)]
            @constraint(model, vr_fr_pn == N * vr_to_pn)
            @constraint(model, vi_fr_pn == N * vi_to_pn)
        end

        # Ideal-core current coupling: N·I_series_fr + I_to = 0
        @constraint(model, N * cr_xf[(tid,"fr",k)] + cr_xf[(tid,"to",k)] == 0)
        @constraint(model, N * ci_xf[(tid,"fr",k)] + ci_xf[(tid,"to",k)] == 0)

        # From-side phase terminal current = series + magnetising shunt.
        # The no-load shunt is wye-connected (phase-to-neutral), so the shunt
        # voltage is V_ph − V_n.  When no neutral exists, use V_ph (earth return).
        if has_shunt
            vr_ph_n = t_n_fr !== nothing ?
                @expression(model, vr[(b_fr, t_fr)] - vr[(b_fr, t_n_fr)]) : vr[(b_fr, t_fr)]
            vi_ph_n = t_n_fr !== nothing ?
                @expression(model, vi[(b_fr, t_fr)] - vi[(b_fr, t_n_fr)]) : vi[(b_fr, t_fr)]
            icr_mag = @expression(model,  G * vr_ph_n - B * vi_ph_n)
            ici_mag = @expression(model,  G * vi_ph_n + B * vr_ph_n)

            icr_term = @expression(model, cr_xf[(tid,"fr",k)] + icr_mag)
            ici_term = @expression(model, ci_xf[(tid,"fr",k)] + ici_mag)

            _kcl_add!(kcl_r, kcl_i, b_fr, t_fr, -icr_term, -ici_term)
            if length(i_max_fr) >= k
                @constraint(model, icr_term^2 + ici_term^2 <= i_max_fr[k]^2)
            end
        else
            _kcl_add!(kcl_r, kcl_i, b_fr, t_fr, -cr_xf[(tid,"fr",k)], -ci_xf[(tid,"fr",k)])
            if length(i_max_fr) >= k
                @constraint(model,
                    cr_xf[(tid,"fr",k)]^2 + ci_xf[(tid,"fr",k)]^2 <= i_max_fr[k]^2)
                # No-load shunt absent here, so the limit is on the bare variable.
                _limit_current_box!(cr_xf[(tid,"fr",k)], ci_xf[(tid,"fr",k)], i_max_fr[k])
            end
        end

        # From-side neutral KCL: series return current + no-load shunt return.
        # Accumulate after the last phase so the neutral KCL fires exactly once.
        if t_n_fr !== nothing && k == n_c
            icr_n = @expression(model, sum(cr_xf[(tid,"fr",kk)] for kk in 1:n_c))
            ici_n = @expression(model, sum(ci_xf[(tid,"fr",kk)] for kk in 1:n_c))
            if has_shunt
                # No-load shunt return current (sum over all phase conductors)
                vr_ph_n_sum = @expression(model,
                    sum(vr[(b_fr, tmfr[ph_fr[kk]])] - vr[(b_fr, t_n_fr)] for kk in 1:n_c))
                vi_ph_n_sum = @expression(model,
                    sum(vi[(b_fr, tmfr[ph_fr[kk]])] - vi[(b_fr, t_n_fr)] for kk in 1:n_c))
                icr_n = @expression(model, icr_n + G * vr_ph_n_sum - B * vi_ph_n_sum)
                ici_n = @expression(model, ici_n + G * vi_ph_n_sum + B * vr_ph_n_sum)
            end
            _kcl_add!(kcl_r, kcl_i, b_fr, t_n_fr, icr_n, ici_n)
        end

        # To-side phase terminal KCL: transformer injects current at the LV phase.
        # The LV neutral is the load's return path; the transformer model does not
        # directly connect to it, so no neutral KCL contribution on the to-side.
        _kcl_add!(kcl_r, kcl_i, b_to, t_to, -cr_xf[(tid,"to",k)], -ci_xf[(tid,"to",k)])
        if length(i_max_to_v) >= k
            @constraint(model,
                cr_xf[(tid,"to",k)]^2 + ci_xf[(tid,"to",k)]^2 <= i_max_to_v[k]^2)
            _limit_current_box!(cr_xf[(tid,"to",k)], ci_xf[(tid,"to",k)], i_max_to_v[k])
        end
    end
end

# ── Center-tap (split-phase) ────────────────────────────────────────────────

"""
    _add_center_tap_transformer!(model, tid, xfmr, vr, vi, cr_xf, ci_xf, kcl_r, kcl_i)

Add constraints for a center-tap (North American split-phase) transformer.

Terminal conventions (from the BMOPF spec arity (2,3)):
  from: `terminal_map_from = ["t_ph", "t_n"]`   — HV phase + neutral
  to:   `terminal_map_to   = ["t1",  "tn", "t2"]` — LV leg-1, center-tap, leg-2

Variable index mapping:
  `cr_xf[(tid,"fr",1)]` — HV series current (into phase terminal)
  `cr_xf[(tid,"to",1)]` — LV leg-1 current  (flows through winding-2 resistance)
  `cr_xf[(tid,"to",2)]` — LV center-tap current I_n (KCL balance at neutral)
  `cr_xf[(tid,"to",3)]` — LV leg-2 current  (flows through winding-3 resistance)

Physics (T-model: primary impedance on HV side, per-leg impedance on each LV branch):

  The HV winding carries the total series current I_s = -(I_leg1 + I_leg2)/N.
  Each LV leg has its own winding resistance R_lv/X_lv in addition to the
  primary resistance referred to LV (R_hv/N², X_hv/N²).

  Voltage — leg-1 (t1→tn) and leg-2 (tn→t2) each see the same ideal EMF but
  their own series impedance:
    V_hv/N − R_hv/N²·I_s − R_lv·I_leg1 = V_lv_leg1
    V_hv/N − R_hv/N²·I_s − R_lv·I_leg2 = V_lv_leg2

  Expanding with V_hv = V_fr_ph − V_fr_n, V_lv_leg1 = V_to[t1] − V_to[tn],
  V_lv_leg2 = V_to[tn] − V_to[t2], and I_s from current coupling:

    (V_fr_ph − V_fr_n)/N − R_hv/N²·I_s − R_lv·I_leg1 − X_hv/N²·jI_s − X_lv·jI_leg1
      = V_to[t1] − V_to[tn]

  Rearranging to the BMOPF variable convention (HV voltage drop form):
    (V_fr_ph − V_fr_n) − N·(V_to[t1] − V_to[tn])
      = (R_hv + N²·R_lv)·I_s − N²·R_lv·(I_s − I_leg1/N)   [cancels partially]

  The clean LV-side form avoids the N² coefficient explosion.  Writing:
    R1 = r_series_from, X1 = x_series_from  (HV winding, Ω)
    R2 = r_series_to,   X2 = x_series_to    (each LV winding, Ω)

  OpenDSS uses a T-model with a star-network conversion for 3-winding leakage:
    X1_star = (XHL + XHT − XLT) / 2   (HV winding star leakage)
    X2_star = (XHL + XLT − XHT) / 2   (LV winding 2 star leakage)
    X3_star = (XHT + XLT − XHL) / 2   (LV winding 3 star leakage)

  The BMOPF data fields `x_series_from` / `x_series_to` must store the star values,
  NOT XHL/2. For a symmetric center-tap (X2=X3), the data model stores:
    x_series_from  ← X1_star × Zhv / 100
    x_series_to    ← X2_star × Zlv / 100   (= X3_star × Zlv / 100 when symmetric)

  Polarity convention for leg-2:
    Winding 3 in DSS connects center-tap(4) → lv.2, i.e., it is wound in REVERSE
    relative to winding 2 (which connects lv.1 → center-tap(4)). This means
    the LV leg-2 current flows FROM lv.2 INTO the center-tap, OPPOSITE to the
    leg-1 current (which flows from lv.1 into the center-tap). The current
    coupling at the ideal core is therefore:
      N·I_s + I_leg1 − I_leg2 = 0
    (leg-2 subtracts because winding 3 is the reverse winding).
    BMOPF convention: `cr_xf[(tid,"to",3)]` = I_leg2 defined as positive flowing
    INTO lv.2 (out of the center-tap), which is the DSS winding-3 "to" terminal
    current convention.

  Voltage equations (HV-side form):
    (V_fr_ph − V_fr_n) − N·(V_to[t1] − V_to[tn]) = R1·I_s + N·R2·I_leg1
    (V_fr_ph − V_fr_n) − N·(V_to[tn] − V_to[t2]) = R1·I_s − N·R2·I_leg2
    (leg-2 RHS has −N·R2·I_leg2 because the winding direction is reversed)

  Center-tap KCL (current balance at the neutral terminal):
    I_n = −(I_leg1 − I_leg2) = −I_leg1 + I_leg2

  No-load shunt (G+jB) at HV terminals (placed on winding-1 from side).
"""
function _add_center_tap_transformer!(model, tid, xfmr, vr, vi, cr_xf, ci_xf, kcl_r, kcl_i)
    b_fr       = get(xfmr, "bus_from", "")
    b_to       = get(xfmr, "bus_to",   "")
    tmfr       = Vector{String}(get(xfmr, "terminal_map_from", String[]))
    tmto       = Vector{String}(get(xfmr, "terminal_map_to",   String[]))
    N          = _xfmr_turns_ratio(xfmr)
    i_max_fr   = Float64.(get(xfmr, "i_max_from", Float64[]))
    i_max_to_v = Float64.(get(xfmr, "i_max_to",   Float64[]))

    # Require exactly 2 HV and 3 LV terminals.
    length(tmfr) == 2 && length(tmto) == 3 || begin
        @warn "center_tap '$tid': expected terminal_map_from length 2 and " *
              "terminal_map_to length 3; got $(length(tmfr)) and $(length(tmto)). Skipping."
        return
    end

    t_fr_ph = tmfr[1]; t_fr_n  = tmfr[2]   # HV phase, HV neutral
    t_lv_1  = tmto[1]; t_lv_n  = tmto[2]; t_lv_2 = tmto[3]  # leg-1, center-tap, leg-2

    # Winding impedances in their own-side units (Ω).
    # r_series_from / x_series_from  — HV winding (Ω, HV-side)
    # r_series_to   / x_series_to    — each LV winding (Ω, LV-side); both legs same rating
    R1 = Float64(get(xfmr, "r_series_from", 0.0))
    X1 = Float64(get(xfmr, "x_series_from", 0.0))
    R2 = Float64(get(xfmr, "r_series_to",   0.0))
    X2 = Float64(get(xfmr, "x_series_to",   0.0))
    has_series = (R1 != 0.0 || X1 != 0.0 || R2 != 0.0 || X2 != 0.0)

    # No-load admittance at HV terminals.
    G = Float64(get(xfmr, "g_no_load", 0.0))
    B = Float64(get(xfmr, "b_no_load", 0.0))
    has_shunt = (G != 0.0 || B != 0.0)

    # HV series current: index 1 on the "fr" side.
    Isr = cr_xf[(tid,"fr",1)];  Isi = ci_xf[(tid,"fr",1)]
    # LV currents: leg-1 = index 1, center-tap = index 2, leg-2 = index 3.
    Il1r = cr_xf[(tid,"to",1)]; Il1i = ci_xf[(tid,"to",1)]
    Il2r = cr_xf[(tid,"to",3)]; Il2i = ci_xf[(tid,"to",3)]
    Inr  = cr_xf[(tid,"to",2)]; Ini  = ci_xf[(tid,"to",2)]

    # ── Voltage constraints (T-model with per-leg secondary impedance) ────────
    # T-model: V_hv = V_star + Z1·I_s  (HV branch, I_s flows into hv.1)
    # Winding 2: V_star/N = V_leg1 + Z2·I_wdg2  where I_wdg2 flows from star→bus
    #   I_wdg2 = −Il1 (Il1 is defined INTO bus terminal t1, i.e. OUT of the winding)
    #   → V_star/N = V_leg1 − Z2·Il1  → N·V_leg1 = V_star + N·Z2·Il1
    #   Subtracting: V_hv − N·V_leg1 = Z1·I_s − N·Z2·Il1
    #
    # Winding 3 (reversed): connects tn→t2, so V_wdg3 = V(tn)−V(t2) = V_leg2
    #   and the winding's "from" terminal is tn (center-tap).
    #   V_star/N = V_leg2 + Z2·I_wdg3  where I_wdg3 flows from star→tn
    #   I_wdg3 = −Il2 (Il2 INTO lv.2 = out of winding's to-terminal; current entering tn from star = −Il2)
    #   → V_star/N = V_leg2 − Z2·Il2  → N·V_leg2 = V_star + N·Z2·Il2
    #   Subtracting: V_hv − N·V_leg2 = Z1·I_s − N·Z2·Il2
    if has_series
        # Leg-1: V_hv − N·V_leg1 = R1·Is − X1·Is_i − N·(R2·Il1 − X2·Il1_i)
        @constraint(model,
            (vr[(b_fr, t_fr_ph)] - vr[(b_fr, t_fr_n)]) -
            N * (vr[(b_to, t_lv_1)] - vr[(b_to, t_lv_n)]) ==
            R1 * Isr - X1 * Isi - N * ( R2 * Il1r - X2 * Il1i))
        @constraint(model,
            (vi[(b_fr, t_fr_ph)] - vi[(b_fr, t_fr_n)]) -
            N * (vi[(b_to, t_lv_1)] - vi[(b_to, t_lv_n)]) ==
            R1 * Isi + X1 * Isr - N * ( R2 * Il1i + X2 * Il1r))
        # Leg-2: V_hv − N·V_leg2 = R1·Is − X1·Is_i − N·(R2·Il2 − X2·Il2_i)
        @constraint(model,
            (vr[(b_fr, t_fr_ph)] - vr[(b_fr, t_fr_n)]) -
            N * (vr[(b_to, t_lv_n)] - vr[(b_to, t_lv_2)]) ==
            R1 * Isr - X1 * Isi - N * ( R2 * Il2r - X2 * Il2i))
        @constraint(model,
            (vi[(b_fr, t_fr_ph)] - vi[(b_fr, t_fr_n)]) -
            N * (vi[(b_to, t_lv_n)] - vi[(b_to, t_lv_2)]) ==
            R1 * Isi + X1 * Isr - N * ( R2 * Il2i + X2 * Il2r))
    else
        @constraint(model,
            vr[(b_fr, t_fr_ph)] - vr[(b_fr, t_fr_n)] ==
            N * (vr[(b_to, t_lv_1)] - vr[(b_to, t_lv_n)]))
        @constraint(model,
            vi[(b_fr, t_fr_ph)] - vi[(b_fr, t_fr_n)] ==
            N * (vi[(b_to, t_lv_1)] - vi[(b_to, t_lv_n)]))
        @constraint(model,
            vr[(b_fr, t_fr_ph)] - vr[(b_fr, t_fr_n)] ==
            N * (vr[(b_to, t_lv_n)] - vr[(b_to, t_lv_2)]))
        @constraint(model,
            vi[(b_fr, t_fr_ph)] - vi[(b_fr, t_fr_n)] ==
            N * (vi[(b_to, t_lv_n)] - vi[(b_to, t_lv_2)]))
    end

    # ── Current coupling (power conservation) ────────────────────────────────
    # Power balance at ideal core: V_hv·conj(I_s) + (V_leg1·conj(−Il1) + V_leg2·conj(−Il2)) = 0
    # The ideal-core coupling for a 3-winding T with both secondaries in the same
    # polarity convention (current into terminal = positive) is: N·I_s = Il1 + Il2
    # i.e. N·I_s − Il1 − Il2 = 0 (primary delivers, secondaries receive)
    # BUT: in the BMOPF variable convention, I_s is defined flowing INTO hv.1
    # (into the transformer), while Il1 and Il2 flow INTO lv.1 and lv.2
    # (also into the transformer from their respective buses).
    # Power balance: V_hv·I_s* = V_leg1·Il1* + V_leg2·Il2*  (complex power into primary = sum out)
    # Actually all currents are INTO the transformer, so power conservation:
    # V_hv·I_s* + V_leg1·Il1* + V_leg2·Il2* = 0  (three ports, all into element)
    # With V_hv/N = V_leg1 (ideal, no losses): N·I_s* + Il1* + Il2* = 0 → N·I_s + Il1 + Il2 = 0
    @constraint(model, N * Isr + Il1r + Il2r == 0)
    @constraint(model, N * Isi + Il1i + Il2i == 0)

    # ── Center-tap KCL: I_n balances the two leg currents at the center-tap ──
    # At lv.n: current entering = I_n (from wdg neutral tap) − Il1 (leaving to leg-1 bus)
    #   + Il2 (entering from leg-2 bus, since leg-2 draws from neutral).
    # Wait — both Il1 and Il2 are currents INTO the transformer FROM their buses.
    # Il1 leaves bus lv.1 → it's extracted from bus (negative KCL contribution to bus).
    # Il2 leaves bus lv.2 → it's extracted from bus (negative KCL contribution to bus).
    # At the center-tap node (lv.n): current in from lv.n bus = I_n (also leaves bus lv.n).
    # Center-tap node internal: the winding junction sees Il1 + I_n − Il2 = 0
    # (Il1 flows into the t1→tn winding at the tn end, I_n into the neutral terminal,
    #  and Il2 flows out of the tn→t2 winding at the tn end)
    # Actually: at tn node: current from wdg2's tn-end (= Il1 arrives here after flowing from t1)
    # + current from wdg3's tn-end (= Il2 arrives here going toward t2)
    # + I_n (from bus) = 0 at ideal no-leakage node
    # In our BMOPF variables, Inr = cr_xf[(tid,"to",2)] = current extracted from bus lv.n.
    # KCL at internal tn node: Il1 + Inr + Il2 = 0  (all flowing through the winding, sign from bus into element)
    # This matches the power coupling: if coupling is N·Is + Il1 + Il2 = 0,
    # then the center-tap sees the sum Il1 + Il2 = -N·Is, and I_n = -Il1 - Il2 = N·Is
    # But I_n also has the neutral reactor load ≈ 0, so effectively:
    @constraint(model, Inr + Il1r + Il2r == 0)
    @constraint(model, Ini + Il1i + Il2i == 0)

    # ── HV side KCL (terminal current = series + shunt) ──────────────────────
    if has_shunt
        icr_ph = JuMP.AffExpr(0.0); ici_ph = JuMP.AffExpr(0.0)
        JuMP.add_to_expression!(icr_ph,  1.0, Isr)
        JuMP.add_to_expression!(ici_ph,  1.0, Isi)
        JuMP.add_to_expression!(icr_ph,  G,   vr[(b_fr, t_fr_ph)])
        JuMP.add_to_expression!(icr_ph, -B,   vi[(b_fr, t_fr_ph)])
        JuMP.add_to_expression!(ici_ph,  G,   vi[(b_fr, t_fr_ph)])
        JuMP.add_to_expression!(ici_ph,  B,   vr[(b_fr, t_fr_ph)])
        _kcl_add!(kcl_r, kcl_i, b_fr, t_fr_ph, -icr_ph, -ici_ph)
        length(i_max_fr) >= 1 && @constraint(model, icr_ph^2 + ici_ph^2 <= i_max_fr[1]^2)
    else
        _kcl_add!(kcl_r, kcl_i, b_fr, t_fr_ph, -Isr, -Isi)
        if length(i_max_fr) >= 1
            @constraint(model, Isr^2 + Isi^2 <= i_max_fr[1]^2)
            _limit_current_box!(Isr, Isi, i_max_fr[1])  # bare HV series-current variable
        end
    end
    # HV neutral: series current returns here (shunt is phase-to-ground, not phase-to-neutral).
    _kcl_add!(kcl_r, kcl_i, b_fr, t_fr_n, Isr, Isi)

    # ── LV side KCL contributions ─────────────────────────────────────────────
    _kcl_add!(kcl_r, kcl_i, b_to, t_lv_1, -Il1r, -Il1i)
    _kcl_add!(kcl_r, kcl_i, b_to, t_lv_n, -Inr,  -Ini)
    _kcl_add!(kcl_r, kcl_i, b_to, t_lv_2, -Il2r, -Il2i)

    # ── Current magnitude limits (Il1/In/Il2 are bare LV winding-current
    #    variables, so the limit also tightens each component's box bound) ───────
    if length(i_max_to_v) >= 1
        @constraint(model, Il1r^2 + Il1i^2 <= i_max_to_v[1]^2)
        _limit_current_box!(Il1r, Il1i, i_max_to_v[1])
    end
    if length(i_max_to_v) >= 2
        @constraint(model, Inr^2 + Ini^2 <= i_max_to_v[2]^2)
        _limit_current_box!(Inr, Ini, i_max_to_v[2])
    end
    if length(i_max_to_v) >= 3
        @constraint(model, Il2r^2 + Il2i^2 <= i_max_to_v[3]^2)
        _limit_current_box!(Il2r, Il2i, i_max_to_v[3])
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

Loss model (per-winding T behind the ideal transform — matches OpenDSS / PMD):
  - `r/x_series_from` → series impedance on the from-side winding branch
  - `r/x_series_to`   → series impedance on the to-side winding branch
  - `g/b_no_load`     → core-loss shunt at the from-side (HV) phase terminals

The series drop enters the voltage constraint; with all impedance fields zero
the model collapses to the previous ideal transform.  A legacy single
`r_series`/`x_series` is read by the converter/migration as `*_series_from`
(wye side) with the to-side branch zero.
"""
function _add_yd_transformer!(model, tid, xfmr, vr, vi, cr_xf, ci_xf, kcl_r, kcl_i;
                               wye_is_from::Bool)
    N = _xfmr_turns_ratio(xfmr)   # v_ref_from / v_ref_to
    i_max_fr   = Float64.(get(xfmr, "i_max_from", Float64[]))
    i_max_to_v = Float64.(get(xfmr, "i_max_to",   Float64[]))

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

    # Series impedance per winding (Ω). r/x_series_from is the from-side winding,
    # r/x_series_to the to-side winding. Map to wye/delta branches by side.
    r_fr = Float64(get(xfmr, "r_series_from", 0.0))
    x_fr = Float64(get(xfmr, "x_series_from", 0.0))
    r_to = Float64(get(xfmr, "r_series_to",   0.0))
    x_to = Float64(get(xfmr, "x_series_to",   0.0))
    if wye_is_from
        Rw, Xw = r_fr, x_fr   # wye branch = from
        Rd, Xd = r_to, x_to   # delta branch = to
    else
        Rd, Xd = r_fr, x_fr   # delta branch = from
        Rw, Xw = r_to, x_to   # wye branch = to
    end
    has_series = (Rw != 0.0 || Xw != 0.0 || Rd != 0.0 || Xd != 0.0)

    # Voltage constraints.
    # For Yd (wye_is_from=true):  V_del[k] - V_del[k_next] = n_eff*(V_wye[k] - V_n)
    # For Dy (wye_is_from=false): V_del[k] - V_del[k_prev] = n_eff*(V_wye[k] - V_n)
    # The Dy direction matches the ODS backward-delta convention.
    #
    # Per-winding T: subtract the series drop across the wye branch (current
    # I_wye,k) and the delta branch (current I_del,k, referred through n_eff):
    #   ΔV_del = n_eff·ΔV_wye − (Rw+jXw)·I_wye,k − n_eff·(Rd+jXd)·I_del,k
    for k in 1:n_ph
        t_del_k   = tm_del[k]
        ph_pos    = ph_idx[k]
        t_wye_ph  = tm_wye[ph_pos]
        if wye_is_from
            k_other = (k % n_ph) + 1          # k_next for Yd
        else
            k_other = ((k - 2 + n_ph) % n_ph) + 1  # k_prev for Dy
        end
        t_del_other = tm_del[k_other]

        # Wye phase-to-neutral voltage (neutral implicitly zero if absent)
        if n_pos !== nothing
            t_wye_n = tm_wye[n_pos]
            vr_wye_pn = vr[(b_wye, t_wye_ph)] - vr[(b_wye, t_wye_n)]
            vi_wye_pn = vi[(b_wye, t_wye_ph)] - vi[(b_wye, t_wye_n)]
        else
            vr_wye_pn = vr[(b_wye, t_wye_ph)]
            vi_wye_pn = vi[(b_wye, t_wye_ph)]
        end

        if has_series
            Iwr = cr_xf[(tid, side_wye, ph_pos)]; Iwi = ci_xf[(tid, side_wye, ph_pos)]
            Idr = cr_xf[(tid, side_del, k)];      Idi = ci_xf[(tid, side_del, k)]
            @constraint(model,
                vr[(b_del, t_del_k)] - vr[(b_del, t_del_other)] ==
                n_eff * vr_wye_pn
                - n_eff * (Rw * Iwr - Xw * Iwi)
                - (Rd * Idr - Xd * Idi))
            @constraint(model,
                vi[(b_del, t_del_k)] - vi[(b_del, t_del_other)] ==
                n_eff * vi_wye_pn
                - n_eff * (Rw * Iwi + Xw * Iwr)
                - (Rd * Idi + Xd * Idr))
        else
            @constraint(model,
                vr[(b_del, t_del_k)] - vr[(b_del, t_del_other)] == n_eff * vr_wye_pn)
            @constraint(model,
                vi[(b_del, t_del_k)] - vi[(b_del, t_del_other)] == n_eff * vi_wye_pn)
        end
    end

    # Current constraints (transpose of voltage transformation):
    # For Yd (wye_is_from=true):  n_eff*I_del[k] = I_wye[k] - I_wye[k_prev]
    # For Dy (wye_is_from=false): n_eff*I_del[k] = I_wye[k] - I_wye[k_next]
    for k in 1:n_ph
        ph_pos = ph_idx[k]
        if wye_is_from
            k_other = ((k - 2 + n_ph) % n_ph) + 1  # k_prev for Yd
        else
            k_other = (k % n_ph) + 1                # k_next for Dy
        end
        ph_other = ph_idx[k_other]
        @constraint(model,
            n_eff * cr_xf[(tid, side_del, k)] ==
            cr_xf[(tid, side_wye, ph_pos)] - cr_xf[(tid, side_wye, ph_other)])
        @constraint(model,
            n_eff * ci_xf[(tid, side_del, k)] ==
            ci_xf[(tid, side_wye, ph_pos)] - ci_xf[(tid, side_wye, ph_other)])
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

    # ── No-load (core-loss) shunt at the from-side phase terminals ─────────────
    # OpenDSS places the magnetising branch on winding 1 (from side), phase-to-
    # ground. Split equally across the from-side phase conductors.
    G_total = Float64(get(xfmr, "g_no_load", 0.0))
    B_total = Float64(get(xfmr, "b_no_load", 0.0))
    # The from side is the wye phases (Yd) or the delta phases (Dy).
    from_is_wye = wye_is_from
    n_from_ph   = from_is_wye ? length(ph_idx) : n_ph
    Gph = (n_from_ph > 0) ? G_total / n_from_ph : 0.0
    Bph = (n_from_ph > 0) ? B_total / n_from_ph : 0.0
    has_shunt = (Gph != 0.0 || Bph != 0.0)

    # ── KCL contributions ─────────────────────────────────────────────────────
    # From-side phase terminals carry winding current + magnetising shunt.
    for k in 1:n_wye
        t = tm_wye[k]
        is_from_phase = from_is_wye && (k in ph_idx)
        if is_from_phase && has_shunt
            icr = JuMP.AffExpr(0.0); ici = JuMP.AffExpr(0.0)
            JuMP.add_to_expression!(icr,  1.0, cr_xf[(tid, side_wye, k)])
            JuMP.add_to_expression!(ici,  1.0, ci_xf[(tid, side_wye, k)])
            JuMP.add_to_expression!(icr,  Gph, vr[(b_wye, t)])
            JuMP.add_to_expression!(icr, -Bph, vi[(b_wye, t)])
            JuMP.add_to_expression!(ici,  Gph, vi[(b_wye, t)])
            JuMP.add_to_expression!(ici,  Bph, vr[(b_wye, t)])
            _kcl_add!(kcl_r, kcl_i, b_wye, t, -icr, -ici)
        else
            _kcl_add!(kcl_r, kcl_i, b_wye, t,
                      -cr_xf[(tid, side_wye, k)], -ci_xf[(tid, side_wye, k)])
        end
    end
    for k in 1:n_ph
        t = tm_del[k]
        if !from_is_wye && has_shunt
            icr = JuMP.AffExpr(0.0); ici = JuMP.AffExpr(0.0)
            JuMP.add_to_expression!(icr,  1.0, cr_xf[(tid, side_del, k)])
            JuMP.add_to_expression!(ici,  1.0, ci_xf[(tid, side_del, k)])
            JuMP.add_to_expression!(icr,  Gph, vr[(b_del, t)])
            JuMP.add_to_expression!(icr, -Bph, vi[(b_del, t)])
            JuMP.add_to_expression!(ici,  Gph, vi[(b_del, t)])
            JuMP.add_to_expression!(ici,  Bph, vr[(b_del, t)])
            _kcl_add!(kcl_r, kcl_i, b_del, t, -icr, -ici)
        else
            _kcl_add!(kcl_r, kcl_i, b_del, t,
                      -cr_xf[(tid, side_del, k)], -ci_xf[(tid, side_del, k)])
        end
    end

    # ── Current magnitude limits (bare winding-current variables, so the
    #    magnitude limit also tightens each component's box bound) ───────────────
    _limit_xf_current!(s, t, ilim) = (@constraint(model, s^2 + t^2 <= ilim^2);
                                      _limit_current_box!(s, t, ilim))
    for k in 1:n_wye
        length(i_max_fr)   >= k && side_wye == "fr" &&
            _limit_xf_current!(cr_xf[(tid,"fr",k)], ci_xf[(tid,"fr",k)], i_max_fr[k])
        length(i_max_to_v) >= k && side_wye == "to" &&
            _limit_xf_current!(cr_xf[(tid,"to",k)], ci_xf[(tid,"to",k)], i_max_to_v[k])
    end
    for k in 1:n_ph
        length(i_max_fr)   >= k && side_del == "fr" &&
            _limit_xf_current!(cr_xf[(tid,"fr",k)], ci_xf[(tid,"fr",k)], i_max_fr[k])
        length(i_max_to_v) >= k && side_del == "to" &&
            _limit_xf_current!(cr_xf[(tid,"to",k)], ci_xf[(tid,"to",k)], i_max_to_v[k])
    end
end
