# Voltage bound injection pass.
#
# For each bus that is missing bounds, computes SI values from the per-unit
# recipe fractions and the nominal voltage assigned by voltage_level_analysis.
#
# Never overwrites existing bounds.  Source buses are skipped for vpn/vpp/vneg
# (their voltages are fixed by the voltage source, not constrained by bounds).

# Return the (lo_pu, hi_pu) phase-to-ground envelope for a given nominal
# voltage in Volts.
function _v_pu_for_level(v_nom::Float64, r::AugmentationRecipe)
    v_nom <= 1_000.0  && return r.lv_v_pu
    v_nom <= 35_000.0 && return r.mv_v_pu
    return r.hv_v_pu
end

function _level_name(v_nom::Float64)::String
    v_nom <= 1_000.0  && return "LV"
    v_nom <= 35_000.0 && return "MV"
    return "HV"
end

function _v_standard(v_nom::Float64)::String
    v_nom <= 35_000.0 && return "EN50160:2010§3.5-3.6+DSO_planning_practice"
    return "transmission_planning_±5%"
end

function _apply_voltage_bounds!(net′::Dict{String,Any},
                                 entries::Vector{TransformEntry},
                                 r::AugmentationRecipe,
                                 bus_voltage_map::Dict{String,Float64})
    buses = get(net′, "bus", Dict())

    # Collect source buses (their phase voltages are fixed; skip vpn/vpp/vneg)
    source_buses = Set{String}()
    for (_, vs) in get(net′, "voltage_source", Dict())
        b = get(vs, "bus", nothing)
        b isa String && push!(source_buses, b)
    end

    for (bid, bus) in buses
        bus isa Dict || continue
        v_nom = get(bus_voltage_map, bid, nothing)
        v_nom === nothing && continue   # islanded bus — skip

        # ── v_min / v_max (phase-to-ground envelope) ─────────────────────────
        if r.apply_v_bounds
            lo_pu, hi_pu = _v_pu_for_level(v_nom, r)
            std = _v_standard(v_nom)
            lvl = _level_name(v_nom)

            for (field, pu) in (("v_min", lo_pu), ("v_max", hi_pu))
                if !haskey(bus, field)
                    val = v_nom * pu
                    bus[field] = val
                    push!(entries, TransformEntry(
                        :bus, bid, field, nothing, val,
                        std, :standard,
                        "$lvl bus; v_nom=$(round(v_nom, digits=1)) V"))
                end
            end
        end

        is_source = bid in source_buses

        # ── vpn_min / vpn_max (phase-to-neutral, EN 50160) ───────────────────
        if r.apply_vpn_bounds && !is_source
            nt = _neutral_terminal(bus)
            terms = get(bus, "terminal_names", String[])
            n_phase = count(t -> t != nt, terms)
            (nt === nothing || n_phase == 0) && continue

            # For 3-phase buses v_pn_nom = v_nom / √3; for single-phase
            # (two terminals: one phase + neutral) v_nom is already phase-to-ground.
            v_pn_nom = n_phase >= 2 ? v_nom / sqrt(3.0) : v_nom
            lo_pu, hi_pu = r.vpn_pu

            for (field, pu) in (("vpn_min", lo_pu), ("vpn_max", hi_pu))
                if !haskey(bus, field)
                    val = v_pn_nom * pu
                    bus[field] = val
                    push!(entries, TransformEntry(
                        :bus, bid, field, nothing, val,
                        "EN50160:2010§3.5", :standard,
                        "vpn_nom=$(round(v_pn_nom, digits=1)) V ×$(pu)"))
                end
            end

            # ── vneg_max (EN 50160: VUF ≤ 2 %) ──────────────────────────────
            if r.apply_vneg_bounds && n_phase >= 2
                if !haskey(bus, "vneg_max")
                    val = v_pn_nom * r.vneg_max_pu
                    bus["vneg_max"] = val
                    push!(entries, TransformEntry(
                        :bus, bid, "vneg_max", nothing, val,
                        "EN50160:2010§3.5_VUF≤2%", :standard,
                        "$(r.vneg_max_pu*100)% of vpn_nom=$(round(v_pn_nom, digits=1)) V"))
                end
            end
        end

        # ── vpp_min / vpp_max (phase-to-phase, EN 50160) ─────────────────────
        if r.apply_vpp_bounds && !is_source
            terms = get(bus, "terminal_names", String[])
            nt    = _neutral_terminal(bus)
            n_phase = count(t -> t != nt, terms)
            n_phase < 2 && continue

            v_pp_nom = v_nom   # line voltage equals v_nom for 3-phase buses
            lo_pu, hi_pu = r.vpp_pu

            for (field, pu) in (("vpp_min", lo_pu), ("vpp_max", hi_pu))
                if !haskey(bus, field)
                    val = v_pp_nom * pu
                    bus[field] = val
                    push!(entries, TransformEntry(
                        :bus, bid, field, nothing, val,
                        "EN50160:2010§3.5", :standard,
                        "vpp_nom=$(round(v_pp_nom, digits=1)) V ×$(pu)"))
                end
            end
        end
    end
end
