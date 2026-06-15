# io/from_dss.jl
#
# OpenDSS → BMOPF conversion via the `powerio` CLI
# (eigenergy/powerio, `powerio-dist` crate).

# OpenDSS numeric terminal names ["1","2","3","4"] → task-force phase labels.
const _DSS_TERMINAL_MAP = Dict("1" => "a", "2" => "b", "3" => "c", "4" => "n")

"""
    from_dss(path::AbstractString; powerio=nothing, name=nothing) -> Dict{String,Any}

Parse an OpenDSS Master file directly to a BMOPF network dict using the
`powerio` CLI (eigenergy/powerio, `powerio-dist` crate).

This is the recommended path for reading OpenDSS networks: the Rust parser
materialises every OpenDSS class default explicitly, validates fidelity against
the OpenDSS solver, and produces schema-valid BMOPF JSON without going through
PowerModelsDistribution.

OpenDSS numeric terminal names (`"1"`, `"2"`, `"3"`, `"4"`) are remapped to
the task-force convention (`"a"`, `"b"`, `"c"`, `"n"`) and `neutral_terminal`
is set to `"n"` on every affected bus.

# Arguments
- `path`: path to the OpenDSS Master.dss file (or any .dss entry point)
- `powerio`: path to the `powerio` binary. Defaults to `BMOPFTOOLS_POWERIO_PATH`
  env var, then the first `powerio` on `PATH`.
- `name`: optional network name string set on `net["name"]` after parsing.
  Defaults to the relative path of the Master file from the working directory.

# Conversion warnings
`powerio convert` reports every piece of information that cannot be represented
in BMOPF JSON (e.g. shunt admittance, load shape time series, RegControl OLTC
taps). These are surfaced as `INFO` findings on `_meta["powerio_warnings"]` in
the returned dict, so callers can inspect them without losing the converted data.

# Errors
- `ArgumentError` if `powerio` binary cannot be found.
- `ErrorException` if the binary exits non-zero (parse failure or schema error).

# Example
```julia
net = from_dss("test/data/ENWL/network_1/Feeder_1/Master.dss")
report = analyze(net)
render(report, stdout)
```
"""
function from_dss(path::AbstractString;
                  powerio::Union{AbstractString,Nothing}=nothing,
                  name::Union{AbstractString,Nothing}=nothing)::Dict{String,Any}

    binary = _find_powerio(powerio)
    abspath_dss = abspath(path)
    isfile(abspath_dss) || throw(ArgumentError("DSS file not found: $abspath_dss"))

    # powerio writes warnings to stderr, BMOPF JSON to stdout
    cmd = `$binary convert $abspath_dss --to bmopf-json`
    stdout_buf = IOBuffer()
    stderr_buf = IOBuffer()

    proc = run(pipeline(cmd; stdout=stdout_buf, stderr=stderr_buf); wait=true)

    warnings_raw = String(take!(stderr_buf))
    json_raw     = String(take!(stdout_buf))

    if !success(proc)
        err_snippet = first(warnings_raw, 500)
        throw(ErrorException("powerio exited with non-zero status for $path:\n$err_snippet"))
    end

    if isempty(json_raw)
        throw(ErrorException(
            "powerio produced no output for $path " *
            "(stderr: $(first(warnings_raw, 200)))"))
    end

    net = parse_bmopf(json_raw; from_string=true)
    _remap_opendss_terminals!(net)

    # Store conversion warnings so callers can inspect fidelity losses
    warnings_list = filter!(!isempty, split(strip(warnings_raw), '\n'))
    net["_meta"] = get(net, "_meta", Dict{String,Any}())
    net["_meta"]["powerio_warnings"] = warnings_list
    net["_meta"]["powerio_source"]   = abspath_dss

    if !isnothing(name)
        net["name"] = name
    elseif !haskey(net, "name") || isempty(get(net, "name", ""))
        net["name"] = relpath(abspath_dss)
    end

    net
end

