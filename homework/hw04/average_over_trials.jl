# average_over_trials.jl
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 4 helper: averaging an estimator over many trials, for many sample sizes.
#
# Toss a coin that lands heads with probability p = 0.3 and estimate p^2 = 0.09
# by the square of the sample proportion, est = (mean of the tosses)^2.
# For n = 3, 4, ..., 100 draw 100 samples of size n, compute the estimate for
# each sample, and average the 100 values; that average estimates E[est]. Plot it
# against n, together with the exact value E[est] = p^2 + p(1 - p)/n and the true
# value p^2. The estimator is biased: it overestimates p^2, by less as n grows.
# Needs the Plots package.
#
# Run:  include("average_over_trials.jl")   (at the Julia REPL, from this folder)

using Random, Statistics, Printf
using Plots

Random.seed!(1)                        # reproducibility (remove for a fresh draw)

p = 0.3
nvals = 3:100                          # n = 3, 4, ..., 100
trials = 100                           # samples per n
avg_est = zeros(length(nvals))         # room for one average per n, filled in below

for k in eachindex(nvals)              # outer loop: one sample size at a time
    nk = nvals[k]                      # the sample size for this pass of the loop
    est = zeros(trials)                # room for one estimate per trial
    for t in 1:trials                  # inner loop: one fresh sample at a time
        tosses = Float64.(rand(nk) .< p)   # nk coin tosses: 1 (heads) with probability p, else 0
        est[t] = mean(tosses)^2        # the estimator, computed from this one sample
    end
    avg_est[k] = mean(est)             # average over the trials: estimates E[est]
end

exact = p^2 .+ p * (1 - p) ./ nvals    # E[est] = p^2 + p(1 - p)/n

@printf("n = %d:   average %.4f   exact %.4f   true p^2 = %.4f\n", nvals[1], avg_est[1], exact[1], p^2)
@printf("n = %d: average %.4f   exact %.4f\n", nvals[end], avg_est[end], exact[end])

pl = plot(nvals, avg_est; label = "average of the estimate over 100 trials",
          xlabel = "n", ylabel = "average estimate",
          title = "estimating p^2 by (sample proportion)^2, p = 0.3")
plot!(pl, nvals, exact; color = :black, linewidth = 2, label = "exact E[est] = p^2 + p(1-p)/n")
hline!(pl, [p^2]; color = :gray, linestyle = :dash, label = "true value p^2 = 0.09")
display(pl)

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
