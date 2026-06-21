# Optimal power flow

Despite the name, the ambition of this Task Force extends well beyond the
classical OPF problem of minimising generation cost subject to network
constraints.  The unifying theme of the benchmark problems targeted here is
the need to **accurately represent distribution network physics** rather than
any particular objective function.  Generation cost minimisation is a
convenient and well-posed starting point — it admits a unique solution, is
straightforward to compare across solvers, and is equivalent to loss
minimisation under mild conditions — but the same network physics underpins a
much broader class of distribution-network-constrained optimisation problems
of practical relevance: maximum load delivery, conservation voltage reduction
(CVR), Dynamic Operating Envelopes (DOEs) for distributed energy resources,
and distribution system state estimation (DSSE).

What these problems share is not a common objective but a common requirement:
a faithful, conductor-level representation of an unbalanced network subject
to a selectable set of bounds.  Voltage bounds, current limits, and power
constraints are therefore **optional** in the data model, reflecting the fact
that different problem formulations will activate different subsets of the
feasible region.  The intent is a reusable foundation across all such problem
classes, not merely infrastructure for a single OPF problem definition.

---

BMOPFTools ships a **four-wire rectangular current–voltage (IVR-EN)** optimal
power flow engine as a Julia package extension.  It activates automatically when
both JuMP and Ipopt are loaded:

```julia
using BMOPFTools, JuMP, Ipopt

net    = parse_bmopf("mynetwork.json")
result = solve_opf(net)
```

A full mathematical derivation is available in `docs/math-model.tex`.

---

## Mathematical model

### Network representation

The network is a graph of **buses** $b \in \mathcal{B}$, each with a set of
**terminals** $\mathcal{T}_b$.  Terminals are named strings (e.g. `"a"`, `"b"`,
`"c"`, `"n"`).  The *neutral terminal* $n_b$ is identified by the explicit
`neutral_terminal` bus field, or by the naming convention: a terminal named `"n"`
or `"N"` (case-insensitive) is treated as neutral.

Terminals declared in `perfectly_grounded_terminals` are **perfectly grounded**:
their voltage is fixed to zero and they do not appear in the KCL system.
The set of grounded pairs is $\mathcal{G}_\text{nd}$.

**Phase terminals** $\mathcal{T}_b^\phi \subseteq \mathcal{T}_b$ are all
terminals that are not the neutral.

---

### Variables

All variables are real-valued and in SI units (V and A).

| Variable | Index | Description |
|---|---|---|
| $v^r_{b,t},\; v^i_{b,t}$ | $(b,t)\in\mathcal{B}\times\mathcal{T}_b$ | Rectangular voltage at terminal |
| $c^r_{\ell,k},\; c^i_{\ell,k}$ | line $\ell$, conductor $k$ | Series current, from-side |
| $\tilde{c}^r_{\ell,k},\; \tilde{c}^i_{\ell,k}$ | line $\ell$, conductor $k$ | Series current, to-side |
| $c^{r,d}_{d,k},\; c^{i,d}_{d,k}$ | load $d$, phase $k$ | Load current |
| $c^{r,g}_{g,k},\; c^{i,g}_{g,k}$ | generator $g$, phase $k$ | Generator current |
| $c^{r,s}_{v,k},\; c^{i,s}_{v,k}$ | voltage source $v$, phase $k$ | Source slack current |
| $c^{r,x}_{x,\sigma,k},\; c^{i,x}_{x,\sigma,k}$ | transformer $x$, side $\sigma$, conductor $k$ | Transformer winding current |

Load, generator, and source current variables cover **phase conductors only**;
neutral return current is implicit in KCL. (Inverters add an analogous current
variable per phase — see the inverter section.)

---

### Objective

Minimise total active-power generation cost (linear in current variables):

