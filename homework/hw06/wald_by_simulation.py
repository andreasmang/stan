# wald_by_simulation.py
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
# Needs numpy and matplotlib; the normal CDF comes with Python.
#
# Run:  python3 wald_by_simulation.py

from statistics import NormalDist

import numpy as np
import matplotlib.pyplot as plt

rng = np.random.default_rng(1)            # reproducibility (drop the 1 for a fresh draw)

theta = 1.0                               # the true mean: change this to make H0 false
theta0 = 1.0                              # the value of theta under H0
n = 25                                    # sample size
trials = 10_000                           # number of samples
Phi = NormalDist().cdf                    # the standard normal CDF
W = np.zeros(trials)                      # room for one statistic per sample
p = np.zeros(trials)                      # room for one p-value per sample

for t in range(trials):                   # one fresh sample at a time
    x = rng.exponential(theta, n)         # n draws; numpy takes the mean, not the rate
    xbar = np.mean(x)                     # the estimate, computed from this one sample
    se = xbar / np.sqrt(n)                # its estimated standard error
    W[t] = (xbar - theta0) / se           # the Wald statistic
    p[t] = 2 * Phi(-abs(W[t]))            # the two-sided p-value

print(f"true mean {theta}, H0: theta = {theta0}, n = {n}")
print(f"fraction with |W| > 1.96: {np.mean(np.abs(W) > 1.96):.4f}")
print(f"fraction with p < .05:    {np.mean(p < 0.05):.4f}")
print(f"fraction with p < .01:    {np.mean(p < 0.01):.4f}")

plt.hist(W, bins=40)                      # 40 bins of equal width
plt.axvline(-1.96, color="black", linestyle="--")
plt.axvline(1.96, color="black", linestyle="--")   # the test rejects outside these lines
plt.xlabel("W")
plt.ylabel("number of samples")
plt.title(f"the Wald statistic, true mean {theta}")
plt.show()                                # the script finishes when you close the window

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
