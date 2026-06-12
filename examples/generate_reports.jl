# =============================================================================
# Batch report + BMOPF JSON generation for all test cases
# =============================================================================
# For every standalone test case in test/data (33 LV feeders) plus the
# combined MV+LV system (test/data/Master.dss), this script:
#   1. parses the OpenDSS master via PowerModelsDistribution (4-wire),
#   2. converts to a BMOPF dict with `from_pmd`,
#   3. writes the BMOPF-compliant JSON to output/<group>/<case>.json,
#   4. runs `analyze` and writes the Markdown report to
#      output/<group>/<case>_report.md.
#
# Run from the repository root (parent project, which has PMD):
#   julia --project=. BMOPFTools/examples/generate_reports.jl
# =============================================================================

using BMOPFTools
using PowerModelsDistribution
using Logging

const DATA_DIR   = normpath(joinpath(@__DIR__, "..", "test", "data"))
const OUTPUT_DIR = normpath(joinpath(@__DIR__, "..", "output"))

# Collect cases: (group, case_name, path_to_master). Any directory under
# test/data containing a Master.dss is a case; the first path component is
# the group (LV, MV, ENWL, …) and deeper nesting is flattened into the case
# name (e.g. ENWL/network_3/Feeder_2 → "network_3_Feeder_2").
cases = Tuple{String,String,String}[]
for (root, dirs, files) in walkdir(DATA_DIR)
    "Master.dss" in files || continue
    master = joinpath(root, "Master.dss")
    rel = relpath(root, DATA_DIR)
    if rel == "."
        push!(cases, ("combined", "MV_LV_combined", master))
    else
        parts = splitpath(rel)
        push!(cases, (parts[1], join(parts[2:end], "_"), master))
    end
end
sort!(cases)

println("Found $(length(cases)) case(s). Output → $(relpath(OUTPUT_DIR))\n")

# PMD's parser is chatty (basefreq mismatches, reactor-as-line warnings, …);
# keep the console output to one summary line per case.
summary = NamedTuple[]
for (group, case, master) in cases
    out_dir = joinpath(OUTPUT_DIR, group)
    mkpath(out_dir)
    json_path = joinpath(out_dir, "$case.json")
    md_path   = joinpath(out_dir, "$(case)_report.md")

    t0 = time()
    try
        eng, net, report = with_logger(NullLogger()) do
            eng = parse_file(master; kron_reduce=false)
            net = from_pmd(eng)
            net["name"] = case
            (eng, net, analyze(net))
        end

        write_bmopf(net, json_path)
        render(report, md_path)

        n_bus  = length(get(net, "bus", Dict()))
        n_err  = length(errors(report))
        n_warn = length(warnings(report))
        dt     = round(time() - t0, digits=1)
        push!(summary, (; group, case, n_bus, n_err, n_warn, status="ok"))
        println(rpad("$group/$case", 32),
                rpad("$n_bus buses", 12),
                rpad("$n_err err / $n_warn warn", 18),
                "$(dt)s")
    catch e
        push!(summary, (; group, case, n_bus=0, n_err=-1, n_warn=-1, status="FAILED"))
        println(rpad("$group/$case", 32), "FAILED: ", sprint(showerror, e)[1:min(end,120)])
    end
end

# ---------------------------------------------------------------------------
# Roll-up
# ---------------------------------------------------------------------------
n_ok     = count(s -> s.status == "ok", summary)
n_failed = length(summary) - n_ok
n_clean  = count(s -> s.status == "ok" && s.n_err == 0, summary)

println("\n", "─"^70)
println("Generated $n_ok of $(length(summary)) case(s)",
        n_failed > 0 ? "  ($n_failed FAILED)" : "")
println("$n_clean case(s) with zero ERROR findings")

with_err = [s for s in summary if s.status == "ok" && s.n_err > 0]
if !isempty(with_err)
    println("\nCases with ERROR findings (see their _report.md for details):")
    for s in with_err
        println("  $(s.group)/$(s.case): $(s.n_err) error(s)")
    end
end
