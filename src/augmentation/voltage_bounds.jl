# Voltage bound injection pass.
#
# For each bus that is missing bounds, injects v_min/v_max (solver
# regularisation), vpn/vpp (power-quality standards), and vneg_max.
#
# Never overwrites existing bounds.  Source buses are skipped for vpn/vpp/vneg
# (their voltages are fixed by the voltage source, not constrained by bounds).
#
# Declared supply voltage priority:
#   1. bus["v_declared"]          — explicit field set at import time
#   2. recipe.v_declared_lv/mv/hv — recipe-level regional fallback
#   3. v_nom from voltage_level_analysis — last resort

# Return the declared supply voltage (phase-to-ground, V) for a bus.
function _v_declared(bus::Dict{String,Any}, v_nom::Float64,
                     r::AugmentationRecipe)::Float64
    vd = get(bus, "v_declared", nothing)
    vd isa Number && return Float64(vd)
    fallback = v_nom <= 1_000.0  ? r.v_declared_lv :
               v_nom <= 35_000.0 ? r.v_declared_mv :
                                   r.v_declared_hv
    fallback isa Number ? Float64(fallback) : v_nom
end

function _level_name(v_nom::Float64)::String
    v_nom <= 1_000.0  && return "LV"
    v_nom <= 35_000.0 && return "MV"
    return "HV"
end

function _vpn_pu(v_nom::Float64, r::AugmentationRecipe)::Tuple{Float64,Float64}
    v_nom <= 1_000.0 ? r.vpn_lv_pu : r.vpn_mv_pu
end

function _vpp_pu(v_nom::Float64, r::AugmentationRecipe)::Tuple{Float64,Float64}
    v_nom <= 1_000.0  ? r.vpp_lv_pu :
    v_nom <= 35_000.0 ? r.vpp_mv_pu :
                        r.vpp_hv_pu
end

function _apply_voltage_bounds!(net′::Dict{String,Any},
                                 entries::Vector{TransformEntry},
                                 r::AugmentationRecipe,
                                 bus_voltage_map::Dict{String,Float64})
    buses = get(net′, "bus", Dict())

    source_buses = Set{String}()
    for (_, vs) in get(net′, "voltage_source", Dict())
        b = get(vs, "bus", nothing)
        b isa String && push!(source_buses, b)
    end

    for (bid, bus) in buses
        bus isa Dict || continue
        v_nom = get(bus_voltage_map, bid, nothing)
        v_nom === nothing && continue   # islanded bus — skip

        lvl = _level_name(v_nom)
        v_dec = _v_declared(bus, v_nom, r)
        is_source = bid in source_buses

        nt       = _neutral_terminal(bus)
        terms    = get(bus, "terminal_names", String[])
        n_phase  = count(t -> string(t) != nt, terms)
        has_neutral = nt !== nothing && any(t -> string(t) == nt, terms)
        is_four_wire = has_neutral && n_phase >= 1

        # ── v_min / v_max (solver regularisation) ────────────────────────────
        if r.apply_v_bounds && r.v_min_pu !== nothing && r.v_max_pu !== nothing
            for (field, pu) in (("v_min", r.v_min_pu), ("v_max", r.v_max_pu))
                if !haskey(bus, field)
                    val = v_dec * pu
                    bus[field] = val
                    push!(entries, TransformEntry(
                        :bus, bid, field, nothing, val,
                        "solver_regularisation", :heuristic,
                        "$lvl bus; v_declared=$(round(v_dec, digits=1)) V × $pu"))
                end
            end
        end

        is_source && continue   # skip power-quality bounds on source buses

        # ── vpn_min / vpn_max (four-wire only) ───────────────────────────────
        if r.apply_vpn_bounds && is_four_wire
            # Phase-to-neutral declared voltage: for multi-phase buses the
            # declared line voltage is phase-to-phase, so vpn_nom = v_dec / √3.
            # For single-phase (one phase + neutral) v_dec is already vpn.
            v_pn_dec = n_phase >= 2 ? v_dec / sqrt(3.0) : v_dec
            lo_pu, hi_pu = _vpn_pu(v_nom, r)

            for (field, pu) in (("vpn_min", lo_pu), ("vpn_max", hi_pu))
                if !haskey(bus, field)
                    val = v_pn_dec * pu
                    bus[field] = val
                    push!(entries, TransformEntry(
                        :bus, bid, field, nothing, val,
                        "EN50160:2010§3.5", :standard,
                        "vpn_declared=$(round(v_pn_dec, digits=1)) V × $pu"))
                end
            end

            # ── vneg_max (EN 50160: VUF ≤ 2 %) ──────────────────────────────
            if r.apply_vneg_bounds && n_phase >= 2
                if !haskey(bus, "vneg_max")
                    val = v_pn_dec * r.vneg_max_pu
                    bus["vneg_max"] = val
                    push!(entries, TransformEntry(
                        :bus, bid, "vneg_max", nothing, val,
                        "EN50160:2010§3.5_VUF≤2%", :standard,
                        "$(r.vneg_max_pu*100)% of vpn_declared=$(round(v_pn_dec, digits=1)) V"))
                end
            end
        end

        # ── vpp_min / vpp_max ─────────────────────────────────────────────────
        # Four-wire: vpp_nom = v_dec (declared line voltage = phase-to-phase).
        # Three-wire: same — v_dec is the declared line voltage directly.
        # Requires ≥ 2 phase terminals.
        if r.apply_vpp_bounds && n_phase >= 2
            lo_pu, hi_pu = _vpp_pu(v_nom, r)

            for (field, pu) in (("vpp_min", lo_pu), ("vpp_max", hi_pu))
                if !haskey(bus, field)
                    val = v_dec * pu
                    bus[field] = val
                    push!(entries, TransformEntry(
                        :bus, bid, field, nothing, val,
                        "EN50160:2010§3.5", :standard,
                        "vpp_declared=$(round(v_dec, digits=1)) V × $pu"))
                end
            end
        end
    end
end
