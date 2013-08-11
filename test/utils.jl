@assert isa(h("abc"), Uint32)

@assert rho(0x80000000) == 1
@assert rho(0x40000000) == 2
@assert rho(0x20000000) == 3
@assert rho(0x10000000) == 4
@assert rho(0x08000000) == 5
@assert rho(0x04000000) == 6
@assert rho(0x02000000) == 7
@assert rho(0x01000000) == 8
@assert rho(0x00000000) == 33

@assert alpha(uint32(16)) == 0.673
@assert alpha(uint32(32)) == 0.697
@assert alpha(uint32(64)) == 0.709
@assert alpha(uint32(128)) > 0.709
