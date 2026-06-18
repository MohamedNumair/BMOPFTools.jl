# validation/solution.jl
#
# Post-solve result profiler: given a BMOPF network dict and a result dict
# (from any solver), flag bound violations, near-active bounds, poor
# constraint residuals, and other solution-quality issues.
#
# Entry point: solution_check(net, result, findings) -> Dict{String,Any}
#
# Finding codes (SOL family):
#   E.SOL.INFEASIBLE         — solver did not find a feasible point
#   E.SOL.NAN_IN_RESULT      — non-finite value in a claimed-feasible result
#   E.SOL.VOLT_VIOLATION     — vm / vpn / vpp / vpos / vneg / vzero outside bounds
#   E.SOL.THERMAL_VIOLATION  — line or switch current exceeds i_max / s_max
#   E.SOL.GEN_VIOLATION      — generator pg/qg outside [p_min, p_max] / [q_min, q_max]
#   W.SOL.VOLT_ACTIVE        — voltage bound within the active threshold
#   W.SOL.THERMAL_ACTIVE     — thermal limit within the active threshold
#   W.SOL.GEN_ACTIVE         — generator bound within the active threshold
#   W.SOL.LOAD_RESIDUAL      — |pd - p_nom| or |qd - q_nom| above tolerance
#   W.SOL.POWER_BALANCE      — network-wide active power doesn't balance
#   I.SOL.BINDING_SUMMARY    — aggregate count of active / violated bounds
#   I.SOL.LOSS_FRACTION      — line losses as fraction of total load
#   I.SOL.NEUTRAL_SHIFT      — maximum neutral terminal voltage across non-source buses
#   W.SOL.INIT_LEVEL_MISMATCH — init voltage differs from solved by > 10× (wrong voltage level)
#   W.SOL.INIT_LARGE_ERROR   — init voltage error > 20 % of solved value on a phase terminal
#   I.SOL.INIT_NEUTRAL_NONZERO — neutral terminal initialised non-zero

