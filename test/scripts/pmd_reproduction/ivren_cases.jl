# Reproduce the explicit-neutral (IVREN) bound-binding targets of
# test/pmd_opf_bounds_tests.jl. See README.md. Not run in CI.
#
# Produced with: PowerModelsDistribution v0.16.0 (dev checkout), Ipopt via JuMP.

include(joinpath(@__DIR__, "common.jl"))

# ─────────────────────────────────────────────────────────────────────────────
# Pipeline check — Case A (locked in the testset): the helpers must reproduce
# Σpg = 11.7642 kW with the load bus pinned at v_max = 235 V before any new
# case is trusted.
# ─────────────────────────────────────────────────────────────────────────────
let
    net = parse_bmopf("""
    {"bus":{
        "sourcebus":{"terminal_names":["1","2","3","n"],"perfectly_grounded_terminals":["n"]},
        "loadbus":  {"terminal_names":["1","2","3","n"],"perfectly_grounded_terminals":["n"],
                     "v_min":[220.0,220.0,220.0],"v_max":[235.0,235.0,235.0]}},
     "voltage_source":{"source":{"bus":"sourcebus","terminal_map":["1","2","3"],
         "v_magnitude":[230.0,230.0,230.0],"v_angle":[0.0,-2.0943951,2.0943951]}},
     "linecode":{"lc":{"R_series_1_1":0.3,"R_series_2_2":0.3,"R_series_3_3":0.3,
                       "X_series_1_1":0.1,"X_series_2_2":0.1,"X_series_3_3":0.1}},
     "line":{"l1":{"bus_from":"sourcebus","bus_to":"loadbus",
         "terminal_map_from":["1","2","3"],"terminal_map_to":["1","2","3"],"linecode":"lc","length":1.0}},
     "generator":{"der":{"bus":"loadbus","terminal_map":["1","2","3","n"],"configuration":"WYE",
         "p_min":[0.0,0.0,0.0],"p_max":[100000.0,100000.0,100000.0],
         "q_min":[0.0,0.0,0.0],"q_max":[0.0,0.0,0.0],"cost":[-1.0,-1.0,-1.0]}}}
    """; from_string=true)
    res, sol, _ = solve_pmd_en(net; gen_costs=Dict("der" => -1.0))
    disp = pmd_dispatch(sol)
    vm = pmd_vm(sol, "loadbus")
    ok = isapprox(disp["der"].pg, 11.7642; atol=1e-3) &&
         all(isapprox.(vm[1:3], 235.0; atol=1e-2))
    println("pipeline check (Case A): ", ok ? "OK" : "FAILED",
            "  Σpg = ", round(disp["der"].pg; digits=4), " kW, |V| = ",
            round.(vm[1:3]; digits=3))
    ok || error("pipeline check failed — do not derive new targets with these helpers")
end

# ─────────────────────────────────────────────────────────────────────────────
# Case G1 — vpn_max binds (four-wire, two DERs). See the testset provenance
# comment. PMD converges to the BMOPF optimum from a FLAT start; the two
# cost-ratio perturbations must move the dispatch split (non-degeneracy gate).
# ─────────────────────────────────────────────────────────────────────────────
let
    costs0 = Dict("der_m" => -3.0, "der_e" => -1.0)
    function solve_g1(costs)
        net = load_fixture("G1_vpn_max")
        _, sol, _ = solve_pmd_en(net; gen_costs=costs)
        pmd_dispatch(sol), sol
    end
    disp, sol = solve_g1(costs0)
    vpn = [abs((sol["bus"]["buse"]["vr"][k] + im * sol["bus"]["buse"]["vi"][k]) -
               (sol["bus"]["buse"]["vr"][4] + im * sol["bus"]["buse"]["vi"][4])) for k in 1:3]
    print_targets("G1_vpn_max", disp,
                  "|V_pn|(buse)" => round.(vpn; digits=4),
                  "|V_n|(buse)" => round(abs(sol["bus"]["buse"]["vr"][4] +
                                             im * sol["bus"]["buse"]["vi"][4]); digits=4))
    perturbation_check(c -> solve_g1(c)[1], costs0, ["der_m", "der_e"]; ratio=9.0)
end

# ─────────────────────────────────────────────────────────────────────────────
# Case G2 — vpn_min binds (four-wire, two DERs, cost-minimised support).
# Flat start; the der_e ×9 perturbation must flip the dispatch order.
# ─────────────────────────────────────────────────────────────────────────────
let
    costs0 = Dict("der_m" => 3.0, "der_e" => 1.0)
    function solve_g2(costs)
        net = load_fixture("G2_vpn_min")
        _, sol, _ = solve_pmd_en(net; gen_costs=costs)
        pmd_dispatch(sol), sol
    end
    disp, sol = solve_g2(costs0)
    v = sol["bus"]["buse"]["vr"] .+ im .* sol["bus"]["buse"]["vi"]
    print_targets("G2_vpn_min", disp,
                  "|V_pn|(buse)" => round.([abs(v[k] - v[4]) for k in 1:3]; digits=4),
                  "|V_n|(buse)" => round(abs(v[4]); digits=4),
                  "der_m per-ph pg (kW)" => round.(sol["generator"]["der_m"]["pg"] ./ 1000; digits=4))
    perturbation_check(c -> solve_g2(c)[1], costs0, ["der_m", "der_e"]; ratio=9.0)
end

# ─────────────────────────────────────────────────────────────────────────────
# Case F — vn_max binds (four-wire, two single-phase DERs on different phases
# sharing the |Vₙ| ≤ 6 V disc budget). Flat start; both ×9 cost perturbations
# must slide the split along the disc boundary.
# ─────────────────────────────────────────────────────────────────────────────
let
    costs0 = Dict("der_m" => -3.0, "der_e" => -1.0)
    function solve_f(costs)
        net = load_fixture("F_vn_max")
        _, sol, _ = solve_pmd_en(net; gen_costs=costs)
        pmd_dispatch(sol), sol
    end
    disp, sol = solve_f(costs0)
    v = sol["bus"]["buse"]["vr"] .+ im .* sol["bus"]["buse"]["vi"]
    vm_busm_n = abs(sol["bus"]["busm"]["vr"][4] + im * sol["bus"]["busm"]["vi"][4])
    print_targets("F_vn_max", disp,
                  "|V_n|(buse)" => round(abs(v[4]); digits=4),
                  "|V_n|(busm)" => round(vm_busm_n; digits=4),
                  "|V_pg|(buse)" => round.(abs.(v[1:3]); digits=4))
    perturbation_check(c -> solve_f(c)[1], costs0, ["der_m", "der_e"]; ratio=9.0)
end
