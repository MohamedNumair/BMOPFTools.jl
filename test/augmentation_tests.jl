using Test
using BMOPFTools

# ---------------------------------------------------------------------------
# Shared minimal fixtures
# ---------------------------------------------------------------------------

# Three-phase 4-wire LV feeder (230/400 V) with one load — no bounds, no limits.
function _lv_net()
    parse_bmopf("""
    {"bus":{
        "src":{"terminal_names":["1","2","3","n"],
               "perfectly_grounded_terminals":["n"]},
        "b1": {"terminal_names":["1","2","3","n"],
               "perfectly_grounded_terminals":["n"]}},
     "voltage_source":{"vs":{"bus":"src",
         "terminal_map":["1","2","3"],
         "v_magnitude":[230.0,230.0,230.0],
         "v_angle":[0.0,-2.0944,2.0944]}},
     "linecode":{"lc":{"R_series_1_1":0.000396,"R_series_2_2":0.000396,
                       "R_series_3_3":0.000396,"R_series_4_4":0.000396}},
     "line":{"l1":{"bus_from":"src","bus_to":"b1",
         "terminal_map_from":["1","2","3","n"],"terminal_map_to":["1","2","3","n"],
         "linecode":"lc","length":100.0}},
     "load":{"ld":{"bus":"b1","terminal_map":["1","2","3","n"],
         "configuration":"WYE",
         "p_nom":[1000.0,1000.0,1000.0],"q_nom":[0.0,0.0,0.0]}}}
    """; from_string=true)
end

# Two-level MV→LV feeder (no bounds anywhere)
function _mv_lv_net()
    parse_bmopf("""
    {"bus":{
        "mv_src":{"terminal_names":["a","b","c","n"],
                  "perfectly_grounded_terminals":["n"]},
        "lv_bus":{"terminal_names":["1","2","3","n"],
                  "perfectly_grounded_terminals":["n"]}},
     "voltage_source":{"vs":{"bus":"mv_src",
         "terminal_map":["a","b","c"],
         "v_magnitude":[6350.0,6350.0,6350.0],
         "v_angle":[0.0,-2.0944,2.0944]}},
     "transformer":{"single_phase":{"tx":{"bus_from":"mv_src","bus_to":"lv_bus",
         "terminal_map_from":["a","b","c"],
         "terminal_map_to":["1","2","3"],
         "s_rating":100000.0,
         "v_ref_from":11000.0,"v_ref_to":400.0,
         "r_series_from":1.0,"r_series_to":0.01,
         "x_series_from":5.0,"x_series_to":0.05}}},
     "load":{"ld":{"bus":"lv_bus","terminal_map":["1","2","3","n"],
         "configuration":"WYE",
         "p_nom":[2000.0,2000.0,2000.0],"q_nom":[0.0,0.0,0.0]}}}
    """; from_string=true)
end

# LV net with a dispatchable generator (has p_max, no q bounds)
function _lv_net_with_gen()
    net = _lv_net()
    get!(net, "generator", Dict{String,Any}())["g1"] = Dict{String,Any}(
        "bus"           => "b1",
        "terminal_map"  => ["1","2","3","n"],
        "configuration" => "WYE",
        "p_min"         => [0.0, 0.0, 0.0],
        "p_max"         => [500.0, 500.0, 500.0],
        "cost"          => [10.0, 10.0, 10.0],
    )
    net
end

# ── T1: Voltage bounds ───────────────────────────────────────────────────────

