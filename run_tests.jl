using HyperLogLog

@printf "Running tests\n"

for file in ["test/utils.jl", "test/HyperLogLog.jl"]
	@printf " * %s\n" file
	include(file)
end
