# OPF result dictionary

`solve_opf` returns a plain `Dict{String,Any}` in SI units (V, A, W, var).
The structure mirrors the input network dict: top-level keys match the network's
component types, and within each component the result is keyed by the component
id, then by terminal name (or winding label for transformers).

```julia
result = solve_opf(net)

result["termination_status"]   # "LOCALLY_SOLVED", "INFEASIBLE", …
result["objective"]            # total generation cost
result["solve_time"]           # wall-clock time in seconds

result["bus"]["b1"]["1"]["vm"] # phase-1 voltage magnitude at bus b1 (V)
result["line"]["l1"]["1"]["cr_fr"]  # real part of current at from-terminal "1" (A)
result["generator"]["g1"]["1"]["pg"]  # active power on phase "1" (W)
```

## Infeasible solutions

When the solver terminates without finding a feasible point
(`termination_status` is neither `"LOCALLY_SOLVED"`, `"OPTIMAL"`, nor
`"ALMOST_LOCALLY_SOLVED"`), every numeric field in the result is set to `NaN`.
The `termination_status` and `solve_time` fields are always valid.

## Top-level fields

| Key | Type | Description |
|---|---|---|
| `termination_status` | String | JuMP termination status (e.g. `"LOCALLY_SOLVED"`, `"INFEASIBLE"`, `"TIME_LIMIT"`) |
| `objective` | Float64 | Objective value in cost units (matches the generator cost model) |
| `solve_time` | Float64 | Solver wall-clock time (s) |
| `bus` | Dict | Per-bus, per-terminal voltage results |
| `line` | Dict | Per-line, per-conductor current results |
| `switch` | Dict | Per-switch, per-conductor current results |
| `load` | Dict | Per-load, per-phase current and absorbed power |
| `generator` | Dict | Per-generator, per-phase current and produced power |
| `transformer` | Dict | Per-transformer, per-winding-side currents |

## `bus` — voltages

```
result["bus"][bus_id][terminal] => Dict
```

All voltages are phase-to-ground (i.e. referenced to the global ground at
potential 0 V). The rectangular components `vr`/`vi` are the primary variables
solved by the OPF; `vm` and `va` are derived for convenience.

| Field | Unit | Description |
|---|---|---|
| `vr` | V | Real part of complex voltage |
| `vi` | V | Imaginary part of complex voltage |
| `vm` | V | Voltage magnitude: `√(vr² + vi²)` |
| `va` | rad | Voltage angle: `atan(vi, vr)` |

Grounded terminals (listed in `perfectly_grounded_terminals` or fixed by the
voltage source neutral) are present in the result with `vr = vi = vm = 0`,
`va = 0`.

The neutral terminal voltage is an explicit variable. In a balanced network it
is close to zero; in an unbalanced network it reflects the neutral shift.

## `line` — series currents

```
result["line"][line_id][terminal_name] => Dict
```

Conductors are keyed by **terminal name** taken from `terminal_map_from` of the
input line. A line with `terminal_map_from = ["1","2","n"]` produces result
keys `"1"`, `"2"`, `"n"`.

The IVR formulation carries separate current variables at each end of every
line to account for the shunt (capacitive) half-sections of the π model. Both
ends are available in the result.

| Field | Unit | Description |
|---|---|---|
| `cr_fr` | A | Real part of current leaving the from-terminal |
| `ci_fr` | A | Imaginary part of current leaving the from-terminal |
| `cr_to` | A | Real part of current entering the to-terminal |
| `ci_to` | A | Imaginary part of current entering the to-terminal |
| `cm_fr` | A | Current magnitude at from-terminal: `√(cr_fr² + ci_fr²)` |
| `cm_to` | A | Current magnitude at to-terminal: `√(cr_to² + ci_to²)` |

KCL sign convention: current is positive flowing **into** the bus. `cr_fr` and
`ci_fr` are the current *leaving* the from-bus into the line, so they appear as
negative contributions in the from-bus KCL and positive in the to-bus KCL
(after traversing the series impedance).

`cm_fr ≠ cm_to` when the linecode has nonzero shunt admittance (π model). For
purely series lines (no shunt) they are equal.

## `switch` — switch currents

```
result["switch"][switch_id][terminal_name] => Dict
```

Conductors are keyed by terminal name from `terminal_map_from`. Open switches
have all currents fixed to zero; they appear in the result as `cr = ci = cm = 0`.

| Field | Unit | Description |
|---|---|---|
| `cr` | A | Real part of current (positive into bus at from-side) |
| `ci` | A | Imaginary part of current |
| `cm` | A | Current magnitude: `√(cr² + ci²)` |

