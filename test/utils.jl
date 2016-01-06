@assert HyperLogLog.isa(HyperLogLog.hash32("abc"), UInt32)

@assert HyperLogLog.rho(0x80000000) == UInt32(1)
@assert HyperLogLog.rho(0x40000000) == UInt32(2)
@assert HyperLogLog.rho(0x20000000) == UInt32(3)
@assert HyperLogLog.rho(0x10000000) == UInt32(4)
@assert HyperLogLog.rho(0x08000000) == UInt32(5)
@assert HyperLogLog.rho(0x04000000) == UInt32(6)
@assert HyperLogLog.rho(0x02000000) == UInt32(7)
@assert HyperLogLog.rho(0x01000000) == UInt32(8)
@assert HyperLogLog.rho(0x00000000) == UInt32(33)

@assert HyperLogLog.alpha(UInt32(16)) == 0.673
@assert HyperLogLog.alpha(UInt32(32)) == 0.697
@assert HyperLogLog.alpha(UInt32(64)) == 0.709
@assert HyperLogLog.alpha(UInt32(128)) > 0.709