"""
    powerio_version(; powerio=nothing) -> String

Return the version string of the `powerio` binary, e.g. `"powerio 0.3.0"`.
Useful for pinning test expectations and bug reports.
"""
function powerio_version(; powerio::Union{AbstractString,Nothing}=nothing)::String
    binary = _find_powerio(powerio)
    strip(read(`$binary --version`, String))
end

# ---------------------------------------------------------------------------
# Internal helpers
# ---------------------------------------------------------------------------

function _find_powerio(hint::Union{AbstractString,Nothing})::String
    candidates = filter(!isnothing, [
        hint,
        get(ENV, "BMOPFTOOLS_POWERIO_PATH", nothing),
        Sys.which("powerio"),
    ])
    isempty(candidates) && throw(ArgumentError(
        "powerio binary not found. Install it from https://github.com/eigenergy/powerio " *
        "and ensure it is on PATH, or set BMOPFTOOLS_POWERIO_PATH to its location."))
    first(candidates)
end

"""
    _remap_opendss_terminals!(net)

Remap OpenDSS numeric terminal names ["1","2","3","4"] to the task-force
phase labels ["a","b","c","n"] throughout a BMOPF network dict. Sets
`neutral_terminal => "n"` on every affected bus. All component `terminal_map`
and `terminal_map_from`/`terminal_map_to` references are updated consistently.

Buses with other naming conventions are left unchanged.
"""
function _remap_opendss_terminals!(net::Dict{String,Any})
    rename_maps = Dict{String,Dict{String,String}}()

    for (bus_id, bus) in get(net, "bus", Dict())
        bus isa Dict || continue
        names = get(bus, "terminal_names", nothing)
        names isa Vector || continue
        str_names = string.(names)
        sort(str_names) == ["1", "2", "3", "4"] || continue
        bus["terminal_names"] = [get(_DSS_TERMINAL_MAP, n, n) for n in str_names]
        bus["neutral_terminal"] = "n"
        rename_maps[bus_id] = _DSS_TERMINAL_MAP
    end

    isempty(rename_maps) && return

    _remap_terminal_maps!(net, rename_maps)
end

function _remap_terminal_maps!(net::Dict{String,Any},
                               rename_maps::Dict{String,Dict{String,String}})
    # Single-bus components: load, generator, voltage_source, shunt
    for comp_type in ("load", "generator", "voltage_source", "shunt")
        for (_, comp) in get(net, comp_type, Dict())
            comp isa Dict || continue
            rmap = get(rename_maps, get(comp, "bus", ""), nothing)
            rmap === nothing && continue
            tmap = get(comp, "terminal_map", nothing)
            tmap isa Vector &&
                (comp["terminal_map"] = [get(rmap, string(t), string(t)) for t in tmap])
        end
    end

    # Two-bus components: line, switch
    for comp_type in ("line", "switch")
        for (_, comp) in get(net, comp_type, Dict())
            comp isa Dict || continue
            for (tmap_key, bus_key) in (("terminal_map_from", "bus_from"),
                                        ("terminal_map_to",   "bus_to"))
                rmap = get(rename_maps, get(comp, bus_key, ""), nothing)
                rmap === nothing && continue
                tmap = get(comp, tmap_key, nothing)
                tmap isa Vector &&
                    (comp[tmap_key] = [get(rmap, string(t), string(t)) for t in tmap])
            end
        end
    end

    # Transformers — nested by subtype
    xfmr = get(net, "transformer", nothing)
    xfmr isa Dict || return
    for (_, subdict) in xfmr
        subdict isa Dict || continue
        for (_, comp) in subdict
            comp isa Dict || continue
            for (tmap_key, bus_key) in (("terminal_map_from", "bus_from"),
                                        ("terminal_map_to",   "bus_to"))
                rmap = get(rename_maps, get(comp, bus_key, ""), nothing)
                rmap === nothing && continue
                tmap = get(comp, tmap_key, nothing)
                tmap isa Vector &&
                    (comp[tmap_key] = [get(rmap, string(t), string(t)) for t in tmap])
            end
        end
    end
end