$$\min \sum_{g \in \mathcal{G}} \sum_{k=1}^{|\mathcal{T}_g^\phi|}
  c^g_k \cdot \bigl(\Delta v^r_k \, c^{r,g}_{g,k} + \Delta v^i_k \, c^{i,g}_{g,k}\bigr)$$

where $c^g_k$ (currency/W) is the **per-phase** linear cost coefficient — the
`cost` field is a vector with one entry per phase term, indexed by $k$ — and
$\Delta v_k$ is the phase-to-neutral (WYE) or line-to-line (DELTA) voltage at
generator $g$'s $k$-th phase terminal (see [Generators](@ref generators-section)
below). The same per-phase `cost` vector prices the voltage source and inverters.

---

### Constraints

#### Grounding

```math
v^r_{b,t} = 0, \quad v^i_{b,t} = 0 \qquad \forall\,(b,t) \in \mathcal{G}_\text{nd}
```

#### Voltage sources

Each source terminal $t_k$ is fixed to the specified rectangular value:

```math
v^r_{b,t_k} = V^s_{v,k} \cos\theta^s_{v,k}, \qquad
v^i_{b,t_k} = V^s_{v,k} \sin\theta^s_{v,k}
```

The voltage source is also the network's **current slack**: it injects a free
current $(c^{r,s}_{v,k},\, c^{i,s}_{v,k})$ into KCL at each phase terminal (with
the summed return at the neutral), so power balance at the source bus is met by
the source itself — no auxiliary generator is required. The slack current is
unbounded by default; optional per-phase bounds make it a bounded grid
connection, and an optional `cost` prices imported power (see
[Voltage source as current slack](@ref source-slack) below).

The source-bus **neutral** is additionally fixed to zero
($v^r_{b,n} = v^i_{b,n} = 0$) without being added to $\mathcal{G}_\text{nd}$,
so that KCL is still enforced there and the grid generator's neutral return
current can satisfy it.

#### Voltage magnitude bounds

Applied at every ungrounded, non-source, non-neutral phase terminal:

```math
\bigl(v^b_\text{min}\bigr)^2
\;\leq\;
\bigl(v^r_{b,t}\bigr)^2 + \bigl(v^i_{b,t}\bigr)^2
\;\leq\;
\bigl(v^b_\text{max}\bigr)^2,
\qquad t \in \mathcal{T}_b^\phi
```

The neutral terminal is excluded; its voltage is determined by KCL.

#### Lines

**KVL** (series voltage drop, conductor $k$ of line $\ell$ with total impedance
matrix $\mathbf{R}_\ell + j\mathbf{X}_\ell$ in Ω):

```math
v^r_{b^\text{fr}, t^\text{fr}_k} - v^r_{b^\text{to}, t^\text{to}_k}
= \sum_j \bigl(R_{\ell,kj}\,c^r_{\ell,j} - X_{\ell,kj}\,c^i_{\ell,j}\bigr)
```

```math
v^i_{b^\text{fr}, t^\text{fr}_k} - v^i_{b^\text{to}, t^\text{to}_k}
= \sum_j \bigl(R_{\ell,kj}\,c^i_{\ell,j} + X_{\ell,kj}\,c^r_{\ell,j}\bigr)
```

The impedance matrices capture full mutual coupling between conductors.

**Series current balance** (to-side series current equals the negative of the from-side):

```math
\tilde{c}^r_{\ell,k} = -c^r_{\ell,k}, \qquad \tilde{c}^i_{\ell,k} = -c^i_{\ell,k}
```

**π-model shunt currents** (from linecode ``G_fr``/``B_fr``/``G_to``/``B_to`` fields,
scaled by line length; linear in voltage variables, no new JuMP variables):

```math
I^{\text{sh},r}_{k}(b) = \sum_j \bigl(G_{kj}\,v^r_{b,t_j} - B_{kj}\,v^i_{b,t_j}\bigr),
\qquad
I^{\text{sh},i}_{k}(b) = \sum_j \bigl(G_{kj}\,v^i_{b,t_j} + B_{kj}\,v^r_{b,t_j}\bigr)
```

