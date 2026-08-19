# IBR Model Extensions — Design Doc

Status: **Draft for review**
Scope: extend the inverter-based-resource (IBR) OPF model with output filters, an
explicit internal voltage source, grid-forming (120°) operation, converter losses,
and double-frequency power constraints.

---

## 1. Where we are today

The IBR is **not** a power sink. It is a **bounded current-injection source**:

- Free primal variables are rectangular per-phase currents `cri[(id,k)]`, `cii[(id,k)]`
  ([`ext/BMOPFOpfExt/ibr.jl:26-44`](ext/BMOPFOpfExt/ibr.jl)).
- P/Q are *derived* bilinear expressions of terminal-voltage-difference × current
  (`p_expr = dvr·cri + dvi·cii`, `q_expr = dvi·cri − dvr·cii`,
  [`ibr.jl:273-511`](ext/BMOPFOpfExt/ibr.jl)).
- Currents are injected into bus KCL via `_kcl_add!`
  ([`bus.jl:296-303`](ext/BMOPFOpfExt/bus.jl)); the reference terminal takes the
  negative.
- Limits: apparent-power circle `P²+Q² ≤ s_max²` via `pi_/qi_` auxiliaries + `_soc_norm!`;
  per-conductor `i_max` via `_soc_norm!`; neutral (FOUR_LEG) via
  `_neutral_current_limit!`.
- Topologies: `SINGLE_PHASE`, `THREE_LEG` (delta, line-to-line, no neutral),
  `FOUR_LEG` (star, phase-to-neutral, neutral current available).
- Per-unit: `_pu_scale_ibrs!` ([`per_unit.jl:387-407`](ext/BMOPFOpfExt/per_unit.jl))
  scales p/q/s ÷ s_base, i_max ÷ i_base.
- Warm start: `_warmstart_ibr_current!` seeds `I = conj(S)/conj(V)` to land Ipopt on
  the *physical* (high-V/low-I) root — see issue #302. **Every new bilinear/quadratic
  constraint must respect this or risk the spurious root.**

Two feature sets are **already declared in the schema but unread by the OPF**:

- Filter: `r_filter` [Ω]/phase, `x_filter` [Ω]/phase, `b_filter_shunt` [S] scalar
  ([`draft_bmopf_schema.json:614-631`](src/validation/schemas/draft_bmopf_schema.json)).
- Grid-forming: `grid_forming` (bool), `v_ref_internal` [V]
  ([`draft_bmopf_schema.json:632-639`](src/validation/schemas/draft_bmopf_schema.json)).

The **slack source** ([`source.jl:3-101`](ext/BMOPFOpfExt/source.jl)) is the existing
template for an internal-voltage model: it `fix`es a per-phase internal EMF and lets a
current slack absorb balance.

---

## 2. Core structural idea: the internal AC node

Four of the five features share one prerequisite — an explicit **internal AC node**
behind the converter terminal:

```
 POC bus ──[filter: r+jx (+ shunt b)]── internal AC node ──[converter]── DC link
   network sets V here                    EMF lives here                losses/ripple here
```

- **Output filter** = series `r+jx` branch from POC terminal to the internal node
  (+ optional shunt `b`), modeled like a transformer-winding coupling. Reuse
  `_apparent_power_limit!` ([`data_utils.jl:243+`](ext/BMOPFOpfExt/data_utils.jl)),
  which already limits power at an *internal coil* voltage.
- **Explicit internal voltage source** = promote the internal node voltage
  (`vr_int`, `vi_int`) to bounded decision variables.
- **120° phase separation** = *linear* rectangular constraints on the internal node
  voltages: `V_b = a²·V_a`, `V_c = a·V_a`, `a = e^{j120°}`. Meaningful **only** at the
  internal node; the POC is unbalanced because the network makes it so. Balanced EMF →
  unbalanced filter current → captures grid-forming behavior.