Switches are ideal (lossless and voltage-coupling): `cr_from = -cr_to` exactly.
Only the from-side current is stored.

## `load` — absorbed power

```
result["load"][load_id][phase_terminal] => Dict
```

Loads are keyed by **phase terminal** name (the neutral terminal, if present,
carries no independent current variable and is absent from the result). For a
WYE load with `terminal_map = ["1","2","3","n"]` the result has keys `"1"`,
`"2"`, `"3"`.

The power fields confirm that the constant-power constraints were satisfied at
the solved operating point.

| Field | Unit | Description |
|---|---|---|
| `crd` | A | Real part of phase current drawn by the load |
| `cid` | A | Imaginary part of phase current drawn by the load |
| `pd`  | W | Active power absorbed: `Δvr·crd + Δvi·cid` |
| `qd`  | var | Reactive power absorbed: `Δvi·crd − Δvr·cid` |

`Δv = v_phase − v_neutral` for WYE/SINGLE_PHASE; `Δv = v_pos − v_neg` across
the DELTA element (terminal `k` to terminal `k mod n + 1`). For a feasible
solve `pd ≈ p_nom[k]` and `qd ≈ q_nom[k]`.

## `generator` — produced power

```
result["generator"][gen_id][phase_terminal] => Dict
```

Same terminal indexing as `load` — phase terminals only, neutral absent.

| Field | Unit | Description |
|---|---|---|
| `crg` | A | Real part of phase current injected by the generator |
| `cig` | A | Imaginary part of phase current injected by the generator |
| `pg`  | W | Active power produced: `Δvr·crg + Δvi·cig` |
| `qg`  | var | Reactive power produced: `Δvi·crg − Δvr·cig` |

The auto-injected source-bus generator `_auto_slack` (see
[Source bus generator injection](opf.md#source-gen-injection)) appears under
`result["generator"]["_auto_slack"]` with the same structure.

## `transformer` — winding currents

```
result["transformer"][xfmr_id]["fr"|"to"][k] => Dict
```

Transformer results use winding-side keys `"fr"` and `"to"`, each mapping to a
**positional index string** (`"1"`, `"2"`, ...) rather than a terminal name.
The two winding sides may have different terminal maps (e.g. a wye_delta
transformer has a neutral terminal on the wye side but not on the delta side),
so a shared terminal-name key is not well-defined.

To map position back to terminal: position `k` corresponds to
`terminal_map_from[k]` (from-side) or `terminal_map_to[k]` (to-side) in the
input network.

| Field | Unit | Description |
|---|---|---|
| `cr` | A | Real part of winding current |
| `ci` | A | Imaginary part of winding current |
| `cm` | A | Current magnitude: `√(cr² + ci²)` |

For ideal transformers the apparent power `S = V·I*` is conserved across
windings (up to the ideal turns ratio). Series winding impedances
(`r_series_from`, `x_series_from`, etc.) cause a small difference.

## Voltage source and grid injection

The voltage source object fixes terminal voltages only — it does not inject
current and has no entry in the result dict. All current injection at the source
bus is handled by the generator there: either an explicit user-defined generator
or the auto-injected `_auto_slack` generator (see
[Source bus generator injection](opf.md#source-gen-injection)).

To obtain the total active power drawn from the grid, sum `pg` over all
terminals of the source-bus generator:

```julia
slack = result["generator"]["_auto_slack"]   # or your explicit generator id
p_grid = sum(v["pg"] for v in values(slack))
```

## Coordinate spaces and sign conventions

| Quantity | Space | Sign |
|---|---|---|
| Bus voltage | Rectangular (`vr`/`vi`), phase-to-ground | — |
| Line current | Rectangular, referenced to from-bus direction | Positive leaving the bus into the line |
| Load current | Rectangular, phase current only | Positive flowing from bus into load |
| Generator current | Rectangular, phase current only | Positive flowing from generator into bus |
| Power (all) | `P = Re(V · I*)`, `Q = Im(V · I*)` | Positive = absorbed (load) / produced (generator) |

All phase-to-neutral voltage differences use the **solved** neutral voltage
(explicit JuMP variable), not a forced-zero assumption. This is the correct
reference for 4-wire networks where the neutral is not perfectly grounded.

## Per-unit scaling

When `solve_opf` is called with `per_unit=true` the result is automatically
converted back to SI before being returned. The caller always receives SI units
regardless of the internal solver representation.
