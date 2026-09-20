# clt_exponential.R
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Recitation 2: how fast does the central limit theorem kick in?
#
# For n = 1, 5, 30, draw N = 10000 samples of size n from the exponential
# distribution with mean 1 (so mu = sigma = 1), standardize each sample mean,
# Z = sqrt(n) (xbar - 1), and plot a histogram of the N values against the
# N(0,1) density. Prints how often Z > 1.645 and Z < -1.645, which is 0.05 each
# for a standard normal. Base R only; no packages needed.
#
# Run:  source("clt_exponential.R")     (in R or RStudio, from this folder)

set.seed(0)                              # reproducibility (remove for a fresh draw)

N <- 10000                               # number of samples for each n
z <- seq(-4, 4, length.out = 200)

par(mfrow = c(1, 3))                     # 1 row, 3 columns of plots
for (n in c(1, 5, 30)) {
  x <- matrix(rexp(n * N), nrow = n)     # N samples of size n, one per column
  Z <- sqrt(n) * (colMeans(x) - 1)       # N standardized means
  cat(sprintf("n = %2d:  P(Z > 1.645) = %.3f,  P(Z < -1.645) = %.3f   (normal: 0.050 each)\n",
              n, mean(Z > 1.645), mean(Z < -1.645)))
  h <- hist(Z, breaks = 60, plot = FALSE)
  plot(h, freq = FALSE, ylim = c(0, max(h$density, dnorm(0))), col = "gray75",
       border = NA, xlab = "standardized mean", main = sprintf("n = %d", n))
  lines(z, dnorm(z), lwd = 2)
}

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
