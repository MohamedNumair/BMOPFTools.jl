# Implementation Feedback on the TF Data Model Specification (V0.2, 13/4/2026)

Feedback from implementing the data model end-to-end in **BMOPFTools**: an
OpenDSS → (PowerModelsDistribution) → BMOPF JSON converter, a native
validation/analysis suite (~150 tests), and batch conversion of 162 real
network cases (33 LV feeders + MV trunk + combined MV/LV system, and the
128-feeder ENWL four-wire library). Issues are ordered roughly by impact.

## 1. Phase identity and neutral identification are convention-dependent

Terminal names are free strings (Table 11), but nothing in the data model
identifies *which* terminal is the neutral, nor the phase *order*:

- `vpn_min/max` bounds and Eq. (55) require knowing the neutral;
- `vsym_min/max` bounds require the a→b→c rotation order (the Fortescue
  matrix **F** in Eq. (62) is order-sensitive).

Presumably the convention is positional (terminals listed in phase order,
neutral last), but this is unstated — and Table 11's own examples break it
(GridLab-D triplex `["1","N","2"]` has the neutral in the middle; for
OpenDSS `["1","2","3","4"]` the neutral is only identifiable by counting).

**Suggestion:** either state a normative positional convention, or add an
explicit marker (e.g. an optional bus-level `neutral_terminal` field).
Without it, no analysis tool can reliably evaluate the phase-to-neutral or
sequence bound fields. Our implementation currently uses a heuristic
(name `n`/`N`, else terminal `"4"` of a `{"1","2","3","4"}` bus), which is
exactly the kind of guessing a spec should make unnecessary.

## 2. Voltage source + explicit slack generator: a convention is needed

The OpenDSS circuit object is simultaneously a voltage reference and an
implicit unbounded power injection. In the spec, the `voltage_source`
captures the former, and per §3.8.1 its (auxiliary) current is a free
variable — so the import power is **uncosted** and the objective (Eq. 135)
is degenerate whenever no generators exist (true of essentially every raw
utility-derived dataset we converted: 162 of 162 cases had zero
generators).

The natural fix is to make the slack explicit: a generator at the source
bus, unbounded, with a cost — then minimum-cost ≈ loss minimisation and the
problem is well-posed. **However**, combining a costed unbounded generator
with the spec's free source current at the same bus makes the problem
unbounded (the generator can absorb arbitrarily, offset by the source).
Problem builders must adopt one of:

- treat a co-located slack generator as *the* costed representation of the
  source injection (i.e. bind `I_s` to the generator, or omit the free
  auxiliary current), or
- bound or cost the source current directly.

**Suggestion:** document the recommended pattern (voltage source = reference
only when a co-located generator exists), and/or state that reference cases
ship with an explicit slack generator. BMOPFTools' converter now emits
`slack_<source_id>` generators by default for this reason.

## 3. Angle-difference bounds exist in the math model but not the data model

The feasible set (Table 7) includes bus-pair angle bounds (67) and
phase-separation bounds (68), but §4.2 defines no fields to carry the θ
limits. Companion numerical work (PSCC 2026) shows angle/sequence
constraints are precisely what rescues NLP convergence under bad
initialisation, so the data model should arguably carry them — or the spec
should state that (68) is exercised only via the `vsym_*` route (Eq. 64,
which forcing `U_max,2 = U_max,1 = 0` makes equivalent).

## 4. Symmetric matrix storage: full or upper-triangular?

§4.1.1 defines row-first full storage (`A_1_1 … A_m_n`) but does not say
whether symmetric matrices (R_series, X_series, G, B) may be stored
upper-triangular only. Hand-authored files in the wild do this. Our reader
accepts both (mirroring missing `i_j` from `j_i`), and our conformance
check reports triangular storage as informational. **Suggestion:** state
explicitly that all n² entries are required (or bless the triangular
shorthand).

## 5. Three-phase transformer impedance: a conversion FAQ is needed

`wye_delta`/`delta_wye` carry a single `r_series`/`x_series` on the wye
windings (Eqs. 125–126: the delta windings are ideal). Source tools
provide *per-winding* impedances (OpenDSS `%r` per winding + `xhl`), so
converters must lump both windings onto the wye side. The arithmetic is
pleasant — referring the delta-winding impedance through the turns ratio
lands on the same base, so

> `r_series = (r_pu,1 + r_pu,2) · v_ref_wye² / s_rating`,
> `x_series = x_hl,pu · v_ref_wye² / s_rating`

(the √3 factors of Eq. (128) cancel against the per-winding power S/3) —
but it is exactly the kind of derivation that belongs next to the existing
center-tap FAQ. Note the lumping loses the per-winding split (acceptable,
since the math model cannot represent it anyway).

## 6. Wye-wye three-phase transformers have no spec type

The spec supports Φ, center-tap, wye-delta and delta-wye. Wye-wye
three-phase units (common in practice) must be decomposed into three
single-phase transformers. Worth an FAQ entry; converters currently have
no blessed target for them.

## 7. Star-point earthing vs the wye terminal map

