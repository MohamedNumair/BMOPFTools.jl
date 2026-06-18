"""
    AugmentationRecipe

Parameters controlling which augmentation passes run and what default values
they inject.  Every field has a standards-grounded default; override only what
you need.

Construct with keyword arguments:

    recipe = AugmentationRecipe(mv_v_pu = (0.90, 1.10))

or use [`default_recipe`](@ref) to get the unmodified defaults.
"""
Base.@kwdef struct AugmentationRecipe
    # ── Phase-to-ground envelope (solver regularisation) ─────────────────────
    # Wider than the EN 50160 customer-facing guarantee so the solver has room
    # to find a feasible point even at the boundary of the power-quality window.
    # MV uses the tighter DSO operational planning band (UK/EU practice: ±6 %)
    # so that downstream LV buses can still satisfy their ±10 % guarantee after
    # the MV→LV transformer voltage drop.
    lv_v_pu :: Tuple{Float64,Float64} = (0.85, 1.15)
    mv_v_pu :: Tuple{Float64,Float64} = (0.94, 1.06)   # ±6 %, DSO planning
    hv_v_pu :: Tuple{Float64,Float64} = (0.95, 1.05)   # ±5 %, transmission

    # ── Phase-to-neutral bounds (EN 50160:2010 §3.5/§3.6) ────────────────────
    # 95-%-of-week criterion: Un ±10 % for both LV (230 V) and MV.
    # Applied as a fraction of the per-bus nominal phase-to-neutral voltage.
    vpn_pu :: Tuple{Float64,Float64} = (0.90, 1.10)

    # ── Phase-to-phase bounds (EN 50160:2010, same ±10 % band) ───────────────
    # Vpp_nom = Vpn_nom × √3; same percentage window as vpn.
    vpp_pu :: Tuple{Float64,Float64} = (0.90, 1.10)

    # ── Negative-sequence upper bound (EN 50160:2010 §3.5) ───────────────────
    # "Under normal operating conditions … the negative-sequence component
    # shall not exceed 2 % of the positive-sequence component."
    vneg_max_pu :: Float64 = 0.02

    # ── Thermal limits ───────────────────────────────────────────────────────
    # Cable/overhead type selects the ampacity column from the IEC 60228 /
    # IEC 60364-5-52 lookup table.
    conductor_type :: Symbol = :underground   # :underground | :overhead

    # Minimum provenance confidence required before inferring i_max from R₁₁.
    # :high   — only geometry-derived (distinct) matrices
    # :medium — geometry-derived OR near-balanced (default)
    # :low    — any linecode including sequence-derived
    thermal_min_confidence :: Symbol = :medium

    # ── Reactive capability ──────────────────────────────────────────────────
    # EN 50549-1:2019 requires cos φ ≥ 0.90 for LV-connected DERs.
    # Q_max = P_max × tan(arccos(0.90)) ≈ 0.484 × P_max.
    # Set to 0.95 for IEEE 1547-2018 (ANSI) deployments.
    q_capability_pf :: Float64 = 0.90

    # ── Slack generator ──────────────────────────────────────────────────────
    # Cost assigned to the injected slack generator ($/kWh).  Matches the
    # from_pmd default so augmented cases behave consistently with imported ones.
    slack_cost :: Float64 = 1.0

    # ── Pass enable flags ────────────────────────────────────────────────────
    apply_v_bounds        :: Bool = true
    apply_vpn_bounds      :: Bool = true
    apply_vpp_bounds      :: Bool = true
    apply_vneg_bounds     :: Bool = true
    apply_thermal         :: Bool = true
    apply_q_bounds        :: Bool = true
    apply_slack_generator :: Bool = true
end

"""
    default_recipe() -> AugmentationRecipe

Return an [`AugmentationRecipe`](@ref) with all defaults as specified in the
package documentation.
"""
default_recipe() = AugmentationRecipe()
