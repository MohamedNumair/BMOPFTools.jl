# Bus voltage bounds and KCL.
#
# KCL sign convention: positive current = flowing INTO the bus.
# Each component function receives the KCL expression dicts and adds its
# contribution. At the end, _add_kcl_constraints! enforces sum == 0 at
# every ungrounded terminal.

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
