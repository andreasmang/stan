# smoke_test.jl
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 0, Problem 4(a): toolchain smoke test.
#
# Draw n = 1000 i.i.d. samples from N(0,1), report the sample mean, and plot a
# histogram. Needs the Plots package (see README.md to install it).
#
# Run:  julia smoke_test.jl      (or  include("smoke_test.jl")  at the REPL)

using Random, Statistics, Printf
using Plots

Random.seed!(0)                  # reproducibility (remove for a fresh draw)

n = 1000
x = randn(n)                     # i.i.d. N(0,1)

@printf("sample mean of n = %d draws: %.4f\n", n, mean(x))

p = histogram(x; bins = 30, xlabel = "x", ylabel = "count", legend = false,
              title = @sprintf("%d samples from N(0,1), sample mean = %.4f", n, mean(x)))
savefig(p, "hw00-histogram.png")
display(p)

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
