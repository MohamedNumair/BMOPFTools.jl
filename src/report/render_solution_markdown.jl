# report/render_solution_markdown.jl

"""
    render_solution_markdown(report, io; verbose)

Write a Markdown-formatted OPF solution profile to `io`.
"""
function render_solution_markdown(report::SolutionReport, io::IO; verbose::Bool=true)
    name = something(report.network_name, "Unnamed Network")
    println(io, "# BMOPF Solution Profile: $name\n")
    println(io, "**Generated:** $(Dates.format(report.generated_at, "yyyy-mm-dd HH:MM:SS"))  ")

    meta = report.result_meta
    status = get(meta, "termination_status", "UNKNOWN")
    obj    = get(meta, "objective",          NaN)
    tsolve = get(meta, "solve_time",         NaN)
    println(io, "**Status:** `$status`  ")
    isfinite(obj)    && println(io, "**Objective:** $(round(obj; digits=4))  ")
    isfinite(tsolve) && println(io, "**Solve time:** $(round(tsolve; digits=3)) s  ")

    errs  = errors(report)
    warns = warnings(report)
    infs  = infos(report)
    println(io, "**Findings:** $(length(errs)) errors · $(length(warns)) warnings · $(length(infs)) info  ")
    println(io)
    println(io, "---\n")

    _sol_md_summary(report, io)
    _sol_md_voltage(report, io)
    _sol_md_thermal(report, io)
    _sol_md_generator(report, io)
    _sol_md_residuals(report, io)
    _sol_md_findings(report, io; verbose)
end

# ── 1. Solution summary ───────────────────────────────────────────────────────

function _sol_md_summary(r::SolutionReport, io::IO)
    d = get(r.results, :solution, nothing)
    d isa Dict || return
    println(io, "## 1. Solution Summary\n")

    status = get(d, "termination_status", "UNKNOWN")
    feasible = get(d, "feasible", false)
    println(io, "| Field | Value |")
    println(io, "|-------|-------|")
    println(io, "| Status | `$status` |")

    p_gen  = get(d, "p_gen",  NaN)
    p_load = get(d, "p_load", NaN)
    p_loss = get(d, "p_loss", NaN)
    lf     = get(d, "loss_fraction", NaN)
    bal    = get(d, "power_balance_err", NaN)

    isfinite(p_gen)  && println(io, "| Total generation | $(_fmt_mw(p_gen)) |")
    isfinite(p_load) && println(io, "| Total load | $(_fmt_mw(p_load)) |")
    isfinite(p_loss) && println(io, "| Total line losses | $(_fmt_mw(p_loss)) |")
    isfinite(lf)     && println(io, "| Loss fraction | $(_fmt_pct(lf * 100)) |")
    isfinite(bal)    && println(io, "| Power balance error | $(_fmt_mw(bal)) |")

    vn_v = get(d, "max_neutral_shift_v",   NaN)
    vn_b = get(d, "max_neutral_shift_bus", "")
    if isfinite(vn_v) && vn_v > 0
        println(io, "| Max neutral shift | $(round(vn_v; digits=3)) V (bus `$vn_b`) |")
    end

    println(io)

    if feasible
        n_vv = get(d, "n_volt_violations",    0)
        n_va = get(d, "n_volt_active",        0)
        n_tv = get(d, "n_thermal_violations", 0)
        n_ta = get(d, "n_thermal_active",     0)
        n_gv = get(d, "n_gen_violations",     0)
        n_ga = get(d, "n_gen_active",         0)
        println(io, "### Bound status\n")
        println(io, "| Category | Violated | Active (≤1 %) |")
        println(io, "|----------|:--------:|:-------------:|")
        println(io, "| Voltage  | $n_vv | $n_va |")
        println(io, "| Thermal  | $n_tv | $n_ta |")
        println(io, "| Generator| $n_gv | $n_ga |")
        println(io)
    end
end

# ── 2. Voltage bound findings ─────────────────────────────────────────────────

function _sol_md_voltage(r::SolutionReport, io::IO)
    volt_findings = filter(f -> f.code in ("E.SOL.VOLT_VIOLATION", "W.SOL.VOLT_ACTIVE"),
                           r.findings)
    isempty(volt_findings) && return
    println(io, "## 2. Voltage Bounds\n")
    println(io, "| Sev | Bus | Terminal/Seq | Flavour | Value | Bound |")
    println(io, "|-----|-----|-------------|---------|-------|-------|")
    for f in volt_findings
        sev  = f.severity == ERROR ? "**E**" : "W"
        bid  = get(f.detail, "bus", "?")
        flav = get(f.detail, "flavour", "vm")
        t    = get(f.detail, "terminal", get(f.detail, "pair",
               get(f.detail, "sequence", "?")))
        val  = get(f.detail, "vm",
               get(f.detail, "vpn",
               get(f.detail, "vpp",
               get(f.detail, "value", NaN))))
        lo   = get(f.detail, "v_min",     get(f.detail, "vpn_min",
               get(f.detail, "vpp_min",   get(f.detail, "bound_min", nothing))))
        hi   = get(f.detail, "v_max",     get(f.detail, "vpn_max",
               get(f.detail, "vpp_max",   get(f.detail, "bound_max", nothing))))
        val_s = isfinite(val) ? "$(round(val; digits=2)) V" : "?"
        lo_s  = lo !== nothing ? "$(round(Float64(lo); digits=2))" : "−∞"
        hi_s  = hi !== nothing ? "$(round(Float64(hi); digits=2))" : "+∞"
        println(io, "| $sev | `$bid` | `$t` | $flav | $val_s | [$lo_s, $hi_s] V |")
    end
    println(io)
