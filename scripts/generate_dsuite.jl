"""
    generate_dsuite.jl

Convert the six D-Suite UK LV distribution network models from OpenDSS to
BMOPF JSON and write them to output/DSuite/.

Source data: test/data/dsuite_networks_scaled_v1.1/<network>/master_scaled.dss
Attribution: M. Deakin, 'Six UK-based Low Voltage Distribution Network Models',
             2025, DOI: 10.25405/data.ncl.27175317, CC BY 4.0.

After running this script, run generate_output.jl to produce analysis reports,
ASCII trees, and simplified variants.

Usage:
    julia --project scripts/generate_dsuite.jl
"""

using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))

using BMOPFTools
using PowerModelsDistribution

const DSS_ROOT  = joinpath(@__DIR__, "..", "test", "data", "dsuite_networks_scaled_v1.1")
const OUT_DIR   = joinpath(@__DIR__, "..", "output", "DSuite")

# Human-readable names for the six networks
const NETWORK_NAMES = Dict(
    "spd_r" => "DSuite_SPD_Rural",
    "spd_s" => "DSuite_SPD_Suburban",
    "spd_u" => "DSuite_SPD_Urban",
    "spm_r" => "DSuite_SPM_Rural",
    "spm_s" => "DSuite_SPM_Suburban",
    "spm_u" => "DSuite_SPM_Urban",
)

mkpath(OUT_DIR)

networks = sort(collect(keys(NETWORK_NAMES)))

println("Converting $(length(networks)) D-Suite networks to BMOPF JSON...\n")

let ok = 0, failed = 0
    for key in networks
        name     = NETWORK_NAMES[key]
        dss_path = joinpath(DSS_ROOT, key, "master_scaled.dss")
        out_path = joinpath(OUT_DIR, name * ".json")

        print("  $key ($name) … ")
        try
            eng = PowerModelsDistribution.parse_file(dss_path; kron_reduce=false)
            net = from_pmd(eng)
            net["name"] = name
            net["meta"] = Dict{String,Any}(
                "source"    => "D-Suite Alpha v1.1",
                "reference" => "M. Deakin, DOI: 10.25405/data.ncl.27175317",
                "license"   => "CC-BY-4.0",
            )
            write_bmopf(net, out_path)

            n_buses = length(get(net, "bus",  Dict()))
            n_lines = length(get(net, "line", Dict()))
            n_loads = length(get(net, "load", Dict()))
            println("✓  buses=$n_buses  lines=$n_lines  loads=$n_loads")
            ok += 1
        catch e
            println("✗")
            @error "Failed to convert $key" exception=(e, catch_backtrace())
            failed += 1
        end
    end

    println("\nDone: $ok converted, $failed failed.")
    println("JSON files written to $OUT_DIR")
    println("Run `julia --project scripts/generate_output.jl` to produce reports.")
end
