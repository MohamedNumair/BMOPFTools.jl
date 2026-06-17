# Tests for solution_check / profile_solution / render_solution.
#
# All tests build synthetic network + result dicts — no solver required.
# The helpers _net() and _result() return a minimal clean 3-phase 4-wire
# single-line feeder that produces zero findings beyond the INFO summaries.
# Individual testsets mutate copies to provoke specific findings.

# ── Minimal fixture helpers ───────────────────────────────────────────────────

function _base_net()
    Dict{String,Any}(
        "name" => "test_net",
        "bus" => Dict{String,Any}(
            "sourcebus" => Dict{String,Any}(
                "terminal_names" => ["a","b","c","n"],
                "perfectly_grounded_terminals" => ["n"],
            ),
            "b1" => Dict{String,Any}(
                "terminal_names" => ["a","b","c","n"],
                "v_min" => 200.0,
                "v_max" => 260.0,
            ),
        ),
        "voltage_source" => Dict{String,Any}(
            "src" => Dict{String,Any}(
                "bus" => "sourcebus",
                "terminal_map" => ["a","b","c","n"],
                "vm" => [230.0, 230.0, 230.0, 0.0],
                "va" => [0.0, -2.094, 2.094, 0.0],
            ),
        ),
        "linecode" => Dict{String,Any}(
            "lc1" => Dict{String,Any}(
                "R_series_1_1" => 0.1,
                "R_series_2_2" => 0.1,
                "R_series_3_3" => 0.1,
                "R_series_4_4" => 0.05,
                "i_max" => [200.0, 200.0, 200.0, 200.0],
            ),
        ),
        "line" => Dict{String,Any}(
            "l1" => Dict{String,Any}(
                "bus_from" => "sourcebus",
                "bus_to"   => "b1",
                "length"   => 100.0,
                "linecode" => "lc1",
                "terminal_map_from" => ["a","b","c","n"],
                "terminal_map_to"   => ["a","b","c","n"],
            ),
        ),
        "load" => Dict{String,Any}(
            "ld1" => Dict{String,Any}(
                "bus"           => "b1",
                "terminal_map"  => ["a","b","c","n"],
                "configuration" => "WYE",
                "p_nom"         => [1000.0, 1000.0, 1000.0],
                "q_nom"         => [100.0,  100.0,  100.0],
            ),
        ),
        "generator" => Dict{String,Any}(
            "g1" => Dict{String,Any}(
                "bus"           => "sourcebus",
                "terminal_map"  => ["a","b","c","n"],
                "configuration" => "WYE",
                "p_min"         => [0.0, 0.0, 0.0],
                "p_max"         => [2000.0, 2000.0, 2000.0],
                "q_min"         => [-500.0, -500.0, -500.0],
                "q_max"         => [500.0,  500.0,  500.0],
            ),
        ),
    )
end

function _base_result(; vm=230.0)
    vr = vm
    Dict{String,Any}(
        "termination_status" => "LOCALLY_SOLVED",
        "objective" => 0.0,
        "solve_time" => 0.1,
        "bus" => Dict{String,Any}(
            "sourcebus" => Dict{String,Any}(
                "a" => Dict("vr"=>vr,  "vi"=>0.0,   "vm"=>vm,  "va"=>0.0),
                "b" => Dict("vr"=>-vr/2, "vi"=>-vr*sqrt(3)/2, "vm"=>vm, "va"=>-2.094),
                "c" => Dict("vr"=>-vr/2, "vi"=> vr*sqrt(3)/2, "vm"=>vm, "va"=> 2.094),
                "n" => Dict("vr"=>0.0, "vi"=>0.0, "vm"=>0.0, "va"=>0.0),
            ),
            "b1" => Dict{String,Any}(
                "a" => Dict("vr"=>vr,  "vi"=>0.0,   "vm"=>vm,  "va"=>0.0),
                "b" => Dict("vr"=>-vr/2, "vi"=>-vr*sqrt(3)/2, "vm"=>vm, "va"=>-2.094),
                "c" => Dict("vr"=>-vr/2, "vi"=> vr*sqrt(3)/2, "vm"=>vm, "va"=> 2.094),
                "n" => Dict("vr"=>0.0, "vi"=>0.0, "vm"=>0.0, "va"=>0.0),
            ),
        ),
        "line" => Dict{String,Any}(
            "l1" => Dict{String,Any}(
                "a" => Dict("cr_fr"=>5.0,"ci_fr"=>0.0,"cr_to"=>-5.0,"ci_to"=>0.0,"cm_fr"=>5.0,"cm_to"=>5.0),
                "b" => Dict("cr_fr"=>5.0,"ci_fr"=>0.0,"cr_to"=>-5.0,"ci_to"=>0.0,"cm_fr"=>5.0,"cm_to"=>5.0),
                "c" => Dict("cr_fr"=>5.0,"ci_fr"=>0.0,"cr_to"=>-5.0,"ci_to"=>0.0,"cm_fr"=>5.0,"cm_to"=>5.0),
                "n" => Dict("cr_fr"=>0.0,"ci_fr"=>0.0,"cr_to"=>0.0, "ci_to"=>0.0,"cm_fr"=>0.0,"cm_to"=>0.0),
            ),
        ),
        "switch"  => Dict{String,Any}(),
        "load" => Dict{String,Any}(
            "ld1" => Dict{String,Any}(
                "a" => Dict("crd"=>4.35,"cid"=>0.0,"pd"=>1000.0,"qd"=>100.0),
                "b" => Dict("crd"=>4.35,"cid"=>0.0,"pd"=>1000.0,"qd"=>100.0),
                "c" => Dict("crd"=>4.35,"cid"=>0.0,"pd"=>1000.0,"qd"=>100.0),
            ),
        ),
        "generator" => Dict{String,Any}(
            "g1" => Dict{String,Any}(
                # pd=1000 W + R*len*cm² = 0.1*100*5² = 250 W line loss per phase
                "a" => Dict("crg"=>5.0,"cig"=>0.0,"pg"=>1250.0,"qg"=>0.0),
                "b" => Dict("crg"=>5.0,"cig"=>0.0,"pg"=>1250.0,"qg"=>0.0),
                "c" => Dict("crg"=>5.0,"cig"=>0.0,"pg"=>1250.0,"qg"=>0.0),
            ),
        ),
        "transformer" => Dict{String,Any}(),
    )