end

# ── 3. Thermal limit findings ─────────────────────────────────────────────────

function _sol_md_thermal(r::SolutionReport, io::IO)
    therm_findings = filter(f -> f.code in ("E.SOL.THERMAL_VIOLATION", "W.SOL.THERMAL_ACTIVE"),
                            r.findings)
    isempty(therm_findings) && return
    println(io, "## 3. Thermal Limits\n")
    println(io, "| Sev | Component | ID | Terminal | cm (A) | i\\_max (A) |")
    println(io, "|-----|-----------|----|---------:|-------:|----------:|")
    for f in therm_findings
        sev   = f.severity == ERROR ? "**E**" : "W"
        ctype = string(f.component_type)
        cid   = something(f.component_id, "?")
        t     = get(f.detail, "terminal", "?")
        cm    = get(f.detail, "cm_fr", get(f.detail, "cm", NaN))
        ilim  = get(f.detail, "i_max", NaN)
        cm_s  = isfinite(cm)   ? "$(round(cm;   digits=2))" : "?"
        il_s  = isfinite(ilim) ? "$(round(ilim; digits=2))" : "?"
        println(io, "| $sev | $ctype | `$cid` | `$t` | $cm_s | $il_s |")
    end
    println(io)
end

# ── 4. Generator dispatch findings ────────────────────────────────────────────

function _sol_md_generator(r::SolutionReport, io::IO)
    gen_findings = filter(f -> f.code in ("E.SOL.GEN_VIOLATION", "W.SOL.GEN_ACTIVE"),
                          r.findings)
    isempty(gen_findings) && return
    println(io, "## 4. Generator Dispatch\n")
    println(io, "| Sev | Generator | Terminal | Field | Value | Bound |")
    println(io, "|-----|-----------|----------|-------|-------|-------|")
    for f in gen_findings
        sev   = f.severity == ERROR ? "**E**" : "W"
        gid   = something(f.component_id, "?")
        t     = get(f.detail, "terminal", "?")
        field = get(f.detail, "field",    "?")
        v     = get(f.detail, "value",    NaN)
        lo    = get(f.detail, "lo",       nothing)
        hi    = get(f.detail, "hi",       nothing)
        v_s   = isfinite(v) ? _fmt_mw(v) : "?"
        lo_s  = lo !== nothing ? _fmt_mw(Float64(lo)) : "−∞"
        hi_s  = hi !== nothing ? _fmt_mw(Float64(hi)) : "+∞"
        println(io, "| $sev | `$gid` | `$t` | $field | $v_s | [$lo_s, $hi_s] |")
    end
    println(io)
end

# ── 5. Constraint residuals ───────────────────────────────────────────────────

function _sol_md_residuals(r::SolutionReport, io::IO)
    resid_findings = filter(f -> f.code == "W.SOL.LOAD_RESIDUAL", r.findings)
    bal_findings   = filter(f -> f.code == "W.SOL.POWER_BALANCE", r.findings)
    isempty(resid_findings) && isempty(bal_findings) && return
    println(io, "## 5. Constraint Residuals\n")
    if !isempty(bal_findings)
        for f in bal_findings
            println(io, "> ⚠ $(f.message)")
        end
        println(io)
    end
    if !isempty(resid_findings)
        println(io, "| Load | Terminal | |Δp| (W) | |Δq| (var) |")
        println(io, "|------|----------|--------:|----------:|")
        for f in resid_findings
            lid   = something(f.component_id, "?")
            t     = get(f.detail, "terminal", "?")
            p_err = get(f.detail, "p_err",    NaN)
            q_err = get(f.detail, "q_err",    NaN)
            pe_s  = isfinite(p_err) ? "$(round(p_err; digits=3))" : "?"
            qe_s  = isfinite(q_err) ? "$(round(q_err; digits=3))" : "?"
            println(io, "| `$lid` | `$t` | $pe_s | $qe_s |")
        end
        println(io)
    end
end

# ── 6. All findings ───────────────────────────────────────────────────────────

function _sol_md_findings(r::SolutionReport, io::IO; verbose::Bool=true)
    fs = verbose ? r.findings : filter(f -> f.severity != INFO, r.findings)
    isempty(fs) && return
    println(io, "## 6. All Findings\n")
    for f in fs
        sev_label = f.severity == ERROR   ? "**ERROR**" :
                    f.severity == WARNING  ? "**WARN**"  : "INFO"
        id_str = f.component_id !== nothing ? " — $(f.component_type)/`$(f.component_id)`" : ""
        println(io, "- $sev_label `$(f.code)`$id_str  ")
        println(io, "  $(f.message)")
    end
    println(io)
end
