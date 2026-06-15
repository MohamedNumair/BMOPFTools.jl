# test/write_bmopf_tests.jl
#
# Syntactic validity tests for write_bmopf:
#   - output is parseable JSON (bytes → JSON3.read succeeds)
#   - default output is pretty-printed (multi-line, indented)
#   - indent=nothing produces compact output
#   - _meta is never serialised
#   - no NaN or Inf values in output (JSON does not support these)
#   - round-trip preserves all top-level keys

using JSON3

# Walk any nested structure and return true iff all Float64 values are finite.
function _all_finite(v)
    v isa Float64        && return isfinite(v)
    v isa AbstractDict   && return all(_all_finite(val) for val in values(v))
    v isa AbstractVector && return all(_all_finite(x)   for x in v)
    true
end

@testset "IO — write_bmopf JSON validity" begin
    net = parse_bmopf(IEEE13_FIXTURE; from_string=true)

    @testset "file output is parseable JSON" begin
        path = tempname() * ".json"
        try
            write_bmopf(net, path)
            @test isfile(path)
            raw    = read(path, String)
            parsed = JSON3.read(raw)
            @test !isnothing(parsed)
            @test haskey(parsed, "name")
            @test haskey(parsed, "bus")
            @test haskey(parsed, "meta")
        finally
            isfile(path) && rm(path)
        end
    end

    @testset "IOBuffer output is parseable JSON" begin
        buf = IOBuffer()
        write_bmopf(net, buf)
        raw    = String(take!(buf))
        parsed = JSON3.read(raw)
        @test haskey(parsed, "bus")
        @test length(parsed["bus"]) == 7
        @test haskey(parsed, "line")
        @test length(parsed["line"]) == 4
    end

    @testset "default output is multi-line" begin
        buf = IOBuffer()
        write_bmopf(net, buf)
        raw = String(take!(buf))
        # JSON3.pretty with default 4-space indent produces many newlines.
        @test count('\n', raw) > 20
        lines = split(raw, '\n')
        # At least some lines start with whitespace (indented keys/values).
        @test any(l -> startswith(l, "    "), lines)
    end

    @testset "indent=nothing produces compact single-line output" begin
        buf = IOBuffer()
        write_bmopf(net, buf; indent=nothing)
        raw = String(take!(buf))
        # JSON3 compact mode writes no internal newlines.
        @test count('\n', raw) == 0
    end

    @testset "_meta is never serialised" begin
        net2 = deepcopy(net)
        net2["_meta"] = Dict{String,Any}("tool_private" => "yes")
        buf = IOBuffer()
        write_bmopf(net2, buf)
        raw = String(take!(buf))
        @test !occursin("\"_meta\"",      raw)
        @test !occursin("tool_private",   raw)
    end

    @testset "all top-level keys are present after round-trip" begin
        buf = IOBuffer()
        write_bmopf(net, buf)
        raw  = String(take!(buf))
        net2 = parse_bmopf(raw; from_string=true)
        for k in keys(net)
            k == "_meta" && continue   # tool-private, intentionally dropped
            @test haskey(net2, k)
        end
    end

    @testset "no NaN or Inf in output" begin
        # JSON3 throws if a NaN/Inf reaches the serialiser; a successful
        # write_bmopf call therefore proves the dict was finite. We also
        # verify the parsed-back tree contains only finite floats.
        buf = IOBuffer()
        @test_nowarn write_bmopf(net, buf)
        raw    = String(take!(buf))
        parsed = JSON3.read(raw, Dict{String,Any})
        @test _all_finite(parsed)
        # Belt-and-suspenders: the literal tokens must not appear.
        @test !occursin("NaN",      raw)
        @test !occursin("Infinity", raw)
    end

    @testset "meta block always present and well-formed" begin
        buf = IOBuffer()
        write_bmopf(net, buf)
        raw    = String(take!(buf))
        parsed = JSON3.read(raw)
        meta   = parsed["meta"]
        @test haskey(meta, "\$schema")
        @test haskey(meta, "generator")
        @test haskey(meta, "created")
        @test meta["generator"]["tool"] == "BMOPFTools.jl"
    end
end
