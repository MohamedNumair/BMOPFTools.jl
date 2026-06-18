> [!WARNING]  
> This project is currently ongoing rapid development and may have breaking changes made directly to main. Use at your own risk until further notice. An upcoming breaking change is removing the dependence on the OpenDSS parser from PMD, which will be switched to https://github.com/eigenergy/PowerIO.jl


[![Documentation](https://github.com/frederikgeth/BMOPFTools.jl/actions/workflows/documentation.yml/badge.svg)](https://github.com/frederikgeth/BMOPFTools.jl/actions/workflows/documentation.yml) [![CI](https://github.com/frederikgeth/BMOPFTools.jl/actions/workflows/ci.yml/badge.svg)](https://github.com/frederikgeth/BMOPFTools.jl/actions/workflows/ci.yml)

# BMOPFTools.jl

A Julia library for **parsing, validating, analysing and reporting** on
BMOPF-format distribution network datasets — the JSON data model developed by
the IEEE Task Force on *Benchmarking Multiconductor OPF for Distribution
Systems* for up-to-four-wire optimal power flow currently hosted at 
https://github.com/frederikgeth/bmopf-report

The network data model is a plain `Dict{String,Any}` that mirrors the BMOPF
JSON schema exactly: no wrapper types, so data flows naturally between JSON,
PowerModelsDistribution and your own code.

## What it does

```
OpenDSS .dss ──(PowerModelsDistribution)──► ENGINEERING dict
                                                 │ from_pmd
                                                 ▼
   BMOPF JSON ◄──── write_bmopf ────── BMOPF Dict{String,Any} ──── to_pmd ──► PMD
                                                 │ analyze                │ solve_opf
                                                 ▼                        ▼
                                          SummaryReport        result Dict{String,Any}
                                                 │                        │ profile_solution
                                                 ▼                        ▼
                                              render              SolutionReport ──► render_solution
```

- **Conversion**: `from_pmd` / `to_pmd` translate between PMD's ENGINEERING
  model and the BMOPF data model, handling earth-terminal conventions,
  grounding reactors, transformer impedance bases, and adding an explicit
  slack generator at the source.
- **Validation**: required fields, spec conformance (configuration/arity
  rules, terminal types), referential and dimensional integrity, domain
  plausibility, redundancy.
- **Analysis**: inventory, voltage levels, connectivity/topology, diversity,
  operational loading, infeasibility preflight, data **provenance**
  (sequence-derived impedances, Kron-reduction likelihood, earthing-system
  tagging, OpenDSS default fingerprints, regulator patterns) and
  **benchmark readiness**.
- **Reporting**: every `analyze` run produces a `SummaryReport` with a
  complete catalogue of stable, documented finding codes, rendered to
  terminal or Markdown.
- **Solution profiling**: given a BMOPF network and an OPF result dict,
  `profile_solution` flags bound violations, near-active constraints,
  constraint residuals, and solution-quality issues without access to solver
  internals.

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
```

Profiling an OPF result dict (requires `solve_opf` or any compatible solver):

```julia
using BMOPFTools, JuMP, Ipopt

net    = parse_bmopf("case.json")
result = solve_opf(net; optimizer=Ipopt.Optimizer)

report = profile_solution(net, result)
render_solution(report, "solution.md")

errors(report)    # bound violations and infeasibility findings
warnings(report)  # near-active bounds and residual warnings
```

Converting from OpenDSS (requires PowerModelsDistribution in the environment):

```julia
using BMOPFTools, PowerModelsDistribution

eng = parse_file("Master.dss"; kron_reduce=false)   # keep 4-wire detail
net = from_pmd(eng)                                  # adds slack generator
report = analyze(net)
```

## Environments

The package depends on `Graphs`, `JSON3`, `LinearAlgebra`, `Statistics`,
`Dates`, `Logging`, and `PowerModelsDistribution`. PMD is used by `from_pmd`
/ `to_pmd` for the ENGINEERING-model conversion; it accepts plain dicts so no
PMD types leak into BMOPF data. The test suite skips the OpenDSS integration
test when `OpenDSSDirect` is absent.

```sh
# full test suite (with PMD, from the package root)
julia --project=. -e "using Pkg; Pkg.test()"

# generate analysis reports and simplified variants for all output/ networks
julia --project=. scripts/generate_output.jl
```

## Documentation

Build the documentation locally:

```sh
julia --project=docs -e 'using Pkg; Pkg.develop(path="."); Pkg.instantiate()'
julia --project=docs docs/make.jl
# open docs/build/index.html
```

Pages: data-model conventions, the conversion guide (every deliberate
`from_pmd`/`to_pmd` decision), the analysis/report guide, the **complete
finding-code reference**, and methodology notes with literature references.

`docs/taskforce_feedback.md` collects implementation feedback on the Task
Force draft specification.

## Examples

- `examples/lv1_14bus_walkthrough.jl` — step-by-step tour of every analysis
  on a real 14-bus LV feeder.
