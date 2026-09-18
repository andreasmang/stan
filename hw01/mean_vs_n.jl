# mean_vs_n.jl
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 1 helper: a loop over sample sizes.
#
# For n = 5, 10, 15, ..., 1000 draw a fresh sample of n numbers from
# Uniform(0, 1), store its average, and plot the averages against n. The plot
# also shows the true mean 1/2 and the band 1/2 +- 2 sigma/sqrt(n) of two
# standard errors, where sigma^2 = 1/12 is the variance of Uniform(0, 1).
# Needs the Plots package.
#
# Run:  include("mean_vs_n.jl")   (at the Julia REPL, from this folder)

using Random, Statistics, Printf
using Plots

Random.seed!(0)                        # reproducibility (remove for a fresh draw)

nvals = 5:5:1000                       # n = 5, 10, ..., 1000
avg = zeros(length(nvals))             # room for one average per n, filled in below

for k in eachindex(nvals)              # k = 1, 2, ..., 200 numbers the entries of nvals
    avg[k] = mean(rand(nvals[k]))      # the average of a fresh sample of size n = nvals[k]
end

band = 2 .* sqrt.(1 / 12 ./ nvals)     # two standard errors, 2 sigma / sqrt(n), for every n
inside = mean(abs.(avg .- 0.5) .<= band)   # the mean of trues and falses is a proportion

@printf("average at n = %d: %.4f   (true mean 0.5)\n", nvals[end], avg[end])
@printf("proportion of the %d averages inside the band: %.2f\n", length(nvals), inside)

p = plot(nvals, avg; label = "sample average", xlabel = "n", ylabel = "sample average",
         title = "averages of n draws from Uniform(0, 1)")
hline!(p, [0.5]; color = :black, linestyle = :dash, label = "true mean 1/2")
plot!(p, nvals, 0.5 .+ band; color = :gray, linestyle = :dot, label = "1/2 ± 2 standard errors")
plot!(p, nvals, 0.5 .- band; color = :gray, linestyle = :dot, label = "")
display(p)

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
