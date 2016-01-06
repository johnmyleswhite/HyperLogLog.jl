using HyperLogLog

b_values = [4, 8, 12, 16]
n_b = length(b_values)
n_points = 2_500

bs = Array(Int, n_b * n_points)
is = Array(Int, n_b * n_points)
counts = Array(Float64, n_b * n_points)

index = 0
for b in b_values
	counter = HLL(b)
	for i in 1:n_points
		index += 1
		consume!(counter, [i])
		bs[index] = b
		is[index] = i
		current_estimate = estimate(counter)
		counts[index] = current_estimate
	end
end

@assert cor(counts, repeat(collect(1:n_points), outer = [n_b])) > 0.98

# abs_errors = counts - is
# rel_errors = (counts - is) ./ is

# using Vega
# plot(x = is, y = abs_errors, group = bs, kind = :line)
# plot(x = is, y = rel_errors, group = bs, kind = :line)
