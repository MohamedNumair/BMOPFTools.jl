"""
    solve_benchmark_opf.jl

Solve each reduced BMOPF network in output/ENWLbenchmark/reduced/ using
Ipopt, in both SI units and per-unit formulations.  Results are written to:

    output/ENWLbenchmark/opf_results.json    — raw result table (JSON)
    output/ENWLbenchmark/opf_comparison.md   — markdown comparison table

Each solve prints a live Ipopt iteration ticker so it is clear whether the
solver is making progress or spinning at the iteration limit.

Usage:
    julia scripts/solve_benchmark_opf.jl
"""

using Pkg
Pkg.activate(@__DIR__)   # scripts/Project.toml — includes BMOPFTools + JuMP + Ipopt

using BMOPFTools
using JuMP, Ipopt
using JSON3
using Printf

const REDUCED_DIR  = joinpath(@__DIR__, "..", "output", "ENWLbenchmark", "reduced")
const RESULT_JSON  = joinpath(@__DIR__, "..", "output", "ENWLbenchmark", "opf_results.json")
const REPORT_MD    = joinpath(@__DIR__, "..", "output", "ENWLbenchmark", "opf_comparison.md")

const SOLVED_STATUSES = ("LOCALLY_SOLVED", "OPTIMAL")

# ── Ipopt options ─────────────────────────────────────────────────────────────
# max_iter: cap so a diverging solve fails fast rather than spinning
# print_level: 5 = one line per iteration to stdout — lets us see live progress
#              and distinguish a converging solve from one stuck at the limit
const IPOPT_MAX_ITER  = 500
const IPOPT_PRINT_LVL = 0   # silent — progress shown by the ✓/✗ lines below

function _make_optimizer()
    optimizer_with_attributes(
        Ipopt.Optimizer,
        "max_iter"    => IPOPT_MAX_ITER,
        "print_level" => IPOPT_PRINT_LVL,
    )
end

# ── solve helper ──────────────────────────────────────────────────────────────
function run_solve(net, per_unit)
    status = "ERROR"
    obj    = nothing
    t0     = time()
    try
        res    = solve_opf(net; optimizer=_make_optimizer(), per_unit=per_unit)
        status = res["termination_status"]
        obj    = res["objective"]
    catch e
        status = "ERROR: $(sprint(showerror, e))"
    end
    elapsed = round(time() - t0; digits=1)
    return status, obj, elapsed
end

# ── discover source files ─────────────────────────────────────────────────────
json_files = sort([
    f for f in readdir(REDUCED_DIR; join=true)
    if isfile(f) && endswith(f, ".json")
])

n = length(json_files)
println("Solving $n reduced benchmark networks with Ipopt (max_iter=$IPOPT_MAX_ITER)...\n")

struct Row
    name         ::String
    n_buses      ::Int
    n_gens       ::Int
    status_si    ::String
    objective_si ::Union{Float64,Nothing}
    time_si      ::Float64
    status_pu    ::String
    objective_pu ::Union{Float64,Nothing}
    time_pu      ::Float64
end

rows = Row[]

for (i, src) in enumerate(json_files)
    stem = splitext(basename(src))[1]
    net  = parse_bmopf(src)
    n_buses = length(get(net, "bus",       Dict()))
    n_gens  = length(get(net, "generator", Dict()))

    @printf("[%3d/%d] %s  (%d buses, %d gens)\n", i, n, stem, n_buses, n_gens)

    # ── SI ────────────────────────────────────────────────────────────────────
    print("         SI  … ")
    flush(stdout)
    status_si, obj_si, t_si = run_solve(net, false)
    ok_si = status_si in SOLVED_STATUSES
    if ok_si
        @printf("✓ %+.6e  (%.1fs)\n", obj_si, t_si)
    else
        @printf("✗ %s  (%.1fs)\n", status_si, t_si)
    end

    # ── per-unit ──────────────────────────────────────────────────────────────
    print("         PU  … ")
    flush(stdout)
    status_pu, obj_pu, t_pu = run_solve(net, true)
    ok_pu = status_pu in SOLVED_STATUSES
    if ok_pu
        @printf("✓ %+.6e  (%.1fs)\n", obj_pu, t_pu)
    else
        @printf("✗ %s  (%.1fs)\n", status_pu, t_pu)
    end

    println()
    push!(rows, Row(stem, n_buses, n_gens,
                    status_si, obj_si, t_si,
                    status_pu, obj_pu, t_pu))

    # Flush results to JSON after every case so a crash doesn't lose progress
    json_rows = [
        Dict("name"         => r.name,
             "n_buses"      => r.n_buses,
             "n_gens"       => r.n_gens,
             "status_si"    => r.status_si,
             "objective_si" => r.objective_si,
             "time_si_s"    => r.time_si,
             "status_pu"    => r.status_pu,
             "objective_pu" => r.objective_pu,
             "time_pu_s"    => r.time_pu)
        for r in rows
    ]
    open(RESULT_JSON, "w") do io; JSON3.pretty(io, json_rows); end
end

# ── Markdown report ───────────────────────────────────────────────────────────
function fmt_obj(status, obj)
    status in SOLVED_STATUSES || return "`$(split(status, ':')[1])`"
    obj === nothing && return "—"
    @sprintf("%.6g", obj)
end

function fmt_delta(obj_si, obj_pu)
    (obj_si === nothing || obj_pu === nothing) && return "—"
    abs(obj_si) < 1e-12 && return "—"
    @sprintf("%+.4f%%", (obj_pu - obj_si) / abs(obj_si) * 100)
end

n_solved_si = count(r -> r.status_si in SOLVED_STATUSES, rows)
n_solved_pu = count(r -> r.status_pu in SOLVED_STATUSES, rows)

open(REPORT_MD, "w") do io
    println(io, "# ENWL Benchmark OPF Results (reduced networks)")
    println(io, "")
    println(io, "Solver: **Ipopt** (local NLP, AC rectangular power flow)  ")
    println(io, "Networks: simplified via `simplify_network` (series merge, dangling removal)  ")
    println(io, "Formulation: 4-wire, phase-to-neutral voltage bounds, single-phase DERs  ")
    println(io, raw"Objective: minimise total generation cost ($/s)  ")
    println(io, "Max iterations: $IPOPT_MAX_ITER")
    println(io, "")
    println(io, raw"| Network | Buses | Gens | SI status | Obj SI ($/s) | SI time | PU status | Obj PU ($/s) | PU time | Δ (PU−SI)/SI |")
    println(io,   "|---------|------:|-----:|-----------|-------------:|--------:|-----------|-------------:|--------:|-------------|")
    for r in rows
        ok_si  = r.status_si in SOLVED_STATUSES ? "✓" : "✗"
        ok_pu  = r.status_pu in SOLVED_STATUSES ? "✓" : "✗"
        si_str = fmt_obj(r.status_si, r.objective_si)
        pu_str = fmt_obj(r.status_pu, r.objective_pu)
        delta  = fmt_delta(r.objective_si, r.objective_pu)
        @printf(io, "| %s | %d | %d | %s | %s | %.1fs | %s | %s | %.1fs | %s |\n",
                r.name, r.n_buses, r.n_gens,
                ok_si, si_str, r.time_si,
                ok_pu, pu_str, r.time_pu,
                delta)
    end
    println(io, "")
    println(io, "**Summary:** $(n_solved_si)/$(length(rows)) solved in SI, " *
                "$(n_solved_pu)/$(length(rows)) solved in per-unit.")
end

println("Results: $RESULT_JSON")
println("Report:  $REPORT_MD")
println("Done.")
