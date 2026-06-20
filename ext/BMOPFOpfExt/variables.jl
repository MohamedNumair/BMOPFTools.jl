# JuMP variable declarations for the four-wire IVR-EN OPF.
#
# Index conventions:
#   vr/vi        : Dict{Tuple{String,String}, VariableRef}  (bus_id, terminal)
#   cr_fr/ci_fr  : Dict{Tuple{String,Int},    VariableRef}  (line_id, conductor_pos)
#   cr_to/ci_to  : Dict{Tuple{String,Int},    AffExpr}      (line_id, conductor_pos) = -cr_fr / -ci_fr
#   crd/cid      : Dict{Tuple{String,Int},    VariableRef}  (load_id, conductor_pos)
#   crg/cig      : Dict{Tuple{String,Int},    VariableRef}  (gen_id,  conductor_pos)
#   cr_src/ci_src: Dict{Tuple{String,Int},    VariableRef}  (src_id,  conductor_pos)
#   cr_xf/ci_xf  : Dict{Tuple{String,String,Int},VariableRef} (xfmr_id, "fr"/"to", k)
#   cr_sw/ci_sw  : Dict{Tuple{String,Int},    VariableRef}  (sw_id,   conductor_pos)

"Declare `vr`/`vi` voltage variables at every bus terminal; fix grounded terminals to 0."
function _add_voltage_variables!(model, bus_terminals, grounded)
    vr = Dict{Tuple{String,String}, JuMP.VariableRef}()
    vi = Dict{Tuple{String,String}, JuMP.VariableRef}()

    for (bid, terminals) in bus_terminals
        for t in terminals
            key = (bid, t)
            if (bid, t) in grounded
                vr[key] = @variable(model, base_name = "vr_$(bid)_$(t)")
                vi[key] = @variable(model, base_name = "vi_$(bid)_$(t)")
                fix(vr[key], 0.0; force=true)
                fix(vi[key], 0.0; force=true)
            else
                vr[key] = @variable(model, base_name = "vr_$(bid)_$(t)")
                vi[key] = @variable(model, base_name = "vi_$(bid)_$(t)")
            end
        end
    end
    vr, vi
end

"Declare `cr_fr`/`ci_fr` series current variables for each line conductor.
`cr_to`/`ci_to` are returned as `AffExpr` aliases equal to `-cr_fr` — there
is only one independent series current per branch."
function _add_line_variables!(model, net)
    cr_fr = Dict{Tuple{String,Int}, JuMP.VariableRef}()
    ci_fr = Dict{Tuple{String,Int}, JuMP.VariableRef}()
    cr_to = Dict{Tuple{String,Int}, JuMP.AffExpr}()
    ci_to = Dict{Tuple{String,Int}, JuMP.AffExpr}()

    for (lid, line) in get(net, "line", Dict())
        n_c = length(get(line, "terminal_map_from", String[]))
        for k in 1:n_c
            cr_fr[(lid,k)] = @variable(model, base_name = "cr_fr_$(lid)_$(k)")
            ci_fr[(lid,k)] = @variable(model, base_name = "ci_fr_$(lid)_$(k)")
            cr_to[(lid,k)] = JuMP.AffExpr(0.0, cr_fr[(lid,k)] => -1.0)
            ci_to[(lid,k)] = JuMP.AffExpr(0.0, ci_fr[(lid,k)] => -1.0)
        end
    end

    cr_fr, ci_fr, cr_to, ci_to
end

"Declare `cr_sw`/`ci_sw` switch current variables; fix open-switch currents to 0."
function _add_switch_variables!(model, net)
    cr_sw = Dict{Tuple{String,Int}, JuMP.VariableRef}()
    ci_sw = Dict{Tuple{String,Int}, JuMP.VariableRef}()

    for (sid, sw) in get(net, "switch", Dict())
        is_open = get(sw, "open_switch", false)
        n_c = length(get(sw, "terminal_map_from", String[]))
        for k in 1:n_c
            cr_sw[(sid,k)] = @variable(model, base_name = "cr_sw_$(sid)_$(k)")
            ci_sw[(sid,k)] = @variable(model, base_name = "ci_sw_$(sid)_$(k)")
            if is_open
                fix(cr_sw[(sid,k)], 0.0; force=true)
                fix(ci_sw[(sid,k)], 0.0; force=true)
            end
        end
    end
    cr_sw, ci_sw
