using Documenter
using BMOPFTools

makedocs(
    sitename = "BMOPFTools.jl",
    modules  = [BMOPFTools],
    format   = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true",  # pretty URLs on CI, plain files locally
        edit_link  = nothing,
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
        "Optimal power flow"      => "opf.md",
        "OPF result dictionary"   => "results.md",
        "Case augmentation"       => "augmentation.md",
        "API reference"           => "api.md",
    ],
    checkdocs = :exports,
    warnonly  = [:missing_docs],
)

deploydocs(
    repo = "github.com/frederikgeth/BMOPFTools.jl.git",
    devbranch = "main",
    dirname = "docs",   # Pages serves gh-pages:/docs; changing that needs repo admin
    push_preview = false,
)
