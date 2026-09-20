# clt_exponential.jl
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Recitation 2: how fast does the central limit theorem kick in?
#
# For n = 1, 5, 30, draw N = 10000 samples of size n from the exponential
# distribution with mean 1 (so mu = sigma = 1), standardize each sample mean,
# Z = sqrt(n) (xbar - 1), and plot a histogram of the N values against the
# N(0,1) density. Prints how often Z > 1.645 and Z < -1.645, which is 0.05 each
# for a standard normal. Needs the Plots package.
#
# Run:  include("clt_exponential.jl")   (at the Julia REPL, from this folder)

using Random, Statistics, Printf
using Plots

Random.seed!(0)                          # reproducibility (remove for a fresh draw)

N = 10000                                # number of samples for each n
z = range(-4, 4; length = 200)
phi = exp.(-z .^ 2 ./ 2) ./ sqrt(2pi)    # the N(0,1) density

panels = map([1, 5, 30]) do n
    x = randexp(n, N)                    # N samples of size n, one per column
    Z = sqrt(n) .* (vec(mean(x; dims = 1)) .- 1)   # N standardized means
    @printf("n = %2d:  P(Z > 1.645) = %.3f,  P(Z < -1.645) = %.3f   (normal: 0.050 each)\n",
            n, mean(Z .> 1.645), mean(Z .< -1.645))
    p = histogram(Z; normalize = :pdf, bins = 60, legend = false,
                  title = "n = $n", xlabel = "standardized mean")
    plot!(p, z, phi; linewidth = 2)
end
display(plot(panels...; layout = (1, 3), size = (1100, 330)))

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
