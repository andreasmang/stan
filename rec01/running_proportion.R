# running_proportion.R
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Recitation 1: your first simulation.
#
# Flip a fair coin n = 1000 times and plot the running proportion of heads
# against the number of flips. Base R only; no packages needed.
#
# Run:  source("running_proportion.R")     (in R or RStudio, from this folder)

set.seed(0)                      # reproducibility (remove for a fresh draw)

n <- 1000
x <- as.numeric(runif(n) < 0.5)  # 1 = heads
p <- cumsum(x) / seq_len(n)      # running proportion

cat(sprintf("proportion of heads after n = %d flips: %.4f\n", n, p[n]))

plot(seq_len(n), p, type = "l", xlab = "flips", ylab = "proportion of heads",
     main = sprintf("running proportion of heads, n = %d flips", n))
abline(h = 0.5, lty = 2, col = "gray")

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
