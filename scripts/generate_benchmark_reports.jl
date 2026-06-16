"""
    generate_benchmark_reports.jl

Read each enriched BMOPF JSON from output/ENWLbenchmark/ and write a
companion markdown report alongside it.

Output per file:
    output/ENWLbenchmark/<name>_report.md

Usage:
    julia --project scripts/generate_benchmark_reports.jl
"""

using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))

using BMOPFTools

const BENCH_DIR = joinpath(@__DIR__, "..", "output", "ENWLbenchmark")

json_files = sort([
    f for f in readdir(BENCH_DIR; join=true)
    if isfile(f) && endswith(f, ".json")
])

println("Found $(length(json_files)) benchmark networks.\n")

let ok = 0, failed = 0
    for src in json_files
        stem = splitext(basename(src))[1]
        report_path = joinpath(BENCH_DIR, stem * "_report.md")
        print("  $stem … ")
        try
            net    = parse_bmopf(src)
            report = analyze(net)
            render(report, report_path)
            n_buses = length(get(net, "bus",       Dict()))
            n_gens  = length(get(net, "generator", Dict()))
            println("✓  buses=$n_buses  generators=$n_gens")
            ok += 1
        catch e
            println("✗  $e")
            failed += 1
        end
    end

    println("\nDone: $ok reports written, $failed failed.")
    println("Output: $BENCH_DIR")
end