@testset "T1: Voltage bounds — LV" begin
    net  = _lv_net()
    net′, mf = augment_case(net)

    b1 = net′["bus"]["b1"]

    # v_min / v_max: 230 V nominal × 0.85 / 1.15
    @test b1["v_min"] ≈ 230.0 * 0.85   atol=1e-6
    @test b1["v_max"] ≈ 230.0 * 1.15   atol=1e-6

    # vpn: 230 V / √3 × 0.90 / 1.10
    v_pn = 230.0 / sqrt(3.0)
    @test b1["vpn_min"] ≈ v_pn * 0.90  atol=1e-6
    @test b1["vpn_max"] ≈ v_pn * 1.10  atol=1e-6

    # vpp: 230 V (line voltage for a 230 V source) × 0.90 / 1.10
    @test b1["vpp_min"] ≈ 230.0 * 0.90  atol=1e-6
    @test b1["vpp_max"] ≈ 230.0 * 1.10  atol=1e-6

    # vneg_max: 2% of v_pn
    @test b1["vneg_max"] ≈ v_pn * 0.02  atol=1e-6

    # Source bus gets v_min/v_max but NOT vpn/vpp/vneg
    src = net′["bus"]["src"]
    @test haskey(src, "v_min")
    @test !haskey(src, "vpn_min")
    @test !haskey(src, "vpp_min")
    @test !haskey(src, "vneg_max")

    # Manifest records the entries
    @test length(mf.entries) > 0
    fields_written = [e.field for e in mf.entries if e.component_id == "b1"]
    @test "v_min"    in fields_written
    @test "vpn_min"  in fields_written
    @test "vpp_min"  in fields_written
    @test "vneg_max" in fields_written
end

@testset "T1: Voltage bounds — MV tighter than LV" begin
    net  = _mv_lv_net()
    net′, _ = augment_case(net)

    mv = net′["bus"]["mv_src"]
    lv = net′["bus"]["lv_bus"]

    # MV source bus gets v bounds (but not vpn/vpp — it's a source bus)
    # MV v_min = 6350 * 0.94 (±6%)
    @test mv["v_min"] ≈ 6350.0 * 0.94  atol=1.0

    # LV bus: v_min = V_nom × 0.85 (LV band)
    lv_vnom = get(voltage_level_analysis(net, Finding[])["bus_voltage_map"], "lv_bus", NaN)
    @test lv["v_min"] ≈ lv_vnom * 0.85  atol=1.0

    # MV band is strictly tighter than LV band
    mv_range = mv["v_max"] - mv["v_min"]
    lv_range = lv["v_max"] - lv["v_min"]
    @test mv_range / mv["v_max"] < lv_range / lv["v_max"]
end

@testset "T1: Voltage bounds — never overwrite existing" begin
    net = _lv_net()
    net["bus"]["b1"]["vpn_min"] = 199.0   # deliberately set

    net′, mf = augment_case(net)

    # Pre-existing value unchanged
    @test net′["bus"]["b1"]["vpn_min"] == 199.0

    # vpn_min not in manifest entries for b1
    @test !any(e -> e.component_id == "b1" && e.field == "vpn_min", mf.entries)
end

@testset "T1: Voltage bounds — single-phase bus (no vpp)" begin
    net = parse_bmopf("""
    {"bus":{
        "src":{"terminal_names":["1","n"],
               "perfectly_grounded_terminals":["n"]},
        "b1": {"terminal_names":["1","n"],
               "perfectly_grounded_terminals":["n"]}},
     "voltage_source":{"vs":{"bus":"src","terminal_map":["1"],
         "v_magnitude":[230.0],"v_angle":[0.0]}},
     "linecode":{"lc":{"R_series_1_1":0.001}},
     "line":{"l1":{"bus_from":"src","bus_to":"b1",
         "terminal_map_from":["1","n"],"terminal_map_to":["1","n"],
         "linecode":"lc","length":50.0}},
     "load":{"ld":{"bus":"b1","terminal_map":["1","n"],
         "configuration":"SINGLE_PHASE",
         "p_nom":[500.0],"q_nom":[0.0]}}}
    """; from_string=true)

    net′, _ = augment_case(net)
    b1 = net′["bus"]["b1"]

    @test haskey(b1, "v_min")
    @test haskey(b1, "vpn_min")   # single-phase: vpn still applies
    @test !haskey(b1, "vpp_min")  # only 1 phase terminal → no vpp
    @test !haskey(b1, "vneg_max") # only 1 phase terminal → no vneg
