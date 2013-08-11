HyperLogLog.jl
==============

	using HyperLogLog

	counter = HLL(8)

	consume!(counter, 1:100)
	estimate(counter)

	consume!(counter, 101:1000)
	estimate(counter)
