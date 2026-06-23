# OPF bound-binding optimality tests — validated against PowerModelsDistribution.
#
# Provenance
# ----------
# Companion to pmd_opf_port_tests.jl. Those fixtures pin PMD's published OPF
# objectives for cases whose only active constraints are the power-flow
# equations themselves — the operating bounds (voltage, thermal/current and
# reactive limits) are left slack. These fixtures close that gap (issue #138):
# each is a small DER-hosting network engineered so that exactly ONE operating
# bound is the binding (active) constraint at the optimum — the "non-obvious
# binding constraints, line current limits or voltage restrictions" the issue
# asks to lock in.
#
# The locked-in targets were reproduced independently by exporting the same
# network with `to_pmd` and solving it in PMD's explicit-neutral IVR formulation
# (IVRENPowerModel) — the PMD model whose wye nodal equations,
#   pg = (vr_p - vr_n)·crg + (vi_p - vi_n)·cig,
#   qg = (vi_p - vi_n)·crg - (vr_p - vr_n)·cig,
# are identical to BMOPF's own IVR-EN engine. The two solvers agree on every
# dispatch and voltage to < 1e-2 W / 1e-3 V. As in pmd_opf_port_tests.jl the
# numbers are hardcoded, so the suite needs no PMD/PowerIO dependency at test
# time; each network is built directly in BMOPF's native JSON schema.
#
# Modelling notes
# ---------------
#   · Source: a stiff 230 V phase-to-ground wye source at 0/-120/+120°, modelled
#     as an ideal BMOPF voltage source; perfectly-grounded "n" terminal at every
#     bus (ideal return), so phase-to-ground = phase-to-neutral.
#   · A DER is a `generator` at the feeder end. A per-phase linear `cost` ($/W)
#     sets the objective direction: cost < 0 maximises export (A, B, D), cost > 0
#     minimises local injection (C); pricing the source while the DER is reactive
#     -only drives reactive support to its ceiling (E). The binding-bound optimum
#     is a boundary point, independent of the cost magnitude.
#   · Lines use diagonal R/X linecodes (Ω, length = 1). The bus `v_min`/`v_max`
#     are phase-to-ground magnitude bounds; `i_max` on a linecode/switch is the
#     per-conductor current rating (A); generator `p_min/p_max`, `q_min/q_max`
#     are the per-phase dispatch box (W/var).

