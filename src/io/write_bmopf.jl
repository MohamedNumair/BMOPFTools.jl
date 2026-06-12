"""
    write_bmopf(net::Dict{String,Any}, dest)

Serialise a BMOPF network dict to JSON.

- `dest::IO`             — writes to the IO stream
- `dest::AbstractString` — writes to a file at that path
"""
function write_bmopf(net::Dict{String,Any}, io::IO)
    JSON3.write(io, net)
end

function write_bmopf(net::Dict{String,Any}, path::AbstractString)
    open(path, "w") do io
        write_bmopf(net, io)
    end
end
