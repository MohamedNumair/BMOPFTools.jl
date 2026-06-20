# Inverter constraints for the four-wire IVR-EN OPF.
#
# Topology → voltage reference mapping:
#   FOUR_LEG    — phase-to-neutral; neutral is the last terminal in terminal_map
#   THREE_LEG   — line-to-line (delta); no neutral current; one current per
#                 conductor pair (k, k mod n + 1)
#   SINGLE_PHASE — phase-to-reference; terminal_map = [phase, ref]; one current
#
# Constant power-factor (PF) mode
# ────────────────────────────────
# When the inverter references a control_profile with a "power_factor" sub-object
# the signed field "pf" determines the Q/P coupling:
#
#   pf > 0  (lagging, absorbing VAr):  Q_k = -tan(arccos(pf))  · P_k
#   pf < 0  (leading,  injecting VAr): Q_k = +tan(arccos(|pf|))· P_k
#
# Implemented as the bilinear equality:
#   sign(pf) · Q_k + tan_phi · P_k = 0
#
# which Ipopt handles exactly — no relaxation or bound approximation.
#
# Without a PF control profile, q_min/q_max box bounds are used; these are
# normally filled by _apply_inverter_augmentation! before the OPF is called.

"Declare `cri`/`cii` inverter current variables (one per phase conductor)."
function _add_inverter_variables!(model, net)
    cri = Dict{Tuple{String,Int}, JuMP.VariableRef}()
    cii = Dict{Tuple{String,Int}, JuMP.VariableRef}()

    for (inv_id, inv) in get(net, "inverter", Dict())
        inv isa Dict || continue
        tm   = Vector{String}(get(inv, "terminal_map", String[]))
        topo = get(inv, "topology", "FOUR_LEG")
        n_ph = topo == "THREE_LEG" ? length(tm) :
               topo == "SINGLE_PHASE" ? 1 :
               length(_phase_positions(tm))   # FOUR_LEG
        for k in 1:n_ph
            cri[(inv_id, k)] = @variable(model, base_name = "cri_$(inv_id)_$(k)")
            cii[(inv_id, k)] = @variable(model, base_name = "cii_$(inv_id)_$(k)")
        end
    end
    cri, cii
end