end

"Declare `crd`/`cid` load current variables (one per phase conductor; neutral excluded)."
function _add_load_variables!(model, net)
    crd = Dict{Tuple{String,Int}, JuMP.VariableRef}()
    cid = Dict{Tuple{String,Int}, JuMP.VariableRef}()

    for (lid, load) in get(net, "load", Dict())
        tm  = Vector{String}(get(load, "terminal_map", String[]))
        cfg = get(load, "configuration", "WYE")
        # For WYE/SINGLE_PHASE: one current per phase conductor (not neutral).
        # For DELTA: one current per conductor.
        n_ph = cfg == "DELTA" ? length(tm) : length(_phase_positions(tm))
        for k in 1:n_ph
            crd[(lid,k)] = @variable(model, base_name = "crd_$(lid)_$(k)")
            cid[(lid,k)] = @variable(model, base_name = "cid_$(lid)_$(k)")
        end
    end
    crd, cid
end

"Declare `crg`/`cig` generator current variables (one per phase conductor; neutral excluded)."
function _add_generator_variables!(model, net)
    crg = Dict{Tuple{String,Int}, JuMP.VariableRef}()
    cig = Dict{Tuple{String,Int}, JuMP.VariableRef}()

    for (gid, gen) in get(net, "generator", Dict())
        tm  = Vector{String}(get(gen, "terminal_map", String[]))
        cfg = get(gen, "configuration", "WYE")
        n_ph = cfg == "DELTA" ? length(tm) : length(_phase_positions(tm))
        for k in 1:n_ph
            crg[(gid,k)] = @variable(model, base_name = "crg_$(gid)_$(k)")
            cig[(gid,k)] = @variable(model, base_name = "cig_$(gid)_$(k)")
        end
    end
    crg, cig
end

"Declare `cr_src`/`ci_src` voltage-source slack current variables (one per phase
conductor; neutral excluded — the neutral carries the summed return current)."
function _add_source_variables!(model, net)
    cr_src = Dict{Tuple{String,Int}, JuMP.VariableRef}()
    ci_src = Dict{Tuple{String,Int}, JuMP.VariableRef}()

    for (sid, vs) in get(net, "voltage_source", Dict())
        tm   = Vector{String}(get(vs, "terminal_map", String[]))
        cfg  = get(vs, "configuration", "WYE")
        n_ph = cfg == "DELTA" ? length(tm) : length(_phase_positions(tm))
        for k in 1:n_ph
            cr_src[(sid,k)] = @variable(model, base_name = "cr_src_$(sid)_$(k)")
            ci_src[(sid,k)] = @variable(model, base_name = "ci_src_$(sid)_$(k)")
        end
    end
    cr_src, ci_src
end

"Declare `cr_xf`/`ci_xf` transformer branch current variables for both winding sides."
function _add_transformer_variables!(model, net)
    cr_xf = Dict{Tuple{String,String,Int}, JuMP.VariableRef}()
    ci_xf = Dict{Tuple{String,String,Int}, JuMP.VariableRef}()

    xfmr_dict = get(net, "transformer", Dict())
    for subtype in ("single_phase", "wye_delta", "delta_wye", "center_tap")
        for (tid, xfmr) in get(xfmr_dict, subtype, Dict())
            tmfr = Vector{String}(get(xfmr, "terminal_map_from", String[]))
            tmto = Vector{String}(get(xfmr, "terminal_map_to",   String[]))
            if subtype in ("single_phase",)
                # YY transformer: one current variable per phase conductor only.
                # Neutral is the return path, not an independent winding conductor.
                n_fr = length(BMOPFTools._phase_positions(tmfr))
                n_to = length(BMOPFTools._phase_positions(tmto))
            else
                n_fr = length(tmfr)
                n_to = length(tmto)
            end
            for k in 1:n_fr
                cr_xf[(tid,"fr",k)] = @variable(model, base_name = "cr_xf_$(tid)_fr_$(k)")
                ci_xf[(tid,"fr",k)] = @variable(model, base_name = "ci_xf_$(tid)_fr_$(k)")
            end
            for k in 1:n_to
                cr_xf[(tid,"to",k)] = @variable(model, base_name = "cr_xf_$(tid)_to_$(k)")
                ci_xf[(tid,"to",k)] = @variable(model, base_name = "ci_xf_$(tid)_to_$(k)")
            end
        end
    end
    cr_xf, ci_xf
