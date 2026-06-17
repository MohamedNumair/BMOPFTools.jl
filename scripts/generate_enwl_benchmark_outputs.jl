"""
    generate_enwl_benchmark_outputs.jl

Pipeline 2: generate analysis reports, ASCII trees, simplified variants, and
reduction logs for the ENWLbenchmark cases.

These are enriched OPF-ready BMOPF JSON cases (voltage bounds, cable ampacity,
DER generators) produced by scripts/generate_enwl_benchmark.py. There are no
matching OpenDSS source files, so this script reads the existing JSONs directly.

Input:  output/ENWLbenchmark/*.json  (enriched cases, excluding *_results*)
Output per case:
  output/ENWLbenchmark/original/<stem>.json
  output/ENWLbenchmark/original/<stem>_report.md
  output/ENWLbenchmark/original/<stem>_tree.txt
  output/ENWLbenchmark/reduced/<stem>.json
  output/ENWLbenchmark/reduced/<stem>_report.md
  output/ENWLbenchmark/reduced/<stem>_tree.txt
  output/ENWLbenchmark/reduced/<stem>_reduction.md

Usage:
    julia --project scripts/generate_enwl_benchmark_outputs.jl
"""

using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))

using BMOPFTools
using Dates

const BENCH_DIR = joinpath(@__DIR__, "..", "output", "ENWLbenchmark")

const TREE_OPTS = (
    max_buses    = 200,
    max_depth    = 10,
    fold_chains  = true,
    legend_limit = 50,
)

# ── Reduction log renderer ────────────────────────────────────────────────────

function write_reduction_md(net_orig, net_red, path)
    log = get(net_red, "_simplification_log", [])
    b0  = length(get(net_orig, "bus",  Dict()))
    b1  = length(get(net_red,  "bus",  Dict()))
    l0  = length(get(net_orig, "line", Dict()))
    l1  = length(get(net_red,  "line", Dict()))

    op_counts = Dict{String,Int}()
    for e in log
        op = get(e, "operation", "unknown")
        op_counts[op] = get(op_counts, op, 0) + 1
    end

    open(path, "w") do io
        name = get(net_red, "name", basename(path))
        println(io, "# Simplification log: $name\n")
        println(io, "**Generated:** $(Dates.format(now(), "yyyy-mm-dd HH:MM:SS"))  ")
        println(io, "**Buses:** $b0 → $b1 (−$(b0 - b1))  ")
        println(io, "**Lines:** $l0 → $l1 (−$(l0 - l1))  ")
        println(io, "**Operations:** $(length(log))\n")
        println(io, "## Summary by operation\n")
        println(io, "| Operation | Count |")
        println(io, "|-----------|------:|")
        for op in sort(collect(keys(op_counts)))
            println(io, "| `$op` | $(op_counts[op]) |")
        end
        println(io)
        if !isempty(log)
            println(io, "## Operation log\n")
            println(io, "| # | Operation | Element | Message |")
            println(io, "|--:|-----------|---------|---------|")
            for (i, e) in enumerate(log)
                op    = get(e, "operation",    "")
                etype = get(e, "element_type", "")
                eid   = get(e, "element_id",   "")
                msg   = get(e, "message",      "")
                println(io, "| $i | `$op` | $etype `$eid` | $msg |")
            end
            println(io)
        end
    end
end

# ── Discover source files ─────────────────────────────────────────────────────
# Read *.json from the root of ENWLbenchmark/, skipping results files and
# anything already inside original/ or reduced/.

orig_dir = joinpath(BENCH_DIR, "original")
red_dir  = joinpath(BENCH_DIR, "reduced")

source_files = sort([
    f for f in readdir(orig_dir; join=true)
    if isfile(f) && endswith(f, ".json") &&
       !occursin("_results", basename(f)) &&
       !occursin("_opf", basename(f)) &&
       !occursin("_report", basename(f))
])

println("Found $(length(source_files)) ENWLbenchmark case(s).\n")

mkpath(orig_dir)
mkpath(red_dir)

let ok = 0, failed = 0
    for src in source_files
        stem = splitext(basename(src))[1]
        print("  $stem … ")
        t0 = time()
        try
            net_orig = parse_bmopf(src)
            net_red  = simplify_network(net_orig)

            # Original
            write_bmopf(net_orig, joinpath(orig_dir, stem * ".json"))
            render(analyze(net_orig), joinpath(orig_dir, stem * "_report.md"))
            open(joinpath(orig_dir, stem * "_tree.txt"), "w") do io
                render_ascii_tree(net_orig, io; TREE_OPTS...)
            end

            # Reduced
            write_bmopf(net_red, joinpath(red_dir, stem * ".json"))
            render(analyze(net_red), joinpath(red_dir, stem * "_report.md"))
            open(joinpath(red_dir, stem * "_tree.txt"), "w") do io
                render_ascii_tree(net_red, io; TREE_OPTS...)
            end
            write_reduction_md(net_orig, net_red, joinpath(red_dir, stem * "_reduction.md"))

            b0 = length(get(net_orig, "bus",  Dict()))
            b1 = length(get(net_red,  "bus",  Dict()))
            l0 = length(get(net_orig, "line", Dict()))
            l1 = length(get(net_red,  "line", Dict()))
            dt = round(time() - t0; digits=1)
            println("✓  buses $(b0)→$(b1) (-$(b0-b1))" *
                    "  lines $(l0)→$(l1) (-$(l0-l1))  $(dt)s")
            ok += 1
        catch e
            println("✗")
            @error "Failed: $stem" exception=(e, catch_backtrace())
            failed += 1
        end
    end

    println("\nDone: $ok processed, $failed failed.")
    println("Output written to $BENCH_DIR/{original,reduced}/")
end
