# sample_average.R
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 1 helper: the average of a sequence of random numbers.
#
# Draw n = 1000 numbers from Uniform(0, 1) and compute their average three ways:
# by hand with a loop, as sum(x)/n, and with mean. All three agree up to
# rounding error. Base R only; no packages needed.
#
# Run:  source("sample_average.R")     (in R or RStudio, from this folder)

set.seed(0)                    # reproducibility (remove for a fresh draw)

n <- 1000
x <- runif(n)                  # n numbers from Uniform(0, 1), whose mean is 1/2

# 1. by hand: add the numbers up one at a time, then divide by how many there are
total <- 0
for (i in 1:n) {               # i = 1, 2, ..., n: R counts from 1
  total <- total + x[i]
}
avg_loop <- total / n

# 2. add them up with sum, then divide
avg_sum <- sum(x) / n

# 3. let R do both steps
avg_mean <- mean(x)

cat(sprintf("by hand, with a loop: %.15f\n", avg_loop))
cat(sprintf("sum(x) / n:           %.15f\n", avg_sum))
cat(sprintf("mean(x):              %.15f\n", avg_mean))
# sum and mean work with extra precision internally, so the last digit or two can
# differ from the loop: a computer rounds every sum to about 16 significant digits
cat(sprintf("loop minus mean:      %.1e\n", avg_loop - avg_mean))
cat("\n")
cat(sprintf("average of the first 10 numbers, mean(x[1:10]): %.4f\n", mean(x[1:10])))

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
