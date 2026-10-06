# average_over_trials.R
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 4 helper: averaging an estimator over many trials, for many sample sizes.
#
# Toss a coin that lands heads with probability p = 0.3 and estimate p^2 = 0.09
# by the square of the sample proportion, est = (mean of the tosses)^2.
# For n = 3, 4, ..., 100 draw 100 samples of size n, compute the estimate for
# each sample, and average the 100 values; that average estimates E[est]. Plot it
# against n, together with the exact value E[est] = p^2 + p(1 - p)/n and the true
# value p^2. The estimator is biased: it overestimates p^2, by less as n grows.
# Base R only; no packages needed.
#
# Run:  source("average_over_trials.R")     (in R or RStudio, from this folder)

set.seed(1)                            # reproducibility (remove for a fresh draw)

p <- 0.3
nvals <- 3:100                         # n = 3, 4, ..., 100
trials <- 100                          # samples per n
avg_est <- numeric(length(nvals))      # room for one average per n, filled in below

for (k in seq_along(nvals)) {          # outer loop: one sample size at a time
  n <- nvals[k]
  est <- numeric(trials)               # room for one estimate per trial
  for (t in 1:trials) {                # inner loop: one fresh sample at a time
    x <- rbinom(n, 1, p)               # n coin tosses: 1 (heads) with probability p, else 0
    est[t] <- mean(x)^2                # the estimator, computed from this one sample
  }
  avg_est[k] <- mean(est)              # average over the trials: estimates E[est]
}

exact <- p^2 + p * (1 - p) / nvals     # E[est] = p^2 + p(1 - p)/n

cat(sprintf("n = %d:   average %.4f   exact %.4f   true p^2 = %.4f\n",
            nvals[1], avg_est[1], exact[1], p^2))
cat(sprintf("n = %d: average %.4f   exact %.4f\n",
            nvals[length(nvals)], avg_est[length(avg_est)], exact[length(exact)]))

# plot() fixes the range of the y-axis, so make it wide enough for every curve
plot(nvals, avg_est, type = "l", xlab = "n", ylab = "average estimate",
     ylim = range(avg_est, exact, p^2),
     main = "estimating p^2 by (sample proportion)^2, p = 0.3")
lines(nvals, exact, lwd = 2)
abline(h = p^2, lty = 2, col = "gray40")
legend("topright", bty = "n", lty = c(1, 1, 2), lwd = c(1, 2, 1),
       col = c("black", "black", "gray40"),
       legend = c("average of the estimate over 100 trials",
                  "exact E[est] = p^2 + p(1-p)/n", "true value p^2 = 0.09"))

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