Converter losses and double-frequency power attach to the **converter / DC side** and
are more separable.

**Backward compatibility is a hard requirement**: absent all new fields → today's model,
bit-for-bit. The internal node is introduced **only** when a filter or `grid_forming`
is present.

---

## 3. Decisions locked in (this review round)

| Topic | Decision |
|---|---|
| Filter fidelity | **Series R+jX + optional shunt (L / LC)** — one internal node/phase, optional shunt cap on one side. No LCL midpoint node for now. |
| Internal EMF bounds | **DC-link modulation limit** `\|V_int\| ≤ modulation_max·V_dc/√3` when a DC voltage is available; **user-bounded** (`v_ref_internal`/min/max) as the fallback when there is no DC model. Both live in Phase 1. |
| Double-frequency power | Bound the **2ω instantaneous-power ripple magnitude**, phasor `p̃ = Σ_k V_k·I_k` (non-conjugated), `\|p̃\|² ≤ ripple_max²`, formed on the **converter/internal side**. Most relevant for SINGLE_PHASE and unbalanced FOUR_LEG. |
| Filter shunt placement | Default **grid side** (POC terminal). |
| GFM magnitude | **Bounded decision variable** `v_gfm` (OPF chooses magnitude within `[v_int_min, v_int_max]`), not a fixed value. |
| BATTERY loss sign | Single non-branching equation `P_dc = P_ac + P_loss`, `P_loss ≥ 0` (see §4.4). |
| GFM as island reference | **Not allowed for now** — a `grid_forming` IBR still requires an existing slack/reference in its island. |
| Process | Design doc first (this file), then phased implementation. |

---

## 4. Feature designs

### 4.1 Output filter (L / LC) — Phase 0

**Data model (new IBR fields; `r_filter`/`x_filter`/`b_filter_shunt` already exist):**

- `r_filter`, `x_filter`: per-phase arrays [Ω] (converter-side series impedance).
- `b_filter_shunt`: scalar [S] shunt susceptance (filter capacitor). New optional
  companion `filter_shunt_side ∈ {"grid","converter"}` (default `"grid"`) to place the
  shunt at the POC terminal or the internal node.

**Variables (only when filter present):** internal node voltage `vr_int[(id,k)]`,
`vi_int[(id,k)]` per phase; the existing `cri/cii` become the **converter-side** current
(current out of the internal node).

**Constraints:**

