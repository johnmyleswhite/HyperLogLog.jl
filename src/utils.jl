
function num2byte(x::Union{Float16, Float32, Float64, Signed, Unsigned})
    iob = IOBuffer()
    write(iob, x)
    seekstart(iob)
    return readbytes(iob)
end

hash32(x::Number) = Murmur3.x86.hash32(num2byte(x))
hash32(x::Union{AbstractString,Vector{UInt8}}) = Murmur3.x86.hash32(x)

rho(s::UInt32) = UInt32(UInt32(leading_zeros(s)) + UInt32(1))

function alpha(m::UInt32)
    if m == UInt32(16)
        return 0.673
    elseif m == UInt32(32)
        return 0.697
    elseif m == UInt32(64)
        return 0.709
    else # if m >= uint32(128)
        return 0.7213 / (1 + 1.079 / m)
    end
end
