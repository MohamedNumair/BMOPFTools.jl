# validation/schema.jl
#
# Schema-conformance checks implemented natively (no JSONSchema.jl dependency
# for the field-level checks). Full JSON Schema validation can be layered on
# later; the unknown-field catalogue below covers the "undocumented/additional
# fields" requirement directly.

# Known fields per component type: required + optional + structural.
# Pattern-matched fields (matrix keys) are handled by _KNOWN_PATTERNS.
const _KNOWN_FIELDS = Dict{String,Set{String}}(
    "bus" => Set(["terminal_names", "perfectly_grounded_terminals",
                  "v_min", "v_max", "vpn_min", "vpn_max",
                  "vpp_min", "vpp_max", "vsym_min", "vsym_max"]),
    "line" => Set(["length", "linecode", "bus_from", "bus_to",
                   "terminal_map_from", "terminal_map_to"]),
    "voltage_source" => Set(["v_magnitude", "v_angle", "bus", "terminal_map"]),
    "shunt" => Set(["bus", "terminal_map"]),
    "load" => Set(["p_nom", "q_nom", "bus", "configuration", "terminal_map"]),
    "generator" => Set(["p_min", "p_max", "q_min", "q_max", "cost",
                        "bus", "configuration", "terminal_map"]),
    "linecode" => Set(["i_max", "s_max"]),
    "switch" => Set(["bus_from", "bus_to", "terminal_map_from",
                     "terminal_map_to", "open_switch", "i_max"])
)

const _KNOWN_TRANSFORMER_FIELDS = Dict{String,Set{String}}(
    "single_phase" => Set(["s_rating", "r_series_from", "x_series_from",
                           "r_series_to", "x_series_to", "bus_from", "bus_to",
                           "terminal_map_from", "terminal_map_to",
                           "v_ref_from", "v_ref_to"]),
    "center_tap"   => Set(["s_rating", "r_series_from", "x_series_from",
                           "r_series_to", "x_series_to", "bus_from", "bus_to",
                           "terminal_map_from", "terminal_map_to",
                           "v_ref_from", "v_ref_to"]),
    # Per TF spec: wye_delta/delta_wye carry a single wye-side impedance
    "wye_delta"    => Set(["s_rating", "r_series", "x_series", "bus_from",
                           "bus_to", "terminal_map_from", "terminal_map_to",
                           "v_ref_from", "v_ref_to"]),
    "delta_wye"    => Set(["s_rating", "r_series", "x_series", "bus_from",
                           "bus_to", "terminal_map_from", "terminal_map_to",
                           "v_ref_from", "v_ref_to"])
)

# Pattern-matched (matrix) key prefixes per component type, matching the
# schema's patternProperties regexes.
const _KNOWN_PATTERNS = Dict{String,Vector{Regex}}(
    "linecode" => [r"^R_series_\d_\d$", r"^X_series_\d_\d$",
                   r"^G_from_\d_\d$",   r"^G_to_\d_\d$",
                   r"^B_from_\d_\d$",   r"^B_to_\d_\d$"],
    "shunt"    => [r"^G_\d_\d$", r"^B_\d_\d$"]
)

# Keys that are always tolerated and never reported:
# internal bookkeeping, PMD passthrough, and the time-series convention.
const _TOLERATED_KEYS = Set(["_meta", "_pmd", "time_series"])

"""
    schema_check(net, findings) -> Dict{String,Any}

Catalogue fields present in the data that are not defined in the BMOPF
schema. Unknown fields are reported as INFO findings (not errors) so that
PMD-carried extras and schema-evolution candidates are visible without
blocking the pipeline.

Returns per-component-type counts and a field → occurrence-count map of
unknown keys, which directly feeds the "undocumented/additional fields"
section of the dataset assessment.
"""
function schema_check(net::Dict{String,Any},
                      findings::Vector{Finding})::Dict{String,Any}
    result = Dict{String,Any}()
    unknown_by_type = Dict{String,Dict{String,Int}}()

    for (comp_type, known) in _KNOWN_FIELDS
        components = get(net, comp_type, nothing)
        components isa Dict || continue
        patterns = get(_KNOWN_PATTERNS, comp_type, Regex[])
        unknown = Dict{String,Int}()

        for (_, comp) in components
            comp isa Dict || continue
            for k in keys(comp)
                k in known && continue
                (k in _TOLERATED_KEYS || startswith(k, "_")) && continue
                any(p -> match(p, k) !== nothing, patterns) && continue
                unknown[k] = get(unknown, k, 0) + 1
            end
        end

        isempty(unknown) || (unknown_by_type[comp_type] = unknown)
    end

    # transformer subtypes
    xfmr = get(net, "transformer", nothing)
    if xfmr isa Dict
        for (subtype, known) in _KNOWN_TRANSFORMER_FIELDS
            sub = get(xfmr, subtype, nothing)
            sub isa Dict || continue
            unknown = Dict{String,Int}()
            for (_, comp) in sub
                comp isa Dict || continue
                for k in keys(comp)
                    k in known && continue
                    (k in _TOLERATED_KEYS || startswith(k, "_")) && continue
                    unknown[k] = get(unknown, k, 0) + 1
                end
            end
            isempty(unknown) ||
                (unknown_by_type["transformer/$subtype"] = unknown)
        end
    end

    # unknown top-level keys
    known_top = Set(["name", "bus", "line", "linecode", "voltage_source",
                     "load", "generator", "shunt", "switch", "transformer",
                     "time_series", "_meta"])
    unknown_top = [k for k in keys(net) if !(k in known_top) && !startswith(k, "_")]
    isempty(unknown_top) ||
        (unknown_by_type["(top-level)"] = Dict(k => 1 for k in unknown_top))

    for (ctype, unknown) in unknown_by_type
        field_list = join(sort(collect(keys(unknown))), ", ")
        push!(findings, Finding(INFO, "I.SCHEMA.UNKNOWN_FIELDS", :schema,
            Symbol(replace(ctype, "/" => "_", "(" => "", ")" => "", "-" => "_")), nothing,
            "$ctype has field(s) not in the BMOPF schema: $field_list.",
            Dict{String,Any}("fields" => unknown)))
    end

    result["unknown_fields_by_type"] = unknown_by_type
    result["n_component_types_with_unknown"] = length(unknown_by_type)
    result
end
