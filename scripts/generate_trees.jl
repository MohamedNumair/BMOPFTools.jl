"""
Generate _tree.txt files for all BMOPF JSON files in output/.

Usage:
    julia --project scripts/generate_trees.jl
"""

using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))

using BMOPFTools

const OUTPUT_DIR = joinpath(@__DIR__, "..", "output")

json_files = String[]
for (root, dirs, files) in walkdir(OUTPUT_DIR)
    for f in files
        endswith(f, ".json") && push!(json_files, joinpath(root, f))
    end
end
sort!(json_files)

println("Generating ASCII trees for $(length(json_files)) networks…\n")

ok = 0; failed = 0
for path in json_files
    stem     = splitext(basename(path))[1]
    out_path = joinpath(dirname(path), stem * "_tree.txt")
    try
        net = parse_bmopf(path)
        n   = length(get(net, "bus", Dict()))
        open(out_path, "w") do io
            render_ascii_tree(net, io;
                max_buses    = 200,
                max_depth    = 10,
                fold_chains  = true,
                legend_limit = 50)
        end
        println("  ✓  $stem  ($n buses)")
        global ok += 1
    catch e
        println("  ✗  $stem  — $e")
        global failed += 1
    end
end

println("\nDone: $ok written, $failed failed.")
