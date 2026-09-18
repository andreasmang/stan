# sample_average.jl
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 1 helper: the average of a sequence of random numbers.
#
# Draw n = 1000 numbers from Uniform(0, 1) and compute their average three ways:
# by hand with a loop, as sum(x)/n, and with mean. All three agree up to
# rounding error. Needs no packages (Statistics comes with Julia).
#
# Run:  include("sample_average.jl")   (at the Julia REPL, from this folder)

using Random, Statistics, Printf

Random.seed!(0)                  # reproducibility (remove for a fresh draw)

n = 1000
x = rand(n)                      # n numbers from Uniform(0, 1), whose mean is 1/2

# 1. by hand: add the numbers up one at a time, then divide by how many there are
total = 0.0
for i in 1:n                     # i = 1, 2, ..., n: Julia counts from 1
    global total = total + x[i]  # `global` is needed at the top level of a script
end
avg_loop = total / n

# 2. add them up with sum, then divide
avg_sum = sum(x) / n

# 3. let Julia do both steps (mean is in the Statistics package)
avg_mean = mean(x)

@printf("by hand, with a loop: %.15f\n", avg_loop)
@printf("sum(x) / n:           %.15f\n", avg_sum)
@printf("mean(x):              %.15f\n", avg_mean)
# sum adds the numbers in a different order than the loop, so the last digit or
# two can differ: a computer rounds every sum to about 16 significant digits
@printf("loop minus mean:      %.1e\n", avg_loop - avg_mean)
println()
@printf("average of the first 10 numbers, mean(x[1:10]): %.4f\n", mean(x[1:10]))

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
