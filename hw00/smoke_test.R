# smoke_test.R
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 0, Problem 4(a): toolchain smoke test.
#
# Draw n = 1000 i.i.d. samples from N(0,1), report the sample mean, and plot a
# histogram. Base R only; no packages needed.
#
# Run:  Rscript smoke_test.R     (or  source("smoke_test.R")  in R / RStudio)

set.seed(0)                      # reproducibility (remove for a fresh draw)

n <- 1000
x <- rnorm(n)                    # i.i.d. N(0,1)

cat(sprintf("sample mean of n = %d draws: %.4f\n", n, mean(x)))

png("hw00-histogram.png", width = 960, height = 720, res = 150)   # draw into a file
hist(x, breaks = 30, xlab = "x", ylab = "count",
     main = sprintf("%d samples from N(0,1), sample mean = %.4f", n, mean(x)))
invisible(dev.off())                                             # write the file

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
