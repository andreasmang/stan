# variance_two_ways.jl
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 4 helper: two variances that differ only in what they divide by.
#
# For one sample of size n = 5 from Uniform(0, 1), compute
#   divide by n:      (1/n)     * sum (x_i - mean)^2  =  mean(x^2) - mean(x)^2
#   divide by n - 1:  (1/(n-1)) * sum (x_i - mean)^2
# by hand and with the built-in var from Statistics. The two differ by the
# factor (n - 1)/n, which matters for small n. Careful: var(x) divides by n - 1;
# var(x; corrected = false) divides by n.
#
# Run:  include("variance_two_ways.jl")   (at the Julia REPL, from this folder)

using Random, Statistics, Printf

Random.seed!(0)                        # reproducibility (remove for a fresh draw)

n = 5
x = rand(n)                            # one sample of size n from Uniform(0, 1)
xbar = mean(x)

by_n_hand  = sum((x .- xbar).^2) / n         # divide by n
by_n_short = mean(x.^2) - xbar^2             # the same number, written another way
by_n1_hand = sum((x .- xbar).^2) / (n - 1)   # divide by n - 1

println("sample: ", round.(x; digits = 3))
@printf("divide by n,     by hand:                    %.6f\n", by_n_hand)
@printf("divide by n,     mean(x.^2)-mean^2:          %.6f\n", by_n_short)
@printf("divide by n,     var(x; corrected = false):  %.6f\n", var(x; corrected = false))
@printf("divide by n - 1, by hand:                    %.6f\n", by_n1_hand)
@printf("divide by n - 1, var(x):                     %.6f\n", var(x))
@printf("ratio (divide by n) / (divide by n - 1) = %.4f   and (n - 1)/n = %.4f\n",
        by_n_hand / by_n1_hand, (n - 1) / n)

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
