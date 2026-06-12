# infeasibility/preflight.jl
# The infeasibility_preflight function is defined in analysis/preflight.jl.
# This file is reserved for the future TPIA integration.

"""
    run_tpia(net; kwargs...) -> Dict{String,Any}

Run Pandey et al.'s Three-Phase Infeasibility Analysis on the network.

This function is a stub. Full implementation requires:
- A circuit-theoretic Y-bus formulation from the BMOPF admittance data
- A non-convex optimisation solver (e.g. Ipopt via JuMP)
- Integration with PowerModelsDistribution's IVR formulation or equivalent

When implemented, returns:
- `"infeasibility_magnitude"` — total slack injection needed (A)
- `"weak_buses"` — ranked list of buses by slack current magnitude
- `"suggested_remediation"` — load shedding / DER dispatch recommendations

References:
- Foster, Pandey, Pileggi (2022). "Three-Phase Infeasibility Analysis for
  Distribution Grid Studies." Electric Power Systems Research, 212.
- Ali & Pandey (2024). "Distributed Primal-Dual Interior Point Framework..."
"""
function run_tpia(net::Dict{String,Any}; kwargs...)::Dict{String,Any}
    error("run_tpia is not yet implemented. See infeasibility/preflight.jl for the roadmap.")
end