KCL contributions: $-(c^r_{\ell,k} + I^{\text{sh},r}_k(b^\text{fr}))$ at the from-bus,
$-(\tilde{c}^r_{\ell,k} + I^{\text{sh},r}_k(b^\text{to}))$ at the to-bus.

**Thermal current limit** on the **total** current (series + shunt) at each end:

```math
\bigl(c^r_{\ell,k} + I^{\text{sh},r}_k(b^\text{fr})\bigr)^2
+ \bigl(c^i_{\ell,k} + I^{\text{sh},i}_k(b^\text{fr})\bigr)^2
\leq \bigl(I^\text{max}_{\ell,k}\bigr)^2
```

```math
\bigl(\tilde{c}^r_{\ell,k} + I^{\text{sh},r}_k(b^\text{to})\bigr)^2
+ \bigl(\tilde{c}^i_{\ell,k} + I^{\text{sh},i}_k(b^\text{to})\bigr)^2
\leq \bigl(I^\text{max}_{\ell,k}\bigr)^2
```

#### Switches

A **closed** switch enforces zero voltage drop:

```math
v^r_{b^\text{fr},t^\text{fr}_k} = v^r_{b^\text{to},t^\text{to}_k}, \qquad
v^i_{b^\text{fr},t^\text{fr}_k} = v^i_{b^\text{to},t^\text{to}_k}
```

An **open** switch has its current variables fixed to zero; no voltage coupling
is imposed.

#### Standalone shunts

A `shunt` object represents an admittance matrix $\mathbf{Y}^{sh} = \mathbf{G}^{sh} + j\mathbf{B}^{sh}$ (S)
connected between a set of bus terminals and ground.  The current it draws is
linear in the voltage variables (no new JuMP variables):

```math
I^{\text{sh},r}_{k} = \sum_j \bigl(G^{sh}_{kj}\,v^r_{b,t_j} - B^{sh}_{kj}\,v^i_{b,t_j}\bigr),
\qquad
I^{\text{sh},i}_{k} = \sum_j \bigl(G^{sh}_{kj}\,v^i_{b,t_j} + B^{sh}_{kj}\,v^r_{b,t_j}\bigr)
```

KCL contribution: $-I^{\text{sh},r}_k$ (current leaves the bus to ground).
Grounded terminals are absent from the voltage variable dict and contribute zero.

#### Loads

For every load sub-load $k$, define the **voltage drop** across the sub-load
(phase-to-neutral for WYE/SINGLE\_PHASE; line-to-line for DELTA):

```math
\Delta v^r_k = v^r_{b,t^\phi_k} - v^r_{b,n_b}, \qquad
\Delta v^i_k = v^i_{b,t^\phi_k} - v^i_{b,n_b}
```

The **realized power** is always bilinear in these voltage drops and the load
current variables (exact, no approximation):

```math
P_k = \Delta v^r_k \, c^{r,d}_{d,k} + \Delta v^i_k \, c^{i,d}_{d,k}, \qquad
Q_k = \Delta v^i_k \, c^{r,d}_{d,k} - \Delta v^r_k \, c^{i,d}_{d,k}
```

The load `model` field determines the right-hand-side value that $P_k$ and
$Q_k$ are pinned to.

##### Squared-voltage-drop variable

All voltage-dependent models introduce a scalar auxiliary variable per
sub-load:

```math
W_k = (\Delta v^r_k)^2 + (\Delta v^i_k)^2
```

$W_k$ is bounded: $(f \cdot V^{\text{nom}}_k)^2 \leq W_k \leq (c \cdot V^{\text{nom}}_k)^2$
with floor fraction $f = 0.5$ and ceiling fraction $c = 1.5$.  These
conditioning bounds are deliberately wider than any supply standard; the
bus voltage-magnitude bounds are the operative engineering constraints.

