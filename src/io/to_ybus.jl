# Nodal admittance (Yprim) export for BMOPF transformer subtypes.
#
# For each transformer, builds the complex matrix Y ∈ ℂⁿˣⁿ over the terminal
# nodes such that I = Y·V, where I is the vector of currents INTO the element
# (out of the bus) and V is the vector of node voltages.
#
# Convention matches OpenDSS Yprim / DumpYprim: SI units (siemens), positive
# current = into the element, symmetric (Y = Yᵀ — reciprocal, NOT Hermitian).
#
# Construction: C' * y_prim * C + Y₀ (shunt at HV nodes), where C maps node
# voltages to per-core winding voltages and y_prim is the block-diagonal
# primitive admittance. This guarantees Y = Yᵀ. See docs/transformer_admittance_derivation.md.
#
# All four subtypes are supported:
#   single_phase  — per-phase YY, Γ-model referred to HV (§2 of the note)
#   wye_delta     — Yd 3-phase, connection-matrix form (§3)
#   delta_wye     — Dy 3-phase, connection-matrix form (§3)
#   center_tap    — 3-winding star-equivalent T-model (§4)

"""
    transformer_yprim(xfmr, subtype) -> (nodes, Y)

Return the nodal admittance block for a single transformer data dict.

- `nodes`  — `Vector{Tuple{String,String}}` of `(bus_id, terminal_name)` pairs,
             in the same order as the rows/columns of `Y`.
- `Y`      — `Matrix{ComplexF64}`, SI siemens. Symmetric: `Y ≈ transpose(Y)`.

`subtype` must be one of `"single_phase"`, `"center_tap"`, `"wye_delta"`,
`"delta_wye"`.

Raises an `ArgumentError` for unknown subtypes. Returns `([], zeros(0,0))` when
the transformer is degenerate (zero `v_ref_to`, missing terminal maps).
"""
function transformer_yprim(xfmr::Dict{String,Any}, subtype::AbstractString)
    subtype == "single_phase" && return _yprim_single_phase(xfmr)
    subtype == "center_tap"   && return _yprim_center_tap(xfmr)
    subtype == "wye_delta"    && return _yprim_yd(xfmr; wye_is_from=true)
    subtype == "delta_wye"    && return _yprim_yd(xfmr; wye_is_from=false)
    throw(ArgumentError("unknown transformer subtype: $(repr(subtype))"))
end

"""
    export_yprim(net) -> Dict

Build the Yprim block for every transformer in the network and return a nested
Dict:

```
Dict(
  subtype => Dict(
    id => Dict("nodes" => [...], "Y_real" => [...], "Y_imag" => [...])
  )
)
```

Each `"nodes"` entry is a `Vector` of `[bus_id, terminal_name]` pairs.
`"Y_real"` and `"Y_imag"` are row-major dense matrices (Vector of Vector).
"""
function export_yprim(net::Dict{String,Any})::Dict{String,Any}
    result = Dict{String,Any}()
    xfmr_dict = get(net, "transformer", Dict())
    for subtype in ("single_phase", "center_tap", "wye_delta", "delta_wye")
        sub = get(xfmr_dict, subtype, Dict())
        isempty(sub) && continue
        result[subtype] = Dict{String,Any}()
        for (tid, xfmr) in sub
            nodes, Y = transformer_yprim(xfmr, subtype)
            isempty(nodes) && continue
            result[subtype][tid] = Dict{String,Any}(
                "nodes"  => [[b, t] for (b, t) in nodes],
                "Y_real" => [real.(row) for row in eachrow(Y)],
                "Y_imag" => [imag.(row) for row in eachrow(Y)],
            )
        end
    end
    result
end

"""
    write_yprim(net, path)

Write the Yprim export for all transformers in `net` to a JSON file at `path`.
"""
function write_yprim(net::Dict{String,Any}, path::AbstractString)
    data = export_yprim(net)
    open(path, "w") do io
        JSON3.pretty(io, data)
    end
    nothing
end

# ── internal helpers ────────────────────────────────────────────────────────

# Build node list and read basic fields shared by all subtypes.
function _node_list(bus, tm)
    [(bus, string(t)) for t in tm]
end

# ── single_phase ────────────────────────────────────────────────────────────