end

"""
    _set_voltage_start_values!(vars, net, bus_terminals, grounded)

Provide Ipopt with phase-correct initial voltage estimates.

For every non-grounded, non-fixed terminal the start value is set to
`v_nom × exp(j × angle)` where `v_nom` and `angle` are read from the
network's first voltage source.  Terminals that are not in the source's
terminal_map use the canonical 3-phase angles (0°, −120°, +120°).
The neutral terminal is initialised at 0.

Without this, Ipopt starts from vr=vi=0 and fails to navigate into the
correct region of the feasible set for multi-phase (complex-voltage)
problems.
"""
function _set_voltage_start_values!(vars, net, bus_terminals, grounded)
    vr = vars[:vr]; vi = vars[:vi]

    # Canonical 3-phase angles (rad) keyed by terminal name.
    # These are overwritten by whatever the actual source specifies.
    t_angle = Dict{String,Float64}(
        "1" => 0.0, "2" => -2.0944, "3" => 2.0944, "n" => 0.0)
    v_nom = 0.0

    for (_, vs) in get(net, "voltage_source", Dict())
        tm   = Vector{String}(get(vs, "terminal_map", String[]))
        vmag = Float64.(get(vs, "v_magnitude", Float64[]))
        vang = Float64.(get(vs, "v_angle",     Float64[]))
        for (k, t) in enumerate(tm)
            k ≤ length(vmag) && (v_nom = max(v_nom, vmag[k]))
            k ≤ length(vang) && (t_angle[t] = vang[k])
        end
        break   # first source is enough
    end
    v_nom == 0.0 && (v_nom = 1.0)   # degenerate fallback

    for (bid, terminals) in bus_terminals
        nt = BMOPFTools._neutral_terminal(terminals)
        for t in terminals
            (bid, t) in grounded && continue   # fixed at 0 — skip
            key = (bid, t)
            if t == nt
                JuMP.set_start_value(vr[key], 0.0)
                JuMP.set_start_value(vi[key], 0.0)
            else
                ang = get(t_angle, t, 0.0)
                JuMP.set_start_value(vr[key], v_nom * cos(ang))
                JuMP.set_start_value(vi[key], v_nom * sin(ang))
            end
        end
    end
end

"""
    _set_level_aware_start_values!(vars, net, bus_terminals, grounded)

Like `_set_voltage_start_values!` but uses per-bus nominal voltages derived
from the BFS voltage propagation (`_assign_nominal_voltages`). This correctly
initialises LV buses at ~250 V rather than at the source voltage (~6350 V),
preventing Ipopt from converging to the degenerate high-voltage local minimum
that arises in the unconstrained feasibility OPF.
"""
function _set_level_aware_start_values!(vars, net, bus_terminals, grounded)
    vr = vars[:vr]; vi = vars[:vi]

    t_angle = Dict{String,Float64}(
        "1" => 0.0, "2" => -2.0944, "3" => 2.0944, "n" => 0.0)

    for (_, vs) in get(net, "voltage_source", Dict())
        tm   = Vector{String}(get(vs, "terminal_map", String[]))
        vang = Float64.(get(vs, "v_angle", Float64[]))
        for (k, t) in enumerate(tm)
            k ≤ length(vang) && (t_angle[t] = vang[k])
        end
        break
    end

    v_nom_by_bus = BMOPFTools._assign_nominal_voltages(net)

    for (bid, terminals) in bus_terminals
        nt    = BMOPFTools._neutral_terminal(terminals)
        v_nom = get(v_nom_by_bus, bid, 1000.0)
        for t in terminals
            (bid, t) in grounded && continue
            key = (bid, t)
            if t == nt
                JuMP.set_start_value(vr[key], 0.0)
                JuMP.set_start_value(vi[key], 0.0)
            else
                ang = get(t_angle, t, 0.0)
                JuMP.set_start_value(vr[key], v_nom * cos(ang))
                JuMP.set_start_value(vi[key], v_nom * sin(ang))
            end
        end
    end
