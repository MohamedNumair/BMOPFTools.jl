# Tests for the HELM power-flow solver stack.
#
# Layer 0: Padé / Wynn-epsilon analytic continuation on series with known
#          limits — including series that DIVERGE at the evaluation point but
#          have an analytic continuation there (the HELM situation).
# Later layers (added with the solver): analytic power-flow fixtures, OpenDSS
# parity, collapse / non-existence detection.

@testset "helm: pade layer" begin

    _pade_sum = BMOPFTools._pade_sum
    _wynn_epsilon = BMOPFTools._wynn_epsilon

    @testset "geometric series inside the radius" begin
        # Σ zᵏ = 1/(1−z). Padé is exact for geometric series (rank-1 table),
        # so even slow-converging tails lock in immediately.
        for z in (0.5 + 0.0im, 0.9 + 0.0im, 0.6 + 0.3im)
            coeffs = [z^k for k in 0:12]
            v, spread = _pade_sum(coeffs)
            @test v ≈ 1 / (1 - z)  rtol=1e-10
            @test spread < 1e-8
        end
    end

    @testset "geometric series OUTSIDE the radius (analytic continuation)" begin
        # Σ 1.5ᵏ diverges at s=1, but the function 1/(1−z) continues to −2.
        coeffs = [(1.5 + 0.0im)^k for k in 0:10]
        v, spread = _pade_sum(coeffs)
        @test v ≈ -2.0 + 0.0im  rtol=1e-10
        @test spread < 1e-8
    end

    @testset "log(1+s) at s=1 (branch point at s=−1)" begin
        # c₀=0, c_k = (−1)^{k+1}/k → ln 2. Plain partial sums need ~10⁸ terms
        # for 1e-8; the epsilon table needs ~15.
        coeffs = ComplexF64[0.0; [(-1.0)^(k+1)/k for k in 1:15]]
        v, spread = _pade_sum(coeffs)
        @test v ≈ log(2.0)  atol=1e-9
        @test spread < 1e-6
    end

    @testset "sqrt-type branch point beyond s=1" begin
        # √(1−s/2) at s=1 = √(1/2); radius of convergence 2 > 1, but the
        # nearby branch point makes plain summation slow.
        cf = ComplexF64[1.0]
        for k in 1:20
            push!(cf, cf[end] * (0.5 - (k - 1)) / k * (-0.5))  # binomial(1/2,k)·(−1/2)ᵏ
        end
        v, spread = _pade_sum(cf)
        @test v ≈ sqrt(0.5)  atol=1e-10
        @test spread < 1e-8
    end

    @testset "no limit at the point: spread stagnates" begin
        # √(1−s) at s=1: the value exists (0) but the DERIVATIVE blows up;
        # harder: 1/√(1−s) has NO finite value at s=1. The epsilon table must
        # not pretend otherwise: spread stays large relative to convergence.
        cf = ComplexF64[1.0]
        for k in 1:24
            push!(cf, cf[end] * (k - 0.5) / k)   # coefficients of (1−s)^(−1/2)
        end
        _, spread = _pade_sum(cf)
        @test spread > 1e-4      # nothing like the ~1e-8 lock-in of true limits
    end

    @testset "degenerate/guard paths" begin
        # Already-converged sequence: zero differences short-circuit safely.
        v, spread = _wynn_epsilon(fill(3.0 + 1.0im, 6))
        @test v == 3.0 + 1.0im
        @test spread == 0.0
        # Single partial sum: no acceleration information.
        v, spread = _wynn_epsilon([2.0 + 0.0im])
        @test v == 2.0 + 0.0im && spread == Inf
        @test_throws ArgumentError _wynn_epsilon(ComplexF64[])
        @test_throws ArgumentError _pade_sum(ComplexF64[])
    end
end
