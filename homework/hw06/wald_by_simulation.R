# wald_by_simulation.R
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
# Base R only; no packages needed.
#
# Run:  source("wald_by_simulation.R")     (in R or RStudio, from this folder)

set.seed(1)                            # reproducibility (remove for a fresh draw)

theta <- 1                             # the true mean: change this to make H0 false
theta0 <- 1                            # the value of theta under H0
n <- 25                                # sample size
trials <- 10000                        # number of samples
W <- numeric(trials)                   # room for one statistic per sample
p <- numeric(trials)                   # room for one p-value per sample

for (t in 1:trials) {                  # one fresh sample at a time
  x <- rexp(n, rate = 1 / theta)       # n draws; R takes the rate, not the mean
  xbar <- mean(x)                      # the estimate, computed from this one sample
  se <- xbar / sqrt(n)                 # its estimated standard error
  W[t] <- (xbar - theta0) / se         # the Wald statistic
  p[t] <- 2 * pnorm(-abs(W[t]))        # the two-sided p-value; pnorm is the normal CDF
}

cat(sprintf("true mean %g, H0: theta = %g, n = %d\n", theta, theta0, n))
cat(sprintf("fraction with |W| > 1.96: %.4f\n", mean(abs(W) > 1.96)))
cat(sprintf("fraction with p < .05:    %.4f\n", mean(p < 0.05)))
cat(sprintf("fraction with p < .01:    %.4f\n", mean(p < 0.01)))

hist(W, breaks = 40, xlab = "W", ylab = "number of samples",   # about 40 bins
     main = sprintf("the Wald statistic, true mean %g", theta))
abline(v = c(-1.96, 1.96), lty = 2)    # the test rejects outside these lines

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