function _yprim_single_phase(xfmr::Dict{String,Any})
    b_fr  = get(xfmr, "bus_from", "")
    b_to  = get(xfmr, "bus_to",   "")
    tm_fr = Vector{String}(get(xfmr, "terminal_map_from", String[]))
    tm_to = Vector{String}(get(xfmr, "terminal_map_to",   String[]))
    isempty(tm_fr) || isempty(tm_to) && return (Tuple{String,String}[], zeros(ComplexF64,0,0))

    N   = _xfmr_turns_ratio(xfmr)
    n_c = min(length(tm_fr), length(tm_to))

    r1 = Float64(get(xfmr, "r_series_from", 0.0))
    x1 = Float64(get(xfmr, "x_series_from", 0.0))
    r2 = Float64(get(xfmr, "r_series_to",   0.0))
    x2 = Float64(get(xfmr, "x_series_to",   0.0))
    Z  = (r1 + N^2 * r2) + im*(x1 + N^2 * x2)

    G0 = Float64(get(xfmr, "g_no_load", 0.0))
    B0 = Float64(get(xfmr, "b_no_load", 0.0))
    Y0_per = n_c > 0 ? (G0 + im*B0) / n_c : 0.0 + 0.0im

    n_tot = 2 * n_c
    Y     = zeros(ComplexF64, n_tot, n_tot)
    nodes = Tuple{String,String}[]

    for k in 1:n_c
        push!(nodes, (b_fr, tm_fr[k]))
        push!(nodes, (b_to, tm_to[k]))
    end

    for k in 1:n_c
        p = 2k - 1   # HV node index (1-based)
        q = 2k       # LV node index

        if !iszero(Z)
            y = 1.0 / Z
            Y[p,p] += y + Y0_per
            Y[p,q] += -N * y
            Y[q,p] += -N * y
            Y[q,q] += N^2 * y
        else
            Y[p,p] += Y0_per
        end
    end

    nodes, Y
end

# ── center_tap ──────────────────────────────────────────────────────────────

function _yprim_center_tap(xfmr::Dict{String,Any})
    b_fr  = get(xfmr, "bus_from", "")
    b_to  = get(xfmr, "bus_to",   "")
    tm_fr = Vector{String}(get(xfmr, "terminal_map_from", String[]))
    tm_to = Vector{String}(get(xfmr, "terminal_map_to",   String[]))

    if length(tm_fr) != 2 || length(tm_to) != 3
        @warn "center_tap transformer: expected 2 HV and 3 LV terminals; got " *
              "$(length(tm_fr)) and $(length(tm_to)). Skipping."
        return (Tuple{String,String}[], zeros(ComplexF64,0,0))
    end

    N  = _xfmr_turns_ratio(xfmr)
    Z1 = Float64(get(xfmr, "r_series_from", 0.0)) + im*Float64(get(xfmr, "x_series_from", 0.0))
    Z2 = Float64(get(xfmr, "r_series_to",   0.0)) + im*Float64(get(xfmr, "x_series_to",   0.0))
    G0 = Float64(get(xfmr, "g_no_load", 0.0))
    B0 = Float64(get(xfmr, "b_no_load", 0.0))

    # Nodes: [HV-phase, HV-neutral, LV-leg1, LV-center-tap, LV-leg2]
    nodes = Tuple{String,String}[
        (b_fr, tm_fr[1]), (b_fr, tm_fr[2]),
        (b_to, tm_to[1]), (b_to, tm_to[2]), (b_to, tm_to[3]),
    ]

    # 3-port star admittance (all referred to LV).
    # Arms: HV (impedance Z1/N², admitted y1=N²/Z1), LV1 (Z2, y2), LV2 (Z2, y2).
    # LV-leg-2 winding spans V_c→V_g (same direction as leg-1 V_a→V_g).
    if iszero(Z1) || iszero(Z2)
        # Degenerate (ideal): Y is singular; return zero matrix as placeholder.
        @warn "center_tap transformer has zero series impedance; Yprim is singular."
        return nodes, zeros(ComplexF64, 5, 5)
    end

    y1 = N^2 / Z1
    y2 = 1.0  / Z2
    Ys = y1 + y2 + y2   # total star admittance

    # 3×3 star-equivalent admittance (winding ordering: [HV-ref, LV1, LV2])
    yv = (y1, y2, y2)
    Y3 = zeros(ComplexF64, 3, 3)
    for i in 1:3, j in 1:3
        Y3[i,j] = i == j ? yv[i] * (Ys - yv[i]) / Ys : -yv[i] * yv[j] / Ys
    end

    # Connection matrix C (3×5): maps node voltages [p,m,a,g,c] to winding voltages.
    # Row 1: V_HV_ref = (V_p - V_m)/N
    # Row 2: V_leg1   = V_a - V_g
    # Row 3: V_leg2   = V_c - V_g  (c→g, same polarity as leg1)
    C = zeros(ComplexF64, 3, 5)
    C[1,1] =  1.0/N;  C[1,2] = -1.0/N
    C[2,3] =  1.0;    C[2,4] = -1.0
    C[3,5] =  1.0;    C[3,4] = -1.0

    Y_core = transpose(C) * Y3 * C

    # Add Y0 shunt at HV-phase node (index 1).
    Y_core[1,1] += G0 + im*B0

    nodes, Y_core
