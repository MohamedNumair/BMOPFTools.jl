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
- `vpos_min/max` bounds require the a→b→c rotation order (the Fortescue
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
should state that (68) is exercised only via the `vpos_*` route (Eq. 64,
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

## 14. Several limit types in the feasible set have no data model fields

The V0.2 data model defines `v_min`/`v_max` (phase-to-ground), `vpn_min`/`vpn_max`
(phase-to-neutral, Eq. 55), and `vpos_min`/`vpos_max` (positive-sequence, Eq. 64),
but the following limit types appear in the math model or are natural engineering
requirements with no assigned §4.2 field names.

**Bus-level, voltage magnitude:**

| Field | Constraint | Notes |
|---|---|---|
| `vpp_min` / `vpp_max` | `vpp_min² ≤ \|V_j − V_k\|² ≤ vpp_max²` per unordered phase pair (j,k) | Complements `vpn` and `v_min/max`; all three constrain distinct quantities on a 4-wire bus |
| `vn_max` | `\|V_n\|² ≤ vn_max²` at the neutral terminal | Controls neutral displacement voltage; no counterpart in §4.2 |
| `vneg_max` | `\|V₂\|² ≤ vneg_max²` | Negative-sequence counterpart to `vpos_max`; Eq. (62) defines V₂ but the spec bounds only V₁ |
| `vzero_max` | `\|V₀\|² ≤ vzero_max²` | Zero-sequence counterpart; same issue |

All four are quadratic in rectangular voltage variables and fit the IVR-EN formulation
without approximation. `vneg_max` and `vzero_max` share the three-ordered-phase-terminal
precondition of `vpos_min/max` (see item 1).

**Bus-level, voltage angle separation (intra-bus):**

Table 7 Eq. (68) bounds the angle between phase terminals at the same bus, but §4.2
carries no field for it. The bilinear form is:

> `tan(va_diff_min) · Re(V_j V_k*) ≤ Im(V_j V_k*) ≤ tan(va_diff_max) · Re(V_j V_k*)`

**Suggested field:** `va_diff_min` / `va_diff_max` (radians) on the bus object, applied
to every unordered pair of ungrounded phase terminals.

**Line-level, voltage angle difference (cross-branch):**

Table 7 Eq. (67) bounds the angle mismatch across a branch per conductor, but again
§4.2 has no field. The same bilinear form applies with from- and to-end voltages:

> `tan(va_diff_min) · Re(V_fr V_to*) ≤ Im(V_fr V_to*) ≤ tan(va_diff_max) · Re(V_fr V_to*)`

**Suggested field:** `va_diff_min` / `va_diff_max` (radians) on the line object,
applied per matched conductor pair in `terminal_map_from` / `terminal_map_to`.

**Suggestion:** add the six field pairs above to §4.2. All are in the BMOPF JSON
implementation and tested; the math is already in the spec, only the JSON field names
are missing. For `vneg_max`/`vzero_max` the spec may also want to extend Eq. (64) with
the corresponding negative- and zero-sequence inequality.

## 15. `voltage_source` fixes both magnitude and angle; variable-magnitude sources have no representation

The current `voltage_source` model (§3.8.1) requires both `v_magnitude` and `v_angle`
per terminal, which the solver implementation maps to hard equalities:
`Vre = |V|·cos θ`, `Vim = |V|·sin θ`.  This is correct for a stiff grid
connection with a known Thevenin voltage, but it precludes two common modelling
needs:

**1. Angle-reference-only source (unknown magnitude)**

The IVR rectangular formulation has a global rotational symmetry: if `(V, I)` is
feasible then so is `(e^{jθ}V, e^{jθ}I)`.  The minimal fix is to pin only the
angle of one reference terminal, leaving the magnitude free.  For a reference
angle `θ_ref ∈ {0, π/2, π, −π/2}` this reduces to a pair of sign constraints
on `(Vre, Vim)`:

| `θ_ref` | constraint |
|---|---|
| 0 | `Vim = 0`, `Vre ≥ 0` |
| π/2 | `Vre = 0`, `Vim ≥ 0` |
| π | `Vim = 0`, `Vre ≤ 0` |
| −π/2 | `Vre = 0`, `Vim ≤ 0` |

Our current implementation satisfies these as a special case (strict equality is
stronger than the inequalities), so no correctness issue arises — but a converter
that wants to represent a source with automatic voltage regulation (AVR), or a
network where the upstream voltage magnitude is itself an optimisation variable,
has no data model hook.

**2. Bounded-voltage source (controllable magnitude)**

A controllable voltage source (e.g. a STATCOM or an ideal AVR set-point) has a
magnitude that lies within a range `[|V|_min, |V|_max]` rather than being fixed.
This cannot be expressed in the current model; the closest approximation is a
generator with tight reactive-power bounds, which loses the "voltage behind
impedance" semantics.

**Suggestion:** extend `voltage_source` with optional `v_magnitude_min` /
`v_magnitude_max` fields (defaulting to a fixed point when only `v_magnitude` is
given).  When min ≠ max the solver should add the angle-reference inequalities
above instead of the hard equalities, treating the magnitude as a free variable
bounded within the range.  This also cleanly separates the *angle reference*
role (one terminal, sign constraint only) from the *voltage magnitude reference*
role (hard equality), which the current model conflates.

## 16. Declared supply voltage (`v_declared`) is absent from the data model

Voltage bound augmentation requires a *declared supply voltage* — the nominal
voltage relative to which power-quality standards (EN 50160, AS 61000.3.100,
etc.) define their percentage envelopes — but the spec provides no field for it.

The problem is that transformer rated voltages (the natural `v_nom` in a
power-flow dataset) routinely differ from the declared voltage.  For example,
240 V and 250 V distribution transformers are common in Australia, while
AS 61000.3.100 mandates a supply within ±10 % of **230 V**.  Using the
transformer rated voltage as the percentage base silently shifts the bound
window and can under- or over-constrain the OPF.

**Alternatives considered:**

1. *Snap-to-standard-table (OpenDSS approach)*: a lookup list of canonical
   nominal voltages (e.g. `[120, 230, 400, 11000, 33000]` V) is used to round
   each bus's `v_nom` to the nearest declared level.  Convenient but introduces
   an implicit country-specific table that varies by deployment context and is
   invisible in the data file itself.

2. *Explicit `v_declared` field on the bus*: an optional bus-level field carries
   the declared supply voltage (V).  If absent, the tool falls back to `v_nom`.
   This is explicit, auditable, and travels with the data.

3. *Recipe-level scalar override*: the augmentation tool's configuration carries
   `v_declared_lv`, `v_declared_mv`, `v_declared_hv` scalars.  Simple for
   single-country datasets but cannot handle mixed-voltage networks (e.g. 120 V
   and 230 V LV buses in the same case).

**Suggestion:** add an optional `v_declared` (V) field to the bus object (option 2).
When present it takes precedence over `v_nom` for percentage-based bound
computation.  Option 3 (tool-level fallback) is complementary: if `v_declared`
is absent and the tool has a recipe scalar set for that voltage level, use that;
otherwise fall back to `v_nom`.

In our implementation we are currently treating `v_declared` as an informal
extension field (read with `get(bus, "v_declared", nothing)`) and populating it
at import time from DSS `baseKV` / PMD nominal voltage.  It would be cleaner
to make this official so all compliant tools share a common field name.

## 17. Solver regularisation bounds vs power-quality bounds are conceptually distinct

The spec defines `v_min`/`v_max` (phase-to-ground), `vpn_min`/`vpn_max`
(phase-to-neutral), and `vpp_min`/`vpp_max` (phase-to-phase) without
distinguishing two fundamentally different purposes these bounds serve:

**Power-quality bounds** — derived from supply standards (EN 50160, AS
61000.3.100, etc.).  They are engineering constraints that correspond to a
customer's right to supply within a defined voltage envelope.  Their values
are set relative to a declared supply voltage (see item 16) and are
*meaningful* in the context of the OPF: a binding constraint signals a
potential supply quality violation.

**Solver regularisation bounds** — wide phase-to-ground bounds that exist
solely to prevent the NLP solver from wandering into numerically pathological
regions far from the operating point.  They are *hyperparameters* of the
solution algorithm, not engineering constraints: a typical value might be
0.85–1.15 pu, which is wider than any supply standard would permit, precisely
so the solver can always find a feasible starting point.  A binding
regularisation bound is a solver artifact, not an engineering violation.

Conflating these two in the same field (`v_min`/`v_max`) creates an ambiguity:
tools that inspect bound activity cannot distinguish a genuine supply quality
issue from a solver warm-start artefact without out-of-band metadata.

**Suggestions:**

1. *Separate field names* — introduce `v_reg_min`/`v_reg_max` for the
   regularisation hyperparameters, keeping `v_min`/`v_max` for
   engineering bounds.  This makes bound activity unambiguous in solution
   profiling.

2. *Provenance tag* — add an optional `bound_source` metadata field per
   bound entry (e.g. `"standard"` vs `"regularisation"`) so that the
   distinction is recorded without renaming fields.

3. *Documented convention* — leave the fields as-is but state explicitly in
   the spec that `v_min`/`v_max` on non-source buses *should* reflect
   engineering bounds (from a standard), and that solver regularisation is
   the implementer's responsibility, not a data model concern.

In our implementation we chose option 3 as a practical interim: `augment_case`
injects engineering `vpn`/`vpp` bounds from standards, and separately injects
`v_min`/`v_max` as a configurable regularisation hyperparameter (default
0.85/1.15 pu, same for all voltage levels) — recorded in the manifest with
source `"solver_regularisation"` rather than `"standard"` so callers can
distinguish them.

### Corollary: vpn vs vpp applicability depends on wire configuration

A related modelling ambiguity: `vpn_min`/`vpn_max` are physically meaningful
only on **four-wire buses** that have a neutral terminal.  On a three-wire MV
bus there is no neutral voltage to constrain, and adding `vpn` bounds would
reference a non-existent terminal.  Conversely, on a four-wire bus the
relevant standard bound is the phase-to-neutral voltage (what the customer
measures at their socket), not phase-to-ground.

The spec does not state which bound types are applicable to which terminal
configurations.  Our implementation applies:
- `vpn` + `vpp` + `vneg_max` to four-wire buses (neutral terminal present)
- `vpp` only to three-wire buses (no neutral)
- `v_min`/`v_max` (regularisation) to all buses regardless of configuration

**Suggestion:** add a note in §4.2 (or in the bound field descriptions) stating
the intended terminal-configuration preconditions for each voltage bound type.

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
