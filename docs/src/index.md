# BMOPFTools.jl

A Julia library for **parsing, validating, analysing and reporting** on
BMOPF-format distribution network datasets — the JSON data model developed by
the IEEE Task Force on *Benchmarking Multiconductor OPF for Distribution
Systems* for up-to-four-wire optimal power flow (OPF) benchmarks
([ref. 1](methodology.md#refs)).

The term *optimal power flow* is used throughout, but the Task Force's scope
extends well beyond generation cost minimisation.  The unifying requirement
across all targeted problem classes — CVR, Dynamic Operating Envelopes,
state estimation, maximum load delivery — is a faithful, conductor-level
representation of an unbalanced distribution network subject to a selectable
set of bounds.  Voltage limits, current ratings and power constraints are
therefore optional in the data model; different formulations activate
different subsets.  See [Optimal power flow](opf.md) for the full motivation.

The library serves three use cases:

- **Dataset producers** converting utility-derived OpenDSS models into
  clean, spec-conformant BMOPF JSON benchmark cases,
- **dataset consumers** who want to understand exactly what a case contains
  — its modeling conventions, hidden assumptions, data-quality issues and
  OPF-readiness — before building optimization models on it, and
- **optimization practitioners** who, given a solved BMOPF case and an OPF
  result dict, want to flag bound violations, near-active constraints,
  constraint residuals, and solution-quality issues without access to solver
  internals.

## Design

The network data model is a plain `Dict{String,Any}` mirroring the BMOPF
JSON structure exactly. There are deliberately no wrapper types: data flows
to and from JSON and PowerModelsDistribution without conversion layers, and
the only structs in the library are the *outputs* — [`Finding`](@ref),
[`SummaryReport`](@ref), and [`SolutionReport`](@ref) — which need stable
shape for rendering and programmatic use.

Every diagnostic is a `Finding` with a **stable dot-separated code**
(`E.`/`W.`/`I.` for error/warning/info) — see the
[finding-code reference](findings.md) for the complete catalogue. Match on
codes, never on message text.

## Quickstart

Analysing an existing BMOPF JSON case:

```julia
using BMOPFTools

net    = parse_bmopf("case.json")
report = analyze(net)

render(report, stdout)              # terminal report
render(report, "case_report.md")    # Markdown report

errors(report)                      # findings with ERROR severity
report.results[:provenance]["convention"]
report.results[:benchmark]["suggestions"]
```

Profiling an OPF result dict (requires `solve_opf` or any compatible solver):

```julia
using BMOPFTools, JuMP, Ipopt

net    = parse_bmopf("case.json")
result = solve_opf(net; optimizer=Ipopt.Optimizer)

report = profile_solution(net, result)
render_solution(report, stdout)              # Markdown to terminal
render_solution(report, "solution.md")      # Markdown file

errors(report)     # bound violations and infeasibility findings
warnings(report)   # near-active bounds and residual warnings
```

Converting from OpenDSS via PowerModelsDistribution (PMD must be available
in the active environment — it is *not* a dependency of BMOPFTools):

```julia
using BMOPFTools, PowerModelsDistribution

eng = parse_file("Master.dss"; kron_reduce=false)   # keep 4-wire detail
net = from_pmd(eng)        # prices the slack on the voltage source by default
write_bmopf(net, "case.json")
analyze(net) |> r -> render(r, "case_report.md")
```

## The pipeline

```
OpenDSS .dss ──(PMD parse_file)──► ENGINEERING dict
                                        │  from_pmd
                                        ▼
  BMOPF JSON ◄── write_bmopf ── BMOPF Dict{String,Any}
                                        │  analyze
                                        ▼
                                 SummaryReport ──► render
                                        │  fix_case
                                        ▼
                                 net′ (repaired)
                                        │  augment_case
                                        ▼
                                 net″ (benchmark-ready) ──► write_bmopf
                                        │  solve_opf / to_pmd
                                        ▼
                                 result Dict{String,Any}
                                        │  profile_solution
                                        ▼
                                 SolutionReport ──► render_solution
```

`analyze` runs fifteen passes (see [Analysis & reports](analysis.md)) and
the report renders in nine sections, including a one-line **modeling
convention statement** (wires per voltage level, grounding style,
normalisations) so the case's assumptions are explicit rather than implied.

## Where to go next

- [Positioning & ecosystem](positioning.md) — where BMOPFTools fits among
  distribution optimization and modelling tools, and the benchmarking gap it targets.
- [Data model conventions](conventions.md) — units, terminal names,
  transformer subtypes, grounding semantics.
- [Conversion guide](conversion.md) — every deliberate decision in
  `from_pmd`/`to_pmd`, with the impedance-base formulas.
- [Analysis & reports](analysis.md) — what each pass computes and how to
  read the report.
- [Finding-code reference](findings.md) — complete catalogue of finding codes,
  with triggers and rationale.
- [Methodology notes](methodology.md) — the physics and linear algebra
  behind the provenance checks, with literature references.
- [Optimal power flow](opf.md) — running `solve_opf`, solver options, and
  the OPF extension model.
- [OPF result dictionary](results.md) — structure of the result dict returned
  by `solve_opf`, including the `"initialisation"` diagnostics block.
- [Case augmentation](augmentation.md) — `fix_case` structural repairs and
  `augment_case` standards-grounded gap-filling, with the manifest audit trail.
- [API reference](api.md).
