h(d::Any) = uint32(hash(d))

rho(s::Uint32) = uint32(leading_zeros(s)) + uint32(1)

function alpha(m::Uint32)
	if count_ones(m) != 1
		throw(ArgumentError("m must be a power of 2"))
	end

	if m == uint32(16)
		return 0.673
	elseif m == uint32(32)
		return 0.697
	elseif m == uint32(64)
		return 0.709
	elseif m >= uint32(128)
		return 0.7213 / (1 + 1.079 / m)
	end
end
