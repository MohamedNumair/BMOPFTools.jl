module BMOPFOpfExt

using BMOPFTools
using JuMP
using Ipopt

include("data_utils.jl")
include("variables.jl")
include("bus.jl")
include("branch.jl")
include("transformer.jl")
include("load.jl")
include("generator.jl")
include("objective.jl")
include("results.jl")
include("feasibility_opf.jl")

"""
    BMOPFTools.solve_opf(net; optimizer=Ipopt.Optimizer, t_index=1) -> Dict

Four-wire rectangular current-voltage (IVR-EN) OPF on a BMOPF network dict.

The formulation follows the PMD IVRENPowerModel convention:
- Voltage variables vr/vi at every bus terminal including neutral.
- Series current variables cr/ci per conductor at each branch end.
- Constant-power load and generator models (bilinear P/Q equations).
- Neutral terminal voltages are explicit JuMP variables; they float unless
  declared in `perfectly_grounded_terminals` or fixed by a voltage source.
- Transformer models: per-phase YY (single_phase/center_tap) and
  wye-delta / delta-wye with linear voltage-current transformation.

Shunt line admittance (G/B pi-model) is not modelled in this version.
"""
function BMOPFTools.solve_opf(net::Dict{String,Any};
                               optimizer=Ipopt.Optimizer,
                               t_index::Int=1)

    working = BMOPFTools.is_timeseries(net) ?
              BMOPFTools.get_snapshot(net, t_index) : net

    model = JuMP.Model(optimizer)
    JuMP.set_silent(model)

    # Index structures
    bus_terminals = _bus_terminals(working)
    grounded      = _grounded_terminals(working)

    # Variables
    vars = _build_vars(model, working, bus_terminals, grounded)

    # Warm-start: set phase-angle-correct initial values so Ipopt can find
    # the physical (high-voltage) solution without a load-flow pre-solve.
    _set_voltage_start_values!(vars, working, bus_terminals, grounded)

    # Voltage bounds
    _add_voltage_bounds!(model, working, bus_terminals, grounded, vars)

    # Voltage source: fix slack voltages and register slack current in KCL
    kcl_r, kcl_i = _init_kcl(bus_terminals, grounded)
    _add_source_constraints!(working, vars, kcl_r, kcl_i)

    # Branch constraints and KCL contributions
    _add_line_constraints!(model, working, vars, kcl_r, kcl_i)
    _add_switch_constraints!(model, working, vars, kcl_r, kcl_i)
    _add_transformer_constraints!(model, working, vars, kcl_r, kcl_i)

    # Load and generator power equations and KCL contributions
    _add_load_constraints!(model, working, vars, kcl_r, kcl_i)
    _add_generator_constraints!(model, working, vars, kcl_r, kcl_i)

    # Enforce KCL
    _add_kcl_constraints!(model, kcl_r, kcl_i)

    # Objective
    _add_objective!(model, working, vars)

    JuMP.optimize!(model)

    _extract_results(model, working, bus_terminals, grounded, vars)
end

end # module BMOPFOpfExt