- Series coupling (per phase, Ohm's law across `r+jx`):
  the current from internal node to POC through `z = r+jx` equals `cri+j·cii`, and
  `(V_int − V_poc) = z · I`. In rectangular:
  - `vr_int − vr_poc = r·cri − x·cii`
  - `vi_int − vi_poc = r·cii + x·cri`
- Shunt cap injects `I_sh = j·b·V` at the chosen side; add to that terminal's KCL.
- **Power/current limits move to the converter side**: apply `s_max`, `p_*`, `q_*` on
  P/Q formed from `V_int × I` (not `V_poc`), matching real nameplate (nameplate is the
  converter rating). `i_max` still limits `cri/cii` (the converter current). Reuse
  `_apparent_power_limit!` with the internal voltage as the reference.
- Net current injected at the POC = `cri/cii` minus/plus the grid-side shunt current.

**Per-unit:** `r_filter,x_filter ÷ z_base[bus]`; `b_filter_shunt ÷ y_base[bus]`. Add to
`_pu_scale_ibrs!` (precedent: transformer leakage scaling).

**Warm start:** seed `V_int = V_poc + z·I_seed`, keeping the physical root
(extend `_warmstart_ibr_current!`).

**Degenerate case:** `r=x=0`, `b=0` ⇒ internal node collapses to POC ⇒ identical to
today. Use this as a regression guard.

### 4.2 Explicit internal voltage source + DC-link modulation limit — Phase 1

Promote `vr_int/vi_int` to bounded decision variables independent of the filter branch.
The internal EMF magnitude is bounded by **one of two mechanisms**, chosen by data
availability:

**(a) DC-link modulation limit (preferred when a DC model exists).**
A converter cannot synthesize an AC voltage larger than its DC-link voltage allows:

```
|V_int|  ≤  modulation_max · V_dc / √3          (per phase, phase-to-neutral RMS)
⇔  vr_int² + vi_int²  ≤  (modulation_max · V_dc / √3)²     (SOC, via _soc_norm!)
```

- `modulation_max`: new dimensionless IBR field (default ≈ `1.0`; ~`1.10–1.15` allows
  third-harmonic injection / SVPWM overmodulation headroom). The exact `/√3` constant is
  scheme-dependent (SPWM vs SVPWM vs line-to-line reference); we fix the `/√3`
  phase-to-neutral-RMS-vs-DC form in code and let `modulation_max` absorb the residual
  scheme factor. Documented in the field description.
- `V_dc` source, in priority order:
  1. **Shared DC bus** (`dc_bus` set): `V_dc` is the DC node voltage variable (`Uport`
     in `_couple_converter_to_dc!`, [`dcnetwork.jl:375-424`](ext/BMOPFOpfExt/dcnetwork.jl)).
     The modulation limit then **couples the AC internal voltage to the optimized DC
     voltage** — a genuine cross-domain constraint.
  2. **Isolated link with `dc_v_set`**: `V_dc` is that fixed value (parameter, not variable).
  3. **No DC voltage available**: fall back to mechanism (b).
- **Per-unit care:** this constraint couples an AC voltage (`v_base[bus]`) to a DC voltage
  (`v_dc_base`). In per-unit both sides are normalized; the effective coefficient carries
  the base ratio `v_dc_base / (√3 · v_base)`. Compute it once in `per_unit.jl` and
  **unit-test the SI-vs-pu equivalence** — this is the highest-risk scaling in the whole
  design.

**(b) User-bounded EMF (fallback / no DC model).**
When `v_ref_internal` (or `v_int_min`/`v_int_max`) is set and no `V_dc` is resolvable,
bound `\|V_int\|` per phase directly: `v_int_min² ≤ vr_int² + vi_int² ≤ v_int_max²`.
Per-unit `÷ v_base[bus]`.

**Grid-following (default, neither set):** internal voltage is free — only the filter
equations and current/power limits constrain it. Nothing extra once the node exists.

Requires the internal node from 4.1. If a user sets `v_ref_internal`/`modulation_max`
without filter fields, we still create the node with `z=0` (pure EMF at the terminal,
source-like). The two mechanisms are mutually exclusive per IBR; validation errors if
both a resolvable `V_dc` **and** explicit `v_int_max` disagree (warn + prefer modulation).

### 4.3 Grid-forming (120° balanced internal voltage) — Phase 2

Gate on `grid_forming = true` (schema field exists).

- **Balanced positive-sequence internal EMF** via linear rectangular constraints on the
  internal node voltages (THREE_LEG/FOUR_LEG):
  - `V_b = a²·V_a`, `V_c = a·V_a`, with `a = −½ + j(√3/2)`.
  - Expanded: `vr_b = −½vr_a − (√3/2)vi_a`, etc. — pure linear equalities.
- **Magnitude is a bounded decision variable** `v_gfm` (single per-IBR, `\|V_a\| = v_gfm`
  with `v_int_min ≤ v_gfm ≤ v_int_max`). The OPF chooses magnitude (and implicitly angle
  via the free `V_a` direction), making the IBR a **controllable balanced voltage source
  behind the filter**. Current slack = the filter current, already present. If a
  modulation limit (§4.2a) applies, `v_gfm` is additionally capped by `modulation_max·V_dc/√3`.
- Optional relaxation `gfm_unbalance_tol` to allow small deviation from perfect 120°
  (box around the balanced target) for realism/feasibility; default 0 (strict).
- SINGLE_PHASE grid-forming: no 120° constraint, just a bounded single EMF.

**Not an island reference (this round).** A `grid_forming` IBR does **not** replace the
slack/reference: its island must still contain a slack source. Add an integrity rule
(near [`integrity.jl:631-647`](src/validation/integrity.jl)) that rejects a network whose
only reference in an island is a `grid_forming` IBR. Allowing GFM-as-reference (angle
anchor / distributed slack) is deferred — it interacts with the P–f droop backlog item (§5.4).

Validation: `grid_forming` requires the internal node (auto-created).

Testing: cross-check against `source.jl` slack behavior — a GFM IBR with tight bounds
and zero filter should reproduce a Vsource (as a device *behind* an existing slack, not
as the slack itself).

### 4.4 Converter losses — Phase 3

Three-term inverter loss curve on the **DC-link balance** (currently lossless at
[`dcnetwork.jl:387`](ext/BMOPFOpfExt/dcnetwork.jl)):

```
P_loss = p_loss_fixed + a_loss·|I| + c_loss·|I|²        (P_loss ≥ 0 always)
P_dc   = P_ac + P_loss
```

**Sign convention — deliberately non-branching (least confusing for a general audience).**
Fix once: **AC power positive = injected to the grid** (export/discharge); **DC power
positive = drawn from the DC source**. Then the *same* equation `P_dc = P_ac + P_loss`
holds in **both** directions with `P_loss` always positive:

- Discharge (`P_ac > 0`): the DC source supplies the AC power **plus** the loss.
- Charge (`P_ac < 0`): the DC source receives `|P_ac| − P_loss` — the grid delivers more
  than the battery stores, the difference being the loss.

No charge/discharge `if`-branch, no direction-dependent efficiency table — one equation,
losses always dissipated. This is the framing to use in docs and the field descriptions.

- `p_loss_fixed` [W]: no-load/switching losses (constant).
- `a_loss` [V-equiv]: conduction / semiconductor forward-drop (linear in current
  magnitude). `|I|` already exposed via SOC auxiliaries.
- `c_loss` [Ω-equiv]: ohmic / copper (quadratic).
- Applies in both DC-coupled modes:
  - Isolated link (`dc_link_coupled`): `p_net` bound becomes `p_net + P_loss ∈ [p_dc_min, p_dc_max]`.
  - Shared DC bus: `_couple_converter_to_dc!` balance `Uport·I == ΣP_k` → `... + P_loss`.
- BATTERY charge/discharge handled by the single non-branching equation above (no
  special-casing).

Per-unit: `p_loss_fixed ÷ s_base`; `a_loss`, `c_loss` scaled consistently with their
current-magnitude basis (`÷ i_base`, `÷ i_base²` respectively, times s_base — derive
carefully and unit-test).

Nonconvexity: `c_loss·|I|²` is convex in `|I|` but `|I|` itself is an SOC var; keep it
optional so users pay only when enabled.

### 4.5 Double-frequency power constraints — Phase 4

Bound the 2ω instantaneous-power pulsation. Complex 2ω power (non-conjugated sum over
phases):

```
p̃ = Σ_k V_k · I_k          (V_k, I_k complex phasors)
p̃_re = Σ_k (vr_k·cri_k − vi_k·cii_k)
p̃_im = Σ_k (vr_k·cii_k + vi_k·cri_k)
constraint:  p̃_re² + p̃_im² ≤ ripple_max²     (via _soc_norm!)
```

- Balanced three-phase ⇒ `p̃ = 0` automatically; the constraint only bites for
  SINGLE_PHASE and unbalanced FOUR_LEG — exactly the DC-link-ripple-limited cases.
- New field `p_ripple_max` [VA] scalar (optional). Per-unit `÷ s_base`.
- Formed on the **converter/internal side** (`V_int × I`), since the ripple is what
  stresses the DC-link capacitor. Requires the internal node (Phase 0).
- Nonconvex quadratic; optional.

---

## 5. Features not requested but recommended

Surfaced for the backlog (not scheduled unless you want them pulled in):

1. **Negative/zero-sequence current limits** — converter protection; cheap sequence-current bound.
2. **P-vs-Q priority under s_max saturation** — active-priority vs reactive-priority mode.
3. **GFM as island reference (angle anchor / distributed slack)** — deferred this round
   (§4.3). Would let a `grid_forming` IBR replace the slack source.
4. **GFM P–f / Q–V droop** — needs a shared system-frequency variable; the GFM analog of
   the existing volt-var/volt-watt droop. Larger lift; natural companion to #3.

(The DC-link modulation limit, previously listed here, is now **in-plan** as Phase 1 §4.2a.)

---

## 6. Cross-cutting engineering checklist (every phase)

- [ ] New fields added to `draft_bmopf_schema.json` (`additionalProperties:false`).
- [ ] Duplicate field allowlists updated: `completeness.jl:86-87`, `schema.jl:154-155`.
- [ ] Integrity dimension checks updated (`integrity.jl:355-374`).
- [ ] `_pu_scale_ibrs!` extended for every new dimensional field (+ DC-side fields in
      `per_unit.jl:573-584`).
- [ ] `_warmstart_ibr_current!` extended to seed internal node voltage / filter current
      on the physical root (issue #302).
- [ ] All new constraints use the **normalized** `_soc_norm!` cone (Ipopt tolerance,
      issue #302).
- [ ] Backward-compat regression: absent new fields ⇒ identical model & solution.
- [ ] OpenDSS cross-check where a mapping exists (GFM ↔ Vsource, filter ↔ line+shunt),
      via `project_solution`.
- [ ] Augmentation defaults (`src/augmentation/ibr.jl`) for any new optional field.

---

## 7. Phasing summary

| Phase | Feature | Depends on | Convexity added |
|---|---|---|---|
| 0 | Internal node + series filter (L/LC, grid-side shunt) | — | linear (Ohm) |
| 1 | Internal EMF + DC-link modulation limit (user-bounded fallback) | 0 (+ DC model for modulation) | SOC (`\|V_int\|`) |
| 2 | Grid-forming (120° balanced, `v_gfm` decision var) | 0/1 | linear |
| 3 | Converter losses (3-term, non-branching sign) | DC-link | quadratic (optional) |
| 4 | Double-frequency power (converter-side) | 0 | nonconvex quad (optional) |

Each phase is independently shippable and independently gated by field presence.

---

## 8. Resolved decisions (this round)

1. **Filter shunt placement** — **grid side** (POC terminal). New optional
   `filter_shunt_side` still allows converter-side override.
2. **Double-frequency reference voltage** — **converter/internal side** (§4.5).
3. **GFM magnitude control** — **bounded decision variable** `v_gfm` (§4.3).
4. **DC-link modulation limit** — **in-plan** as Phase 1 §4.2a; user-bounded EMF is the
   fallback when no DC voltage is resolvable.
5. **BATTERY loss sign** — single non-branching `P_dc = P_ac + P_loss`, `P_loss ≥ 0` (§4.4).
6. **GFM as island reference** — **not allowed this round**; a `grid_forming` IBR still
   requires an existing slack in its island (§4.3). Deferred to backlog §5.3.

### Remaining smaller items to settle during Phase 1/3 implementation

- `modulation_max` default value and whether to expose the `/√3` constant or fully absorb
  it into `modulation_max` (§4.2a) — decide against a worked SVPWM example.
- `a_loss`/`c_loss` user-facing units — physical (V-equiv / Ω-equiv) vs. a normalized
  efficiency-curve parameterization (η at rated / half / no-load). Physical is simpler to
  stamp; efficiency-curve is friendlier to datasheet users. Lean physical, provide a
  converter helper.
