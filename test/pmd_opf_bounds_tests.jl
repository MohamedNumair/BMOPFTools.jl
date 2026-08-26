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
#   · A DER is a `generator` at the feeder end. A per-phase linear `cost` ($/kWh;
#     the objective is cost·P/1000 in $/h, see `_add_objective!`)
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
        @test res["objective"] ≈ 106.957697  atol=1e-3   # cost(+1 /kWh)·Σpg/1000, currency/h
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

    # ─────────────────────────────────────────────────────────────────────────
    # Case G1 — phase-to-neutral UPPER bound (vpn_max) binds (#157).
    # Four-wire feeder (explicit neutral conductor, grounded ONLY at the
    # source), two DERs: a three-phase der_m at the mid bus whose reward
    # (cost −3) saturates its 9 kW/phase box, and a SINGLE-PHASE der_e (1–n)
    # at the end bus (cost −1) whose export displaces the neutral until the
    # phase-1 PHASE-TO-NEUTRAL magnitude hits vpn_max = 240 V. The displaced
    # neutral (|Vₙ| ≈ 19.5 V) keeps the phase-to-ground magnitude ~10 V away
    # from the cap, so a phase-to-ground mis-encoding cannot pass.
    # Fixture: test/data/pmd_bounds/G1_vpn_max.json (shared with the
    # reproduction script). PMD IVREN target (flat start, identical digits):
    # der_m Σpg = 27.0 kW, der_e Σpg = 3.3943 kW, |V_pn(buse)| =
    # [240.0, 188.6497, 233.4057] V. Cost-ratio perturbations move the split
    # (der_e at −9 pulls der_m phase 1 off its box), so the arbitration is
    # non-degenerate. Reproduce with scripts/pmd_reproduction/ivren_cases.jl.
    # ─────────────────────────────────────────────────────────────────────────
    @testset "G1: vpn_max binds — der_m 27 kW (box), der_e 3.3943 kW, |Vpn|=240 V" begin
        net = parse_bmopf(joinpath(@__DIR__, "data", "pmd_bounds", "G1_vpn_max.json"))
        res = solve_opf(net)
        @test res["termination_status"] in ("LOCALLY_SOLVED", "OPTIMAL")
        # binding bound: phase-1 pn magnitude at vpn_max, recomputed from the
        # primal (vr/vi differences), never from the constraint expression
        b  = res["bus"]["buse"]
        vn = b["n"]["vr"] + im * b["n"]["vi"]
        vpn = [abs(b[ph]["vr"] + im * b[ph]["vi"] - vn) for ph in ("1", "2", "3")]
        @test vpn[1] ≈ 240.0    atol=1e-2
        @test vpn[2] ≈ 188.6497 atol=1e-2    # strictly inside the cap
        @test vpn[3] ≈ 233.4057 atol=1e-2
        # it is the pn quantity that binds, NOT phase-to-ground
        @test abs(b["1"]["vr"] + im * b["1"]["vi"]) ≈ 229.7744 atol=1e-2
        @test abs(vn) ≈ 19.5308 atol=1e-2
        # two-generator arbitration: der_m saturated, der_e interior
        for ph in ("1", "2", "3")
            @test res["generator"]["der_m"][ph]["pg"] ≈ 9000.0 atol=1.0
        end
        @test res["generator"]["der_e"]["1"]["pg"] ≈ 3394.3 atol=10.0
        @test res["objective"] ≈ -84.3943 atol=1e-3   # (−3·27 − 1·3.3943) $/h
    end

    # ─────────────────────────────────────────────────────────────────────────
    # Case G2 — phase-to-neutral LOWER bound (vpn_min) binds (#157).
    # Mirror of Case C in the pn quantity: the same four-wire two-DER feeder,
    # phase-2-heavy loads (busm [5,9,4] kW, buse [2,12,2] kW) sag the end-bus
    # pn voltages; positive costs make generation a last resort, so the
    # vpn_min = 218 V floor is what forces support. The cheap SINGLE-PHASE
    # der_e (2–n, +1) saturates its 4 kW box; the dear three-phase der_m (+3)
    # covers the remainder — dispatching per phase until every pn magnitude
    # lands exactly on the floor (no overshoot: floors bind on all three).
    # The displaced neutral keeps |V_pg| up to 0.30 V off the floor (30× the
    # assert tolerance), so a phase-to-ground mis-encoding cannot pass.
    # Fixture: test/data/pmd_bounds/G2_vpn_min.json. PMD IVREN target (flat
    # start, identical digits): der_m Σpg = 23.7793 kW ([2.3358, 19.8182,
    # 1.6253]), der_e Σpg = 4.0 kW. A der_e ×9 cost perturbation flips the
    # split (der_m → 34.03 kW), so the arbitration is non-degenerate.
    # Reproduce with scripts/pmd_reproduction/ivren_cases.jl.
    # ─────────────────────────────────────────────────────────────────────────
    @testset "G2: vpn_min binds — der_e 4 kW (box), der_m 23.7793 kW, |Vpn|=218 V" begin
        net = parse_bmopf(joinpath(@__DIR__, "data", "pmd_bounds", "G2_vpn_min.json"))
        res = solve_opf(net)
        @test res["termination_status"] in ("LOCALLY_SOLVED", "OPTIMAL")
        b  = res["bus"]["buse"]
        vn = b["n"]["vr"] + im * b["n"]["vi"]
        # binding bound: every pn magnitude held exactly at the vpn_min floor,
        # recomputed from the primal
        for (k, ph) in enumerate(("1", "2", "3"))
            @test abs(b[ph]["vr"] + im * b[ph]["vi"] - vn) ≈ 218.0 atol=1e-2
        end
        # the pn quantity binds, NOT phase-to-ground
        @test abs(b["1"]["vr"] + im * b["1"]["vi"]) ≈ 217.6962 atol=1e-2
        @test abs(vn) ≈ 0.3131 atol=1e-2
        # two-generator arbitration: cheap der_e saturated, dear der_m interior
        @test res["generator"]["der_e"]["2"]["pg"] ≈ 4000.0 atol=1.0
        for (ph, pg) in (("1", 2335.8), ("2", 19818.2), ("3", 1625.3))
            @test res["generator"]["der_m"][ph]["pg"] ≈ pg atol=10.0
        end
        @test res["objective"] ≈ 75.3379 atol=1e-3   # (3·23.7793 + 1·4) $/h
    end

    # ─────────────────────────────────────────────────────────────────────────
    # Case F — NEUTRAL voltage upper bound (vn_max) binds (#157).
    # Same four-wire feeder, near-balanced loads (so the baseline neutral
    # displacement stays well under the cap). Two SINGLE-PHASE exporters sit on
    # different phases of the end bus (der_e on 1–n at −1, der_m on 3–n at −3):
    # each unit's export displaces the ungrounded end-bus neutral in a
    # different complex direction, so |Vₙ| ≤ vn_max = 6 V is a shared 2-D disc
    # budget whose curved boundary arbitrates the two units continuously —
    # both land interior with the cap exactly active. Cost-ratio perturbations
    # slide the split along the boundary (×9 on either unit moves both
    # dispatches), so the arbitration is non-degenerate.
    # Fixture: test/data/pmd_bounds/F_vn_max.json. PMD IVREN target (flat
    # start, identical digits): der_e = 0.4008 kW, der_m = 0.5809 kW,
    # |Vₙ(buse)| = 6.0 V, |Vₙ(busm)| = 3.577 V (strictly inside — the bound is
    # per-bus). Reproduce with scripts/pmd_reproduction/ivren_cases.jl.
    # ─────────────────────────────────────────────────────────────────────────
    @testset "F: vn_max binds — |Vn|=6 V, der_e 0.4008 kW, der_m 0.5809 kW" begin
        net = parse_bmopf(joinpath(@__DIR__, "data", "pmd_bounds", "F_vn_max.json"))
        res = solve_opf(net)
        @test res["termination_status"] in ("LOCALLY_SOLVED", "OPTIMAL")
        # binding bound: the neutral-to-ground magnitude at the cap, recomputed
        # from the primal as √(vrₙ² + viₙ²)
        bn = res["bus"]["buse"]["n"]
        @test abs(bn["vr"] + im * bn["vi"]) ≈ 6.0 atol=1e-2
        # the un-capped mid-bus neutral sits strictly inside
        mn = res["bus"]["busm"]["n"]
        @test abs(mn["vr"] + im * mn["vi"]) ≈ 3.577 atol=1e-2
        # phase-to-ground magnitudes are nowhere near the cap or the guards
        for (ph, vm) in (("1", 200.0687), ("2", 195.2269), ("3", 203.0483))
            b = res["bus"]["buse"][ph]
            @test abs(b["vr"] + im * b["vi"]) ≈ vm atol=1e-2
        end
        # two-generator arbitration on the shared disc budget
        @test res["generator"]["der_e"]["1"]["pg"] ≈ 400.8 atol=10.0
        @test res["generator"]["der_m"]["3"]["pg"] ≈ 580.9 atol=10.0
        @test res["objective"] ≈ -2.1435 atol=1e-3   # (−3·0.5809 − 1·0.4008) $/h
    end

    # ─────────────────────────────────────────────────────────────────────────
    # Case H1 — phase-to-phase UPPER bound (vpp_max) binds (#157).
    # Three-wire grounded feeder (A–E style), vpp_max = 405 V on the end bus
    # only. The three-phase der_m (−3) saturates its 9 kW/phase box; the
    # SINGLE-PHASE der_e (1–n, −1) raises phase 1 until the (1,2) pair spread
    # hits the cap. Because only one unit phase is free, the pairs cannot
    # equalise: (1,2) binds at exactly 405 V while (1,3)/(2,3) stay strictly
    # inside (403.2 / 373.1 V) and the phase magnitudes are wildly unequal
    # (248.6 / 210.7 / 222.5 V — far from 405/√3 ≈ 233.8), so a √3-scaled
    # per-phase mis-encoding cannot pass. The unbounded MID bus even carries
    # pair spreads above 405 V (406.05), proving the bound is per-bus.
    # Fixture: test/data/pmd_bounds/H1_vpp_max.json. PMD IVREN target (flat
    # start, identical digits): der_m Σpg = 27.0 kW, der_e = 9.2675 kW. A
    # der_e ×9 cost perturbation pulls der_m off its box (15.59 / 15.06 kW).
    # Reproduce with scripts/pmd_reproduction/ivren_cases.jl.
    # ─────────────────────────────────────────────────────────────────────────
    @testset "H1: vpp_max binds — pair (1,2) at 405 V, der_m 27 kW, der_e 9.2675 kW" begin
        net = parse_bmopf(joinpath(@__DIR__, "data", "pmd_bounds", "H1_vpp_max.json"))
        res = solve_opf(net)
        @test res["termination_status"] in ("LOCALLY_SOLVED", "OPTIMAL")
        b = res["bus"]["buse"]
        v = [b[ph]["vr"] + im * b[ph]["vi"] for ph in ("1", "2", "3")]
        # binding bound: pair (1,2) spread at vpp_max, recomputed from the
        # primal; the other pairs strictly inside
        @test abs(v[1] - v[2]) ≈ 405.0    atol=1e-2
        @test abs(v[1] - v[3]) ≈ 403.2167 atol=1e-2
        @test abs(v[2] - v[3]) ≈ 373.1262 atol=1e-2
        # phase magnitudes are far from 405/√3 — a per-phase mis-encoding fails
        for (ph, vm) in (("1", 248.6102), ("2", 210.6816), ("3", 222.5378))
            @test abs(b[ph]["vr"] + im * b[ph]["vi"]) ≈ vm atol=1e-2
        end
        # the unbounded mid bus carries a pair spread ABOVE the cap
        bm = res["bus"]["busm"]
        vm13 = abs(bm["1"]["vr"] + im * bm["1"]["vi"] - bm["3"]["vr"] - im * bm["3"]["vi"])
        @test vm13 ≈ 406.0473 atol=1e-2
        @test vm13 > 405.0
        # two-generator arbitration: der_m saturated, der_e interior
        for ph in ("1", "2", "3")
            @test res["generator"]["der_m"][ph]["pg"] ≈ 9000.0 atol=1.0
        end
        @test res["generator"]["der_e"]["1"]["pg"] ≈ 9267.5 atol=10.0
        @test res["objective"] ≈ -90.2675 atol=1e-3   # (−3·27 − 1·9.2675) $/h
    end

    # ─────────────────────────────────────────────────────────────────────────
    # Case H2 — phase-to-phase LOWER bound (vpp_min) binds (#157).
    # Same three-wire feeder, per-pair floors [395, 375, 375] V on the end bus
    # (BMOPF's vpp_min is per-pair — the non-uniform floors travel to PMD as
    # explicit vm_pair_lb tuples, the exact per-pair semantics). Heavy loads
    # sag the spreads; positive costs make support a last resort. The cheap
    # der_e (+1) saturates phases 1–2 of its 5 kW box, the dear der_m (+3)
    # covers the remainder: pairs (1,2) and (2,3) land exactly on their
    # different floors while (1,3) stays slack at 385.86 V, and the phase
    # magnitudes are visibly unequal — a √3-scaled per-phase mis-encoding
    # cannot produce two different binding pair values at once.
    # Fixture: test/data/pmd_bounds/H2_vpp_min.json. PMD IVREN target (flat
    # start, identical digits): der_e Σpg = 12.4209 kW, der_m Σpg = 11.0412 kW.
    # A der_e ×9 perturbation flips the order (der_m → 33.62 kW, der_e → 0).
    # Reproduce with scripts/pmd_reproduction/ivren_cases.jl.
    # ─────────────────────────────────────────────────────────────────────────
    @testset "H2: vpp_min binds — pairs at 395/375 V, der_e 12.4209 kW, der_m 11.0412 kW" begin
        net = parse_bmopf(joinpath(@__DIR__, "data", "pmd_bounds", "H2_vpp_min.json"))
        res = solve_opf(net)
        @test res["termination_status"] in ("LOCALLY_SOLVED", "OPTIMAL")
        b = res["bus"]["buse"]
        v = [b[ph]["vr"] + im * b[ph]["vi"] for ph in ("1", "2", "3")]
        # binding bounds: two pairs on their (different) floors, one slack —
        # recomputed from the primal
        @test abs(v[1] - v[2]) ≈ 395.0    atol=1e-2
        @test abs(v[1] - v[3]) ≈ 385.8594 atol=1e-2   # strictly inside
        @test abs(v[2] - v[3]) ≈ 375.0    atol=1e-2
        # unequal phase magnitudes — not a per-phase bound in disguise
        for (ph, vm) in (("1", 234.7999), ("2", 217.5709), ("3", 214.8865))
            @test abs(b[ph]["vr"] + im * b[ph]["vi"]) ≈ vm atol=1e-2
        end
        # two-generator arbitration: der_e box-saturated on phases 1–2,
        # der_m interior (phase 3 at its 0 floor)
        @test res["generator"]["der_e"]["1"]["pg"] ≈ 5000.0 atol=1.0
        @test res["generator"]["der_e"]["2"]["pg"] ≈ 5000.0 atol=1.0
        @test res["generator"]["der_e"]["3"]["pg"] ≈ 2420.8 atol=10.0
        @test res["generator"]["der_m"]["1"]["pg"] ≈ 8821.7 atol=10.0
        @test res["generator"]["der_m"]["2"]["pg"] ≈ 2219.6 atol=10.0
        @test res["generator"]["der_m"]["3"]["pg"] ≈ 0.0    atol=1.0
        @test res["objective"] ≈ 45.5445 atol=1e-3   # (3·11.0412 + 1·12.4209) $/h
    end
end