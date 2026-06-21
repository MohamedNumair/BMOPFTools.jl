"""
    place_and_solve_ders.jl

Demonstrate **recipe-driven DER placement** — `add_generators` and
`add_inverters` — feeding the augment → OPF → solution-report pipeline on a
pre-reduced LV feeder (LV1_14bus).

Unlike `augment_and_solve.jl`, which hand-writes each `generator` dict, this
example places DERs *declaratively*: a recipe says where, how big, and how
priced, and the library does the rest — choosing buses from the network's own
semantics/topology and recording every field it writes in a manifest. Both DER
element kinds are shown side by side:

  • `add_inverters` — inverter-interfaced PV (apparent-power nameplate `s_max`,
    a topology, an EN 50549-1 reactive box filled by `augment_case`). The richer
    converter model with a `P² + Q² ≤ s_max²` circle in the OPF.
  • `add_generators` — thin dispatchable active-power generators.

Steps:
  1. Load a reduced BMOPF network from output/LV/reduced/
  2. add_inverters  — place load-following PV inverters (recipe-driven)
  3. add_generators — place load-following generators alongside them
  4. augment_case   — inject voltage bounds, thermal limits, slack price, and
     fill the inverter/generator P/Q dispatch boxes (EN 50160 / EN 50549-1)
  5. Solve the OPF with Ipopt — cheap DERs displace expensive slack import; any
     surplus is exported to the grid
  6. Profile the solution and render the solution report

The pipeline order is the one the library is designed around:
    fix_case → add_inverters / add_generators → augment_case → solve_opf
(`fix_case` is omitted here because the reduced feeder is already clean.)

Run from the repository root using the test environment (which includes JuMP
and Ipopt):
    julia --project=test examples/place_and_solve_ders.jl
"""

using Pkg
Pkg.activate(joinpath(@__DIR__, "..", "test"))

using BMOPFTools
using JuMP, Ipopt
using Printf

# ── Paths ─────────────────────────────────────────────────────────────────────

const INPUT_JSON = joinpath(@__DIR__, "..", "output", "LV", "reduced", "LV1_14bus.json")
const OUT_DIR    = joinpath(@__DIR__, "..", "output", "LV", "ders")

mkpath(OUT_DIR)

stem = splitext(basename(INPUT_JSON))[1]   # "LV1_14bus"

sep(title) = println("\n", "─"^70, "\n  $title\n", "─"^70)

# ── 1. Load ───────────────────────────────────────────────────────────────────

sep("1. Load reduced network")

net = parse_bmopf(INPUT_JSON)
println("Loaded: ", get(net, "name", stem))
for k in ("bus", "line", "load", "generator", "inverter")
    @printf("  %-11s: %d\n", k, length(get(net, k, Dict())))
end

# Strip any pre-existing source cost so augment_case prices the slack itself.
for (_, vs) in get(net, "voltage_source", Dict())
    delete!(vs, "cost")
end

# ── 2. Place inverters (recipe-driven) ────────────────────────────────────────
#
# The reduced feeder has two single-phase loads (10 kW each):
#   ld3313_load_a — bus b3230, phase 1
#   ld3433_load_b — bus b2656, phase 2
#
# A load-following InverterRecipe places one PV inverter per load bus. Because
# the host loads are single-phase, topology inference picks SINGLE_PHASE. The
# nameplate s_max is sized to 80 % of the local load; `augment_case` later turns
# that nameplate into the p_max/p_min/q_min/q_max dispatch box. We price the PV
# below the slack so it is dispatched first.

sep("2. Place PV inverters (add_inverters)")

inv_recipe = InverterRecipe(
    strategy        = :load_following,   # one inverter per load bus
    s_fraction      = 0.8,               # s_max = 0.8 × local load
    s_to_p_ratio    = 0.85,              # p_avail = 0.85 × s_max — leaves VA
                                         #   headroom so the s_max circle and the
                                         #   EN 50549-1 Q box stay consistent
    cost_basis      = :uniform,
    der_cost_uniform = 0.2,              # cheaper than the slack (priced ~1.0)
)
net, inv_mf = add_inverters(net; recipe = inv_recipe)

println("\nInverter placement manifest:")
render_manifest(inv_mf)

# ── 3. Place generators (recipe-driven) ───────────────────────────────────────
#
# A second, thinner DER at the same load buses: plain dispatchable generators,
# sized to 50 % of local load and priced between the PV and the slack. The
# inverter and generator overwrite-guards are independent (per element kind), so
# both co-locate at each load bus — giving the OPF a layered merit order:
#   cheap PV inverter → mid-priced generator → expensive slack import.

sep("3. Place generators (add_generators)")

