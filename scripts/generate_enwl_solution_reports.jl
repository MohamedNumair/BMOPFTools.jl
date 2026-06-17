"""
    generate_enwl_solution_reports.jl

Solve the OPF for each reduced ENWLbenchmark case and write a solution
profile report alongside it.

For each network in output/ENWLbenchmark/reduced/:
  1. Parse the BMOPF JSON
  2. Solve the IVR-EN OPF with Ipopt (SI units)
  3. Call profile_solution to flag bound violations, near-active constraints,
     residuals, and solution quality issues
  4. Write the Markdown solution report

Output per case:
  output/ENWLbenchmark/reduced/<stem>_solution.md

Requires JuMP and Ipopt in the active environment:
    julia --project scripts/generate_enwl_solution_reports.jl

(The scripts/ Project.toml already includes JuMP and Ipopt.)
"""

using Pkg
Pkg.activate(@__DIR__)   # scripts/Project.toml — includes BMOPFTools + JuMP + Ipopt

using BMOPFTools
using JuMP, Ipopt

const REDUCED_DIR = joinpath(@__DIR__, "..", "output", "ENWLbenchmark", "reduced")

function _optimizer()
    optimizer_with_attributes(Ipopt.Optimizer,
        "max_iter"    => 500,
        "print_level" => 0,
        "tol"         => 1e-6,
    )
end

source_files = sort([
    f for f in readdir(REDUCED_DIR; join=true)
    if isfile(f) && endswith(f, ".json") &&
       !occursin("_results", basename(f)) &&
       !occursin("_opf", basename(f))
])

println("Solving OPF for $(length(source_files)) ENWLbenchmark/reduced case(s).\n")

let ok = 0, failed = 0, infeasible = 0
    for src in source_files
        stem     = splitext(basename(src))[1]
        out_path = joinpath(REDUCED_DIR, stem * "_solution.md")
        print("  $stem … ")
        t0 = time()
        try
            net    = parse_bmopf(src)
            result = solve_opf(net; optimizer=_optimizer())
            status = get(result, "termination_status", "UNKNOWN")
            report = profile_solution(net, result)
            render_solution(report, out_path)

            dt   = round(time() - t0; digits=1)
            n_e  = length(errors(report))
            n_w  = length(warnings(report))
            obj  = get(result, "objective", NaN)
            obj_s = isfinite(obj) ? "obj=$(round(obj; digits=2))" : "obj=?"
            println("✓  $status  $obj_s  $(n_e)E/$(n_w)W  $(dt)s")
            status in ("LOCALLY_SOLVED", "OPTIMAL", "ALMOST_LOCALLY_SOLVED") ?
                (ok += 1) : (infeasible += 1)
        catch e
            println("✗")
            @error "Failed: $stem" exception=(e, catch_backtrace())
            failed += 1
        end
    end

    println("\nDone: $ok solved, $infeasible infeasible/suboptimal, $failed errored.")
    println("Solution reports written to $REDUCED_DIR/")
end