end

# ── Helper: extract finding codes ────────────────────────────────────────────

codes(findings) = Set(f.code for f in findings)

# ── T1: infeasible termination status ────────────────────────────────────────

@testset "SOL — infeasible status" begin
    net    = _base_net()
    result = _base_result()
    result["termination_status"] = "INFEASIBLE"

    findings = Finding[]
    out = solution_check(net, result, findings)

    @test "E.SOL.INFEASIBLE" in codes(findings)
    @test !any(f.code == "E.SOL.VOLT_VIOLATION" for f in findings)
    @test out["feasible"] == false
    @test out["n_volt_violations"] == 0
end

# ── T2: NaN in claimed-feasible result ───────────────────────────────────────

@testset "SOL — NaN in result" begin
    net    = _base_net()
    result = _base_result()
    result["bus"]["b1"]["a"]["vm"] = NaN

    findings = Finding[]
    solution_check(net, result, findings)

    @test "E.SOL.NAN_IN_RESULT" in codes(findings)
end

# ── T3: voltage violation (vm below v_min) ────────────────────────────────────

@testset "SOL — voltage magnitude violation" begin
    net    = _base_net()
    result = _base_result(vm=180.0)   # 180 V < v_min=200

    findings = Finding[]
    out = solution_check(net, result, findings)

    @test "E.SOL.VOLT_VIOLATION" in codes(findings)
    @test out["n_volt_violations"] > 0

    f = first(filter(f -> f.code == "E.SOL.VOLT_VIOLATION", findings))
    @test f.component_type == :bus
    @test f.detail["flavour"] == "vm"
    @test f.detail["vm"] ≈ 180.0
end

# ── T4: voltage near-active (within 1 % of v_max) ────────────────────────────

@testset "SOL — voltage near-active" begin
    net    = _base_net()
    # v_max = 260.0; put vm at 259.5 (within 1% of 260 = within 2.6 V)
    result = _base_result(vm=259.5)

    findings = Finding[]
    out = solution_check(net, result, findings)

    @test !("E.SOL.VOLT_VIOLATION" in codes(findings))
    @test "W.SOL.VOLT_ACTIVE" in codes(findings)
    @test out["n_volt_active"] > 0
end

# ── T5: thermal violation ─────────────────────────────────────────────────────

@testset "SOL — thermal violation" begin
    net    = _base_net()
    result = _base_result()
    # i_max on lc1 is 200 A; set cm_fr to 250 A on phase a
    result["line"]["l1"]["a"]["cm_fr"] = 250.0

    findings = Finding[]
    out = solution_check(net, result, findings)

    @test "E.SOL.THERMAL_VIOLATION" in codes(findings)
    @test out["n_thermal_violations"] > 0

    f = first(filter(f -> f.code == "E.SOL.THERMAL_VIOLATION", findings))
    @test f.component_id == "l1"
    @test f.detail["terminal"] == "a"
    @test f.detail["cm_fr"] ≈ 250.0
    @test f.detail["i_max"]  ≈ 200.0
end