end

# ── T2: Thermal limits ───────────────────────────────────────────────────────

@testset "T2: Thermal — 50 mm² distinct linecode (R₁₁ = 0.396 mΩ/m)" begin
    # Use a "distinct" linecode (non-uniform off-diagonals from a geometry-derived
    # matrix) so provenance_analysis gives verdict = "distinct" → confidence :high.
    # R₁₁ = 0.000396 Ω/m = 0.396 mΩ/m matches 50 mm² underground → 170 A.
    net = parse_bmopf("""
    {"bus":{
        "src":{"terminal_names":["1","2","3","n"],"perfectly_grounded_terminals":["n"]},
        "b1": {"terminal_names":["1","2","3","n"],"perfectly_grounded_terminals":["n"]}},
     "voltage_source":{"vs":{"bus":"src","terminal_map":["1","2","3"],
         "v_magnitude":[230.0,230.0,230.0],"v_angle":[0.0,-2.0944,2.0944]}},
     "linecode":{"lc_dist":{
         "R_series_1_1":0.000396,"R_series_2_2":0.000396,"R_series_3_3":0.000396,
         "R_series_1_2":0.000049,"R_series_1_3":0.000052,"R_series_2_3":0.000047,
         "R_series_2_1":0.000049,"R_series_3_1":0.000052,"R_series_3_2":0.000047,
         "X_series_1_1":0.00008,"X_series_2_2":0.00008,"X_series_3_3":0.00008,
         "X_series_1_2":0.00003,"X_series_1_3":0.00002,"X_series_2_3":0.000025,
         "X_series_2_1":0.00003,"X_series_3_1":0.00002,"X_series_3_2":0.000025}},
     "line":{"l1":{"bus_from":"src","bus_to":"b1",
         "terminal_map_from":["1","2","3"],"terminal_map_to":["1","2","3"],
         "linecode":"lc_dist","length":100.0}},
     "load":{"ld":{"bus":"b1","terminal_map":["1","2","3","n"],"configuration":"WYE",
         "p_nom":[1000.0,1000.0,1000.0],"q_nom":[0.0,0.0,0.0]}}}
    """; from_string=true)

    net′, mf = augment_case(net)

    lc = net′["linecode"]["lc_dist"]
    @test haskey(lc, "i_max")
    @test length(lc["i_max"]) == 3          # 3 conductors (no neutral in this linecode)
    @test all(x -> x ≈ 170.0, lc["i_max"]) # underground XLPE, 50 mm²

    e = only(filter(x -> x.component_id == "lc_dist" && x.field == "i_max" &&
                         x.new_value !== nothing, mf.entries))
    @test e.new_value == [170.0, 170.0, 170.0]
    @test contains(e.rule, "IEC60228")
    @test e.confidence == :high   # distinct verdict → :high
end

@testset "T2: Thermal — existing i_max not overwritten" begin
    net = _lv_net()
    net["linecode"]["lc"]["i_max"] = [99.0, 99.0, 99.0, 99.0]

    net′, mf = augment_case(net)

    @test net′["linecode"]["lc"]["i_max"] == [99.0, 99.0, 99.0, 99.0]
    @test !any(e -> e.component_id == "lc" && e.field == "i_max" &&
                    e.new_value !== nothing, mf.entries)
end

@testset "T2: Thermal — R₁₁ outside lookup range → skipped" begin
    net = _lv_net()
    net["linecode"]["lc"]["R_series_1_1"] = 0.00001  # 0.01 mΩ/m — below table minimum

    net′, mf = augment_case(net)

    @test !haskey(net′["linecode"]["lc"], "i_max")
    e = only(filter(x -> x.component_id == "lc" && x.field == "i_max", mf.entries))
    @test contains(e.note, "outside lookup range")
