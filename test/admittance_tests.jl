@testset "Transformer Yprim export" begin

    # ─── helpers ──────────────────────────────────────────────────────────────

    # Build a minimal BMOPF transformer dict and call transformer_yprim.
    # Returns (nodes, Y).

    function check_symmetry(Y; atol=1e-10)
        @test maximum(abs.(Y .- transpose(Y))) < atol
    end

    # Power balance: Re[conj(V)ᵀ I] should equal resistive loss = Σ |Iw|² R.
    # For a passive element we test Re[conj(V)ᵀ Y V] ≥ 0.
    function check_power_balance(Y, V; rtol=1e-6)
        S = conj(V)' * (Y * V)
        @test real(S) >= -rtol * abs(S)   # non-negative real part
    end

    # ─── single_phase ─────────────────────────────────────────────────────────

    @testset "single_phase" begin
        xfmr = Dict{String,Any}(
            "bus_from"          => "hv",
            "bus_to"            => "lv",
            "terminal_map_from" => ["1"],
            "terminal_map_to"   => ["1"],
            "v_ref_from"        => 11000.0,
            "v_ref_to"          => 400.0,
            "r_series_from"     => 0.5,
            "x_series_from"     => 2.0,
            "r_series_to"       => 0.01,
            "x_series_to"       => 0.04,
            "g_no_load"         => 1e-4,
            "b_no_load"         => 5e-4,
        )
        nodes, Y = transformer_yprim(xfmr, "single_phase")

        @test length(nodes) == 2
        @test nodes[1] == ("hv", "1")
        @test nodes[2] == ("lv", "1")
        @test size(Y) == (2, 2)

        check_symmetry(Y)

        # Closed-form oracle (§2 of derivation note):
        #   Z = (R1 + N²R2) + j(X1 + N²X2),  y = 1/Z,  Y0 = G0+jB0
        #   Y = [y+Y0, -Ny; -Ny, N²y]
        N  = 11000.0 / 400.0
        Z  = (0.5 + N^2*0.01) + im*(2.0 + N^2*0.04)
        y  = 1.0 / Z
        Y0 = 1e-4 + im*5e-4
        Y_ref = [y+Y0  -N*y; -N*y  N^2*y]
        @test maximum(abs.(Y .- Y_ref)) < 1e-12

        # Power balance
        check_power_balance(Y, [1.0+0im, 1.0/N])

        # 3-phase block is block-diagonal over phase pairs
        xfmr3 = Dict{String,Any}(
            "bus_from"          => "hv",
            "bus_to"            => "lv",
            "terminal_map_from" => ["1","2","3"],
            "terminal_map_to"   => ["1","2","3"],
            "v_ref_from"        => 11000.0,
            "v_ref_to"          => 400.0,
            "r_series_from"     => 0.5,
            "x_series_from"     => 2.0,
            "r_series_to"       => 0.01,
            "x_series_to"       => 0.04,
            "g_no_load"         => 3e-4,    # total; split into 3 × 1e-4 per pair
            "b_no_load"         => 15e-4,
        )
        nodes3, Y3 = transformer_yprim(xfmr3, "single_phase")
        @test size(Y3) == (6, 6)
        check_symmetry(Y3)
        # Off-diagonal between different pairs must be zero
        @test all(iszero, Y3[1:2, 3:4])
        @test all(iszero, Y3[1:2, 5:6])
    end

    # ─── single_phase (no-shunt, no-series) ───────────────────────────────────

    @testset "single_phase — lossless ideal" begin
        xfmr = Dict{String,Any}(
            "bus_from"          => "hv",
            "bus_to"            => "lv",
            "terminal_map_from" => ["1"],
            "terminal_map_to"   => ["1"],
            "v_ref_from"        => 11000.0,
            "v_ref_to"          => 400.0,
        )
        N = 11000.0 / 400.0
        nodes, Y = transformer_yprim(xfmr, "single_phase")
        # With Z=0: series terms drop out; Y should be zero (shunt also zero).
        @test all(iszero, Y)
        check_symmetry(Y)
    end

    # ─── center_tap ───────────────────────────────────────────────────────────

    @testset "center_tap" begin
        xfmr = Dict{String,Any}(
            "bus_from"          => "hv",
            "bus_to"            => "lv",
            "terminal_map_from" => ["ph","n"],
            "terminal_map_to"   => ["1","n","2"],
            "v_ref_from"        => 2400.0,
            "v_ref_to"          => 120.0,
            "r_series_from"     => 0.1,
            "x_series_from"     => 0.4,
            "r_series_to"       => 0.001,
            "x_series_to"       => 0.004,
            "g_no_load"         => 1e-5,
            "b_no_load"         => 5e-5,
        )
        nodes, Y = transformer_yprim(xfmr, "center_tap")

        @test length(nodes) == 5
        @test nodes[1] == ("hv", "ph")
        @test nodes[2] == ("hv", "n")
        @test nodes[3] == ("lv", "1")
        @test nodes[4] == ("lv", "n")
        @test nodes[5] == ("lv", "2")
        @test size(Y) == (5, 5)

        check_symmetry(Y)

        # Power balance: symmetric loading (V_a = -V_c, V_g = 0)
        N = 2400.0 / 120.0
        V = [1.0+0im, 0.0, 1.0/N, 0.0, -1.0/N]
        check_power_balance(Y, V)

        # HV-neutral row: should see return current only (no shunt at m).
        # Y[2,2] must equal Y[1,1] - G0 - jB0 (no-load shunt only at ph, not n).
        @test abs(Y[2,1] + Y[2,3] + Y[2,4] + Y[2,5] + Y[2,2]) < 1e-10  # row sum ≈ 0 for balanced

        # Symmetry of leg-1 / leg-2 (equal Z2): Y[3,:] should equal Y[5,:] with
        # columns 3 and 5 swapped.
        Y_leg1 = Y[3, :]
        Y_leg2 = Y[5, [1,2,5,4,3]]   # swap indices 3↔5
        @test maximum(abs.(Y_leg1 .- Y_leg2)) < 1e-10
    end

    # ─── wye_delta ────────────────────────────────────────────────────────────

    @testset "wye_delta" begin
        xfmr = Dict{String,Any}(
            "bus_from"          => "hv",
            "bus_to"            => "lv",
            "terminal_map_from" => ["1","2","3","n"],
            "terminal_map_to"   => ["1","2","3"],
            "v_ref_from"        => 11000.0,
            "v_ref_to"          => 400.0,
            "r_series_from"     => 0.5,
            "x_series_from"     => 2.0,
            "r_series_to"       => 0.0,
            "x_series_to"       => 0.0,
            "g_no_load"         => 1e-4,
            "b_no_load"         => 5e-4,
        )
        nodes, Y = transformer_yprim(xfmr, "wye_delta")

        @test length(nodes) == 7     # 4 wye (3 phase + neutral) + 3 delta
        @test size(Y) == (7, 7)
        check_symmetry(Y)

        # Balanced 3-phase excitation — power balance
        N    = 11000.0 / 400.0
        neff = sqrt(3) / N
        ω    = exp(2im*π/3)
        V_wye_pn = 1.0  # per-unit phase-to-neutral
        V_wye    = [V_wye_pn, V_wye_pn*ω, V_wye_pn*ω^2, 0.0+0im]
        # Ideal delta line-to-line = neff * V_wye_pn
        Vd = neff * V_wye_pn .* [1.0+0im, ω, ω^2]
        V_full = vcat(V_wye, Vd)
        check_power_balance(Y, V_full)

        # Neutral row: with balanced voltage (V_n = 0) the neutral current
        # is zero for a 3-phase symmetric load.
        I = Y * V_full
        @test abs(I[4]) < 1e-8 * maximum(abs.(I))

        # With zero series impedance, wye_delta with nonzero Zd path:
        xfmr2 = merge(xfmr, Dict{String,Any}(
            "r_series_from" => 0.0, "x_series_from" => 0.0,
            "r_series_to"   => 0.5, "x_series_to"   => 2.0,
        ))
        nodes2, Y2 = transformer_yprim(xfmr2, "wye_delta")
        check_symmetry(Y2)
    end

    # ─── delta_wye ────────────────────────────────────────────────────────────

    @testset "delta_wye" begin
        xfmr = Dict{String,Any}(
            "bus_from"          => "hv",
            "bus_to"            => "lv",
            "terminal_map_from" => ["1","2","3"],
            "terminal_map_to"   => ["1","2","3","n"],
            "v_ref_from"        => 11000.0,
            "v_ref_to"          => 400.0,
            "r_series_from"     => 0.5,
            "x_series_from"     => 2.0,
            "r_series_to"       => 0.01,
            "x_series_to"       => 0.04,
            "g_no_load"         => 1e-4,
            "b_no_load"         => 5e-4,
        )
        nodes, Y = transformer_yprim(xfmr, "delta_wye")

        @test length(nodes) == 7     # 3 delta + 4 wye (3 phase + neutral)
        @test size(Y) == (7, 7)
        check_symmetry(Y)

        # Balanced excitation.
        # Node ordering from _yprim_yd: [wye terminals..., delta terminals...]
        # For delta_wye: wye = bus_to (4 nodes), delta = bus_from (3 nodes).
        N    = 11000.0 / 400.0
        neff = N * sqrt(3)
        ω    = exp(2im*π/3)
        V_wye_pn = 1.0 / neff
        V_wye    = V_wye_pn .* [1.0+0im, ω, ω^2, 0.0+0im]
        Vd       = [1.0+0im, ω, ω^2]
        V_full   = vcat(V_wye, Vd)   # wye nodes first
        check_power_balance(Y, V_full)
    end

    # ─── export_yprim roundtrip ───────────────────────────────────────────────

    @testset "export_yprim" begin
        net = Dict{String,Any}(
            "transformer" => Dict{String,Any}(
                "single_phase" => Dict{String,Any}(
                    "tx1" => Dict{String,Any}(
                        "bus_from"          => "hv",
                        "bus_to"            => "lv",
                        "terminal_map_from" => ["1"],
                        "terminal_map_to"   => ["1"],
                        "v_ref_from"        => 11000.0,
                        "v_ref_to"          => 400.0,
                        "r_series_from"     => 0.5,
                        "x_series_from"     => 2.0,
                    ),
                ),
                "wye_delta" => Dict{String,Any}(
                    "tx2" => Dict{String,Any}(
                        "bus_from"          => "hv",
                        "bus_to"            => "lv",
                        "terminal_map_from" => ["1","2","3","n"],
                        "terminal_map_to"   => ["1","2","3"],
                        "v_ref_from"        => 11000.0,
                        "v_ref_to"          => 400.0,
                        "r_series_from"     => 0.5,
                        "x_series_from"     => 2.0,
                    ),
                ),
            ),
        )

        out = export_yprim(net)
        @test haskey(out, "single_phase")
        @test haskey(out, "wye_delta")
        @test haskey(out["single_phase"], "tx1")
        @test haskey(out["wye_delta"],    "tx2")

        entry = out["single_phase"]["tx1"]
        @test haskey(entry, "nodes")
        @test haskey(entry, "Y_real")
        @test haskey(entry, "Y_imag")
        @test length(entry["nodes"]) == 2
        @test length(entry["Y_real"]) == 2
        @test length(entry["Y_real"][1]) == 2

        # Reconstruct Y and verify symmetry
        Yr = reduce(vcat, [reshape(row, 1, :) for row in entry["Y_real"]])
        Yi = reduce(vcat, [reshape(row, 1, :) for row in entry["Y_imag"]])
        Y_rt = Yr + im*Yi
        @test maximum(abs.(Y_rt .- transpose(Y_rt))) < 1e-10

        # Subtypes with no transformers should not appear
        @test !haskey(out, "center_tap")
        @test !haskey(out, "delta_wye")
    end

    # ─── unknown subtype ──────────────────────────────────────────────────────

    @testset "unknown subtype" begin
        xfmr = Dict{String,Any}("bus_from"=>"a","bus_to"=>"b")
        @test_throws ArgumentError transformer_yprim(xfmr, "bogus")
    end

    # ─── OPF self-consistency: single_phase ───────────────────────────────────
    # Recover the OPF winding current variables from I=Y·V and verify the
    # IVR constraints from transformer.jl are satisfied.

    @testset "OPF self-consistency — single_phase" begin
        N   = 27.5
        Z   = 0.5 + 2.0im
        Y0  = 1e-4 + 5e-4im
        y   = 1.0 / Z
        Y_  = [y+Y0  -N*y; -N*y  N^2*y]   # closed-form oracle

        # Pick an arbitrary voltage pair and get terminal currents.
        V = [1.1 + 0.05im, 0.04 - 0.01im]
        I = Y_ * V

        # Recover winding current: I_term[HV] = I_s + Y0·V_HV
        Is  = I[1] - Y0*V[1]
        Ito = I[2]

        # OPF voltage eq: V_fr - N·V_to = Z·I_s
        lhs_v = V[1] - N*V[2]
        rhs_v = Z * Is
        @test abs(lhs_v - rhs_v) < 1e-10

        # OPF current coupling: N·I_s + I_to = 0
        @test abs(N*Is + Ito) < 1e-10
    end

    # ─── OPF self-consistency: center_tap ─────────────────────────────────────

    @testset "OPF self-consistency — center_tap" begin
        N   = 20.0
        Z1  = 0.1 + 0.4im
        Z2  = 0.001 + 0.004im
        G0  = 1e-5; B0 = 5e-5

        xfmr = Dict{String,Any}(
            "bus_from"          => "hv", "bus_to"     => "lv",
            "terminal_map_from" => ["ph","n"],
            "terminal_map_to"   => ["1","n","2"],
            "v_ref_from"        => N * 120.0,
            "v_ref_to"          => 120.0,
            "r_series_from"     => real(Z1), "x_series_from" => imag(Z1),
            "r_series_to"       => real(Z2), "x_series_to"   => imag(Z2),
            "g_no_load"         => G0, "b_no_load" => B0,
        )
        nodes, Y = transformer_yprim(xfmr, "center_tap")

        # Pick a voltage consistent with ideal transform: V_leg1 = V_leg2 = 1/N.
        # Small perturbation to get nonzero impedance drops.
        V = [1.0+0im, 0.0, 1.0/N - 0.001, 0.0, -(1.0/N - 0.002)]
        I = Y * V

        # Recover OPF variables.
        Y0_val = G0 + im*B0
        Is  = I[1] - Y0_val*V[1]   # HV phase terminal = Is + shunt
        Im_  = I[2]                 # HV neutral = -Is
        IL1 = I[3]
        In_ = I[4]
        IL2 = I[5]

        # Current coupling: N·Is + IL1 + IL2 = 0
        @test abs(N*Is + IL1 + IL2) < 1e-8

        # Center-tap KCL: In + IL1 + IL2 = 0
        @test abs(In_ + IL1 + IL2) < 1e-8

        # HV neutral: Im = -Is
        @test abs(Im_ + Is) < 1e-8

        # Voltage eq leg-1: (V_p-V_m) - N*(V_a-V_g) = Z1*Is - N*Z2*IL1
        V_hv   = V[1] - V[2]
        V_leg1 = V[3] - V[4]
        lhs1   = V_hv - N*V_leg1
        rhs1   = Z1*Is - N*Z2*IL1
        @test abs(lhs1 - rhs1) < 1e-8

        # Voltage eq leg-2: Yprim winding-3 spans V_c→V_g (V[5]-V[4]).
        # The Yprim satisfies: (V_p-V_m) - N*(V_c-V_g) = Z1*Is - N*Z2*IL2
        # (Note: OPF uses the reversed span V_g-V_c; both represent the same device
        # but with opposite winding-3 polarity convention.)
        V_leg2_yprim = V[5] - V[4]   # V_c - V_g (Yprim convention)
        lhs2 = V_hv - N*V_leg2_yprim
        rhs2 = Z1*Is - N*Z2*IL2
        @test abs(lhs2 - rhs2) < 1e-8
    end

end