"""
    _add_inverter_constraints!(model, net, vars, kcl_r, kcl_i)

Add P/Q power constraints and KCL contributions for all inverter objects.

For each phase k the bilinear power equations are formed from the voltage
difference (dvr, dvi) appropriate to the inverter topology and the inverter
current variables (cri, cii):

    P_k = dvr·cri[k] + dvi·cii[k]
    Q_k = dvi·cri[k] − dvr·cii[k]

Constraints applied per phase:
- `p_min[k] ≤ P_k ≤ p_max[k]`
- `P_k² + Q_k² ≤ s_max[k]²`  (apparent-power circle)
- If constant-PF profile present: `sign(pf)·Q_k + tan_phi·P_k = 0` (equality)
- Otherwise: `q_min[k] ≤ Q_k ≤ q_max[k]`
"""
function _add_inverter_constraints!(model, net, vars, kcl_r, kcl_i)
    vr  = vars[:vr];  vi  = vars[:vi]
    cri = vars[:cri]; cii = vars[:cii]
    profiles = get(net, "control_profile", Dict())

    for (inv_id, inv) in get(net, "inverter", Dict())
        inv isa Dict || continue
        bus   = get(inv, "bus", "")
        tm    = Vector{String}(get(inv, "terminal_map", String[]))
        topo  = get(inv, "topology", "FOUR_LEG")
        smax  = Float64.(get(inv, "s_max",  Float64[]))
        p_min = Float64.(get(inv, "p_min",  Float64[]))
        p_max = Float64.(get(inv, "p_max",  Float64[]))
        q_min = Float64.(get(inv, "q_min",  Float64[]))
        q_max = Float64.(get(inv, "q_max",  Float64[]))

        # Resolve constant-PF coupling from control_profile
        pf_val = nothing
        cp_id  = get(inv, "control_profile", nothing)
        if cp_id isa String
            cp = get(profiles, cp_id, nothing)
            if cp isa Dict
                pf_obj = get(cp, "power_factor", nothing)
                if pf_obj isa Dict
                    raw = get(pf_obj, "pf", nothing)
                    if raw isa Number && abs(Float64(raw)) > 1e-9
                        pf_val = Float64(raw)
                    end
                end
            end
        end

        tan_phi  = pf_val !== nothing ? tan(acos(abs(pf_val))) : nothing
        # sign(pf) > 0 (lagging): Q = -tan_phi*P  →  +1*Q + tan_phi*P = 0
        # sign(pf) < 0 (leading): Q = +tan_phi*P  →  -1*Q + tan_phi*P = 0
        pf_sign  = pf_val !== nothing ? sign(pf_val) : 0.0

        if topo == "SINGLE_PHASE"
            length(tm) >= 2 || (@warn "Inverter '$inv_id': SINGLE_PHASE needs ≥2 terminals"; continue)
            t_ph  = tm[1]
            t_ref = tm[2]
            dvr = @expression(model, vr[(bus, t_ph)] - vr[(bus, t_ref)])
            dvi = @expression(model, vi[(bus, t_ph)] - vi[(bus, t_ref)])

            p_expr = @expression(model, dvr*cri[(inv_id,1)] + dvi*cii[(inv_id,1)])
            q_expr = @expression(model, dvi*cri[(inv_id,1)] - dvr*cii[(inv_id,1)])

            !isempty(p_min) && @constraint(model, p_expr >= p_min[1])
            !isempty(p_max) && @constraint(model, p_expr <= p_max[1])

            if tan_phi !== nothing
                @constraint(model, pf_sign * q_expr + tan_phi * p_expr == 0)
            else
                !isempty(q_min) && @constraint(model, q_expr >= q_min[1])
                !isempty(q_max) && @constraint(model, q_expr <= q_max[1])
            end

            if !isempty(smax)
                p_aux = @variable(model, base_name = "pi_$(inv_id)_1")
                q_aux = @variable(model, base_name = "qi_$(inv_id)_1")
                @constraint(model, p_aux == p_expr)
                @constraint(model, q_aux == q_expr)
                @constraint(model, p_aux^2 + q_aux^2 <= smax[1]^2)
            end

            _kcl_add!(kcl_r, kcl_i, bus, t_ph,   cri[(inv_id,1)],  cii[(inv_id,1)])
            _kcl_add!(kcl_r, kcl_i, bus, t_ref,  -cri[(inv_id,1)], -cii[(inv_id,1)])

        elseif topo == "FOUR_LEG"
            ph_pos    = _phase_positions(tm)
            n_pos_idx = _neutral_pos(tm)
            t_n       = n_pos_idx !== nothing ? tm[n_pos_idx] : nothing

            for (idx, ph) in enumerate(ph_pos)
                t_ph = tm[ph]
                dvr  = t_n !== nothing ?
                       @expression(model, vr[(bus,t_ph)] - vr[(bus,t_n)]) :
                       vr[(bus, t_ph)]
                dvi  = t_n !== nothing ?
                       @expression(model, vi[(bus,t_ph)] - vi[(bus,t_n)]) :
                       vi[(bus, t_ph)]

                p_expr = @expression(model, dvr*cri[(inv_id,idx)] + dvi*cii[(inv_id,idx)])
                q_expr = @expression(model, dvi*cri[(inv_id,idx)] - dvr*cii[(inv_id,idx)])

                length(p_min) >= idx && @constraint(model, p_expr >= p_min[idx])
                length(p_max) >= idx && @constraint(model, p_expr <= p_max[idx])

                if tan_phi !== nothing
                    @constraint(model, pf_sign * q_expr + tan_phi * p_expr == 0)
                else
                    length(q_min) >= idx && @constraint(model, q_expr >= q_min[idx])
                    length(q_max) >= idx && @constraint(model, q_expr <= q_max[idx])
                end

                if length(smax) >= idx
                    p_aux = @variable(model, base_name = "pi_$(inv_id)_$(idx)")
                    q_aux = @variable(model, base_name = "qi_$(inv_id)_$(idx)")
                    @constraint(model, p_aux == p_expr)
                    @constraint(model, q_aux == q_expr)
                    @constraint(model, p_aux^2 + q_aux^2 <= smax[idx]^2)
                end

                _kcl_add!(kcl_r, kcl_i, bus, t_ph,  cri[(inv_id,idx)],  cii[(inv_id,idx)])
                t_n !== nothing &&
                    _kcl_add!(kcl_r, kcl_i, bus, t_n, -cri[(inv_id,idx)], -cii[(inv_id,idx)])
            end

        elseif topo == "THREE_LEG"
            n_c = length(tm)
            for k in 1:n_c
                t_pos = tm[k]
                t_neg = tm[(k % n_c) + 1]
                dvr = @expression(model, vr[(bus,t_pos)] - vr[(bus,t_neg)])
                dvi = @expression(model, vi[(bus,t_pos)] - vi[(bus,t_neg)])

                p_expr = @expression(model, dvr*cri[(inv_id,k)] + dvi*cii[(inv_id,k)])
                q_expr = @expression(model, dvi*cri[(inv_id,k)] - dvr*cii[(inv_id,k)])

                length(p_min) >= k && @constraint(model, p_expr >= p_min[k])
                length(p_max) >= k && @constraint(model, p_expr <= p_max[k])

                if tan_phi !== nothing
                    @constraint(model, pf_sign * q_expr + tan_phi * p_expr == 0)
                else
                    length(q_min) >= k && @constraint(model, q_expr >= q_min[k])
                    length(q_max) >= k && @constraint(model, q_expr <= q_max[k])
                end

                if length(smax) >= k
                    p_aux = @variable(model, base_name = "pi_$(inv_id)_$(k)")
                    q_aux = @variable(model, base_name = "qi_$(inv_id)_$(k)")
                    @constraint(model, p_aux == p_expr)
                    @constraint(model, q_aux == q_expr)
                    @constraint(model, p_aux^2 + q_aux^2 <= smax[k]^2)
                end

                _kcl_add!(kcl_r, kcl_i, bus, t_pos,  cri[(inv_id,k)],  cii[(inv_id,k)])
                _kcl_add!(kcl_r, kcl_i, bus, t_neg, -cri[(inv_id,k)], -cii[(inv_id,k)])
            end

        else
            @warn "Inverter '$inv_id': unknown topology '$topo' — skipping."
        end
    end
end