end

@testset "T2: Thermal — low-confidence linecode skipped at default threshold" begin
    # Make linecode look sequence-derived by making R matrix exactly balanced
    # so verdict = "exactly_balanced" → confidence = :low < threshold :medium
    r = 0.000396; r_off = (r - r/3)/2  # balanced off-diagonal
    net = parse_bmopf("""
    {"bus":{
        "src":{"terminal_names":["1","2","3","n"],"perfectly_grounded_terminals":["n"]},
        "b1": {"terminal_names":["1","2","3","n"],"perfectly_grounded_terminals":["n"]}},
     "voltage_source":{"vs":{"bus":"src","terminal_map":["1","2","3"],
         "v_magnitude":[230.0,230.0,230.0],"v_angle":[0.0,-2.0944,2.0944]}},
     "linecode":{"lc_seq":{
         "R_series_1_1":$(r),"R_series_2_2":$(r),"R_series_3_3":$(r),
         "R_series_1_2":$(r_off),"R_series_1_3":$(r_off),"R_series_2_3":$(r_off),
         "R_series_2_1":$(r_off),"R_series_3_1":$(r_off),"R_series_3_2":$(r_off),
         "X_series_1_1":0.0001,"X_series_2_2":0.0001,"X_series_3_3":0.0001}},
     "line":{"l1":{"bus_from":"src","bus_to":"b1",
         "terminal_map_from":["1","2","3"],"terminal_map_to":["1","2","3"],
         "linecode":"lc_seq","length":100.0}},
     "load":{"ld":{"bus":"b1","terminal_map":["1","2","3","n"],"configuration":"WYE",
         "p_nom":[1000.0,1000.0,1000.0],"q_nom":[0.0,0.0,0.0]}}}
    """; from_string=true)

    net′, mf = augment_case(net)

    # i_max should NOT be written (confidence :low < threshold :medium)
    @test !haskey(net′["linecode"]["lc_seq"], "i_max")
    e = only(filter(x -> x.component_id == "lc_seq" && x.field == "i_max", mf.entries))
    @test contains(e.note, "confidence")

    # But with thermal_min_confidence = :low it should be written
    net2′, _ = augment_case(net; recipe=AugmentationRecipe(thermal_min_confidence=:low))
    @test haskey(net2′["linecode"]["lc_seq"], "i_max")
end

# ── T3: Generation ───────────────────────────────────────────────────────────

@testset "T3: Generation — slack injected when absent" begin
    net  = _lv_net()
    net′, mf = augment_case(net)

    gens = get(net′, "generator", Dict())
    slack_ids = [id for (id, g) in gens if get(g, "_slack", false)]
    @test length(slack_ids) == 1

    g = gens[first(slack_ids)]
    @test g["bus"] == "src"
    @test g["cost"] == [1.0, 1.0, 1.0]
    @test !haskey(g, "p_min")
    @test !haskey(g, "p_max")

    e = only(filter(x -> x.component_type == :generator && x.field == "(new)", mf.entries))
    @test contains(e.rule, "TFspec")
end

@testset "T3: Generation — slack not duplicated when already present" begin
    net = _lv_net()
    net["generator"] = Dict{String,Any}(
        "slack_vs" => Dict{String,Any}(
            "bus" => "src", "terminal_map" => ["1","2","3","n"],
            "configuration" => "WYE", "cost" => [1.0,1.0,1.0], "_slack" => true))

    net′, mf = augment_case(net)

    slack_ids = [id for (id, g) in net′["generator"] if get(g, "_slack", false)]
    @test length(slack_ids) == 1   # still exactly one
    @test !any(e -> e.component_type == :generator && e.field == "(new)", mf.entries)
end

