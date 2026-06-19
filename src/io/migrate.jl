# io/migrate.jl
#
# Spec-version detection and forward migration for BMOPF network dicts.
#
# Usage: called automatically by parse_bmopf (via _postprocess) so that all
# downstream code — analysis, OPF, augmentation — only ever sees a current-spec
# dict. Callers can also invoke `migrate` directly on an already-parsed dict.
#
# Adding a new spec version:
#   1. Bundle the new schema under src/validation/schemas/<tag>.json.
#   2. Add a new entry to _SPEC_VERSIONS mapping the canonical $schema URI to a
#      version tag symbol.
#   3. Write a _migrate_<old>_to_<new>(net) -> net function below.
#   4. Add the migration step to the chain in `migrate`.

# Map canonical $schema URIs (as written into meta.$schema by write_bmopf) to
# internal version tag symbols. Entries should be added in chronological order.
const _SPEC_VERSIONS = Dict{String,Symbol}(
    "https://raw.githubusercontent.com/frederikgeth/bmopf-report/main/schema/bmopf.json" => :draft,
)

# The tag for the spec version this build of BMOPFTools targets.
const _CURRENT_SPEC = :draft

"""
    _detect_spec_version(net::Dict{String,Any}) -> Symbol

Infer the BMOPF spec version from `meta.\$schema`. Returns the corresponding
version tag if the URI is recognised, or `:unknown` otherwise.
"""
function _detect_spec_version(net::Dict{String,Any})::Symbol
    uri = get(get(net, "meta", Dict()), "\$schema", nothing)
    uri isa String || return :unknown
    get(_SPEC_VERSIONS, uri, :unknown)
end

"""
    migrate(net::Dict{String,Any}) -> Dict{String,Any}

Forward-migrate a BMOPF network dict to the current spec version.

If the dict already targets the current spec (or has no recognisable `\$schema`
URI) it is returned unchanged. Otherwise each intermediate migration step is
applied in sequence and a `W.MIGRATE.UPGRADED` finding is appended to
`net["_meta"]["migration_notes"]` so the transformation is auditable.

Called automatically by [`parse_bmopf`](@ref); can also be called directly on
an already-parsed dict.
"""
function migrate(net::Dict{String,Any})::Dict{String,Any}
    # Field-level migrations run unconditionally (independent of spec version).
    _migrate_transformer_series_fields!(net)

    v = _detect_spec_version(net)

    # Nothing to do: current spec or unrecognised (let validation report it).
    (v == _CURRENT_SPEC || v == :unknown) && return net

    # Migration chain — extend when new spec versions are added.
    # (currently empty: only one spec version exists)

    return net
end

"""
    _migrate_transformer_series_fields!(net::Dict{String,Any}) -> nothing

In-place migration applied at parse time (independent of spec version) to
normalise legacy wye_delta/delta_wye transformers that carry the old lumped
`r_series`/`x_series` fields.  Migrates them to `r_series_from`/`x_series_from`
with `r_series_to = x_series_to = 0.0`, matching the per-winding T convention.

This runs unconditionally so that hand-written JSON files that pre-date the
per-winding field names continue to load correctly.
"""
function _migrate_transformer_series_fields!(net::Dict{String,Any})
    xfmrs = get(net, "transformer", nothing)
    xfmrs isa Dict || return
    for (id, xfmr) in xfmrs
        xfmr isa Dict || continue
        subtype = get(xfmr, "subtype", nothing)
        subtype in ("wye_delta", "delta_wye") || continue

        has_legacy_r = haskey(xfmr, "r_series")
        has_legacy_x = haskey(xfmr, "x_series")
        has_new_r    = haskey(xfmr, "r_series_from")
        has_new_x    = haskey(xfmr, "x_series_from")

        # Only migrate if legacy fields present and per-winding fields absent.
        if (has_legacy_r || has_legacy_x) && !has_new_r && !has_new_x
            if has_legacy_r
                xfmr["r_series_from"] = Float64(xfmr["r_series"])
                xfmr["r_series_to"]   = 0.0
                delete!(xfmr, "r_series")
            end
            if has_legacy_x
                xfmr["x_series_from"] = Float64(xfmr["x_series"])
                xfmr["x_series_to"]   = 0.0
                delete!(xfmr, "x_series")
            end
            meta = get!(net, "_meta", Dict{String,Any}())
            notes = get!(meta, "migration_notes", Any[])
            push!(notes, Dict(
                "code"      => "W.MIGRATE.XFMR_SERIES_FIELDS",
                "id"        => id,
                "subtype"   => subtype,
                "message"   => "Migrated legacy r_series/x_series to per-winding r/x_series_from/to (r/x_series_to=0).",
            ))
        end
    end
end
