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
| $c^{r,v}_{v,k},\; c^{i,v}_{v,k}$ | source $v$, terminal $k$ | Voltage source slack current |
| $c^{r,x}_{x,\sigma,k},\; c^{i,x}_{x,\sigma,k}$ | transformer $x$, side $\sigma$, conductor $k$ | Transformer winding current |

Load and generator current variables cover **phase conductors only**; neutral
return current is implicit in KCL.

---

### Objective

Minimise total active-power generation cost (linear in current variables):

$$\min \sum_{g \in \mathcal{G}} \sum_{k=1}^{|\mathcal{T}_g^\phi|}
  c^g_1 \cdot \bigl(\Delta v^r_k \, c^{r,g}_{g,k} + \Delta v^i_k \, c^{i,g}_{g,k}\bigr)$$

where $c^g_1$ (\$/W) is the linear cost coefficient and $\Delta v_k$ is the
phase-to-neutral (WYE) or line-to-line (DELTA) voltage at generator $g$'s
$k$-th phase terminal (see [Generators](@ref generators-section) below).

---

### Constraints

#### Grounding

```math
v^r_{b,t} = 0, \quad v^i_{b,t} = 0 \qquad \forall\,(b,t) \in \mathcal{G}_\text{nd}
```

#### Voltage sources

Each source terminal $t_k$ is fixed to the specified rectangular value and
injects an unconstrained slack current $c^{r,v}_{v,k}$ into KCL:

```math
v^r_{b,t_k} = V^s_{v,k} \cos\theta^s_{v,k}, \qquad
v^i_{b,t_k} = V^s_{v,k} \sin\theta^s_{v,k}
```

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

The constant-power model expresses $S = V \cdot I^*$ in rectangular coordinates.
For phase terminal $t^\phi_k$ and neutral $n_b$, define the voltage drop:

```math
\Delta v^r_k = v^r_{b,t^\phi_k} - v^r_{b,n_b}, \qquad
\Delta v^i_k = v^i_{b,t^\phi_k} - v^i_{b,n_b}
```

**WYE / SINGLE\_PHASE** (phase-to-neutral voltage):

```math
\Delta v^r_k \, c^{r,d}_{d,k} + \Delta v^i_k \, c^{i,d}_{d,k} = P^{d,\text{nom}}_{d,k}
```

```math
\Delta v^i_k \, c^{r,d}_{d,k} - \Delta v^r_k \, c^{i,d}_{d,k} = Q^{d,\text{nom}}_{d,k}
```

**DELTA** (line-to-line voltage, element $k$ connecting $t_k$ to $t_{k^+}$
cyclically):

Same equations with $\Delta v^r_k = v^r_{b,t_k} - v^r_{b,t_{k^+}}$,
$\Delta v^i_k = v^i_{b,t_k} - v^i_{b,t_{k^+}}$.

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
| Voltage source | source terminal | $+c^{r,v}$ (injects) |
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
