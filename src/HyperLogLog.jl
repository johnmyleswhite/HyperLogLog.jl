module HyperLogLog
	include("utils.jl")

	export HLL, consume!, estimate

	type HLL
		m::Uint32
		M::Vector{Uint32}
		mask::Uint32
		altmask::Uint32
		# TODO: Include h here?
	end

	function HLL(b::Integer)
		if !(4 <= b <= 16)
			throw(ArgumentError("b must be an integer between 4 and 16"))
		end

		m = uint32(1) << b

		M = zeros(Uint32, m)

		mask = 0x00000000
		for i in 1:(b - 1)
			mask |= 0x00000001
			mask <<= 1
		end
		mask |= 0x00000001

		altmask = ~mask

		return HLL(m, M, mask, altmask)
	end

	function consume!(counter::HLL, stream::Any)
		for v in stream
			x = h(v)
			j = 1 + (x & counter.mask)
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

		if E <= 5 / 2 * counter.m
			V = 0
			for j in 1:counter.m
				V += int(counter.M[j] == 0x00000000)
			end
			if V != 0
				E_star = counter.m * log(counter.m / V)
			else
				E_star = E
			end
		elseif E <= 1 / 30 * 2^32
			E_star = E
		else
			E_star = -2^32 * log(1 - E / (2^32))
		end

		return E_star
	end
end
