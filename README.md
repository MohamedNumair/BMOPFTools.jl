> [!WARNING]  
> This project is currently ongoing rapid development and may have breaking changes made directly to main. Use at your own risk until further notice. An upcoming breaking change is removing the dependence on the OpenDSS parser from PMD, which will be switched to https://github.com/eigenergy/PowerIO.jl


[![Documentation](https://github.com/frederikgeth/BMOPFTools.jl/actions/workflows/documentation.yml/badge.svg)](https://github.com/frederikgeth/BMOPFTools.jl/actions/workflows/documentation.yml)

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
   BMOPF JSON ◄──── write_bmopf ────── BMOPF Dict{String,Any}
                                                 │ analyze
                                                 ▼
                                          SummaryReport ──► render (terminal / Markdown)
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
- **Reporting**: every `analyze` run produces a `SummaryReport` with ~80
  stable, documented finding codes, rendered to terminal or Markdown.

## Quickstart

```julia
using BMOPFTools

# from an existing BMOPF JSON file
net    = parse_bmopf("case.json")
report = analyze(net)
render(report, stdout)              # terminal report
render(report, "case_report.md")    # Markdown report
write_bmopf(net, "case_clean.json")

# programmatic access
errors(report)                       # Vector{Finding} with ERROR severity
report.results[:provenance]["convention"]
```

Converting from OpenDSS (requires PowerModelsDistribution in the
environment):

```julia
using BMOPFTools, PowerModelsDistribution

eng = parse_file("Master.dss"; kron_reduce=false)   # keep 4-wire detail
net = from_pmd(eng)                                  # adds slack generator
report = analyze(net)
```

## Environments

The package itself depends only on `Graphs`, `JSON3`, `LinearAlgebra`,
`Statistics`, `Dates`, `Logging`. PowerModelsDistribution is **not** a
dependency — the converter accepts its plain-dict ENGINEERING model, so run
conversion from an environment that has PMD (e.g. the parent project, with
BMOPFTools `Pkg.develop`ed into it). The test suite skips the OpenDSS
integration test when PMD is absent.

```sh
# full test suite (with PMD, from the parent project root)
julia --project=. BMOPFTools/test/runtests.jl

# batch-convert every test case and generate reports into BMOPFTools/output/
julia --project=. BMOPFTools/examples/generate_reports.jl
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
- `examples/generate_reports.jl` — batch conversion + reporting over all
  test datasets (LV/MV library, combined MV+LV system, ENWL).
