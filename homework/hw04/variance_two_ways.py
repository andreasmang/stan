# variance_two_ways.py
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 4 helper: two variances that differ only in what they divide by.
#
# For one sample of size n = 5 from Uniform(0, 1), compute
#   divide by n:      (1/n)     * sum (x_i - mean)^2  =  mean(x^2) - mean(x)^2
#   divide by n - 1:  (1/(n-1)) * sum (x_i - mean)^2
# by hand and with numpy's built-in np.var. The two differ by the factor
# (n - 1)/n, which matters for small n. Needs numpy.
#
# Run:  python3 variance_two_ways.py

import numpy as np

rng = np.random.default_rng(0)            # reproducibility (drop the 0 for a fresh draw)

n = 5
x = rng.random(n)                         # one sample of size n from Uniform(0, 1)
xbar = np.mean(x)

by_n_hand = np.sum((x - xbar) ** 2) / n          # divide by n
by_n_short = np.mean(x ** 2) - xbar ** 2         # the same number, written another way
by_n1_hand = np.sum((x - xbar) ** 2) / (n - 1)   # divide by n - 1

print(f"sample: {np.round(x, 3)}")
print(f"divide by n,     by hand:            {by_n_hand:.6f}")
print(f"divide by n,     mean(x^2)-mean^2:   {by_n_short:.6f}")
print(f"divide by n,     np.var(x):          {np.var(x):.6f}")
print(f"divide by n - 1, by hand:            {by_n1_hand:.6f}")
print(f"divide by n - 1, np.var(x, ddof=1):  {np.var(x, ddof=1):.6f}")
print(f"ratio (divide by n) / (divide by n - 1) = {by_n_hand / by_n1_hand:.4f}"
      f"   and (n - 1)/n = {(n - 1) / n:.4f}")

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
