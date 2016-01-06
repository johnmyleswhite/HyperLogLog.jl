module HyperLogLog

using Murmur3

include("utils.jl")

export HLL, consume!, estimate

type HLL
    m::UInt32
    M::Vector{UInt32}
    mask::UInt32
    altmask::UInt32
    # h() must be a function of the form: Any -> UInt32
    h::Function
end

function HLL(b::Integer, h::Function = hash32)
    if !(4 <= b <= 16)
        throw(ArgumentError("b must be an integer between 4 and 16"))
    end
    
    m = UInt32(1) << b
    
    M = zeros(UInt32, m)

    mask = 0x00000000
    for i in 1:(b - 1)
        mask |= 0x00000001
        mask <<= 1
    end
    mask |= 0x00000001
    
    altmask = ~mask
    
    return HLL(m, M, mask, altmask, h)
end

function Base.show(io::IO, counter::HLL)
    @printf io "A HyperLogLog counter w/ %d registers" Int(counter.m)
    return
end

# Stream must be iterable
function consume!(counter::HLL, stream::Any)
    for v in stream
        x = counter.h(v)
        j = UInt32(UInt32(1) + (x & counter.mask))
        w = x & counter.altmask
        counter.M[j] = max(counter.M[j], rho(w))
    end
    return
end

function estimate(counter::HLL)
    S = 0.0
    
    for j in 1:counter.m
        S += 1 / (2^counter.M[j])
    end
    
    Z = 1 / S
    
    E = alpha(counter.m) * counter.m^2 * Z
    
    if E <= 5//2 * counter.m
        V = 0
        for j in 1:counter.m
            V += Int(counter.M[j] == 0x00000000)
        end
        if V != 0
            E_star = counter.m * log(counter.m / V)
        else
            E_star = E
        end
    elseif E <= 1//30 * 2^32
        E_star = E
    else
        E_star = -2^32 * log(1 - E / (2^32))
    end

    return E_star
end

# TODO: Figure out details here
# function confint(counter::HLL)
# 	e = estimate(counter)
# 	delta = e * 1.04 / sqrt(counter.m)
# 	return e - delta, e + delta
# end
end
