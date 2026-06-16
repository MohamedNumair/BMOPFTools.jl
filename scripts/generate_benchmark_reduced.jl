"""
    generate_benchmark_reduced.jl

Simplify each enriched BMOPF network in output/ENWLbenchmark/ using all four
simplification operations (collapse closed switches, remove open switches,
remove dangling lines, merge series lines) and write the reduced networks to
output/ENWLbenchmark/reduced/.

Output per file:
    output/ENWLbenchmark/reduced/<name>.json
    output/ENWLbenchmark/reduced/<name>_report.md

Usage:
    julia --project scripts/generate_benchmark_reduced.jl
"""

using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))

using BMOPFTools

const BENCH_DIR  = joinpath(@__DIR__, "..", "output", "ENWLbenchmark")
const REDUCED_DIR = joinpath(BENCH_DIR, "reduced")

mkpath(REDUCED_DIR)

json_files = sort([
    f for f in readdir(BENCH_DIR; join=true)
    if isfile(f) && endswith(f, ".json") && !endswith(f, "opf_results.json")
])

println("Simplifying $(length(json_files)) benchmark networks...\n")

let ok = 0, failed = 0
    for src in json_files
        stem = splitext(basename(src))[1]
        print("  $stem … ")
        try
            net_orig = parse_bmopf(src)
            net_red  = simplify_network(net_orig)

            out_json   = joinpath(REDUCED_DIR, stem * ".json")
            out_report = joinpath(REDUCED_DIR, stem * "_report.md")

            write_bmopf(net_red, out_json)
            report = analyze(net_red)
            render(report, out_report)

            b0 = length(get(net_orig, "bus",  Dict()))
            b1 = length(get(net_red,  "bus",  Dict()))
            l0 = length(get(net_orig, "line", Dict()))
            l1 = length(get(net_red,  "line", Dict()))
            println("✓  buses $(b0)→$(b1) (-$(b0-b1))  lines $(l0)→$(l1) (-$(l0-l1))")
            ok += 1
        catch e
            println("✗  $e")
            failed += 1
        end
    end

    println("\nDone: $ok simplified, $failed failed.")
    println("Output: $REDUCED_DIR")
end
