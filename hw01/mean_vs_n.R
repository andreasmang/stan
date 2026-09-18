# mean_vs_n.R
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 1 helper: a loop over sample sizes.
#
# For n = 5, 10, 15, ..., 1000 draw a fresh sample of n numbers from
# Uniform(0, 1), store its average, and plot the averages against n. The plot
# also shows the true mean 1/2 and the band 1/2 +- 2 sigma/sqrt(n) of two
# standard errors, where sigma^2 = 1/12 is the variance of Uniform(0, 1).
# Base R only; no packages needed.
#
# Run:  source("mean_vs_n.R")     (in R or RStudio, from this folder)

set.seed(0)                            # reproducibility (remove for a fresh draw)

nvals <- seq(5, 1000, by = 5)          # n = 5, 10, ..., 1000
avg <- numeric(length(nvals))          # room for one average per n, filled in below

for (k in seq_along(nvals)) {          # k = 1, 2, ..., 200 numbers the entries of nvals
  n <- nvals[k]
  x <- runif(n)                        # a fresh sample of size n
  avg[k] <- mean(x)
}

band <- 2 * sqrt(1 / 12 / nvals)       # two standard errors, 2 sigma / sqrt(n), for every n
inside <- mean(abs(avg - 0.5) <= band) # the mean of TRUEs and FALSEs is a proportion

cat(sprintf("average at n = %d: %.4f   (true mean 0.5)\n", nvals[length(nvals)],
            avg[length(avg)]))
cat(sprintf("proportion of the %d averages inside the band: %.2f\n", length(nvals),
            inside))

# plot() fixes the range of the y-axis, so make it wide enough for the band as well
plot(nvals, avg, type = "l", xlab = "n", ylab = "sample average",
     ylim = range(avg, 0.5 - band, 0.5 + band),
     main = "averages of n draws from Uniform(0, 1)")
abline(h = 0.5, lty = 2)
lines(nvals, 0.5 + band, lty = 3, col = "gray40")
lines(nvals, 0.5 - band, lty = 3, col = "gray40")
legend("topright", bty = "n", lty = c(1, 2, 3), col = c("black", "black", "gray40"),
       legend = c("sample average", "true mean 1/2", "1/2 ± 2 standard errors"))

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
