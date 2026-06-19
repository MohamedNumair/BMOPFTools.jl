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
    v = _detect_spec_version(net)

    # Nothing to do: current spec or unrecognised (let validation report it).
    (v == _CURRENT_SPEC || v == :unknown) && return net

    # Migration chain — extend when new spec versions are added.
    # (currently empty: only one spec version exists)

    return net
end
