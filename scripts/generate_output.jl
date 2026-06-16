"""
    generate_output.jl

Regenerate all BMOPF output data from the flat JSON files in output/.

For each network the script produces:

    output/<dataset>/original/<name>.json       pretty-printed source network
    output/<dataset>/original/<name>_report.md  analysis report
    output/<dataset>/original/<name>_tree.txt   ASCII topology tree
    output/<dataset>/reduced/<name>.json        fully simplified network
    output/<dataset>/reduced/<name>_report.md   analysis report
    output/<dataset>/reduced/<name>_tree.txt    ASCII topology tree

"Reduced" means simplify_network with all four operations (collapse closed
switches, remove open switches, remove dangling lines, merge series lines).

Input: every *.json file found directly inside an output/<dataset>/ folder
       (one level deep — does not recurse into existing original/reduced dirs).

Usage:
    julia --project scripts/generate_output.jl
"""

using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))

using BMOPFTools

const OUTPUT_DIR = joinpath(@__DIR__, "..", "output")

const TREE_OPTS = (
    max_buses   = 200,
    max_depth   = 10,
    fold_chains = true,
    legend_limit = 50,
)

# ── helpers ──────────────────────────────────────────────────────────────────

function write_variant(net, dir, stem)
    mkpath(dir)
    write_bmopf(net, joinpath(dir, stem * ".json"))
    report = analyze(net)
    render(report, joinpath(dir, stem * "_report.md"))
    open(joinpath(dir, stem * "_tree.txt"), "w") do io
        render_ascii_tree(net, io; TREE_OPTS...)
    end
end

function simplification_summary(net_orig, net_red)
    buses_before = length(get(net_orig, "bus",  Dict()))
    buses_after  = length(get(net_red,  "bus",  Dict()))
    lines_before = length(get(net_orig, "line", Dict()))
    lines_after  = length(get(net_red,  "line", Dict()))
    log          = get(net_red, "_simplification_log", [])
    n_ops        = length(log)
    (buses_before=buses_before, buses_after=buses_after,
     lines_before=lines_before, lines_after=lines_after,
     n_ops=n_ops)
end

# ── discover source files ─────────────────────────────────────────────────────
# Only read *.json files one level inside output/<dataset>/ — skip the
# original/ and reduced/ subdirectories we are about to (re)create.

source_files = Tuple{String,String,String}[]   # (dataset_dir, stem, path)

for entry in readdir(OUTPUT_DIR; join=true)
    isdir(entry) || continue
    basename(entry) in ("original", "reduced") && continue
    for f in readdir(entry; join=true)
        isfile(f) && endswith(f, ".json") || continue
        stem = splitext(basename(f))[1]
        push!(source_files, (entry, stem, f))
    end
end
sort!(source_files; by = t -> (t[1], t[2]))

println("Found $(length(source_files)) source networks across " *
        "$(length(unique(t[1] for t in source_files))) datasets.\n")

# ── process ───────────────────────────────────────────────────────────────────

let ok = 0, failed = 0
    for (dataset_dir, stem, src_path) in source_files
        dataset = basename(dataset_dir)
        print("  $dataset / $stem … ")
        try
            net_orig = parse_bmopf(src_path)
            net_red  = simplify_network(net_orig)

            orig_dir = joinpath(dataset_dir, "original")
            red_dir  = joinpath(dataset_dir, "reduced")

            write_variant(net_orig, orig_dir, stem)
            write_variant(net_red,  red_dir,  stem)

            s = simplification_summary(net_orig, net_red)
            Δbuses = s.buses_before - s.buses_after
            Δlines = s.lines_before - s.lines_after
            println("✓  buses $(s.buses_before)→$(s.buses_after) (-$Δbuses)" *
                    "  lines $(s.lines_before)→$(s.lines_after) (-$Δlines)" *
                    "  ops=$(s.n_ops)")
            ok += 1
        catch e
            println("✗  $e")
            failed += 1
        end
    end

    println("\nDone: $ok networks processed, $failed failed.")
    println("Output written to $OUTPUT_DIR/<dataset>/{original,reduced}/")
end
