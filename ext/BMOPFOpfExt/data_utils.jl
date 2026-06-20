# Helpers for extracting network data into OPF-ready structures.
# All values remain in SI units: Ω, V, A, W, var.

# Re-export the matrix builder from the parent package internals.
const _pkm = BMOPFTools._pattern_keys_to_matrix

"""
    _bus_terminals(net) -> Dict{String, Vector{String}}

Map each bus id to its ordered list of terminal names.
"""
function _bus_terminals(net::Dict{String,Any})
    bt = Dict{String,Vector{String}}()
    for (bid, bus) in get(net, "bus", Dict())
        bt[bid] = Vector{String}(get(bus, "terminal_names", String[]))
    end
    bt
end

"""
    _grounded_terminals(net) -> Set{Tuple{String,String}}

Set of (bus_id, terminal) pairs that are perfectly grounded (vr=vi=0).
Includes `perfectly_grounded_terminals` declared on buses.
"""
function _grounded_terminals(net::Dict{String,Any})
    grounded = Set{Tuple{String,String}}()
    for (bid, bus) in get(net, "bus", Dict())
        for t in get(bus, "perfectly_grounded_terminals", String[])
            push!(grounded, (bid, string(t)))
        end
    end
    grounded
end

"""
    _line_z_matrix(line, linecodes) -> (R::Matrix, X::Matrix, n::Int)

Return the total series impedance matrices (Ω) for a line and the number
of conductors. R = R_series_per_m × length, same for X.
Returns (nothing, nothing, 0) if the linecode is missing.
"""
function _line_z_matrix(line::Dict{String,Any}, linecodes::Dict{String,Any})
    lcid = get(line, "linecode", nothing)
    lcid === nothing && return (nothing, nothing, 0)
    lc = get(linecodes, lcid, nothing)
    lc === nothing && return (nothing, nothing, 0)

    R_pm = _pkm(lc, "R_series_")   # Ω/m
    X_pm = _pkm(lc, "X_series_")   # Ω/m
    len  = Float64(get(line, "length", 1.0))  # m

    R_pm === nothing && (R_pm = zeros(1,1))
    X_pm === nothing && (X_pm = zeros(size(R_pm)...))

    n = size(R_pm, 1)
    (R_pm .* len, X_pm .* len, n)
end

# These helpers live in BMOPFTools core; alias locally for convenience.
const _neutral_pos      = BMOPFTools._neutral_pos
const _phase_positions  = BMOPFTools._phase_positions
const _xfmr_turns_ratio = BMOPFTools._xfmr_turns_ratio

"""
    _source_fixed_terminals(net) -> Set{Tuple{String,String}}

Collect all (bus_id, terminal) pairs whose voltage is fixed by a voltage source.
These must be excluded from voltage bound constraints.
"""
function _source_fixed_terminals(net::Dict{String,Any})
    fixed = Set{Tuple{String,String}}()
    for (_, vs) in get(net, "voltage_source", Dict())
        bus = get(vs, "bus", "")
        for t in Vector{String}(get(vs, "terminal_map", String[]))
            push!(fixed, (bus, t))
        end
    end
    fixed
end


"""
    _line_pi_shunt(line, linecodes) -> (G_fr, B_fr, G_to, B_to)

Return the total from- and to-side shunt admittance matrices (S) for a line
from its linecode's G_from/B_from/G_to/B_to fields (S/m) scaled by line length.
Returns (nothing, nothing, nothing, nothing) when no shunt fields are present.
"""
function _line_pi_shunt(line::Dict{String,Any}, linecodes::Dict{String,Any})
    lcid = get(line, "linecode", nothing)
    lcid === nothing && return nothing, nothing, nothing, nothing
    lc = get(linecodes, lcid, nothing)
    lc === nothing && return nothing, nothing, nothing, nothing

    G_fr = _pkm(lc, "G_from_")
    B_fr = _pkm(lc, "B_from_")
    G_to = _pkm(lc, "G_to_")
    B_to = _pkm(lc, "B_to_")

    any(!isnothing, (G_fr, B_fr, G_to, B_to)) || return nothing, nothing, nothing, nothing

    len = Float64(get(line, "length", 1.0))
    G_fr !== nothing && (G_fr = G_fr .* len)
    B_fr !== nothing && (B_fr = B_fr .* len)
    G_to !== nothing && (G_to = G_to .* len)
    B_to !== nothing && (B_to = B_to .* len)
    G_fr, B_fr, G_to, B_to
end