# ── T6: thermal near-active ───────────────────────────────────────────────────

@testset "SOL — thermal near-active" begin
    net    = _base_net()
    result = _base_result()
    # i_max = 200; set cm_fr = 199.5 (within 1%)
    result["line"]["l1"]["a"]["cm_fr"] = 199.5

    findings = Finding[]
    out = solution_check(net, result, findings)

    @test !("E.SOL.THERMAL_VIOLATION" in codes(findings))
    @test "W.SOL.THERMAL_ACTIVE" in codes(findings)
    @test out["n_thermal_active"] > 0
end

# ── T7: generator dispatch violation ─────────────────────────────────────────

@testset "SOL — generator violation" begin
    net    = _base_net()
    result = _base_result()
    # p_max = 2000; set pg to 2500 on phase a
    result["generator"]["g1"]["a"]["pg"] = 2500.0

    findings = Finding[]
    out = solution_check(net, result, findings)

    @test "E.SOL.GEN_VIOLATION" in codes(findings)
    @test out["n_gen_violations"] > 0

    f = first(filter(f -> f.code == "E.SOL.GEN_VIOLATION", findings))
    @test f.component_id == "g1"
    @test f.detail["field"] == "pg"
    @test f.detail["value"] ≈ 2500.0
end

# ── T8: generator near-active ─────────────────────────────────────────────────

@testset "SOL — generator near-active" begin
    net    = _base_net()
    result = _base_result()
    # p_max = 2000; set pg = 1998 (within 1% = within 20 W)
    result["generator"]["g1"]["a"]["pg"] = 1998.0

    findings = Finding[]
    out = solution_check(net, result, findings)

    @test !("E.SOL.GEN_VIOLATION" in codes(findings))
    @test "W.SOL.GEN_ACTIVE" in codes(findings)
    @test out["n_gen_active"] > 0
end

# ── T9: load residual ─────────────────────────────────────────────────────────

@testset "SOL — load residual" begin
    net    = _base_net()
    result = _base_result()
    # p_nom = 1000 W; set pd to 1500 W (residual = 500 W >> 1 W tolerance)
    result["load"]["ld1"]["a"]["pd"] = 1500.0

    findings = Finding[]
    solution_check(net, result, findings)

    @test "W.SOL.LOAD_RESIDUAL" in codes(findings)

    f = first(filter(f -> f.code == "W.SOL.LOAD_RESIDUAL", findings))
    @test f.component_id == "ld1"
    @test f.detail["terminal"] == "a"
    @test f.detail["p_err"] ≈ 500.0
end

# ── T10: clean solution — no errors or warnings ────────────────────────────────

@testset "SOL — clean solution" begin
    net    = _base_net()
    result = _base_result()

    findings = Finding[]
    out = solution_check(net, result, findings)

    @test isempty(errors(findings))
    @test isempty(warnings(findings))
    @test out["n_volt_violations"]    == 0
    @test out["n_thermal_violations"] == 0
    @test out["n_gen_violations"]     == 0
    @test out["n_load_residuals"]     == 0
    # INFO summaries are always emitted for feasible solutions
    @test "I.SOL.BINDING_SUMMARY" in codes(findings)
end

# ── T11: profile_solution entry point ────────────────────────────────────────

@testset "SOL — profile_solution entry point" begin
    net    = _base_net()
    result = _base_result()

    report = profile_solution(net, result)

    @test report isa SolutionReport
    @test report.network_name == "test_net"
    @test report.result_meta["termination_status"] == "LOCALLY_SOLVED"
    @test haskey(report.results, :solution)
    @test report.results[:solution]["feasible"] == true
    @test isempty(errors(report))
end

# ── T12: render_solution produces valid Markdown ───────────────────────────────

@testset "SOL — render_solution markdown" begin
    net    = _base_net()
    result = _base_result()
    result["line"]["l1"]["a"]["cm_fr"] = 250.0   # inject a thermal violation for coverage

    report = profile_solution(net, result)
    io = IOBuffer()
    render_solution(report, io)
    md = String(take!(io))

    @test occursin("# BMOPF Solution Profile", md)
    @test occursin("## 1. Solution Summary", md)
    @test occursin("## 3. Thermal Limits", md)
    @test occursin("## 6. All Findings", md)
    @test occursin("LOCALLY_SOLVED", md)
    @test occursin("l1", md)
end

# ── T13: render_solution to file ─────────────────────────────────────────────

@testset "SOL — render_solution to file" begin
    net    = _base_net()
    result = _base_result()
    report = profile_solution(net, result)

    path = tempname() * ".md"
    render_solution(report, path)

    @test isfile(path)
    content = read(path, String)
    @test occursin("# BMOPF Solution Profile", content)
    rm(path)
end
