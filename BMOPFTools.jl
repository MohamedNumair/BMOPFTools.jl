"""
    BMOPFTools

A Julia library for parsing, validating, analysing, and reporting on
BMOPF-format distribution network datasets.

The network data model is a plain `Dict{String,Any}` that mirrors the
BMOPF JSON schema exactly. No custom wrapper types are used for network
data, so data flows naturally to and from PowerModelsDistribution and
JSON without conversion.

# Public API

    net    = parse_bmopf(path)          # load from BMOPF JSON file
    net    = from_pmd(eng)              # convert PMD ENGINEERING dict
    report = analyze(net)               # run all analyses
    render(report, stdout)              # terminal output
    render(report, "report.md")         # markdown file

See also: `write_bmopf`, `to_pmd`, `check_roundtrip` (requires OpenDSSDirect ext).
"""
module BMOPFTools

using Dates
using Logging
using Statistics
using Graphs
using JSON3

# ---------------------------------------------------------------------------
# Finding — the one struct in the library.
# Everything network-related stays as Dict{String,Any}; findings are outputs
# that need stable structure for rendering and programmatic use.
# ---------------------------------------------------------------------------

"""
    Severity

Severity level for a [`Finding`](@ref).

- `ERROR`   — will directly compromise OPF correctness or prevent execution
- `WARNING` — degrades result quality or indicates suspicious data
- `INFO`    — informational; worth knowing but not actionable
"""
@enum Severity ERROR WARNING INFO

"""
    Finding

A single diagnostic finding produced by any analysis or validation pass.

# Fields
- `severity`       — `ERROR`, `WARNING`, or `INFO`
- `code`           — stable dot-separated identifier, e.g. `"E.VOLT.MINMAX"`.
                     Use these for programmatic filtering; do not match on `message`.
- `section`        — which report section produced this, e.g. `:voltage_levels`
- `component_type` — `:bus`, `:line`, `:load`, `:transformer`, `:network`, etc.
- `component_id`   — the dict key of the affected component, or `nothing` for
                     network-level findings
- `message`        — human-readable description
- `detail`         — optional machine-readable metadata (actual vs expected
                     values, timestamps, etc.) for renderer and downstream use
"""
struct Finding
    severity::Severity
    code::String
    section::Symbol
    component_type::Symbol
    component_id::Union{String,Nothing}
    message::String
    detail::Union{Dict{String,Any},Nothing}
end

# Convenience constructors — detail is optional
Finding(sev, code, section, ctype, cid, msg) =
    Finding(sev, code, section, ctype, cid, msg, nothing)

"""
    SummaryReport

Assembled output of [`analyze`](@ref). Holds all section result dicts and
the complete finding log. Passed to [`render`](@ref) for output.

`results` maps section name → analysis output dict. Renderers walk this
structure; the keys are stable across versions.
"""
struct SummaryReport
    network_name::Union{String,Nothing}
    generated_at::DateTime
    results::Dict{Symbol,Dict{String,Any}}
    findings::Vector{Finding}
end

# ---------------------------------------------------------------------------
# Accessors on Finding collections
# ---------------------------------------------------------------------------

errors(fs::Vector{Finding})   = filter(f -> f.severity == ERROR,   fs)
warnings(fs::Vector{Finding}) = filter(f -> f.severity == WARNING, fs)
infos(fs::Vector{Finding})    = filter(f -> f.severity == INFO,    fs)

errors(r::SummaryReport)   = errors(r.findings)
warnings(r::SummaryReport) = warnings(r.findings)
infos(r::SummaryReport)    = infos(r.findings)

# ---------------------------------------------------------------------------
# Submodule includes — order matters; IO first, then analysis, then report
# ---------------------------------------------------------------------------

include("io/parse_bmopf.jl")
include("io/write_bmopf.jl")
include("io/from_pmd.jl")
include("io/to_pmd.jl")

include("analysis/inventory.jl")
include("analysis/voltage_levels.jl")
include("analysis/connectivity.jl")
include("analysis/diversity.jl")
include("analysis/operational.jl")
include("analysis/preflight.jl")

include("validation/schema.jl")
include("validation/completeness.jl")
include("validation/domain_rules.jl")
include("validation/redundancy.jl")
include("validation/roundtrip.jl")

include("report/formatting.jl")
include("report/render_terminal.jl")
include("report/render_markdown.jl")

include("infeasibility/infeasibility.jl")

# ---------------------------------------------------------------------------
# Top-level entry points
# ---------------------------------------------------------------------------

"""
    analyze(net::Dict{String,Any}; t_index::Int=1) -> SummaryReport

Run all analysis and validation passes on a BMOPF network dict and return
a [`SummaryReport`](@ref).

For snapshot networks, `t_index` is ignored. For networks with a
`"time_series"` key, the snapshot at `t_index` is materialised first.
"""
function analyze(net::Dict{String,Any}; t_index::Int=1)
    working = is_timeseries(net) ? get_snapshot(net, t_index) : net
    findings = Finding[]
    results  = Dict{Symbol,Dict{String,Any}}()

    # Analysis passes — each appends to findings and returns a results dict
    results[:inventory]      = inventory_analysis(working, findings)
    results[:voltage_levels] = voltage_level_analysis(working, findings)
    results[:connectivity]   = connectivity_analysis(working, findings)
    results[:diversity]      = diversity_analysis(working, findings)
    results[:operational]    = operational_analysis(working, findings)
    results[:preflight]      = infeasibility_preflight(working, findings)

    # Validation passes
    results[:schema]         = schema_check(working, findings)
    results[:completeness]   = completeness_check(working, findings)
    results[:domain_rules]   = domain_rules_check(working, findings)
    results[:redundancy]     = redundancy_check(working, findings)

    SummaryReport(
        get(net, "name", nothing),
        now(),
        results,
        findings
    )
end

"""
    analyze(path::AbstractString; kwargs...) -> SummaryReport

Parse a BMOPF JSON file and run [`analyze`](@ref).
"""
analyze(path::AbstractString; kwargs...) = analyze(parse_bmopf(path); kwargs...)

"""
    render(report::SummaryReport, dest; kwargs...)

Render a [`SummaryReport`](@ref) to `dest`.

- `dest::IO`            — writes terminal-formatted text (ANSI colour if tty)
- `dest::AbstractString` — writes to file; format inferred from extension
  (`.md` → Markdown, anything else → plain text)

# Keyword arguments
- `color::Bool` — force-enable/disable ANSI colour for IO dest (default: auto)
- `verbose::Bool` — include INFO-level findings (default: `true`)
"""
function render(report::SummaryReport, dest::IO; color::Bool=get(dest, :color, false), verbose::Bool=true)
    render_terminal(report, dest; color=color, verbose=verbose)
end

function render(report::SummaryReport, path::AbstractString; verbose::Bool=true)
    if endswith(path, ".md")
        open(path, "w") do io
            render_markdown(report, io; verbose=verbose)
        end
    else
        open(path, "w") do io
            render_terminal(report, io; color=false, verbose=verbose)
        end
    end
end

# ---------------------------------------------------------------------------
# Exports
# ---------------------------------------------------------------------------

export Severity, ERROR, WARNING, INFO
export Finding, SummaryReport
export errors, warnings, infos
export parse_bmopf, write_bmopf
export from_pmd, to_pmd
export analyze, render
export is_timeseries, get_snapshot      # useful for interactive use

end # module BMOPFTools
