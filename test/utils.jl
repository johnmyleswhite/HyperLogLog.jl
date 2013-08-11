@assert HyperLogLog.isa(HyperLogLog.hash32("abc"), Uint32)

@assert HyperLogLog.rho(0x80000000) == uint32(1)
@assert HyperLogLog.rho(0x40000000) == uint32(2)
@assert HyperLogLog.rho(0x20000000) == uint32(3)
@assert HyperLogLog.rho(0x10000000) == uint32(4)
@assert HyperLogLog.rho(0x08000000) == uint32(5)
@assert HyperLogLog.rho(0x04000000) == uint32(6)
@assert HyperLogLog.rho(0x02000000) == uint32(7)
@assert HyperLogLog.rho(0x01000000) == uint32(8)
@assert HyperLogLog.rho(0x00000000) == uint32(33)

@assert HyperLogLog.alpha(uint32(16)) == 0.673
@assert HyperLogLog.alpha(uint32(32)) == 0.697
@assert HyperLogLog.alpha(uint32(64)) == 0.709
@assert HyperLogLog.alpha(uint32(128)) > 0.709
