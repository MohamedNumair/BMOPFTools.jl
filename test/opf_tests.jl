# OPF solver unit tests with analytically verifiable numerical results.
# Included from runtests.jl when JuMP and Ipopt are in the load path.
#
# Test design notes
# -----------------
# Each test uses a minimal self-consistent fixture where the expected solution
# can be derived analytically, and then asserts the solver matches to a tight
# numerical tolerance (atol ≤ 0.01 V on voltages, which is ~10 ppm at 1 kV).
#
# All fixtures use:
#   - v_min on load buses to exclude the low-voltage (non-physical) NLP solution
#   - diagonal or resistive-only linecodes to enable closed-form derivations
#   - grounded neutral where not under test

@testset "OPF — solve_opf extension" begin

    # ─────────────────────────────────────────────────────────────────────────
    # T1: Single-phase, purely resistive, no reactive power
    #
    # KVL + constant-power load gives:  V² - V_s·V + R·P = 0
    # High-voltage solution:  V = (V_s + √(V_s² - 4RP)) / 2
    # ─────────────────────────────────────────────────────────────────────────
    @testset "T1: single-phase resistive — exact voltage" begin
        V_s = 1000.0;  R = 0.5;  P = 100_000.0
        V_exp = (V_s + sqrt(V_s^2 - 4*R*P)) / 2   # 500 + 200√5 ≈ 947.214 V

        net = parse_bmopf("""
        {"bus":{
            "sourcebus":{"terminal_names":["1","n"],
                         "perfectly_grounded_terminals":["n"]},
            "bus1":     {"terminal_names":["1","n"],
                         "perfectly_grounded_terminals":["n"],
                         "v_min":900.0,"v_max":999.0}},
         "voltage_source":{"vs":{"bus":"sourcebus","terminal_map":["1"],
             "v_magnitude":[1000.0],"v_angle":[0.0]}},
         "linecode":{"lc":{"R_series_1_1":0.5}},
         "line":{"l1":{"bus_from":"sourcebus","bus_to":"bus1",
             "terminal_map_from":["1"],"terminal_map_to":["1"],
             "linecode":"lc","length":1.0}},
         "load":{"ld1":{"bus":"bus1","terminal_map":["1","n"],
             "configuration":"SINGLE_PHASE",
             "p_nom":[100000.0],"q_nom":[0.0]}}}
        """; from_string=true)

        res = solve_opf(net)
        @test res["termination_status"] in ("LOCALLY_SOLVED", "OPTIMAL")
        @test res["bus"]["bus1"]["1"]["vm"] ≈ V_exp   atol=0.01
        @test abs(res["bus"]["bus1"]["1"]["vi"]) < 0.01  # imaginary ≈ 0
        @test res["objective"] ≈ 0.0   atol=1e-6         # no generator
    end

    # ─────────────────────────────────────────────────────────────────────────
    # T2: Three-phase balanced with diagonal linecode
    #
    # Off-diagonal impedance is zero ⟹ each phase decouples to the same
    # single-phase problem as T1.  All phases must have the same |V| and
    # angles equal to the source angles (0°, −120°, +120°).
    # ─────────────────────────────────────────────────────────────────────────
    @testset "T2: 3-phase balanced, decoupled phases" begin
        V_s = 1000.0;  R = 0.5;  P = 100_000.0
        V_exp = (V_s + sqrt(V_s^2 - 4*R*P)) / 2   # ≈ 947.214 V

        net = parse_bmopf("""
        {"bus":{
            "sourcebus":{"terminal_names":["1","2","3","n"],
                         "perfectly_grounded_terminals":["n"]},
            "bus1":     {"terminal_names":["1","2","3","n"],
                         "perfectly_grounded_terminals":["n"],
                         "v_min":900.0,"v_max":999.0}},
         "voltage_source":{"vs":{"bus":"sourcebus",
             "terminal_map":["1","2","3"],
             "v_magnitude":[1000.0,1000.0,1000.0],
             "v_angle":[0.0,-2.0944,2.0944]}},
         "linecode":{"lc":{
             "R_series_1_1":0.5,"R_series_2_2":0.5,"R_series_3_3":0.5}},
         "line":{"l1":{"bus_from":"sourcebus","bus_to":"bus1",
             "terminal_map_from":["1","2","3"],"terminal_map_to":["1","2","3"],
             "linecode":"lc","length":1.0}},
         "load":{"ld1":{"bus":"bus1","terminal_map":["1","2","3","n"],
             "configuration":"WYE",
             "p_nom":[100000.0,100000.0,100000.0],"q_nom":[0.0,0.0,0.0]}}}
        """; from_string=true)

        res = solve_opf(net)
        @test res["termination_status"] in ("LOCALLY_SOLVED", "OPTIMAL")

        b = res["bus"]["bus1"]
        # Equal voltage magnitude on all three phases
        @test b["1"]["vm"] ≈ V_exp   atol=0.01
        @test b["2"]["vm"] ≈ V_exp   atol=0.01
        @test b["3"]["vm"] ≈ V_exp   atol=0.01
        # Phase angles match source (diagonal impedance → no inter-phase coupling)
        @test b["1"]["va"] ≈  0.0     atol=1e-4
        @test b["2"]["va"] ≈ -2.0944  atol=1e-3
        @test b["3"]["va"] ≈  2.0944  atol=1e-3
    end

    # ─────────────────────────────────────────────────────────────────────────
    # T3: Forced generator dispatch — bus voltage rises as line current falls
    #
    # With generator fixed at Pg = P_gen, the source delivers P_net = P_load − P_gen.
    # The same quadratic gives:  V = (V_s + √(V_s² − 4R·P_net)) / 2
    # Objective = cost × P_gen (deterministic since Pg is fixed).
    # ─────────────────────────────────────────────────────────────────────────
    @testset "T3: forced generator dispatch — exact voltage and cost" begin
        V_s = 1000.0;  R = 0.5;  P_load = 100_000.0;  P_gen = 50_000.0
        P_net = P_load - P_gen
        V_exp = (V_s + sqrt(V_s^2 - 4*R*P_net)) / 2   # 500 + 150√10 ≈ 974.342 V
        cost  = 0.1

        net = parse_bmopf("""
        {"bus":{
            "sourcebus":{"terminal_names":["1","n"],
                         "perfectly_grounded_terminals":["n"]},
            "bus1":     {"terminal_names":["1","n"],
                         "perfectly_grounded_terminals":["n"],
                         "v_min":960.0,"v_max":999.0}},
         "voltage_source":{"vs":{"bus":"sourcebus","terminal_map":["1"],
             "v_magnitude":[1000.0],"v_angle":[0.0]}},
         "linecode":{"lc":{"R_series_1_1":0.5}},
         "line":{"l1":{"bus_from":"sourcebus","bus_to":"bus1",
             "terminal_map_from":["1"],"terminal_map_to":["1"],
             "linecode":"lc","length":1.0}},
         "load":{"ld1":{"bus":"bus1","terminal_map":["1","n"],
             "configuration":"SINGLE_PHASE",
             "p_nom":[100000.0],"q_nom":[0.0]}},
         "generator":{"gen1":{"bus":"bus1","terminal_map":["1"],
             "configuration":"WYE",
             "p_min":[50000.0],"p_max":[50000.0],
             "q_min":[0.0],"q_max":[0.0],"cost":0.1}}}
        """; from_string=true)

        res = solve_opf(net)
        @test res["termination_status"] in ("LOCALLY_SOLVED", "OPTIMAL")
        @test res["bus"]["bus1"]["1"]["vm"]          ≈ V_exp         atol=0.01
        @test res["generator"]["gen1"]["1"]["pg"]   ≈ P_gen         atol=1.0
        @test res["objective"]                      ≈ cost * P_gen  atol=0.1
    end

    # ─────────────────────────────────────────────────────────────────────────
    # T4: Cost-optimal dispatch — negative unit cost drives output to p_max
    #
    # cost = −1 $/W → minimising the objective maximises Pg → each phase
    # should hit its p_max bound.  A near-zero-impedance line ensures the
    # voltage constraint does not interfere.
    # ─────────────────────────────────────────────────────────────────────────
    @testset "T4: cost-optimal dispatch — negative cost → p_max" begin
        P_max_ph = 50_000.0

        net = parse_bmopf("""
        {"bus":{
            "sourcebus":{"terminal_names":["1","2","3","n"],
                         "perfectly_grounded_terminals":["n"]},
            "bus1":     {"terminal_names":["1","2","3","n"],
                         "perfectly_grounded_terminals":["n"],
                         "v_min":990.0,"v_max":1001.0}},
         "voltage_source":{"vs":{"bus":"sourcebus",
             "terminal_map":["1","2","3"],
             "v_magnitude":[1000.0,1000.0,1000.0],
             "v_angle":[0.0,-2.0944,2.0944]}},
         "linecode":{"lc":{
             "R_series_1_1":1.0e-4,"R_series_2_2":1.0e-4,"R_series_3_3":1.0e-4}},
         "line":{"l1":{"bus_from":"sourcebus","bus_to":"bus1",
             "terminal_map_from":["1","2","3"],"terminal_map_to":["1","2","3"],
             "linecode":"lc","length":1.0}},
         "load":{"ld1":{"bus":"bus1","terminal_map":["1","2","3","n"],
             "configuration":"WYE",
             "p_nom":[150000.0,150000.0,150000.0],"q_nom":[0.0,0.0,0.0]}},
         "generator":{"gen1":{"bus":"bus1","terminal_map":["1","2","3","n"],
             "configuration":"WYE",
             "p_min":[0.0,0.0,0.0],"p_max":[50000.0,50000.0,50000.0],
             "q_min":[0.0,0.0,0.0],"q_max":[0.0,0.0,0.0],"cost":-1.0}}}
        """; from_string=true)

        res = solve_opf(net)
        @test res["termination_status"] in ("LOCALLY_SOLVED", "OPTIMAL")
        for ph in ("1","2","3")
            @test res["generator"]["gen1"][ph]["pg"] ≈ P_max_ph   atol=1.0
        end
        @test res["objective"] ≈ -3.0 * P_max_ph   atol=10.0
    end

    # ─────────────────────────────────────────────────────────────────────────
    # T5: Power balance identity
    #
    # For any converged OPF:  P_source = P_load + P_line_loss
    # Verified using the KVL-derived source injection and line losses.
    # ─────────────────────────────────────────────────────────────────────────
    @testset "T5: power balance identity" begin
        V_s = 1000.0;  R = 0.5;  P_load = 100_000.0

        net = parse_bmopf("""
        {"bus":{
            "sourcebus":{"terminal_names":["1","n"],
                         "perfectly_grounded_terminals":["n"]},
            "bus1":     {"terminal_names":["1","n"],
                         "perfectly_grounded_terminals":["n"],
                         "v_min":900.0,"v_max":999.0}},
         "voltage_source":{"vs":{"bus":"sourcebus","terminal_map":["1"],
             "v_magnitude":[1000.0],"v_angle":[0.0]}},
         "linecode":{"lc":{"R_series_1_1":0.5}},
         "line":{"l1":{"bus_from":"sourcebus","bus_to":"bus1",
             "terminal_map_from":["1"],"terminal_map_to":["1"],
             "linecode":"lc","length":1.0}},
         "load":{"ld1":{"bus":"bus1","terminal_map":["1","n"],
             "configuration":"SINGLE_PHASE",
             "p_nom":[100000.0],"q_nom":[0.0]}}}
        """; from_string=true)

        res = solve_opf(net)
        @test res["termination_status"] in ("LOCALLY_SOLVED", "OPTIMAL")

        # Source real power: P_src = V_s · Ir  (Vi_s = 0 at the slack bus)
        cr_src = res["voltage_source"]["vs"]["1"]["cr"]
        P_src  = V_s * cr_src

        # Line loss: P_loss = R · |I|² (no reactive component here)
        cr_fr  = res["line"]["l1"]["1"]["cr_fr"]
        ci_fr  = res["line"]["l1"]["1"]["ci_fr"]
        P_loss = R * (cr_fr^2 + ci_fr^2)

        @test P_src ≈ P_load + P_loss   atol=0.1   # within 0.1 W
    end

    # ─────────────────────────────────────────────────────────────────────────
    # T6: Four-wire explicit neutral — floating neutral has non-zero voltage
    #
    # Unbalanced WYE loads drive a non-zero neutral current through the finite
    # neutral impedance (R_n = 0.2 Ω), displacing the neutral potential.
    # Approximate analysis gives |V_n| ≈ 8–10 V at bus1.
    # ─────────────────────────────────────────────────────────────────────────
    @testset "T6: four-wire floating neutral — non-zero neutral voltage" begin
        net = parse_bmopf("""
        {"bus":{
            "sourcebus":{"terminal_names":["1","2","3","n"],
                         "perfectly_grounded_terminals":["n"]},
            "bus1":     {"terminal_names":["1","2","3","n"],
                         "v_min":850.0,"v_max":1050.0}},
         "voltage_source":{"vs":{"bus":"sourcebus",
             "terminal_map":["1","2","3"],
             "v_magnitude":[1000.0,1000.0,1000.0],
             "v_angle":[0.0,-2.0944,2.0944]}},
         "linecode":{"lc4w":{
             "R_series_1_1":0.1,"R_series_2_2":0.1,
             "R_series_3_3":0.1,"R_series_4_4":0.2}},
         "line":{"l1":{"bus_from":"sourcebus","bus_to":"bus1",
             "terminal_map_from":["1","2","3","n"],
             "terminal_map_to":  ["1","2","3","n"],
             "linecode":"lc4w","length":1.0}},
         "load":{"ld1":{"bus":"bus1","terminal_map":["1","2","3","n"],
             "configuration":"WYE",
             "p_nom":[50000.0,100000.0,80000.0],"q_nom":[0.0,0.0,0.0]}}}
        """; from_string=true)

        res = solve_opf(net)
        @test res["termination_status"] in ("LOCALLY_SOLVED", "OPTIMAL")

        # Neutral must float to a non-zero voltage (unbalanced currents through
        # a finite neutral resistance create a measurable voltage displacement).
        vm_n = res["bus"]["bus1"]["n"]["vm"]
        @test vm_n > 1.0   # analytical estimate: |V_n| ≈ R_n × |I_n| ≈ 8–10 V
    end

end  # @testset "OPF — solve_opf extension"
