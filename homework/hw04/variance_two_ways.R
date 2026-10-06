# variance_two_ways.R
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 4 helper: two variances that differ only in what they divide by.
#
# For one sample of size n = 5 from Uniform(0, 1), compute
#   divide by n:      (1/n)     * sum (x_i - mean)^2  =  mean(x^2) - mean(x)^2
#   divide by n - 1:  (1/(n-1)) * sum (x_i - mean)^2
# by hand and with R's built-in var. The two differ by the factor (n - 1)/n,
# which matters for small n. Careful: var(x) always divides by n - 1; R has no
# built-in that divides by n, so compute that one by hand.
# Base R only; no packages needed.
#
# Run:  source("variance_two_ways.R")     (in R or RStudio, from this folder)

set.seed(0)                            # reproducibility (remove for a fresh draw)

n <- 5
x <- runif(n)                          # one sample of size n from Uniform(0, 1)
xbar <- mean(x)

by_n_hand  <- sum((x - xbar)^2) / n          # divide by n
by_n_short <- mean(x^2) - xbar^2             # the same number, written another way
by_n1_hand <- sum((x - xbar)^2) / (n - 1)    # divide by n - 1

cat("sample:", round(x, 3), "\n")
cat(sprintf("divide by n,     by hand:            %.6f\n", by_n_hand))
cat(sprintf("divide by n,     mean(x^2)-mean^2:   %.6f\n", by_n_short))
cat(sprintf("divide by n - 1, by hand:            %.6f\n", by_n1_hand))
cat(sprintf("divide by n - 1, var(x):             %.6f\n", var(x)))
cat(sprintf("ratio (divide by n) / (divide by n - 1) = %.4f   and (n - 1)/n = %.4f\n",
            by_n_hand / by_n1_hand, (n - 1) / n))

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