@testset "OPF bound-binding — validated against PowerModelsDistribution" begin

    # Stiff source phase-to-ground magnitude.
    V_PH = 230.0

    "Σ over phases of the voltage-source injection, returned in kW and kvar."
    function _source_kw_kvar(res, sid="source")
        vs = res["voltage_source"][sid]
        p = sum(vs[ph]["ps"] for ph in keys(vs))
        q = sum(vs[ph]["qs"] for ph in keys(vs))
        return p / 1000.0, q / 1000.0
    end

    "Σ over phases of a generator's dispatch, returned in kW and kvar."
    function _gen_kw_kvar(res, gid="der")
        g = res["generator"][gid]
        p = sum(g[ph]["pg"] for ph in keys(g))
        q = sum(g[ph]["qg"] for ph in keys(g))
        return p / 1000.0, q / 1000.0
    end

    # ─────────────────────────────────────────────────────────────────────────
    # Case A — voltage UPPER bound binds (PV/DER export hosting limit).
    # A unity-PF DER (q fixed to 0) is paid to export (cost = -1 ⇒ maximise pg).
    # Injecting real power up an R/X = 0.3/0.1 Ω line raises the local voltage;
    # with p_max slack at 100 kW the export is capped by v_max = 235 V, binding
    # on every phase.
    # PMD IVREN target: Σpg = 11.7642 kW, load-bus |U| = v_max, Σps = -11.5136 kW.
    # ─────────────────────────────────────────────────────────────────────────
    @testset "A: v_max binds — Σpg=11.7642 kW, |U|=235 V" begin
        net = parse_bmopf("""
        {"bus":{
            "sourcebus":{"terminal_names":["1","2","3","n"],"perfectly_grounded_terminals":["n"]},
            "loadbus":  {"terminal_names":["1","2","3","n"],"perfectly_grounded_terminals":["n"],
                         "v_min":[220.0,220.0,220.0],"v_max":[235.0,235.0,235.0]}},
         "voltage_source":{"source":{"bus":"sourcebus","terminal_map":["1","2","3"],
             "v_magnitude":[$(V_PH),$(V_PH),$(V_PH)],"v_angle":[0.0,-2.0943951,2.0943951]}},
         "linecode":{"lc":{"R_series_1_1":0.3,"R_series_2_2":0.3,"R_series_3_3":0.3,
                           "X_series_1_1":0.1,"X_series_2_2":0.1,"X_series_3_3":0.1}},
         "line":{"l1":{"bus_from":"sourcebus","bus_to":"loadbus",
             "terminal_map_from":["1","2","3"],"terminal_map_to":["1","2","3"],"linecode":"lc","length":1.0}},
         "generator":{"der":{"bus":"loadbus","terminal_map":["1","2","3","n"],"configuration":"WYE",
             "p_min":[0.0,0.0,0.0],"p_max":[100000.0,100000.0,100000.0],
             "q_min":[0.0,0.0,0.0],"q_max":[0.0,0.0,0.0],"cost":[-1.0,-1.0,-1.0]}}}
        """; from_string=true)

        res = solve_opf(net)
        @test res["termination_status"] in ("LOCALLY_SOLVED", "OPTIMAL")
        # binding bound: every load-bus phase sits exactly on v_max
        for ph in ("1","2","3")
            @test res["bus"]["loadbus"][ph]["vm"] ≈ 235.0  atol=1e-2
        end
        pg, qg = _gen_kw_kvar(res)
        @test pg ≈ 11.7642  atol=1e-2
        @test qg ≈ 0.0      atol=1e-2     # unity power factor
        ps, _ = _source_kw_kvar(res)
        @test ps ≈ -11.5136 atol=1e-2     # net export to the grid
    end

    # ─────────────────────────────────────────────────────────────────────────
    # Case B — line CURRENT (thermal) limit binds.
    # Same export incentive, voltage band widened (v_max = 255 V, never reached);
    # the conductor carries a thermal rating i_max = 25 A. The export is capped by
    # ampacity (linecode i_max → PMD branch cm_ub), binding on every phase.
    # PMD IVREN target: Σpg = 17.6243 kW, |I_line| = 25 A.
    # ─────────────────────────────────────────────────────────────────────────
    @testset "B: line i_max binds — Σpg=17.6243 kW, |I|=25 A" begin
        net = parse_bmopf("""
        {"bus":{
            "sourcebus":{"terminal_names":["1","2","3","n"],"perfectly_grounded_terminals":["n"]},
            "loadbus":  {"terminal_names":["1","2","3","n"],"perfectly_grounded_terminals":["n"],
                         "v_min":[215.0,215.0,215.0],"v_max":[255.0,255.0,255.0]}},
         "voltage_source":{"source":{"bus":"sourcebus","terminal_map":["1","2","3"],
             "v_magnitude":[$(V_PH),$(V_PH),$(V_PH)],"v_angle":[0.0,-2.0943951,2.0943951]}},
         "linecode":{"lc":{"R_series_1_1":0.2,"R_series_2_2":0.2,"R_series_3_3":0.2,
                           "X_series_1_1":0.08,"X_series_2_2":0.08,"X_series_3_3":0.08,
                           "i_max":[25.0,25.0,25.0]}},
         "line":{"l1":{"bus_from":"sourcebus","bus_to":"loadbus",
             "terminal_map_from":["1","2","3"],"terminal_map_to":["1","2","3"],"linecode":"lc","length":1.0}},
         "generator":{"der":{"bus":"loadbus","terminal_map":["1","2","3","n"],"configuration":"WYE",
             "p_min":[0.0,0.0,0.0],"p_max":[100000.0,100000.0,100000.0],
             "q_min":[0.0,0.0,0.0],"q_max":[0.0,0.0,0.0],"cost":[-1.0,-1.0,-1.0]}}}
        """; from_string=true)

        res = solve_opf(net)
        @test res["termination_status"] in ("LOCALLY_SOLVED", "OPTIMAL")
        # binding bound: line current at the thermal rating on every phase
        for ph in ("1","2","3")
            @test res["line"]["l1"][ph]["cm_fr"] ≈ 25.0  atol=1e-2
            @test res["line"]["l1"][ph]["cm_to"] ≈ 25.0  atol=1e-2
        end
        @test res["bus"]["loadbus"]["1"]["vm"] < 255.0   # voltage limit is NOT active
        pg, _ = _gen_kw_kvar(res)
        @test pg ≈ 17.6243  atol=1e-2
    end

    # ─────────────────────────────────────────────────────────────────────────
    # Case C — voltage LOWER bound binds (undervoltage support).
    # A heavy 40 kW/phase load down a high-impedance R/X = 0.6/0.2 Ω feeder would
    # collapse the load-bus voltage below v_min = 218 V if served from the grid
    # alone. A DER with a positive cost (+1 ⇒ minimise own output) injects only as
    # much real power as the floor requires, so |U| rests exactly on v_min.
    # PMD IVREN target: Σpg = 106.958 kW, load-bus |U| = v_min.
    # ─────────────────────────────────────────────────────────────────────────
    @testset "C: v_min binds — Σpg=106.958 kW, |U|=218 V" begin
        net = parse_bmopf("""
        {"bus":{
            "sourcebus":{"terminal_names":["1","2","3","n"],"perfectly_grounded_terminals":["n"]},
            "loadbus":  {"terminal_names":["1","2","3","n"],"perfectly_grounded_terminals":["n"],
                         "v_min":[218.0,218.0,218.0],"v_max":[245.0,245.0,245.0]}},
         "voltage_source":{"source":{"bus":"sourcebus","terminal_map":["1","2","3"],
             "v_magnitude":[$(V_PH),$(V_PH),$(V_PH)],"v_angle":[0.0,-2.0943951,2.0943951]}},
         "linecode":{"lc":{"R_series_1_1":0.6,"R_series_2_2":0.6,"R_series_3_3":0.6,
                           "X_series_1_1":0.2,"X_series_2_2":0.2,"X_series_3_3":0.2}},
         "line":{"l1":{"bus_from":"sourcebus","bus_to":"loadbus",
             "terminal_map_from":["1","2","3"],"terminal_map_to":["1","2","3"],"linecode":"lc","length":1.0}},
         "load":{"ld":{"bus":"loadbus","terminal_map":["1","2","3","n"],"configuration":"WYE",
             "p_nom":[40000.0,40000.0,40000.0],"q_nom":[0.0,0.0,0.0]}},
         "generator":{"der":{"bus":"loadbus","terminal_map":["1","2","3","n"],"configuration":"WYE",
             "p_min":[0.0,0.0,0.0],"p_max":[100000.0,100000.0,100000.0],
             "q_min":[0.0,0.0,0.0],"q_max":[0.0,0.0,0.0],"cost":[1.0,1.0,1.0]}}}
        """; from_string=true)

        res = solve_opf(net)
        @test res["termination_status"] in ("LOCALLY_SOLVED", "OPTIMAL")
        # binding bound: load-bus voltage held exactly at the v_min floor
        for ph in ("1","2","3")
            @test res["bus"]["loadbus"][ph]["vm"] ≈ 218.0  atol=1e-2
        end
        pg, _ = _gen_kw_kvar(res)
        @test pg ≈ 106.958  atol=1e-2
        @test res["objective"] ≈ 106957.697  atol=1.0    # cost(+1)·Σpg
    end

    # ─────────────────────────────────────────────────────────────────────────
    # Case D — SWITCH current limit binds.
    # As Case B, but the rating lives on a closed switch (i_max = 18 A) one bus
    # downstream of the DER. The export is throttled by the switch ampacity
    # (switch i_max → PMD cm_ub), and the zero-impedance closed-switch coupling
    # ties the two bus voltages (U_swbus = U_derbus).
    # PMD IVREN target: Σpg = 12.6142 kW, |I_switch| = 18 A.
    # ─────────────────────────────────────────────────────────────────────────
    @testset "D: switch i_max binds — Σpg=12.6142 kW, |I|=18 A" begin
        net = parse_bmopf("""
        {"bus":{
            "sourcebus":{"terminal_names":["1","2","3","n"],"perfectly_grounded_terminals":["n"]},
            "swbus":    {"terminal_names":["1","2","3","n"],"perfectly_grounded_terminals":["n"]},
            "derbus":   {"terminal_names":["1","2","3","n"],"perfectly_grounded_terminals":["n"],
                         "v_min":[215.0,215.0,215.0],"v_max":[255.0,255.0,255.0]}},
         "voltage_source":{"source":{"bus":"sourcebus","terminal_map":["1","2","3"],
             "v_magnitude":[$(V_PH),$(V_PH),$(V_PH)],"v_angle":[0.0,-2.0943951,2.0943951]}},
         "linecode":{"lc":{"R_series_1_1":0.2,"R_series_2_2":0.2,"R_series_3_3":0.2,
                           "X_series_1_1":0.08,"X_series_2_2":0.08,"X_series_3_3":0.08}},
         "line":{"l1":{"bus_from":"sourcebus","bus_to":"swbus",
             "terminal_map_from":["1","2","3"],"terminal_map_to":["1","2","3"],"linecode":"lc","length":1.0}},
         "switch":{"sw":{"bus_from":"swbus","bus_to":"derbus",
             "terminal_map_from":["1","2","3"],"terminal_map_to":["1","2","3"],
             "open_switch":false,"i_max":[18.0,18.0,18.0]}},
         "generator":{"der":{"bus":"derbus","terminal_map":["1","2","3","n"],"configuration":"WYE",
             "p_min":[0.0,0.0,0.0],"p_max":[100000.0,100000.0,100000.0],
             "q_min":[0.0,0.0,0.0],"q_max":[0.0,0.0,0.0],"cost":[-1.0,-1.0,-1.0]}}}
        """; from_string=true)

        res = solve_opf(net)
        @test res["termination_status"] in ("LOCALLY_SOLVED", "OPTIMAL")
        # binding bound: switch current at its rating on every phase
        for ph in ("1","2","3")
            @test res["switch"]["sw"][ph]["cm"] ≈ 18.0  atol=1e-2
        end
        # closed switch couples the two bus voltages
        for ph in ("1","2","3")
            @test res["bus"]["swbus"][ph]["vm"] ≈ res["bus"]["derbus"][ph]["vm"]  atol=1e-6
        end
        pg, _ = _gen_kw_kvar(res)
        @test pg ≈ 12.6142  atol=1e-2
    end

    # ─────────────────────────────────────────────────────────────────────────
    # Case E — generator REACTIVE bound binds (reactive voltage support).
    # An inductive 18 kW + 15 kvar/phase load pulls the load-bus voltage down a
    # symmetric R/X = 0.2/0.2 Ω feeder. The DER injects no real power (p_max = 0)
    # and provides reactive support; because the priced grid source (+1 $/W)
    # rewards cutting the real losses that reactive injection removes, the DER is
    # driven to its reactive ceiling q_max = 8 kvar/phase.
    # PMD IVREN target: Σqg = 24.0 kvar (8 kvar/phase = q_max), pg ≈ 0,
    # source imports Σps = 59.304 kW.
    # ─────────────────────────────────────────────────────────────────────────
    @testset "E: gen q_max binds — Qg=8 kvar/ph, pg≈0" begin
        net = parse_bmopf("""
        {"bus":{
            "sourcebus":{"terminal_names":["1","2","3","n"],"perfectly_grounded_terminals":["n"]},
            "loadbus":  {"terminal_names":["1","2","3","n"],"perfectly_grounded_terminals":["n"],
                         "v_min":[205.0,205.0,205.0],"v_max":[245.0,245.0,245.0]}},
         "voltage_source":{"source":{"bus":"sourcebus","terminal_map":["1","2","3"],
             "v_magnitude":[$(V_PH),$(V_PH),$(V_PH)],"v_angle":[0.0,-2.0943951,2.0943951],
             "cost":[1.0,1.0,1.0]}},
         "linecode":{"lc":{"R_series_1_1":0.2,"R_series_2_2":0.2,"R_series_3_3":0.2,
                           "X_series_1_1":0.2,"X_series_2_2":0.2,"X_series_3_3":0.2}},
         "line":{"l1":{"bus_from":"sourcebus","bus_to":"loadbus",
             "terminal_map_from":["1","2","3"],"terminal_map_to":["1","2","3"],"linecode":"lc","length":1.0}},
         "load":{"ld":{"bus":"loadbus","terminal_map":["1","2","3","n"],"configuration":"WYE",
             "p_nom":[18000.0,18000.0,18000.0],"q_nom":[15000.0,15000.0,15000.0]}},
         "generator":{"der":{"bus":"loadbus","terminal_map":["1","2","3","n"],"configuration":"WYE",
             "p_min":[0.0,0.0,0.0],"p_max":[0.0,0.0,0.0],
             "q_min":[0.0,0.0,0.0],"q_max":[8000.0,8000.0,8000.0]}}}
        """; from_string=true)

        res = solve_opf(net)
        @test res["termination_status"] in ("LOCALLY_SOLVED", "OPTIMAL")
        # binding bound: DER reactive output pinned at q_max on every phase
        for ph in ("1","2","3")
            @test res["generator"]["der"][ph]["qg"] ≈ 8000.0  atol=1.0
            @test res["generator"]["der"][ph]["pg"] ≈ 0.0     atol=1e-2
        end
        pg, qg = _gen_kw_kvar(res)
        @test qg ≈ 24.0  atol=1e-2
        @test pg ≈ 0.0   atol=1e-2
        ps, _ = _source_kw_kvar(res)
        @test ps ≈ 59.304  atol=1e-2     # grid supplies all real power
    end
end
