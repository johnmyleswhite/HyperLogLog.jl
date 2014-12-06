HyperLogLog.jl
==============

# NOTICE

**This package is unmaintained. Its reliability is not guaranteed.**

# Introduction

A simple HyperLogLog implementation in Julia

# Usage Examples

In this example, we'll create a HyperLogLog counter with quality value 8:

	using HyperLogLog

	counter = HLL(8)

	consume!(counter, 1:100)
	estimate(counter)

	consume!(counter, 101:1000)
	estimate(counter)

Note that the quality value must be an integer between 4 and 16. When selecting a value, keep in mind that the memory costs for using value `b` scales like `2^b`.

In this example, we'll use a custom hash function:

	using HyperLogLog

	counter = HLL(8, x -> uint32(hash(x)))

	consume!(counter, 1:100)
	estimate(counter)

	consume!(counter, 101:1000)
	estimate(counter)

Note that the hash function must return a `Uint32`. This is done to be consistent with the theory presented in the original HyperLogLog paper. We may allow 64-bit hashes in the future.
