using Documenter
using BMOPFTools

makedocs(
    sitename = "BMOPFTools.jl",
    modules  = [BMOPFTools],
    format   = Documenter.HTML(
        prettyurls = false,          # browsable straight from the filesystem
        edit_link  = nothing,        # subdirectory of a larger repo
        size_threshold_ignore = ["findings.md"],
    ),
    remotes  = nothing,
    pages = [
        "Home"                    => "index.md",
        "Data model conventions"  => "conventions.md",
        "Conversion guide"        => "conversion.md",
        "Analysis & reports"      => "analysis.md",
        "Finding-code reference"  => "findings.md",
        "Methodology notes"       => "methodology.md",
        "API reference"           => "api.md",
    ],
    checkdocs = :exports,
    warnonly  = [:missing_docs],
)
