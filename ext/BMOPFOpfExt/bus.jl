# Bus voltage bounds and KCL.
#
# KCL sign convention: positive current = flowing INTO the bus.
# Each component function receives the KCL expression dicts and adds its
# contribution. At the end, _add_kcl_constraints! enforces sum == 0 at
# every ungrounded terminal.

# Validate that a per-phase (vpn) or per-pair (vpp) voltage bound is an array of
# the expected length. These bounds are strictly per-phase arrays — a scalar is
# rejected with a clear message.
function _check_per_phase_bound(val, n::Int, bid::AbstractString, field::AbstractString)
    val === nothing && return
    (val isa AbstractVector && length(val) == n) && return
    error("Bus '$bid': $field must be a per-phase array of length $n, got " *
          (val isa AbstractVector ? "length $(length(val))" : "a scalar"))
end

"""
    _init_kcl(bus_terminals, grounded) -> (kcl_r, kcl_i)

Allocate zero JuMP AffExpr accumulators for every ungrounded (bus, terminal).
"""
function _init_kcl(bus_terminals, grounded)
    kcl_r = Dict{Tuple{String,String}, JuMP.AffExpr}()
    kcl_i = Dict{Tuple{String,String}, JuMP.AffExpr}()
    for (bid, terminals) in bus_terminals
        for t in terminals
            (bid, t) in grounded && continue
            kcl_r[(bid, t)] = JuMP.AffExpr(0.0)
            kcl_i[(bid, t)] = JuMP.AffExpr(0.0)
        end
    end
    kcl_r, kcl_i
end

"""
    _add_voltage_bounds!(model, net, bus_terminals, grounded, vars)

Add |v|² ∈ [v_min², v_max²] at every ungrounded phase terminal that has bounds.
Grounded terminals (fixed at 0) and source-fixed terminals are skipped, as are
neutral terminals (their voltage is determined by physics, not operational limits).
"""
function _add_voltage_bounds!(model, net, bus_terminals, grounded, vars)
    vr = vars[:vr]; vi = vars[:vi]
    fixed = _source_fixed_terminals(net)

    for (bid, bus) in get(net, "bus", Dict())
        v_min = get(bus, "v_min", nothing)
        v_max = get(bus, "v_max", nothing)
        (v_min === nothing && v_max === nothing) && continue

        terminals = get(bus_terminals, bid, String[])
        neutral   = BMOPFTools._neutral_terminal(terminals)

        for t in terminals
            (bid, t) in grounded && continue   # vr=vi=0 already fixed
            (bid, t) in fixed   && continue   # source-fixed, skip
            t == neutral        && continue   # neutral floats; don't apply phase bounds
            vr_t = vr[(bid, t)]; vi_t = vi[(bid, t)]
            v2 = @expression(model, vr_t^2 + vi_t^2)
            v_min !== nothing && @constraint(model, v2 >= Float64(v_min)^2)
            v_max !== nothing && @constraint(model, v2 <= Float64(v_max)^2)
        end
    end
end

"""
    _add_wide_voltage_bounds!(model, net, bus_terminals, grounded, vars)

Like `_add_voltage_bounds!` but uses 0.5× v_min and 2× v_max so the NLP is
anchored in the physical operating region without ever being infeasible.
Used by the feasibility OPF to prevent degenerate high/low-voltage solutions
while keeping operational bounds as soft (post-solve) checks.
"""
function _add_wide_voltage_bounds!(model, net, bus_terminals, grounded, vars)
    vr = vars[:vr]; vi = vars[:vi]
    fixed = _source_fixed_terminals(net)

    for (bid, bus) in get(net, "bus", Dict())
        v_min = get(bus, "v_min", nothing)
        v_max = get(bus, "v_max", nothing)
        (v_min === nothing && v_max === nothing) && continue

        terminals = get(bus_terminals, bid, String[])
        neutral   = BMOPFTools._neutral_terminal(terminals)

        for t in terminals
            (bid, t) in grounded && continue
            (bid, t) in fixed   && continue
            t == neutral        && continue
            vr_t = vr[(bid, t)]; vi_t = vi[(bid, t)]
            v2 = @expression(model, vr_t^2 + vi_t^2)
            v_min !== nothing && @constraint(model, v2 >= (Float64(v_min) * 0.5)^2)
            v_max !== nothing && @constraint(model, v2 <= (Float64(v_max) * 2.0)^2)
        end
    end
end

