# mse_by_simulation.py
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 5 helper: the mean squared error (MSE) of an estimator, by simulation.
#
# Draw a sample of size n = 10 from N(theta, 1) with theta = 2, and estimate the
# center theta in two ways: by the sample median and by the sample mean.
# Repeat this for 10,000 samples and average the squared errors (est - theta)^2;
# that average estimates MSE = E[(est - theta)^2]. The MSE of the sample mean is
# known exactly, sigma^2/n = 0.1, so the simulation can be checked against it.
# The MSE of the sample median has no simple formula, which is what the
# simulation is for. Both estimators are unbiased here, so the MSE is the variance.
# Needs numpy.
#
# Run:  python3 mse_by_simulation.py

import numpy as np

rng = np.random.default_rng(1)            # reproducibility (drop the 1 for a fresh draw)

theta = 2.0                               # the true center, which the estimators target
sigma = 1.0
n = 10                                    # sample size
trials = 10_000                           # number of samples
est_median = np.zeros(trials)             # room for one estimate per sample
est_mean = np.zeros(trials)

for t in range(trials):                   # one fresh sample at a time
    x = theta + sigma * rng.standard_normal(n)   # n draws from N(theta, sigma^2)
    est_median[t] = np.median(x)          # the estimators, computed from this one sample
    est_mean[t] = np.mean(x)

mse_median = np.mean((est_median - theta) ** 2)   # average squared error: estimates the MSE
mse_mean = np.mean((est_mean - theta) ** 2)
exact_mean = sigma**2 / n                 # MSE of the sample mean: no bias, variance sigma^2/n

bias_median = np.mean(est_median) - theta
var_median = np.var(est_median)           # divides by the number of trials
print(f"sample median: simulated MSE {mse_median:.4f}"
      f"   (bias^2 {bias_median**2:.6f} + variance {var_median:.4f})")
print(f"sample mean:   simulated MSE {mse_mean:.4f}   exact MSE {exact_mean:.4f}")
print(f"ratio MSE(median)/MSE(mean): {mse_median / exact_mean:.2f}")

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