"""
    solution_check(net, result, findings) -> Dict{String,Any}

Profile an OPF result dict against the network that produced it.
Appends `Finding` objects to `findings` and returns a summary dict.

`net` must be a snapshot (non-time-series) BMOPF network dict.
`result` is the dict returned by `solve_opf` (or any compatible solver).
"""
function solution_check(net::Dict{String,Any},
                        result::Dict{String,Any},
                        findings::Vector{Finding})::Dict{String,Any}
    out = Dict{String,Any}()

    # ── Termination ──────────────────────────────────────────────────────────
    status = get(result, "termination_status", "UNKNOWN")
    feasible = status in ("LOCALLY_SOLVED", "OPTIMAL", "ALMOST_LOCALLY_SOLVED")
    out["termination_status"] = status
    out["feasible"] = feasible

    if !feasible
        push!(findings, Finding(ERROR, "E.SOL.INFEASIBLE", :solution, :network, nothing,
            "Solver terminated with status '$status' — all numeric results are " *
            "unreliable (NaN). No bound or residual checks are meaningful.",
            Dict{String,Any}("termination_status" => status)))
        out["n_volt_violations"]    = 0
        out["n_thermal_violations"] = 0
        out["n_gen_violations"]     = 0
        return out
    end

    # ── NaN / Inf detection ──────────────────────────────────────────────────
    nan_locs = String[]
    for (sec, sec_dict) in result
        sec_dict isa Dict || continue
        for (id, id_dict) in sec_dict
            id_dict isa Dict || continue
            for (t, t_dict) in id_dict
                t_dict isa Dict || continue
                for (f, v) in t_dict
                    v isa Number && !isfinite(v) &&
                        push!(nan_locs, "$sec[$id][$t].$f")
                end
            end
        end
    end
    if !isempty(nan_locs)
        push!(findings, Finding(ERROR, "E.SOL.NAN_IN_RESULT", :solution, :network, nothing,
            "$(length(nan_locs)) non-finite value(s) in a claimed-feasible result " *
            "(first: $(nan_locs[1])). This indicates numerical failure inside the solver.",
            Dict{String,Any}("locations" => nan_locs)))
    end
    out["n_nan_fields"] = length(nan_locs)

    # ── Helpers ───────────────────────────────────────────────────────────────
    # Threshold for "active" (near-binding): within this fraction of the bound value.
    active_frac = 0.01

    # Returns (violated, active) given value v, lower lb, upper ub (either may be nothing).
    # Uses an absolute fallback of 0.01 × |bound| for bounds near zero.
    function _bound_status(v::Float64, lb, ub)
        violated = false
        active   = false
        if lb !== nothing
            lb_f = Float64(lb)
            tol  = max(active_frac * abs(lb_f), 1e-6)
            v < lb_f - 1e-9  && (violated = true)
            !violated && v < lb_f + tol && (active = true)
        end
        if ub !== nothing
            ub_f = Float64(ub)
            tol  = max(active_frac * abs(ub_f), 1e-6)
            v > ub_f + 1e-9  && (violated = true)
            !violated && v > ub_f - tol && (active = true)
        end
        violated, active
    end

    buses   = get(net, "bus", Dict())
    bus_res = get(result, "bus", Dict())

    source_buses = Set(get(vs, "bus", "") for (_, vs) in get(net, "voltage_source", Dict())
                       if vs isa Dict)

    n_volt_viol   = 0
    n_volt_active = 0

    # ── Voltage magnitude bounds (v_min / v_max) ─────────────────────────────
    for (bid, bus) in buses
        bus isa Dict || continue
        v_min = get(bus, "v_min", nothing)
        v_max = get(bus, "v_max", nothing)
        v_min === nothing && v_max === nothing && continue
        t_res = get(bus_res, bid, nothing)
        t_res isa Dict || continue
        nt = _neutral_terminal(bus)

        for (t, tvals) in t_res
            tvals isa Dict || continue
            t == nt && continue   # neutral vm is not constrained by v_min/v_max
            lowercase(t) == "n" && continue
            vm = get(tvals, "vm", NaN)
            isfinite(vm) || continue
            viol, act = _bound_status(vm, v_min, v_max)
            if viol
                n_volt_viol += 1
                push!(findings, Finding(ERROR, "E.SOL.VOLT_VIOLATION", :solution, :bus, bid,
                    "Bus '$bid' terminal '$t': vm=$(_fmt_v(vm)) violates " *
                    "[$(v_min === nothing ? "−∞" : _fmt_v(Float64(v_min))), " *
                    "$(v_max === nothing ? "+∞" : _fmt_v(Float64(v_max)))].",
                    Dict{String,Any}("bus"=>bid,"terminal"=>t,"vm"=>vm,
                                     "v_min"=>v_min,"v_max"=>v_max,"flavour"=>"vm")))
            elseif act
                n_volt_active += 1
                push!(findings, Finding(WARNING, "W.SOL.VOLT_ACTIVE", :solution, :bus, bid,
                    "Bus '$bid' terminal '$t': vm=$(_fmt_v(vm)) is within 1 % of a " *
                    "voltage bound (active constraint).",
                    Dict{String,Any}("bus"=>bid,"terminal"=>t,"vm"=>vm,
                                     "v_min"=>v_min,"v_max"=>v_max,"flavour"=>"vm")))
            end
        end
    end

    # ── Phase-to-neutral voltage bounds (vpn_min / vpn_max) ──────────────────
    # vpn_min/vpn_max are per-phase arrays ordered by terminal_names phase order.
    # Index k in the bound array corresponds to the k-th phase terminal.
    for (bid, bus) in buses
        bus isa Dict || continue
        vpn_min = get(bus, "vpn_min", nothing)
        vpn_max = get(bus, "vpn_max", nothing)
        vpn_min === nothing && vpn_max === nothing && continue
        t_res = get(bus_res, bid, nothing)
        t_res isa Dict || continue
        nt = _neutral_terminal(bus)
        nt === nothing && continue
        vr_n = get(get(t_res, nt, Dict()), "vr", NaN)
        vi_n = get(get(t_res, nt, Dict()), "vi", NaN)
        isfinite(vr_n) && isfinite(vi_n) || continue

        # Phase terminals in terminal_names order (neutral excluded)
        term_names = Vector{String}(get(bus, "terminal_names", String[]))
        phase_ts_ordered = [t for t in term_names if t != nt]

        for (k, t) in enumerate(phase_ts_ordered)
            haskey(t_res, t) || continue
            tvals = t_res[t]
            tvals isa Dict || continue
            vr_t = get(tvals, "vr", NaN); vi_t = get(tvals, "vi", NaN)
            isfinite(vr_t) && isfinite(vi_t) || continue
            vpn = sqrt((vr_t - vr_n)^2 + (vi_t - vi_n)^2)
            # Index into per-phase bound arrays; fall back to scalar for
            # backward-compatibility with hand-written files that use a scalar.
            lb = vpn_min isa AbstractVector ? get(vpn_min, k, nothing) : vpn_min
            ub = vpn_max isa AbstractVector ? get(vpn_max, k, nothing) : vpn_max
            viol, act = _bound_status(vpn, lb, ub)
            if viol
                n_volt_viol += 1
                push!(findings, Finding(ERROR, "E.SOL.VOLT_VIOLATION", :solution, :bus, bid,
                    "Bus '$bid' terminal '$t': |Vpn|=$(_fmt_v(vpn)) violates vpn bounds.",
                    Dict{String,Any}("bus"=>bid,"terminal"=>t,"vpn"=>vpn,
                                     "vpn_min"=>lb,"vpn_max"=>ub,"flavour"=>"vpn")))
            elseif act
                n_volt_active += 1
                push!(findings, Finding(WARNING, "W.SOL.VOLT_ACTIVE", :solution, :bus, bid,
                    "Bus '$bid' terminal '$t': |Vpn|=$(_fmt_v(vpn)) is near a vpn bound.",
                    Dict{String,Any}("bus"=>bid,"terminal"=>t,"vpn"=>vpn,
                                     "vpn_min"=>lb,"vpn_max"=>ub,"flavour"=>"vpn")))
            end
        end
    end

    # ── Phase-to-phase voltage bounds (vpp_min / vpp_max) ────────────────────
    # vpp_min/vpp_max are per-pair arrays. Pairs are enumerated in the same
    # order as the upper triangle of phase terminals in terminal_names order:
    # (ts[1],ts[2]), (ts[1],ts[3]), (ts[2],ts[3]), i.e. i < j in terminal order.
    for (bid, bus) in buses
        bus isa Dict || continue
        vpp_min = get(bus, "vpp_min", nothing)
        vpp_max = get(bus, "vpp_max", nothing)
        vpp_min === nothing && vpp_max === nothing && continue
        t_res = get(bus_res, bid, nothing)
        t_res isa Dict || continue
        nt = _neutral_terminal(bus)
        term_names = Vector{String}(get(bus, "terminal_names", String[]))
        phase_ts_ordered = [t for t in term_names if t != nt && haskey(t_res, t)]
        length(phase_ts_ordered) < 2 && continue

        pair_idx = 0
        for i in eachindex(phase_ts_ordered), j in (i+1):length(phase_ts_ordered)
            pair_idx += 1
            ta = phase_ts_ordered[i]; tb = phase_ts_ordered[j]
            va = t_res[ta]; vb = t_res[tb]
            dvr = get(va,"vr",NaN) - get(vb,"vr",NaN)
            dvi = get(va,"vi",NaN) - get(vb,"vi",NaN)
            isfinite(dvr) && isfinite(dvi) || continue
            vpp = sqrt(dvr^2 + dvi^2)
            lb = vpp_min isa AbstractVector ? get(vpp_min, pair_idx, nothing) : vpp_min
            ub = vpp_max isa AbstractVector ? get(vpp_max, pair_idx, nothing) : vpp_max
            viol, act = _bound_status(vpp, lb, ub)
            pair = "$ta-$tb"
            if viol
                n_volt_viol += 1
                push!(findings, Finding(ERROR, "E.SOL.VOLT_VIOLATION", :solution, :bus, bid,
                    "Bus '$bid' phase pair $pair: |Vpp|=$(_fmt_v(vpp)) violates vpp bounds.",
                    Dict{String,Any}("bus"=>bid,"pair"=>pair,"vpp"=>vpp,
                                     "vpp_min"=>lb,"vpp_max"=>ub,"flavour"=>"vpp")))
            elseif act
                n_volt_active += 1
                push!(findings, Finding(WARNING, "W.SOL.VOLT_ACTIVE", :solution, :bus, bid,
                    "Bus '$bid' phase pair $pair: |Vpp|=$(_fmt_v(vpp)) is near a vpp bound.",
                    Dict{String,Any}("bus"=>bid,"pair"=>pair,"vpp"=>vpp,
                                     "vpp_min"=>lb,"vpp_max"=>ub,"flavour"=>"vpp")))
            end
        end
    end

    # ── Sequence voltage bounds (vpos / vneg / vzero) ────────────────────────
    # Uses the same Fortescue decomposition as the OPF: α = exp(j2π/3).
    # Phase-to-neutral voltages when neutral is present; phase-to-ground otherwise.
    s3 = sqrt(3.0) / 2.0
    for (bid, bus) in buses
        bus isa Dict || continue
        vpos_min  = get(bus, "vpos_min",  nothing)
        vpos_max  = get(bus, "vpos_max",  nothing)
        vneg_max  = get(bus, "vneg_max",  nothing)
        vzero_max = get(bus, "vzero_max", nothing)
        (vpos_min === nothing && vpos_max === nothing &&
         vneg_max === nothing && vzero_max === nothing) && continue

        t_res = get(bus_res, bid, nothing)
        t_res isa Dict || continue
        nt = _neutral_terminal(bus)
        tnames = get(bus, "terminal_names", String[])
        phase_ts = [string(t) for t in tnames
                    if string(t) != nt && lowercase(string(t)) != "n"]
        length(phase_ts) != 3 && continue  # sequence bounds only meaningful for 3-phase

        vr_n = nt !== nothing ? get(get(t_res, nt, Dict()), "vr", 0.0) : 0.0
        vi_n = nt !== nothing ? get(get(t_res, nt, Dict()), "vi", 0.0) : 0.0

        dvr = Float64[]; dvi = Float64[]
        ok = true
        for t in phase_ts
            tvals = get(t_res, t, nothing)
            tvals isa Dict || (ok = false; break)
            vr_t = get(tvals, "vr", NaN); vi_t = get(tvals, "vi", NaN)
            isfinite(vr_t) && isfinite(vi_t) || (ok = false; break)
            push!(dvr, vr_t - vr_n)
            push!(dvi, vi_t - vi_n)
        end
        ok || continue

        # V1 (positive sequence)
        V1r = (dvr[1] - 0.5*dvr[2] - s3*dvi[2] - 0.5*dvr[3] + s3*dvi[3]) / 3
        V1i = (dvi[1] + s3*dvr[2] - 0.5*dvi[2] - s3*dvr[3] - 0.5*dvi[3]) / 3
        V1  = sqrt(V1r^2 + V1i^2)

        # V2 (negative sequence)
        V2r = (dvr[1] - 0.5*dvr[2] + s3*dvi[2] - 0.5*dvr[3] - s3*dvi[3]) / 3
        V2i = (dvi[1] - s3*dvr[2] - 0.5*dvi[2] + s3*dvr[3] - 0.5*dvi[3]) / 3
        V2  = sqrt(V2r^2 + V2i^2)

        # V0 (zero sequence)
        V0r = (dvr[1] + dvr[2] + dvr[3]) / 3
        V0i = (dvi[1] + dvi[2] + dvi[3]) / 3
        V0  = sqrt(V0r^2 + V0i^2)

        for (label, val, lb, ub) in (
                ("vpos", V1, vpos_min, vpos_max),
                ("vneg", V2, nothing,  vneg_max),
                ("vzero", V0, nothing, vzero_max))
            lb === nothing && ub === nothing && continue
            viol, act = _bound_status(val, lb, ub)
            if viol
                n_volt_viol += 1
                push!(findings, Finding(ERROR, "E.SOL.VOLT_VIOLATION", :solution, :bus, bid,
                    "Bus '$bid': $label=$(_fmt_v(val)) violates $label bound(s).",
                    Dict{String,Any}("bus"=>bid,"sequence"=>label,"value"=>val,
                                     "bound_min"=>lb,"bound_max"=>ub,"flavour"=>label)))
            elseif act
                n_volt_active += 1
                push!(findings, Finding(WARNING, "W.SOL.VOLT_ACTIVE", :solution, :bus, bid,
                    "Bus '$bid': $label=$(_fmt_v(val)) is near its bound (active).",
                    Dict{String,Any}("bus"=>bid,"sequence"=>label,"value"=>val,
                                     "bound_min"=>lb,"bound_max"=>ub,"flavour"=>label)))
            end
        end
    end

    out["n_volt_violations"] = n_volt_viol
    out["n_volt_active"]     = n_volt_active

    # ── Thermal limits — lines ────────────────────────────────────────────────
    linecodes = get(net, "linecode", Dict())
    n_therm_viol   = 0
    n_therm_active = 0

    for (lid, line) in get(net, "line", Dict())
        line isa Dict || continue
        lcid  = get(line, "linecode", nothing)
        lc    = lcid isa String ? get(linecodes, lcid, Dict()) : Dict()
        i_max_lc = get(lc,   "i_max", nothing)
        i_max_ln = get(line, "i_max", nothing)
        s_max_ln = get(line, "s_max", nothing)
        i_max_lc === nothing && i_max_ln === nothing && s_max_ln === nothing && continue

        cond_res = get(get(result, "line", Dict()), lid, nothing)
        cond_res isa Dict || continue
        tm_fr = string.(get(line, "terminal_map_from", String[]))

        for (k, t) in enumerate(tm_fr)
            cvals = get(cond_res, t, nothing)
            cvals isa Dict || continue
            cm_fr = get(cvals, "cm_fr", NaN)
            isfinite(cm_fr) || continue

            # i_max: line field takes precedence over linecode field
            i_lim = nothing
            if i_max_ln isa AbstractVector && k <= length(i_max_ln)
                i_lim = Float64(i_max_ln[k])
            elseif i_max_lc isa AbstractVector && k <= length(i_max_lc)
                i_lim = Float64(i_max_lc[k])
            end

            if i_lim !== nothing
                viol, act = _bound_status(cm_fr, nothing, i_lim)
                if viol
                    n_therm_viol += 1
                    push!(findings, Finding(ERROR, "E.SOL.THERMAL_VIOLATION",
                        :solution, :line, lid,
                        "Line '$lid' conductor '$t': cm_fr=$(_fmt_a(cm_fr)) exceeds " *
                        "i_max=$(_fmt_a(i_lim)).",
                        Dict{String,Any}("line"=>lid,"terminal"=>t,
                                         "cm_fr"=>cm_fr,"i_max"=>i_lim)))
                elseif act
                    n_therm_active += 1
                    push!(findings, Finding(WARNING, "W.SOL.THERMAL_ACTIVE",
                        :solution, :line, lid,
                        "Line '$lid' conductor '$t': cm_fr=$(_fmt_a(cm_fr)) is within " *
                        "1 % of i_max=$(_fmt_a(i_lim)).",
                        Dict{String,Any}("line"=>lid,"terminal"=>t,
                                         "cm_fr"=>cm_fr,"i_max"=>i_lim)))
                end
            end
        end
    end

    # ── Thermal limits — switches ─────────────────────────────────────────────
    for (sid, sw) in get(net, "switch", Dict())
        sw isa Dict || continue
        i_max_sw = get(sw, "i_max", nothing)
        i_max_sw === nothing && continue
        cond_res = get(get(result, "switch", Dict()), sid, nothing)
        cond_res isa Dict || continue
        tm_fr = string.(get(sw, "terminal_map_from", String[]))

        for (k, t) in enumerate(tm_fr)
            cvals = get(cond_res, t, nothing)
            cvals isa Dict || continue
            cm = get(cvals, "cm", NaN)
            isfinite(cm) || continue
            i_lim = i_max_sw isa AbstractVector && k <= length(i_max_sw) ?
                        Float64(i_max_sw[k]) : nothing
            i_lim === nothing && continue
            viol, act = _bound_status(cm, nothing, i_lim)
            if viol
                n_therm_viol += 1
                push!(findings, Finding(ERROR, "E.SOL.THERMAL_VIOLATION",
                    :solution, :switch, sid,
                    "Switch '$sid' conductor '$t': cm=$(_fmt_a(cm)) exceeds " *
                    "i_max=$(_fmt_a(i_lim)).",
                    Dict{String,Any}("switch"=>sid,"terminal"=>t,"cm"=>cm,"i_max"=>i_lim)))
            elseif act
                n_therm_active += 1
                push!(findings, Finding(WARNING, "W.SOL.THERMAL_ACTIVE",
                    :solution, :switch, sid,
                    "Switch '$sid' conductor '$t': cm=$(_fmt_a(cm)) is within 1 % of " *
                    "i_max=$(_fmt_a(i_lim)).",
                    Dict{String,Any}("switch"=>sid,"terminal"=>t,"cm"=>cm,"i_max"=>i_lim)))
            end
        end
    end

    out["n_thermal_violations"] = n_therm_viol
    out["n_thermal_active"]     = n_therm_active

    # ── Generator dispatch bounds ─────────────────────────────────────────────
    n_gen_viol   = 0
    n_gen_active = 0

    for (gid, gen) in get(net, "generator", Dict())
        gen isa Dict || continue
        p_min = Float64.(get(gen, "p_min", Float64[]))
        p_max = Float64.(get(gen, "p_max", Float64[]))
        q_min = Float64.(get(gen, "q_min", Float64[]))
        q_max = Float64.(get(gen, "q_max", Float64[]))
        (isempty(p_min) && isempty(p_max) && isempty(q_min) && isempty(q_max)) && continue

        ph_res = get(get(result, "generator", Dict()), gid, nothing)
        ph_res isa Dict || continue
        tm = Vector{String}(get(gen, "terminal_map", String[]))
        cfg = get(gen, "configuration", "WYE")
        ph_pos = cfg == "DELTA" ? collect(eachindex(tm)) : _phase_positions(tm)

        for (idx, ph) in enumerate(ph_pos)
            t_ph = tm[ph]
            gvals = get(ph_res, t_ph, nothing)
            gvals isa Dict || continue

            pg = get(gvals, "pg", NaN); qg = get(gvals, "qg", NaN)
            for (field, v, lo_arr, hi_arr) in (
                    ("pg", pg, p_min, p_max),
                    ("qg", qg, q_min, q_max))
                isfinite(v) || continue
                lo = idx <= length(lo_arr) ? lo_arr[idx] : nothing
                hi = idx <= length(hi_arr) ? hi_arr[idx] : nothing
                lo === nothing && hi === nothing && continue
                viol, act = _bound_status(v, lo, hi)
                if viol
                    n_gen_viol += 1
                    push!(findings, Finding(ERROR, "E.SOL.GEN_VIOLATION",
                        :solution, :generator, gid,
                        "Generator '$gid' phase '$t_ph': $field=$(_fmt_mw(v)) violates " *
                        "[$(lo === nothing ? "−∞" : _fmt_mw(lo)), " *
                        "$(hi === nothing ? "+∞" : _fmt_mw(hi))].",
                        Dict{String,Any}("generator"=>gid,"terminal"=>t_ph,
                                         "field"=>field,"value"=>v,"lo"=>lo,"hi"=>hi)))
                elseif act
                    n_gen_active += 1
                    push!(findings, Finding(WARNING, "W.SOL.GEN_ACTIVE",
                        :solution, :generator, gid,
                        "Generator '$gid' phase '$t_ph': $field=$(_fmt_mw(v)) is within " *
                        "1 % of its bound (active).",
                        Dict{String,Any}("generator"=>gid,"terminal"=>t_ph,
                                         "field"=>field,"value"=>v,"lo"=>lo,"hi"=>hi)))
                end
            end
        end
    end

    out["n_gen_violations"] = n_gen_viol
    out["n_gen_active"]     = n_gen_active

    # ── Load constraint residuals ─────────────────────────────────────────────
    # For a converged solve |pd - p_nom| and |qd - q_nom| should be near zero.
    # A large residual indicates the solver struggled to satisfy the bilinear
    # constant-power constraint.
    resid_tol = 1.0   # 1 W / 1 var absolute tolerance
    n_load_resid = 0

    for (lid, load) in get(net, "load", Dict())
        load isa Dict || continue
        p_nom = Float64.(get(load, "p_nom", Float64[]))
        q_nom = Float64.(get(load, "q_nom", Float64[]))
        ph_res = get(get(result, "load", Dict()), lid, nothing)
        ph_res isa Dict || continue
        tm  = Vector{String}(get(load, "terminal_map", String[]))
        cfg = get(load, "configuration", "WYE")
        ph_pos = cfg == "DELTA" ? collect(eachindex(tm)) : _phase_positions(tm)

        for (idx, ph) in enumerate(ph_pos)
            t_ph = tm[ph]
            lvals = get(ph_res, t_ph, nothing)
            lvals isa Dict || continue
            pd = get(lvals, "pd", NaN); qd = get(lvals, "qd", NaN)
            p_ref = idx <= length(p_nom) ? p_nom[idx] : 0.0
            q_ref = idx <= length(q_nom) ? q_nom[idx] : 0.0

            p_err = isfinite(pd) ? abs(pd - p_ref) : NaN
            q_err = isfinite(qd) ? abs(qd - q_ref) : NaN

            if (isfinite(p_err) && p_err > resid_tol) ||
               (isfinite(q_err) && q_err > resid_tol)
                n_load_resid += 1
                push!(findings, Finding(WARNING, "W.SOL.LOAD_RESIDUAL",
                    :solution, :load, lid,
                    "Load '$lid' phase '$t_ph': constant-power residual " *
                    "|Δp|=$(round(p_err; digits=2)) W, |Δq|=$(round(q_err; digits=2)) var " *
                    "— solver may not have converged tightly.",
                    Dict{String,Any}("load"=>lid,"terminal"=>t_ph,
                                     "p_err"=>p_err,"q_err"=>q_err,
                                     "p_nom"=>p_ref,"q_nom"=>q_ref)))
            end
        end
    end
    out["n_load_residuals"] = n_load_resid

    # ── Network-wide power balance ─────────────────────────────────────────────
    # Σ pg (all generators) - Σ pd (all loads) - Σ p_loss (all lines) ≈ 0
    p_gen  = sum(get(gvals, "pg", 0.0)
                 for (_, ph_dict) in get(result, "generator", Dict())
                 for (_, gvals)   in ph_dict
                 if gvals isa Dict; init=0.0)
    p_load = sum(get(lvals, "pd", 0.0)
                 for (_, ph_dict) in get(result, "load", Dict())
                 for (_, lvals)   in ph_dict
                 if lvals isa Dict; init=0.0)
    # Line losses: sum of (P_from + P_to) per conductor (both have same sign convention)
    p_loss = 0.0
    for (lid, line) in get(net, "line", Dict())
        line isa Dict || continue
        cond_res = get(get(result, "line", Dict()), lid, nothing)
        cond_res isa Dict || continue
        tm_fr = string.(get(line, "terminal_map_from", String[]))
        for t in tm_fr
            cvals = get(cond_res, t, nothing)
            cvals isa Dict || continue
            # Loss on this conductor: power leaving from-end minus power entering to-end
            # P_fr = Re(V_fr · I_fr*)  —  but we only have magnitudes and rectangular currents.
            # Use: p_loss = Re(Z · I · I*) = R·|I|² (series R from linecode × length)
            # Fall back to cm_fr² × R when available; otherwise skip.
            cm_fr = get(cvals, "cm_fr", NaN)
            isfinite(cm_fr) || continue
            lcid = get(line, "linecode", nothing)
            lcid isa String || continue
            lc = get(linecodes, lcid, nothing)
            lc isa Dict || continue
            r_key = "R_series_$(findfirst(==(t), tm_fr))_$(findfirst(==(t), tm_fr))"
            r = get(lc, r_key, nothing)
            r isa Number || continue
            len = get(line, "length", NaN)
            isfinite(len) || continue
            p_loss += Float64(r) * len * cm_fr^2
        end
    end

    balance_err = abs(p_gen - p_load - p_loss)
    balance_tol = max(0.01 * abs(p_load), 1.0)   # 1 % of load or 1 W
    out["p_gen"]          = p_gen
    out["p_load"]         = p_load
    out["p_loss"]         = p_loss
    out["power_balance_err"] = balance_err

    if balance_err > balance_tol
        push!(findings, Finding(WARNING, "W.SOL.POWER_BALANCE", :solution, :network, nothing,
            "Network power balance error: |pg_total − pd_total − p_loss| = " *
            "$(_fmt_mw(balance_err)) (>1 % of load). " *
            "pg=$(round(p_gen/1e3;digits=2)) kW, pd=$(round(p_load/1e3;digits=2)) kW, " *
            "p_loss=$(round(p_loss/1e3;digits=2)) kW.",
            Dict{String,Any}("p_gen"=>p_gen,"p_load"=>p_load,"p_loss"=>p_loss,
                             "balance_err"=>balance_err)))
    end

    # ── Initialisation quality ────────────────────────────────────────────────
    # Only meaningful when the solver found a feasible point and the result
    # contains an "initialisation" block (written by solve_opf).
    init_res = get(result, "initialisation", nothing)
    if init_res isa Dict
        n_level_mismatch = 0
        n_large_error    = 0
        n_neutral_nonzero = 0
        level_mismatch_locs  = String[]
        large_error_locs     = String[]
        neutral_nonzero_locs = String[]

        for (bid, bus) in buses
            bus isa Dict || continue
            nt     = _neutral_terminal(bus)
            t_init = get(init_res, bid, nothing)
            t_init isa Dict || continue
            t_sol  = get(bus_res,  bid, nothing)
            t_sol  isa Dict || continue

            for (t, ivals) in t_init
                ivals isa Dict || continue
                vm_init = get(ivals, "vm_init", NaN)
                isfinite(vm_init) || continue

                # Non-zero neutral init — should always start at 0
                if t == nt && vm_init > 1e-6
                    n_neutral_nonzero += 1
                    push!(neutral_nonzero_locs, "$bid.$t (vm_init=$(_fmt_v(vm_init)))")
                    continue
                end
                t == nt && continue   # zero neutral — nothing further to check

                svals   = get(t_sol, t, nothing)
                svals isa Dict || continue
                vm_sol  = get(svals, "vm", NaN)
                isfinite(vm_sol) && vm_sol > 0 || continue

                ratio = vm_init / vm_sol
                if ratio > 10.0 || ratio < 0.1
                    n_level_mismatch += 1
                    push!(level_mismatch_locs,
                          "$bid.$t (vm_init=$(_fmt_v(vm_init)), vm_sol=$(_fmt_v(vm_sol)))")
                elseif abs(vm_init - vm_sol) / vm_sol > 0.20
                    n_large_error += 1
                    push!(large_error_locs,
                          "$bid.$t (vm_init=$(_fmt_v(vm_init)), vm_sol=$(_fmt_v(vm_sol)))")
                end
            end
        end

        out["n_init_level_mismatches"]  = n_level_mismatch
        out["n_init_large_errors"]      = n_large_error
        out["n_init_neutral_nonzero"]   = n_neutral_nonzero

        if n_level_mismatch > 0
            push!(findings, Finding(WARNING, "W.SOL.INIT_LEVEL_MISMATCH", :solution,
                :network, nothing,
                "$n_level_mismatch terminal(s) were initialised at a voltage more than " *
                "10× away from the solved value — the initialisation used the wrong " *
                "voltage level (source voltage applied to LV buses). Convergence to the " *
                "physical solution is not guaranteed; consider using per-unit mode or " *
                "level-aware initialisation.",
                Dict{String,Any}("terminals" => level_mismatch_locs)))
        end
        if n_large_error > 0
            push!(findings, Finding(WARNING, "W.SOL.INIT_LARGE_ERROR", :solution,
                :network, nothing,
                "$n_large_error phase terminal(s) have an initialisation error > 20 % " *
                "of the solved voltage magnitude — the starting point was a poor " *
                "approximation, which may slow convergence or indicate a local minimum.",
                Dict{String,Any}("terminals" => large_error_locs)))
        end
        if n_neutral_nonzero > 0
            push!(findings, Finding(INFO, "I.SOL.INIT_NEUTRAL_NONZERO", :solution,
                :network, nothing,
                "$n_neutral_nonzero neutral terminal(s) were initialised with non-zero " *
                "voltage — neutral start values should be zero.",
                Dict{String,Any}("terminals" => neutral_nonzero_locs)))
        end
    end

    # ── Informational: binding summary ────────────────────────────────────────
    n_violations = n_volt_viol + n_therm_viol + n_gen_viol
    n_active     = n_volt_active + n_therm_active + n_gen_active
    push!(findings, Finding(INFO, "I.SOL.BINDING_SUMMARY", :solution, :network, nothing,
        "Solution bound summary: $n_violations violation(s), $n_active active constraint(s). " *
        "Voltage: $(n_volt_viol)V / $(n_volt_active)A. " *
        "Thermal: $(n_therm_viol)V / $(n_therm_active)A. " *
        "Generator: $(n_gen_viol)V / $(n_gen_active)A.",
        Dict{String,Any}("n_volt_violations"=>n_volt_viol,"n_volt_active"=>n_volt_active,
                         "n_thermal_violations"=>n_therm_viol,"n_thermal_active"=>n_therm_active,
                         "n_gen_violations"=>n_gen_viol,"n_gen_active"=>n_gen_active)))

    # ── Informational: loss fraction ──────────────────────────────────────────
    if p_load > 0
        loss_frac = p_loss / p_load
        out["loss_fraction"] = loss_frac
        if loss_frac > 0.20
            push!(findings, Finding(INFO, "I.SOL.LOSS_FRACTION", :solution, :network, nothing,
                "Line losses are $(round(loss_frac*100; digits=1)) % of total load — " *
                "unusually high; verify impedance scaling and operating point.",
                Dict{String,Any}("loss_fraction"=>loss_frac,"p_loss"=>p_loss,"p_load"=>p_load)))
        end
    end

    # ── Informational: neutral shift ──────────────────────────────────────────
    max_neutral_vm = 0.0
    max_neutral_bus = ""
    for (bid, bus) in buses
        bus isa Dict || continue
        bid in source_buses && continue
        nt = _neutral_terminal(bus)
        nt === nothing && continue
        t_res = get(bus_res, bid, nothing)
        t_res isa Dict || continue
        vm_n = get(get(t_res, nt, Dict()), "vm", 0.0)
        isfinite(vm_n) && vm_n > max_neutral_vm && (max_neutral_vm = vm_n; max_neutral_bus = bid)
    end
    out["max_neutral_shift_v"] = max_neutral_vm
    out["max_neutral_shift_bus"] = max_neutral_bus
    if max_neutral_vm > 0.0
        push!(findings, Finding(INFO, "I.SOL.NEUTRAL_SHIFT", :solution, :network, nothing,
            "Maximum neutral terminal voltage: $(_fmt_v(max_neutral_vm)) at bus " *
            "'$max_neutral_bus' — reflects the neutral shift under unbalanced loading.",
            Dict{String,Any}("max_neutral_vm"=>max_neutral_vm,"bus"=>max_neutral_bus)))
    end

    out
end

# ── Formatting helpers (local to this file) ───────────────────────────────────
_fmt_v(v::Float64)  = "$(round(v; digits=2)) V"
_fmt_a(v::Float64)  = "$(round(v; digits=2)) A"
_fmt_mw(v::Float64) = abs(v) >= 1e6 ? "$(round(v/1e6; digits=3)) MW" :
                       abs(v) >= 1e3 ? "$(round(v/1e3; digits=3)) kW" :
                                       "$(round(v; digits=2)) W"
