# wald_by_simulation.jl
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 6 helper: a Wald test and its p-value, repeated by simulation.
#
# Draw a sample of size n = 25 from the exponential distribution with mean theta,
# and test H0: theta = 1 against H1: theta != 1 with the Wald test. The estimate is
# the sample mean. Its standard error is theta/sqrt(n), which we estimate by
# xbar/sqrt(n), so W = (xbar - 1)/(xbar/sqrt(n)) and the p-value is 2*Phi(-|W|).
# Repeat this for 10,000 samples, keep W and the p-value of each, plot a histogram
# of W, and print how often the test rejects. Change theta to see what happens
# when H0 is false.
# Needs the packages Plots and Distributions.
#
# Run:  include("wald_by_simulation.jl")   (at the Julia REPL, from this folder)

using Random, Statistics, Printf
using Distributions
using Plots

Random.seed!(1)                        # reproducibility (remove for a fresh draw)

theta = 1.0                            # the true mean: change this to make H0 false
theta0 = 1.0                           # the value of theta under H0
n = 25                                 # sample size
trials = 10_000                        # number of samples
W = zeros(trials)                      # room for one statistic per sample
p = zeros(trials)                      # room for one p-value per sample

for t in 1:trials                      # one fresh sample at a time
    x = theta .* randexp(n)            # n draws; randexp has mean 1, so scale it by theta
    xbar = mean(x)                     # the estimate, computed from this one sample
    se = xbar / sqrt(n)                # its estimated standard error
    W[t] = (xbar - theta0) / se        # the Wald statistic
    p[t] = 2 * cdf(Normal(), -abs(W[t]))   # the two-sided p-value
end

@printf("true mean %g, H0: theta = %g, n = %d\n", theta, theta0, n)
@printf("fraction with |W| > 1.96: %.4f\n", mean(abs.(W) .> 1.96))
@printf("fraction with p < .05:    %.4f\n", mean(p .< 0.05))
@printf("fraction with p < .01:    %.4f\n", mean(p .< 0.01))

pl = histogram(W; bins = 40, label = "", xlabel = "W", ylabel = "number of samples",   # about 40 bins
               title = "the Wald statistic, true mean $theta")
vline!(pl, [-1.96, 1.96]; color = :black, linestyle = :dash, label = "")   # the test rejects outside these lines
display(pl)

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