"""
    _add_bus_limit_constraints!(model, net, bus_terminals, grounded, vars)

Enforce operational bus-level voltage limits (not called from feasibility OPF):

- Neutral voltage upper bound (`vn_max`, V): |v_n|² ≤ vn_max² when neutral is ungrounded.
- Phase-to-neutral voltage magnitude bounds (`vpn_min`, `vpn_max`): applied to each
  ungrounded, non-source phase terminal when a neutral exists.
- Phase-to-phase voltage magnitude bounds (`vpp_min`, `vpp_max`): applied to all
  unordered pairs of ungrounded phase terminals.
- Intra-bus angle-difference bounds (`va_diff_min`, `va_diff_max`, radians): bilinear
  constraints enforcing the angle between every pair of phase terminals.
"""
function _add_bus_limit_constraints!(model, net, bus_terminals, grounded, vars)
    vr    = vars[:vr]; vi = vars[:vi]
    fixed = _source_fixed_terminals(net)

    for (bid, bus) in get(net, "bus", Dict())
        terminals = get(bus_terminals, bid, String[])
        neutral   = BMOPFTools._neutral_terminal(bus)

        # Collect phase terminals: not grounded, not fixed, not neutral
        phase_terms = [t for t in terminals
                       if !((bid, t) in grounded) &&
                          !((bid, t) in fixed)     &&
                          t != neutral]

        # ── a. Neutral voltage upper bound ──────────────────────────────────
        vn_max = get(bus, "vn_max", nothing)
        if vn_max !== nothing && neutral !== nothing && !((bid, neutral) in grounded)
            vr_n = vr[(bid, neutral)]; vi_n = vi[(bid, neutral)]
            @constraint(model, vr_n^2 + vi_n^2 <= Float64(vn_max)^2)
        end

        # ── b. Phase-to-neutral voltage magnitude bounds ─────────────────────
        # vpn_min/vpn_max are per-phase arrays, one element per phase terminal in
        # phase_terms order (see src/augmentation/voltage_bounds.jl).
        vpn_min = get(bus, "vpn_min", nothing)
        vpn_max = get(bus, "vpn_max", nothing)
        if neutral !== nothing && (vpn_min !== nothing || vpn_max !== nothing)
            _check_per_phase_bound(vpn_min, length(phase_terms), bid, "vpn_min")
            _check_per_phase_bound(vpn_max, length(phase_terms), bid, "vpn_max")
            neutral_grounded = (bid, neutral) in grounded
            for (k, t) in enumerate(phase_terms)
                vr_t = vr[(bid, t)]; vi_t = vi[(bid, t)]
                if neutral_grounded
                    v2 = @expression(model, vr_t^2 + vi_t^2)
                else
                    dvr = @expression(model, vr_t - vr[(bid, neutral)])
                    dvi = @expression(model, vi_t - vi[(bid, neutral)])
                    v2  = @expression(model, dvr^2 + dvi^2)
                end
                vpn_min !== nothing && @constraint(model, v2 >= Float64(vpn_min[k])^2)
                vpn_max !== nothing && @constraint(model, v2 <= Float64(vpn_max[k])^2)
            end
        end

        # ── c. Phase-to-phase voltage magnitude bounds ────────────────────────
        # vpp_min/vpp_max are per-pair arrays, one element per unordered phase
        # pair in (ki<kj) enumeration order.
        vpp_min = get(bus, "vpp_min", nothing)
        vpp_max = get(bus, "vpp_max", nothing)
        if (vpp_min !== nothing || vpp_max !== nothing) && length(phase_terms) >= 2
            n_pairs = length(phase_terms) * (length(phase_terms) - 1) ÷ 2
            _check_per_phase_bound(vpp_min, n_pairs, bid, "vpp_min")
            _check_per_phase_bound(vpp_max, n_pairs, bid, "vpp_max")
            pair_idx = 0
            for ki in 1:length(phase_terms)-1
                for kj in ki+1:length(phase_terms)
                    pair_idx += 1
                    tk = phase_terms[ki]; tj = phase_terms[kj]
                    dvr = @expression(model, vr[(bid,tk)] - vr[(bid,tj)])
                    dvi = @expression(model, vi[(bid,tk)] - vi[(bid,tj)])
                    v2  = @expression(model, dvr^2 + dvi^2)
                    vpp_min !== nothing && @constraint(model, v2 >= Float64(vpp_min[pair_idx])^2)
                    vpp_max !== nothing && @constraint(model, v2 <= Float64(vpp_max[pair_idx])^2)
                end
            end
        end

        # ── d. Intra-bus angle difference ─────────────────────────────────────
        va_diff_min = get(bus, "va_diff_min", nothing)
        va_diff_max = get(bus, "va_diff_max", nothing)
        if (va_diff_min !== nothing || va_diff_max !== nothing) && length(phase_terms) >= 2
            tan_min = va_diff_min !== nothing ? tan(Float64(va_diff_min)) : nothing
            tan_max = va_diff_max !== nothing ? tan(Float64(va_diff_max)) : nothing
            for ki in 1:length(phase_terms)-1
                for kj in ki+1:length(phase_terms)
                    tk = phase_terms[ki]; tj = phase_terms[kj]
                    s = @expression(model, vr[(bid,tk)]*vi[(bid,tj)] - vi[(bid,tk)]*vr[(bid,tj)])
                    c = @expression(model, vr[(bid,tk)]*vr[(bid,tj)] + vi[(bid,tk)]*vi[(bid,tj)])
                    tan_min !== nothing && @constraint(model, tan_min * c <= s)
                    tan_max !== nothing && @constraint(model, s <= tan_max * c)
                end
            end
        end

        # ── e. Symmetrical-component voltage bounds (3-phase buses only) ────────
        # Fortescue transformation is linear in rectangular voltages; squared-magnitude
        # bounds are quadratic and compatible with Ipopt.
        # Phase-to-neutral voltages are used as inputs when a floating neutral exists;
        # phase-to-ground voltages are used otherwise (grounded or absent neutral).
        #
        # α = exp(j2π/3): Re(α)=-0.5, Im(α)=√3/2
        # V₁ = (Va + α·Vb + α²·Vc)/3   positive sequence
        # V₂ = (Va + α²·Vb + α·Vc)/3   negative sequence
        # V₀ = (Va + Vb + Vc)/3         zero sequence
        vpos_min  = get(bus, "vpos_min",  nothing)
        vpos_max  = get(bus, "vpos_max",  nothing)
        vneg_max  = get(bus, "vneg_max",  nothing)
        vzero_max = get(bus, "vzero_max", nothing)
        if length(phase_terms) == 3 &&
                (vpos_min !== nothing || vpos_max !== nothing ||
                 vneg_max !== nothing || vzero_max !== nothing)
            s3 = sqrt(3.0) / 2.0
            neutral_floating = neutral !== nothing && !((bid, neutral) in grounded)

            # Δv helper: phase-to-neutral if neutral floats, else phase-to-ground
            function _dv(t)
                if neutral_floating
                    return (@expression(model, vr[(bid,t)] - vr[(bid,neutral)]),
                            @expression(model, vi[(bid,t)] - vi[(bid,neutral)]))
                else
                    return (vr[(bid,t)], vi[(bid,t)])
                end
            end

            (dvr1, dvi1) = _dv(phase_terms[1])
            (dvr2, dvi2) = _dv(phase_terms[2])
            (dvr3, dvi3) = _dv(phase_terms[3])

            if vpos_min !== nothing || vpos_max !== nothing
                V1_r = @expression(model,
                    (dvr1 - 0.5*dvr2 - s3*dvi2 - 0.5*dvr3 + s3*dvi3) / 3)
                V1_i = @expression(model,
                    (dvi1 + s3*dvr2 - 0.5*dvi2 - s3*dvr3 - 0.5*dvi3) / 3)
                v1_sq = @expression(model, V1_r^2 + V1_i^2)
                vpos_min !== nothing && @constraint(model, v1_sq >= Float64(vpos_min)^2)
                vpos_max !== nothing && @constraint(model, v1_sq <= Float64(vpos_max)^2)
            end

            if vneg_max !== nothing
                V2_r = @expression(model,
                    (dvr1 - 0.5*dvr2 + s3*dvi2 - 0.5*dvr3 - s3*dvi3) / 3)
                V2_i = @expression(model,
                    (dvi1 - s3*dvr2 - 0.5*dvi2 + s3*dvr3 - 0.5*dvi3) / 3)
                @constraint(model, V2_r^2 + V2_i^2 <= Float64(vneg_max)^2)
            end

            if vzero_max !== nothing
                V0_r = @expression(model, (dvr1 + dvr2 + dvr3) / 3)
                V0_i = @expression(model, (dvi1 + dvi2 + dvi3) / 3)
                @constraint(model, V0_r^2 + V0_i^2 <= Float64(vzero_max)^2)
            end
        end
    end
end

"""
    _add_kcl_constraints!(model, kcl_r, kcl_i)

Enforce KCL: for every (bus, terminal) accumulator, add == 0 constraints.
"""
function _add_kcl_constraints!(model, kcl_r, kcl_i)
    for key in keys(kcl_r)
        @constraint(model, kcl_r[key] == 0)
        @constraint(model, kcl_i[key] == 0)
    end
end

# ---------------------------------------------------------------------------
# KCL contribution helpers — called by branch/load/generator/source/transformer
# ---------------------------------------------------------------------------

"""
    _kcl_add!(kcl_r, kcl_i, bus, terminal, cr_expr, ci_expr)

Add (cr_expr, ci_expr) to the KCL accumulator at (bus, terminal).
Silently skips grounded terminals (not present in the dict).
"""
function _kcl_add!(kcl_r, kcl_i, bus, terminal, cr_expr, ci_expr)
    key = (bus, terminal)
    haskey(kcl_r, key) || return
    JuMP.add_to_expression!(kcl_r[key], cr_expr)
    JuMP.add_to_expression!(kcl_i[key], ci_expr)
end
