# Optimal power flow

BMOPFTools includes a four-wire rectangular current-voltage (IVR-EN) optimal power
flow engine.  It is shipped as a Julia package extension and activates automatically
when both **JuMP** and **Ipopt** are loaded alongside BMOPFTools:

```julia
using BMOPFTools, JuMP, Ipopt

net    = parse_bmopf("mynetwork.json")
result = solve_opf(net)
```

## Formulation

The OPF uses the IVR-EN (rectangular current-voltage, explicit neutral) formulation
common in four-wire distribution network analysis:

- Voltage variables `vr / vi` at every bus terminal, including the neutral conductor.
- Series current variables `cr / ci` per conductor at each branch end.
- Constant-power load and generator models (bilinear P/Q equations in voltage × current).
- Neutral terminal voltages are explicit variables; they float unless declared
  perfectly grounded or fixed by a voltage source.
- Transformer types: per-phase YY (`single_phase`, `center_tap`), Yd (`wye_delta`),
  and Dy (`delta_wye`).

Shunt admittance (G/B pi-model) is not modelled in this version.

## Feasibility analysis

When a network is overloaded or has conflicting constraints, `solve_opf` may fail
to converge.  `solve_feasibility_opf` instead adds elastic slack current injections
at every bus terminal so that KCL can always be satisfied, then minimises the L2²
norm of those slacks.  Because the relaxed problem is always feasible, the solver
always converges.

```julia
fopf   = solve_feasibility_opf(net)
report = diagnose_infeasibility(fopf, net)

println(report["is_feasible"])            # false if network is overloaded
println(report["total_infeasibility_A"])  # total slack magnitude in amperes
```

Non-zero slacks in the result indicate where the network cannot satisfy its physical
constraints.  Pass the result to `diagnose_infeasibility` for a ranked, classified
breakdown by bus.

## API reference

```@docs
solve_opf
solve_feasibility_opf
diagnose_infeasibility
```