@testset "T3: Generation — q bounds added from p_max" begin
    net  = _lv_net_with_gen()
    net′, mf = augment_case(net)

    g = net′["generator"]["g1"]
    @test haskey(g, "q_min")
    @test haskey(g, "q_max")

    tan_phi = tan(acos(0.90))
    @test g["q_max"] ≈ [500.0 * tan_phi, 500.0 * tan_phi, 500.0 * tan_phi]  rtol=1e-6
    @test g["q_min"] ≈ -g["q_max"]

    e_min = only(filter(x -> x.component_id == "g1" && x.field == "q_min", mf.entries))
    @test contains(e_min.rule, "EN50549")
end

@testset "T3: Generation — q bounds not overwritten" begin
    net = _lv_net_with_gen()
    net["generator"]["g1"]["q_min"] = [-100.0, -100.0, -100.0]
    net["generator"]["g1"]["q_max"] = [ 100.0,  100.0,  100.0]

    net′, _ = augment_case(net)

    @test net′["generator"]["g1"]["q_min"] == [-100.0, -100.0, -100.0]
    @test net′["generator"]["g1"]["q_max"] == [ 100.0,  100.0,  100.0]
end

# ── T4: Manifest ─────────────────────────────────────────────────────────────

@testset "T4: Manifest — structure and deep-copy guarantee" begin
    net  = _lv_net()
    net′, mf = augment_case(net)

    @test mf isa TransformationManifest
    @test length(mf.entries) > 0
    @test all(e isa TransformEntry for e in mf.entries)

    # findings_after should have fewer or equal I.BENCH.AUGMENTATION items
    n_before = count(f -> f.code == "I.BENCH.AUGMENTATION", mf.findings_before)
    n_after  = count(f -> f.code == "I.BENCH.AUGMENTATION", mf.findings_after)
    @test n_after <= n_before

    # Deep copy: mutating net′ must not affect net
    net′["bus"]["b1"]["v_min"] = -999.0
    @test !haskey(get(net["bus"], "b1", Dict()), "v_min")
end

@testset "T4: Manifest — JSON round-trip" begin
    net  = _lv_net()
    _, mf = augment_case(net)

    d = manifest_to_dict(mf)
    @test d isa Dict{String,Any}
    @test haskey(d, "created_at")
    @test haskey(d, "entries")
    @test d["entries"] isa Vector
    @test all(e -> haskey(e, "component_type") && haskey(e, "field") &&
                   haskey(e, "rule") && haskey(e, "confidence"), d["entries"])
end

@testset "T4: Manifest — render_manifest produces non-empty output" begin
    net  = _lv_net()
    _, mf = augment_case(net)

    buf = IOBuffer()
    render_manifest(mf; io=buf)
    out = String(take!(buf))
    @test length(out) > 50
    @test contains(out, "Augmentation manifest")
end

@testset "T4: Manifest — pass flags respected" begin
    net = _lv_net()

    # Disable all passes — net′ should be identical to net (modulo deep copy)
    recipe = AugmentationRecipe(
        apply_v_bounds        = false,
        apply_vpn_bounds      = false,
        apply_vpp_bounds      = false,
        apply_vneg_bounds     = false,
        apply_thermal         = false,
        apply_q_bounds        = false,
        apply_slack_generator = false,
    )
    net′, mf = augment_case(net; recipe)

    @test !haskey(net′["bus"]["b1"], "v_min")
    @test !haskey(get(net′, "generator", Dict()), "_aug_slack_vs")
    @test isempty([e for e in mf.entries if e.new_value !== nothing])
end

@testset "T4: Manifest — pre-supplied analysis reused" begin
    net  = _lv_net()
    # Run analysis once and pass it in — should not error
    a    = analyze(net)
    analysis_dict = Dict{String,Any}(
        "voltage_levels" => voltage_level_analysis(net, Finding[]),
        "provenance"     => provenance_analysis(net, Finding[]),
    )
    net′, mf = augment_case(net; analysis=analysis_dict)
    @test haskey(net′["bus"]["b1"], "v_min")   # bounds still applied
end