When a constant-current term is present, a further auxiliary variable
$s_k = \sqrt{W_k}$ is introduced with $s_k^2 = W_k$, $s_k \geq 0$.

##### Model types

| `model` | $P_k$ pinned to | $Q_k$ pinned to | Quadratic? |
|---|---|---|---|
| `constant_power` (default) | $P^{\text{nom}}_k$ | $Q^{\text{nom}}_k$ | yes |
| `constant_current` | $P^{\text{nom}}_k \cdot s_k / V^{\text{nom}}_k$ | $Q^{\text{nom}}_k \cdot s_k / V^{\text{nom}}_k$ | yes (with $s_k$) |
| `constant_impedance` | $P^{\text{nom}}_k \cdot W_k / (V^{\text{nom}}_k)^2$ | $Q^{\text{nom}}_k \cdot W_k / (V^{\text{nom}}_k)^2$ | yes |
| `zip` | $P^{\text{nom}}_k (\alpha^Z_k W_k/(V^{\text{nom}}_k)^2 + \alpha^I_k s_k/V^{\text{nom}}_k + \alpha^P_k)$ | analogous with $\beta$ | yes (with $s_k$ if $\alpha^I_k \neq 0$) |
| `exponential` | $P^{\text{nom}}_k (W_k/(V^{\text{nom}}_k)^2)^{\gamma^P_k/2}$ | analogous with $\gamma^Q_k$ | only if $\gamma \in \{0,1,2\}$ |

**Integer-exponent routing:** exponential loads with $\gamma \in \{0, 1, 2\}$
are automatically routed to the constant-power, constant-current, or
constant-impedance quadratic path respectively, keeping the formulation
quadratic.  The data-analysis pass ([`load_model_analysis`](@ref)) flags
these loads with `I.LOAD.EXP_ZIP_EQUIVALENT`.

**v\_nom** is required for all models except `constant_power`.  It is the
terminal voltage magnitude at which `p_nom`/`q_nom` are specified: phase-to-neutral (V) for WYE, line-to-line (V) for DELTA.  It may be a scalar
(shared across all sub-loads) or a per-sub-load array.

**DELTA** loads use line-to-line voltage drops: $\Delta v^r_k = v^r_{b,t_k} - v^r_{b,t_{k^+}}$,
$\Delta v^i_k = v^i_{b,t_k} - v^i_{b,t_{k^+}}$ (indices cyclic).

#### [Generators](@id generators-section)

Same bilinear form as WYE loads, with power bounds instead of equalities and
injected (positive) sign convention:

```math
P^{g,\text{min}}_{g,k}
\;\leq\; \Delta v^r_k \, c^{r,g}_{g,k} + \Delta v^i_k \, c^{i,g}_{g,k}
\;\leq\; P^{g,\text{max}}_{g,k}
```

```math
Q^{g,\text{min}}_{g,k}
\;\leq\; \Delta v^i_k \, c^{r,g}_{g,k} - \Delta v^r_k \, c^{i,g}_{g,k}
\;\leq\; Q^{g,\text{max}}_{g,k}
```

#### Transformers

All transformer constraints are **linear**.  The turns ratio for all subtypes
is $N = V^\text{ref}_\text{fr} / V^\text{ref}_\text{to}$ (SI volts).

---

**`single_phase` — Γ-equivalent model**

Series impedance $R_x = R_1 + N^2 R_2$, $X_x = X_1 + N^2 X_2$ is referred
to the HV (from) side, where $R_1, X_1$ (`r/x_series_from`, Ω on HV base)
are the HV winding values and $R_2, X_2$ (`r/x_series_to`, Ω on LV base)
are the LV winding values.  For each per-phase pair index $k$:

```math
v^r_{b^\text{fr},t^\text{fr}_k} - N\,v^r_{b^\text{to},t^\text{to}_k}
= R_x\,c^{r,x}_{x,\text{fr},k} - X_x\,c^{i,x}_{x,\text{fr},k}
```