gen_recipe = GeneratorRecipe(
    strategy        = :load_following,
    der_p_fraction  = 0.5,               # p_max = 0.5 × local load
    cost_basis      = :uniform,
    der_cost_uniform = 0.3,              # dearer than PV, cheaper than slack
)
net, gen_mf = add_generators(net; recipe = gen_recipe)

println("\nGenerator placement manifest:")
render_manifest(gen_mf)

println("\nPlaced DERs:")
for (iid, inv) in sort(collect(get(net, "inverter", Dict())); by = first)
    @printf("  INV  %-12s bus=%-7s topo=%-12s s_max=%s VA\n",
            iid, inv["bus"], inv["topology"], string(inv["s_max"]))
end
for (gid, g) in sort(collect(get(net, "generator", Dict())); by = first)
    @printf("  GEN  %-12s bus=%-7s cfg=%-12s p_max=%s W\n",
            gid, g["bus"], g["configuration"], string(g["p_max"]))
end

# ── 4. Augment ────────────────────────────────────────────────────────────────
#
# augment_case now fills the standards-grounded gaps on the whole case:
#   • voltage bounds on the LV buses (EN 50160)
#   • thermal limits inferred from linecodes (IEC 60228)
#   • a per-phase slack price on the voltage source
#   • the inverter P/Q box from s_max/p_avail (Pass 4; EN 50549-1 cos φ = 0.90)
#   • generator q_min/q_max from p_max (EN 50549-1)

sep("4. Augment case")

net′, aug_mf = augment_case(net)

println("\nAugmentation manifest:")
render_manifest(aug_mf)

aug_json = joinpath(OUT_DIR, stem * "_ders_augmented.json")
write_bmopf(net′, aug_json)
println("\nAugmented JSON → ", relpath(aug_json))

aug_report_path = joinpath(OUT_DIR, stem * "_ders_report.md")
render(analyze(net′), aug_report_path)
println("Augmented report → ", relpath(aug_report_path))

# ── 5. Solve OPF ──────────────────────────────────────────────────────────────
#
# Expected behaviour: the cheap PV inverters dispatch to their p_max first, then
# the mid-priced generators, until the LV voltage-rise / thermal constraints
# bind. With total DER capability above the local load, the surplus is exported
# to the grid (the slack absorbs negative power).

sep("5. Solve OPF")

optimizer = optimizer_with_attributes(
    Ipopt.Optimizer,
    "print_level" => 0,
    "max_iter"    => 500,
)

result = solve_opf(net′; optimizer = optimizer, per_unit = true)

status = result["termination_status"]
println("Status    : ", status)
if status in ("LOCALLY_SOLVED", "OPTIMAL")
    @printf("Objective : %.6g (cost units)\n", result["objective"])
    @printf("Solve time: %.2f s\n", result["solve_time"])

    println("\nInverter dispatch:")
    for (iid, ph) in sort(collect(result["inverter"]); by = first)
        pg = sum(v["pg"] for v in values(ph))
        qg = sum(v["qg"] for v in values(ph))
        @printf("  %-12s  P = %+7.2f kW   Q = %+7.2f kvar\n", iid, pg/1000, qg/1000)
    end

    println("\nGenerator dispatch:")
    for (gid, ph) in sort(collect(result["generator"]); by = first)
        pg = sum(v["pg"] for v in values(ph))
        qg = sum(v["qg"] for v in values(ph))
        @printf("  %-12s  P = %+7.2f kW   Q = %+7.2f kvar\n", gid, pg/1000, qg/1000)
    end

    println("\nGrid slack (voltage source):")
    for (vid, ph) in result["voltage_source"]
        ps = sum(v["ps"] for v in values(ph))
        qs = sum(v["qs"] for v in values(ph))
        @printf("  %-12s  P = %+7.2f kW   Q = %+7.2f kvar  (negative = export)\n",
                vid, ps/1000, qs/1000)
    end
else
    println("Solver did not find a feasible point — check augmentation bounds.")
end

# ── 6. Solution report ────────────────────────────────────────────────────────

sep("6. Solution report")

# The report flags the saturated DERs as `W.SOL.*_ACTIVE` (within 1 % of a
# bound) — expected here, since the cheap DERs dispatch to their limits: this is
# the merit order working, not an error. A `W.SOL.POWER_BALANCE` warning is also
# expected: `profile_solution` estimates line losses with a first-order R·|I|²
# proxy from the from-end current only, so the network balance closes to a few
# hundred W rather than exactly — adequate for a sanity check, not an audit.
sol_report = profile_solution(net′, result)
sol_path   = joinpath(OUT_DIR, stem * "_ders_solution.md")
render_solution(sol_report, sol_path)
println("Solution report → ", relpath(sol_path))

render_solution(sol_report, stdout)