end

# ── wye_delta / delta_wye ───────────────────────────────────────────────────

function _yprim_yd(xfmr::Dict{String,Any}; wye_is_from::Bool)
    if wye_is_from
        b_wye  = get(xfmr, "bus_from", "")
        b_del  = get(xfmr, "bus_to",   "")
        tm_wye = Vector{String}(get(xfmr, "terminal_map_from", String[]))
        tm_del = Vector{String}(get(xfmr, "terminal_map_to",   String[]))
    else
        b_del  = get(xfmr, "bus_from", "")
        b_wye  = get(xfmr, "bus_to",   "")
        tm_del = Vector{String}(get(xfmr, "terminal_map_from", String[]))
        tm_wye = Vector{String}(get(xfmr, "terminal_map_to",   String[]))
    end

    isempty(tm_wye) || isempty(tm_del) && return (Tuple{String,String}[], zeros(ComplexF64,0,0))

    N     = _xfmr_turns_ratio(xfmr)
    n_eff = wye_is_from ? sqrt(3.0)/N : N*sqrt(3.0)

    # Per-winding impedances mapped to wye/delta sides.
    r_fr = Float64(get(xfmr, "r_series_from", 0.0))
    x_fr = Float64(get(xfmr, "x_series_from", 0.0))
    r_to = Float64(get(xfmr, "r_series_to",   0.0))
    x_to = Float64(get(xfmr, "x_series_to",   0.0))
    if wye_is_from
        Zw = (r_fr + im*x_fr); Zd = (r_to + im*x_to)
    else
        Zd = (r_fr + im*x_fr); Zw = (r_to + im*x_to)
    end
    # Γ-equivalent: fold both winding leakages into one series admittance referred to wye.
    Z_total = Zw + n_eff^2 * Zd

    G0 = Float64(get(xfmr, "g_no_load", 0.0))
    B0 = Float64(get(xfmr, "b_no_load", 0.0))

    n_ph  = length(tm_del)
    n_pos = _neutral_pos(tm_wye)
    ph_idx = _phase_positions(tm_wye)

    n_wye  = length(tm_wye)
    n_tot  = n_wye + n_ph
    Y      = zeros(ComplexF64, n_tot, n_tot)

    # Node ordering: [wye terminals..., delta terminals...]
    nodes = vcat(
        [(b_wye, t) for t in tm_wye],
        [(b_del, t) for t in tm_del],
    )

    if iszero(Z_total)
        @warn "wye_delta/delta_wye transformer has zero effective series impedance; Yprim is singular."
        return nodes, Y
    end

    yt = 1.0 / Z_total

    # Per-core primitive: y_prim^(k) = yt * [1, -n_eff; -n_eff, n_eff²]
    # Connection matrix C (2*n_ph × n_tot):
    #   Row k (wye winding k):   C[k, ph_idx[k]] = 1, C[k, neutral] = -1
    #   Row n_ph+k (delta winding k): C[n_ph+k, n_wye+k] = 1, C[n_ph+k, n_wye+k_next] = -1
    #
    # Build C and y_prim, then Y = C' * y_prim * C.
    n_rows = 2 * n_ph
    C      = zeros(ComplexF64, n_rows, n_tot)

    for k in 1:n_ph
        ph = ph_idx[k]
        # Wye winding k: voltage = V_wye_ph[k] - V_wye_neutral
        C[k, ph] = 1.0
        if n_pos !== nothing
            C[k, n_pos] = -1.0
        end
        # Delta winding k:
        # Yd uses k_next; Dy uses k_prev (backward delta convention from OPF).
        k_other = wye_is_from ? (k % n_ph) + 1 : ((k - 2 + n_ph) % n_ph) + 1
        C[n_ph+k, n_wye+k]       =  1.0
        C[n_ph+k, n_wye+k_other] = -1.0
    end

    # y_prim: 2n_ph × 2n_ph block-diagonal, each core's 2×2 in rows [k, n_ph+k].
    prim_block = yt * [1.0 -n_eff; -n_eff n_eff^2]
    y_prim = zeros(ComplexF64, n_rows, n_rows)
    for k in 1:n_ph
        rows = [k, n_ph+k]
        y_prim[rows, rows] .= prim_block
    end

    Y .= transpose(C) * y_prim * C

    # No-load shunt Y0 split equally across from-side phase terminals.
    if !iszero(G0) || !iszero(B0)
        from_ph_indices = wye_is_from ? ph_idx : collect(n_wye+1:n_wye+n_ph)
        n_from_ph = length(from_ph_indices)
        Y0_per = (G0 + im*B0) / n_from_ph
        for idx in from_ph_indices
            Y[idx, idx] += Y0_per
        end
    end

    nodes, Y
end