```math
N\,c^{r,x}_{x,\text{fr},k} + c^{r,x}_{x,\text{to},k} = 0 \quad\text{(and imaginary)}
```

The no-load shunt $G_0 + jB_0$ (`g_no_load`, `b_no_load`, S) sits at the
HV terminals (phase-to-ground).  The total HV terminal current entering the
bus is series + shunt:

```math
I^\text{fr,term}_{x,k} =
  c^{r,x}_{x,\text{fr},k}
  + G_0\,v^r_{b^\text{fr},t^\text{fr}_k}
  - B_0\,v^i_{b^\text{fr},t^\text{fr}_k}
```

When all loss fields are absent or zero the model reduces to the ideal
$v^r_{b^\text{fr},t^\text{fr}_k} = N\,v^r_{b^\text{to},t^\text{to}_k}$.

---

**`center_tap` — T-model with per-leg secondary impedance**

Terminal map: `terminal_map_from = [t_ph, t_n]` (HV phase, HV neutral),
`terminal_map_to = [t₁, tₙ, t₂]` (leg-1, center-tap neutral, leg-2).
$V^\text{ref}_\text{to}$ is the **per-leg** voltage (e.g. 120 V for a
120-0-120 V unit), so $N = V^\text{ref}_\text{fr}/V^\text{ref}_\text{to} = 60$
for a 7.2 kV / 120 V unit.

Each leg has its own secondary impedance branch ($Z_2 = R_2 + jX_2$).
For leg $\ell \in \{1, 2\}$ with LV current $c^{r,x}_{x,\ell}$ and leg
terminals $(t_a, t_b)$:

```math
\bigl(v^r_{b^\text{fr},t^\text{ph}} - v^r_{b^\text{fr},t^\text{n}}\bigr)
- N\bigl(v^r_{b^\text{to},t_a} - v^r_{b^\text{to},t_b}\bigr)
= R_1\,c^{r,x}_{x,s} - X_1\,c^{i,x}_{x,s}
  - N\bigl(R_2\,c^{r,x}_{x,\ell} - X_2\,c^{i,x}_{x,\ell}\bigr)
```

where $c^{r,x}_{x,s}$ is the HV series current (variable index 1 on `fr`
side).  The $-N Z_2 I_\ell$ sign follows from the T-model star-node
elimination: LV currents are defined flowing **into** the transformer from
the bus, i.e. opposite to the direction through the winding branch from the
star node.

Current coupling (both leg currents into the transformer):

```math
N\,c^{r,x}_{x,s} + c^{r,x}_{x,\ell_1} + c^{r,x}_{x,\ell_2} = 0
\quad\text{(and imaginary)}
```

Center-tap KCL (variable index 2 on `to` side):

```math
c^{r,x}_{x,n} + c^{r,x}_{x,\ell_1} + c^{r,x}_{x,\ell_2} = 0
\quad\text{(and imaginary)}
```

The no-load shunt $G_0 + jB_0$ is placed at the HV phase terminal
$t^\text{ph}$ (same convention as `single_phase`).  The HV series current
returns through $t^\text{n}$; the shunt is phase-to-ground and does not
pass through the HV neutral.

!!! note "Leakage from OpenDSS XHL/XLT/XHT"
    For a 3-winding OpenDSS unit, the per-pair leakage values must be
    star-converted before storing in `x_series_from`/`x_series_to`:
    ```
    x_series_from = (XHL + XHT − XLT) / 2 × Vhv² / (100 · s_rating)
    x_series_to   = (XHL + XLT − XHT) / 2 × Vlv² / (100 · s_rating)
    ```
    Using `XHL/2` for both (the 2-winding formula) forces equal leg voltages
    regardless of load imbalance and is incorrect for `center_tap`.

---

**Wye–delta (Yd) / Delta–wye (Dy)** — effective turns ratio:

$$n_\text{eff} = \begin{cases} \sqrt{3}/N & \text{Yd} \\ N\sqrt{3} & \text{Dy} \end{cases}$$

**Loss model (per-winding T).** Matching the OpenDSS / PMD reference, each
winding carries its own series impedance — $R^\text{w}/X^\text{w}$
(`r/x_series_from`, wye winding) and $R^\text{d}/X^\text{d}$
(`r/x_series_to`, delta winding) — and a `g/b_no_load` core-loss shunt sits at
the from-side (HV) phase terminals. The legacy single `r_series`/`x_series` is
read as $R^\text{w} = R_\text{series}$, $R^\text{d} = 0$, recovering the ideal
delta. The series drop enters the voltage equation behind the ideal transform:

Voltage (delta line-to-line = wye phase-to-neutral × $n_\text{eff}$, less the
winding series drop, indices cyclic):

```math
v^r_{\text{del},t_k} - v^r_{\text{del},t_{k^+}}
= n_\text{eff}\bigl(v^r_{\text{wye},t^\phi_k} - v^r_{\text{wye},n_\text{wye}}\bigr)
  - \bigl(R^\text{w} c^{r,x}_{x,\text{wye},k} - X^\text{w} c^{i,x}_{x,\text{wye},k}\bigr)
  - n_\text{eff}\bigl(R^\text{d} c^{r,x}_{x,\text{del},k} - X^\text{d} c^{i,x}_{x,\text{del},k}\bigr)
```

When all impedance fields are zero this collapses to the ideal transform.

Current (transpose of voltage transform, power-conservative):

```math
n_\text{eff} \, c^{r,x}_{x,\text{del},k}
= c^{r,x}_{x,\text{wye},k} - c^{r,x}_{x,\text{wye},k^-}
```

Star-point KCL at the wye neutral:

```math
c^{r,x}_{x,\text{wye},n} + \sum_{k} c^{r,x}_{x,\text{wye},k} = 0
```

#### Kirchhoff's Current Law

KCL is enforced at every ungrounded terminal. Each component accumulates its
signed current contribution (positive = into bus) into per-terminal expressions
$\kappa^r_{b,t}$ and $\kappa^i_{b,t}$:

```math
\kappa^r_{b,t} = 0, \qquad \kappa^i_{b,t} = 0
\qquad \forall\,(b,t) \notin \mathcal{G}_\text{nd}
```

Sign conventions:

| Component | Terminal | KCL contribution |
|---|---|---|
| Line from-side | from terminal | $-c^r_\ell$ (leaves) |
| Line to-side | to terminal | $+c^r_\ell$ (enters, since $\tilde{c} = -c$) |
| Load WYE | phase terminal | $-c^{r,d}$ (consumed) |
| Load WYE | neutral terminal | $+c^{r,d}$ (return) |
| Load DELTA | positive terminal | $-c^{r,d}$ |
| Load DELTA | negative terminal | $+c^{r,d}$ |
| Generator WYE | phase terminal | $+c^{r,g}$ (injects) |
| Generator WYE | neutral terminal | $-c^{r,g}$ (return) |
| Voltage source | phase terminal | $+c^{r,s}$ (slack injects) |
| Voltage source | neutral terminal | $-c^{r,s}$ (return) |
| Transformer | each terminal | $-c^{r,x}$ (winding current leaves) |

---

## [Voltage source as current slack](@id source-slack)

The voltage source fixes its terminal voltages **and** closes KCL at the source
bus through its own slack current $(c^{r,s}_{v,k},\, c^{i,s}_{v,k})$ — there is no
separate slack generator and no `_auto_slack` injection. This mirrors the
OpenDSS/PMD `Vsource`, which is both a voltage reference and an (implicit)
unbounded power injection.

Because the terminal voltages are fixed, the per-phase power is **linear** in the
slack current:

```math
P^s_{v,k} = \Delta v^r_k \, c^{r,s}_{v,k} + \Delta v^i_k \, c^{i,s}_{v,k}, \qquad
Q^s_{v,k} = \Delta v^i_k \, c^{r,s}_{v,k} - \Delta v^r_k \, c^{i,s}_{v,k}
```

where $\Delta v$ is the phase-to-neutral voltage at the source bus. Optional
fields on the `voltage_source` object shape the slack:

- **`p_min`/`p_max`/`q_min`/`q_max`** — per-phase box bounds. Absent ⇒ unbounded
  (pure power-flow slack); present ⇒ a bounded grid connection.
- **`cost`** — a per-phase vector of linear active-power prices (one entry per
  phase term) added to the objective; exact since the source voltage is fixed.

The source-bus **neutral** is fixed to zero and carries the summed slack return
current, so neutral KCL is satisfied without a neutral voltage reference.

This makes the source play three roles with one object: unbounded power-flow
slack (no bounds, no cost), bounded grid connection (bounds), and priced
import/export (cost). `from_pmd` and the augmentation pass set `cost` on the
source by default (see [Conversion](conversion.md) / [Augmentation](augmentation.md)).

!!! note "Independent generators at the source bus"
    The voltage source is already the slack, so an *unbounded* generator
    co-located at the source bus creates a second free current injection at a
    fixed-voltage bus — a degenerate dispatch split. The pre-flight check flags
    this (`W.PRE.SOURCE_BUS_GENERATOR` for unbounded, `I.PRE.SOURCE_BUS_GENERATOR`
    for bounded); model such limits/cost on the voltage source instead.

---

## Warm-start initialisation

Both solvers seed Ipopt with phase-correct voltage start values (rectangular
`v_nom·∠angle`) so the NLP converges to the physical solution without a load-flow
pre-solve. Phase terminals use the canonical three-phase angles (0°, −120°, +120°)
taken from the voltage source. **Split-phase zones are special-cased**: a zone fed
by a `center_tap` transformer (see [`I.PROV.SPLIT_PHASE_ZONE`](findings.md)) has its
two legs initialised **anti-phase** — θ and θ+180° about the centre-tap neutral,
where θ is the feeding MV phase angle — rather than 120° apart. Without this, every
centre-tap secondary starts with a 60° leg error.

## Feasibility relaxation

`solve_feasibility_opf` adds an **elastic slack current**
$(c^{r,\varepsilon}_{b,t},\, c^{i,\varepsilon}_{b,t})$ at every ungrounded,
non-source terminal, making KCL always satisfiable:

```math
\kappa^r_{b,t} + c^{r,\varepsilon}_{b,t} = 0, \qquad
\kappa^i_{b,t} + c^{i,\varepsilon}_{b,t} = 0
```

The cost objective is replaced by the $\ell_2^2$ norm of all slack injections:

```math
\min \sum_{(b,t)} \Bigl[\bigl(c^{r,\varepsilon}_{b,t}\bigr)^2
                       + \bigl(c^{i,\varepsilon}_{b,t}\bigr)^2\Bigr]
```

All device models — load, generator, **inverter**, shunt, transformer, switch,
and the voltage-source slack — are built identically to `solve_opf`. The only
differences are the deliberate ones: operational **network** bounds (voltage
magnitude/sequence, line thermal-angle, bus limits) are **not** hard constraints
here, and the objective is the slack norm rather than cost. Voltage bounds are
evaluated post-solve by `diagnose_infeasibility`.

A zero-slack solution certifies physical feasibility.  Non-zero slacks at
$(b, t)$ reveal where the network cannot balance KCL without external
intervention.

```julia
fopf   = solve_feasibility_opf(net)
diag   = diagnose_infeasibility(fopf, net)

println(diag["is_feasible"])            # false if network is overloaded
println(diag["total_infeasibility_A"])  # L2 norm of all slacks (A)
```

---

## API reference

```@docs
solve_opf
solve_feasibility_opf
diagnose_infeasibility
```