`delta_wye` requires a length-4 wye-side terminal map (incl. neutral). In
OpenDSS sources, the wye star point frequently defaults to a *direct earth
bond* (node `.0`) while the neutral conductor is earthed separately through
an impedance at the same bus. Mapping the star point onto the bus neutral
(to satisfy the spec arity) silently re-routes its earthing through that
bus's grounding impedance — a real modeling change to the zero-sequence
path. The alternative (an extra perfectly-grounded terminal at the bus for
the star point) is exact and expressible in the data model; worth an FAQ
note since every OpenDSS-derived dataset will hit this.

## 8. Eq. (98) — delta capacitor bank admittance appears to be a typo

§3.5 gives the delta-connected capacitor bank as
`Y_h = Y_cap·[[1,−1,0],[0,1,−1],[−1,0,1]]` — but that matrix is **M∆**
itself (Eq. 58): asymmetric, hence violating reciprocity for a passive RLC
element. The physical bank admittance is

> `Y_h = Y_cap·(M∆)ᵀ M∆ = Y_cap·[[2,−1,−1],[−1,2,−1],[−1,−1,2]]`

(symmetric, PSD, zero row sums). Any dataset built from the printed formula
will fail a reciprocity check — which is itself a useful argument for
requiring shunt admittance matrices to be symmetric in the spec text.

## 9. Consider restoring the `is_kron_reduced` flag

The EPSR 2024 Tier-1 data model carried `is_kron_reduced` on linecodes; the
TF draft dropped it. Detecting Kron reduction from data alone is inherently
heuristic (a 3×3 matrix is indistinguishable from a physical 3-wire
section), yet the distinction governs which load configurations are
physically sensible (§5.1.4 of the EPSR paper: only delta expected in
3-wire sections). One boolean restores decidability.

## 10. Reference-solution metadata

A key PG Lib practice is embedding a feasible solution / best-known
objective in the case file, enabling regression detection and best-known
tracking. The TF data model has no slot for it; a reserved optional
top-level entry (e.g. `reference_solution` with objective value, solver,
tolerance, date) would standardise this before ad-hoc conventions emerge.

## 11. An optional declared `earthing_system` tag

The TT/TN/IT classification of an LV zone is partly **undecidable from
power-flow data by construction**: the second letter concerns the
protective-earth path of installations (a TT customer's electrode lives on
the PE conductor, never bonded to N) which the data model — correctly — does
not represent. Network-side evidence resolves multi-earthed systems
(downstream neutral electrodes ⇒ TN-C-S/PME/MEN) but cannot distinguish
TN-S from TT when the neutral is earthed at the source only. An optional
declared tag per zone (analogous to the `is_kron_reduced` suggestion) would
make the intended earthing system decidable; analysis tools can then verify
consistency between the tag and the modeled grounding rather than guess.

## 12. Voltage regulators / autotransformers have no representation

OpenDSS heritage forces regulators into one of two encodings, both of which
survive conversion as misleading "transformers":

- a near-1:1 wye transformer (plus a RegControl that does not convert), or
- the explicit autotransformer form (EPRI guidance): two windings on the
  *same bus* (common + ~10 % series winding), kVA rated at the **series
  winding** (~10 % of through-power), plus a negligible-impedance jumper —
  i.e. a self-loop transformer, a deliberately tiny impedance branch, and a
  rating that reads as 10× overloaded, all in one pattern.

Both freeze a control device into a fixed branch (silently dropping the
tap degree of freedom) and the second injects exactly the small-impedance
and rating artifacts the EPSR paper warns about. Suggestion: either bless a
canonical fixed-tap snapshot representation (with a provenance tag marking
the frozen tap), or schedule a regulator element for a future tier (per the
EPSR roadmap). Converter authors need guidance here either way.

## 13. Smaller items

- **`cost` shape:** §4.2 maps `cost → C_g ($/kWh)` where the math model's
  C_g is a per-phase 3-vector; examples in circulation use scalars. State
  whether scalar shorthand is admissible.
- **Load `p_nom`/`q_nom` shape vs configuration:** the required vector
  length (1 for SINGLE_PHASE, 3 for WYE/DELTA) is implied but could be
  stated in §4.2 alongside the terminal-map arities.
- **SINGLE_PHASE vs 2-terminal WYE:** tools like PMD label 2-terminal loads
  "wye". The spec's distinction (Table 4 + FAQ) is clear, but a one-line
  warning aimed at converter authors would prevent a common mistake.
- **Units cannot be validated from data alone:** since the JSON carries no
  unit metadata (§4.1.2, by design), a length recorded in km is
  undetectable except by plausibility heuristics. Reference datasets should
  therefore be generated through converters with verified unit handling;
  consider adding representative magnitude ranges to the spec as a sanity
  appendix.

## Validation experience (what worked)

For what it's worth to the TF: the data model proved very checkable. On top
of the JSON Schema we implemented semantic checks for required fields,
configuration/arity consistency, transformer map arities, single-source,
grounding structure (floating-neutral detection via the neutral continuity
graph), impedance provenance (sequence-derived/balanced matrices — the
inverse of Appendix A.2's Eq. 148 — reciprocity, passivity), Kron-reduction
likelihood per voltage level, and benchmark readiness (objective
well-posedness, bound/limit coverage). All 162 converted cases pass with
zero errors; the explicit-grounding and 4-wire conventions of the spec map
1:1 onto OpenDSS-derived data once the star-point question (item 7) is
decided.
