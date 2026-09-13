# running_proportion.jl
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Recitation 1: your first simulation.
#
# Flip a fair coin n = 1000 times and plot the running proportion of heads
# against the number of flips. Needs the Plots package.
#
# Run:  include("running_proportion.jl")   (at the Julia REPL, from this folder)

using Random, Printf
using Plots

Random.seed!(0)                  # reproducibility (remove for a fresh draw)

n = 1000
x = rand(n) .< 0.5               # true = heads
p = cumsum(x) ./ (1:n)           # running proportion

@printf("proportion of heads after n = %d flips: %.4f\n", n, p[end])

fig = plot(1:n, p; xlabel = "flips", ylabel = "proportion of heads", legend = false,
           title = @sprintf("running proportion of heads, n = %d flips", n))
hline!(fig, [0.5]; linestyle = :dash, color = :gray)
display(fig)

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