end

"""
    _set_yd_dy_start_values!(vars, net, grounded)

Override start values for delta-bus terminals of Yd/Dy transformers.

The generic `_set_level_aware_start_values!` assigns angles from the source
terminal map ("1"→0°, "2"→−120°, "3"→+120°), which is correct for wye buses
but wrong for the floating delta secondary.  Here we propagate the ideal Yd/Dy
voltage loop to compute physically correct starting angles for the delta bus,
which guides Ipopt to the correct local minimum.
"""
function _set_yd_dy_start_values!(vars, net, grounded)
    vr = vars[:vr]; vi = vars[:vi]
    cr_xf = vars[:cr_xf]; ci_xf = vars[:ci_xf]
    xfmr_dict = get(net, "transformer", Dict())
    for subtype in ("wye_delta", "delta_wye")
        for (tid, xfmr) in get(xfmr_dict, subtype, Dict())
            wye_is_from = (subtype == "wye_delta")
            b_wye = wye_is_from ? get(xfmr, "bus_from", "") : get(xfmr, "bus_to", "")
            b_del = wye_is_from ? get(xfmr, "bus_to",   "") : get(xfmr, "bus_from", "")
            tm_wye = Vector{String}(wye_is_from ?
                get(xfmr, "terminal_map_from", String[]) :
                get(xfmr, "terminal_map_to",   String[]))
            tm_del = Vector{String}(wye_is_from ?
                get(xfmr, "terminal_map_to",   String[]) :
                get(xfmr, "terminal_map_from", String[]))
            N     = Float64(get(xfmr, "v_ref_from", 1.0)) / Float64(get(xfmr, "v_ref_to", 1.0))
            n_eff = wye_is_from ? sqrt(3) / N : N * sqrt(3)
            ph_idx = BMOPFTools._phase_positions(tm_wye)
            n_pos  = BMOPFTools._neutral_pos(tm_wye)
            side_wye = wye_is_from ? "fr" : "to"
            side_del = wye_is_from ? "to" : "fr"
            n_ph   = length(tm_del)

            # Read wye neutral start value (zero if no neutral or grounded)
            Vn = n_pos !== nothing ?
                complex(JuMP.start_value(vr[(b_wye, tm_wye[n_pos])]),
                        JuMP.start_value(vi[(b_wye, tm_wye[n_pos])])) : 0.0 + 0.0im

            # Read wye phase start values
            Vw = [complex(JuMP.start_value(vr[(b_wye, tm_wye[ph_idx[k]])]),
                          JuMP.start_value(vi[(b_wye, tm_wye[ph_idx[k]])])) for k in 1:n_ph]
            Vw_pn = Vw .- Vn

            # Find the first grounded delta terminal to anchor the propagation
            start_k = 1
            for k in 1:n_ph
                (b_del, tm_del[k]) in grounded && (start_k = k; break)
            end

            # Propagate ideal delta voltages around the loop:
            #   V_del[k] - V_del[k_next] = n_eff * Vw_pn[k]  (Yd)
            #   V_del[k] - V_del[k_prev] = n_eff * Vw_pn[k]  (Dy)
            V_del = zeros(ComplexF64, n_ph)
            V_del[start_k] = complex(
                JuMP.start_value(vr[(b_del, tm_del[start_k])]),
                JuMP.start_value(vi[(b_del, tm_del[start_k])]))
            for step in 1:(n_ph - 1)
                k      = mod1(start_k + step - 1, n_ph)
                k_next = mod1(k, n_ph) + 1
                V_del[k_next] = V_del[k] - n_eff * Vw_pn[k]
            end

            # Set delta bus voltage start values
            for k in 1:n_ph
                t = tm_del[k]
                (b_del, t) in grounded && continue
                JuMP.set_start_value(vr[(b_del, t)], real(V_del[k]))
                JuMP.set_start_value(vi[(b_del, t)], imag(V_del[k]))
            end

            # Estimate wye winding currents from apparent power and start voltages.
            # S_rated / (sqrt(3) * V_LL) gives the nominal line current magnitude.
            # The physical direction is positive (into transformer from wye bus).
            s_rating = Float64(get(xfmr, "s_rating", 0.0))
            if s_rating > 0
                v_wye_start = abs(Vw_pn[1])
                I_mag = v_wye_start > 0 ? s_rating / (3 * v_wye_start) : 0.0
                for k in 1:n_ph
                    ph = ph_idx[k]
                    # Physical wye current is IN PHASE with the phase-neutral voltage
                    # (pure resistive estimate); positive = out of wye bus (load conv.)
                    Vw_hat = Vw_pn[k]
                    I_start = abs(Vw_hat) > 0 ? I_mag * conj(Vw_hat) / abs(Vw_hat) : I_mag + 0im
                    JuMP.set_start_value(cr_xf[(tid, side_wye, ph)], real(I_start))
                    JuMP.set_start_value(ci_xf[(tid, side_wye, ph)], imag(I_start))
                end
                # Delta currents from current coupling: n_eff * I_del[k] = I_wye[k] - I_wye[k_prev/next]
                for k in 1:n_ph
                    ph = ph_idx[k]
                    k_other = wye_is_from ?
                        ((k - 2 + n_ph) % n_ph) + 1 :  # k_prev for Yd
                        (k % n_ph) + 1                   # k_next for Dy
                    ph_other = ph_idx[k_other]
                    I_del_r = (JuMP.start_value(cr_xf[(tid, side_wye, ph)]) -
                               JuMP.start_value(cr_xf[(tid, side_wye, ph_other)])) / n_eff
                    I_del_i = (JuMP.start_value(ci_xf[(tid, side_wye, ph)]) -
                               JuMP.start_value(ci_xf[(tid, side_wye, ph_other)])) / n_eff
                    JuMP.set_start_value(cr_xf[(tid, side_del, k)], I_del_r)
                    JuMP.set_start_value(ci_xf[(tid, side_del, k)], I_del_i)
                end
                # Neutral wye current start value
                if n_pos !== nothing
                    I_n_r = -sum(JuMP.start_value(cr_xf[(tid, side_wye, ph_idx[k])]) for k in 1:n_ph)
                    I_n_i = -sum(JuMP.start_value(ci_xf[(tid, side_wye, ph_idx[k])]) for k in 1:n_ph)
                    JuMP.set_start_value(cr_xf[(tid, side_wye, n_pos)], I_n_r)
                    JuMP.set_start_value(ci_xf[(tid, side_wye, n_pos)], I_n_i)
                end
            end
        end
    end
end

"Declare all JuMP variables and return them in a single dict."
function _build_vars(model, net, bus_terminals, grounded)
    vr,    vi    = _add_voltage_variables!(model, bus_terminals, grounded)
    cr_fr, ci_fr,
    cr_to, ci_to = _add_line_variables!(model, net)
    cr_sw, ci_sw = _add_switch_variables!(model, net)
    crd,   cid   = _add_load_variables!(model, net)
    crg,   cig   = _add_generator_variables!(model, net)
    cr_src,ci_src= _add_source_variables!(model, net)
    cr_xf, ci_xf = _add_transformer_variables!(model, net)
    cri,   cii   = _add_inverter_variables!(model, net)

    Dict{Symbol,Any}(
        :vr => vr, :vi => vi,
        :cr_fr => cr_fr, :ci_fr => ci_fr,
        :cr_to => cr_to, :ci_to => ci_to,
        :cr_sw => cr_sw, :ci_sw => ci_sw,
        :crd   => crd,   :cid   => cid,
        :crg   => crg,   :cig   => cig,
        :cr_src=> cr_src,:ci_src=> ci_src,
        :cr_xf => cr_xf, :ci_xf => ci_xf,
        :cri   => cri,   :cii   => cii,
    )
end
