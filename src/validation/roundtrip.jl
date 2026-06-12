# validation/roundtrip.jl

"""
    check_roundtrip(net, dss_path; tol=1e-3) -> Dict{String,Any}

Verify correctness by comparing power flow solutions between the original
OpenDSS case and the round-tripped BMOPF network.

**Not yet implemented.** The planned implementation will solve the original
DSS case via OpenDSSDirect.jl and the round-tripped network via
PowerModelsDistribution, then compare per-bus voltage magnitudes.

# Returns (when implemented)
A dict with keys:
- `"status"` — `"pass"`, `"fail"`, or `"error"`
- `"max_voltage_error_pu"` — maximum per-bus voltage magnitude difference
- `"bus_errors"` — per-bus voltage errors exceeding `tol`
"""
function check_roundtrip(net::Dict{String,Any}, dss_path::AbstractString;
                          tol::Float64=1e-3)::Dict{String,Any}
    error("check_roundtrip is not yet implemented.")
end
