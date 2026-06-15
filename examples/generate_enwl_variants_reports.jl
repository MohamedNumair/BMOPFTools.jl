# =============================================================================
# Report + BMOPF JSON generation for ENWLvariants test cases
#
# Processes three impedance-transformation variants of the ENWL low-voltage
# feeders (Three-wire-Kron-reduced, Three-wire-phase-to-neutral,
# Three-wire-modified-phase-to-neutral), each containing 25 networks and
# 4-5 feeders each (128 cases per variant, 384 total).
#
# Each case produces:
#   output/ENWLvariants/<variant>/<network>_<feeder>.json
#   output/ENWLvariants/<variant>/<network>_<feeder>_report.md
#
# Run from the repository root (project that has PowerModelsDistribution):
#   julia --project=. BMOPFTools/examples/generate_enwl_variants_reports.jl
# =============================================================================

using BMOPFTools
using PowerModelsDistribution
using Logging

const DATA_DIR   = normpath(joinpath(@__DIR__, "..", "test", "data",
                                     "ENWLvariants"))
const OUTPUT_DIR = normpath(joinpath(@__DIR__, "..", "output", "ENWLvariants"))

isdir(DATA_DIR) || error("ENWLvariants data not found at $DATA_DIR")

# Collect (variant, network_feeder_name, master_path) for every Master.dss
cases = Tuple{String,String,String}[]
for (root, dirs, files) in walkdir(DATA_DIR)
    "Master.dss" in files || continue
    master = joinpath(root, "Master.dss")
    rel    = relpath(root, DATA_DIR)
    parts  = splitpath(rel)            # [variant, network, feeder]
    variant   = parts[1]
    case_name = join(parts[2:end], "_")
    push!(cases, (variant, case_name, master))
end
sort!(cases)

println("Found $(length(cases)) ENWLvariants case(s).")
println("Output → $(relpath(OUTPUT_DIR))\n")

summary = NamedTuple[]
for (variant, case, master) in cases
    out_dir   = joinpath(OUTPUT_DIR, variant)
    mkpath(out_dir)
    json_path = joinpath(out_dir, "$case.json")
    md_path   = joinpath(out_dir, "$(case)_report.md")

    t0 = time()
    try
        eng, net, report = with_logger(NullLogger()) do
            eng = parse_file(master; kron_reduce=false)
            net = from_pmd(eng)
            net["name"] = "$variant/$case"
            (eng, net, analyze(net))
        end

        write_bmopf(net, json_path)
        render(report, md_path)

        n_bus  = length(get(net, "bus",  Dict()))
        n_err  = length(errors(report))
        n_warn = length(warnings(report))
        dt     = round(time() - t0, digits=2)

        # Extract impedance transform type from the provenance result
        prov   = get(report.results, :provenance, Dict())
        itrans = get(prov, "impedance_transform", Dict())
        types  = sort(collect(keys(get(itrans, "by_type", Dict()))))
        it_str = isempty(types) ? "?" : join(types, "+")

        push!(summary, (; variant, case, n_bus, n_err, n_warn, it_str, status="ok"))
        println(rpad("$(variant[end-2:end])/$(case)", 36),
                rpad("$n_bus buses", 10),
                rpad("$n_err E / $n_warn W", 14),
                rpad("[$(it_str)]", 32),
                "$(dt)s")
    catch e
        push!(summary, (; variant, case, n_bus=0, n_err=-1, n_warn=-1,
                          it_str="", status="FAILED"))
        println(rpad("$(variant)/$(case)", 36), "FAILED: ",
                sprint(showerror, e)[1:min(end, 100)])
    end
end

# ---------------------------------------------------------------------------
# Summary by variant
# ---------------------------------------------------------------------------
println("\n", "─"^80)
n_ok     = count(s -> s.status == "ok", summary)
n_failed = length(summary) - n_ok
println("Generated $n_ok of $(length(summary)) case(s)",
        n_failed > 0 ? "  ($n_failed FAILED)" : "")

for variant in unique(s.variant for s in summary)
    vsub = [s for s in summary if s.variant == variant && s.status == "ok"]
    isempty(vsub) && continue
    n_clean = count(s -> s.n_err == 0, vsub)
    type_counts = Dict{String,Int}()
    for s in vsub
        type_counts[s.it_str] = get(type_counts, s.it_str, 0) + 1
    end
    tc_str = join(["$t×$(n)" for (t, n) in sort(collect(type_counts))], ", ")
    println("  $(rpad(variant, 40)) $(length(vsub)) cases, " *
            "$n_clean clean — [$tc_str]")
end
