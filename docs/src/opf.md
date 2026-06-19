# Optimal power flow

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
| $c^{r,x}_{x,\sigma,k},\; c^{i,x}_{x,\sigma,k}$ | transformer $x$, side $\sigma$, conductor $k$ | Transformer winding current |

Load and generator current variables cover **phase conductors only**; neutral
return current is implicit in KCL.

---

### Objective

Minimise total active-power generation cost (linear in current variables):

$$\min \sum_{g \in \mathcal{G}} \sum_{k=1}^{|\mathcal{T}_g^\phi|}
  c^g_1 \cdot \bigl(\Delta v^r_k \, c^{r,g}_{g,k} + \Delta v^i_k \, c^{i,g}_{g,k}\bigr)$$

where $c^g_1$ (currency/W) is the linear cost coefficient and $\Delta v_k$ is the
phase-to-neutral (WYE) or line-to-line (DELTA) voltage at generator $g$'s
$k$-th phase terminal (see [Generators](@ref generators-section) below).

---

### Constraints

#### Grounding

```math
v^r_{b,t} = 0, \quad v^i_{b,t} = 0 \qquad \forall\,(b,t) \in \mathcal{G}_\text{nd}
```

#### Voltage sources

Each source terminal $t_k$ is fixed to the specified rectangular value.
The voltage source provides the **voltage reference only** — it does not inject
current into KCL:

```math
v^r_{b,t_k} = V^s_{v,k} \cos\theta^s_{v,k}, \qquad
v^i_{b,t_k} = V^s_{v,k} \sin\theta^s_{v,k}
```

Power balance at the source bus is satisfied by an explicit generator (see
[Source bus generator injection](@ref source-gen-injection) below).

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

All transformer constraints are **linear**.

**Wye–wye (YY)** — `single_phase` and `center_tap` subtypes, turns ratio
$N = V^\text{ref}_\text{fr} / V^\text{ref}_\text{to}$:

```math
v^r_{b^\text{fr},t^\text{fr}_k} = N \, v^r_{b^\text{to},t^\text{to}_k}, \qquad
v^i_{b^\text{fr},t^\text{fr}_k} = N \, v^i_{b^\text{to},t^\text{to}_k}
```

```math
N \, c^{r,x}_{x,\text{fr},k} + c^{r,x}_{x,\text{to},k} = 0 \quad\text{(and imaginary)}
```

**Wye–delta (Yd) / Delta–wye (Dy)** — effective turns ratio:

$$n_\text{eff} = \begin{cases} \sqrt{3}/N & \text{Yd} \\ N\sqrt{3} & \text{Dy} \end{cases}$$

Voltage (delta line-to-line = wye phase-to-neutral × $n_\text{eff}$, indices cyclic):

```math
v^r_{\text{del},t_k} - v^r_{\text{del},t_{k^+}}
= n_\text{eff}\bigl(v^r_{\text{wye},t^\phi_k} - v^r_{\text{wye},n_\text{wye}}\bigr)
```

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
| Transformer | each terminal | $-c^{r,x}$ (winding current leaves) |

---

## [Source bus generator injection](@id source-gen-injection)

Because the voltage source only fixes voltages and does not inject current,
**every ungrounded terminal at the source bus must have its KCL satisfied by
an explicit generator**.  Before building the JuMP model, `solve_opf` and
`solve_feasibility_opf` call `_ensure_source_generator!`, which checks whether
any generator with a neutral terminal already exists at the source bus.  If not,
it automatically injects an unbounded zero-cost generator named `_auto_slack`
and emits a warning:

```
┌ Warning: solve_opf: no generator found at source bus 'sourcebus' —
│ automatically injecting an unbounded zero-cost generator '_auto_slack'
│ to satisfy KCL. For a proper OPF benchmark add an explicit grid generator
│ with bounds and cost at the source bus.
```

The `_auto_slack` generator covers **all phase terminals plus the neutral** of the
source bus, so both phase and neutral KCL are satisfied.  It appears in the
result dict under `result["generator"]["_auto_slack"]` so its active and reactive
power output is visible.

**When auto-injection fires:**

- Pure power-flow networks (no generators defined).
- OPF networks where the modeller omitted a grid-connection generator at the
  slack bus.
- Networks converted from PowerModelsDistribution via `from_pmd`: the
  synthesised `slack_source` generator has only phase terminals (no neutral),
  so `_auto_slack` is injected alongside it to cover the neutral.

**For production OPF benchmarks** the warning should be resolved by adding an
explicit `generator` at the source bus with physically meaningful `p_min`,
`p_max` bounds and a `cost` that reflects grid import/export pricing.  The
`_auto_slack` fallback exists for ergonomics and power-flow compatibility, not
as a substitute for a properly specified grid connection.

---

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

Voltage bounds are **not** hard constraints in this variant; they are evaluated
post-solve by `diagnose_infeasibility`.

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
