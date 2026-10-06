# average_over_trials.py
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 4 helper: averaging an estimator over many trials, for many sample sizes.
#
# Toss a coin that lands heads with probability p = 0.3 and estimate p^2 = 0.09
# by the square of the sample proportion, est = (mean of the tosses)^2.
# For n = 3, 4, ..., 100 draw 100 samples of size n, compute the estimate for
# each sample, and average the 100 values; that average estimates E[est]. Plot it
# against n, together with the exact value E[est] = p^2 + p(1 - p)/n and the true
# value p^2. The estimator is biased: it overestimates p^2, by less as n grows.
# Needs numpy and matplotlib.
#
# Run:  python3 average_over_trials.py

import numpy as np
import matplotlib.pyplot as plt

rng = np.random.default_rng(1)            # reproducibility (drop the 1 for a fresh draw)

p = 0.3
nvals = np.arange(3, 101)                 # n = 3, 4, ..., 100: arange leaves out the end, 101
trials = 100                              # samples per n
avg_est = np.zeros(nvals.size)            # room for one average per n, filled in below

for k in range(nvals.size):               # outer loop: one sample size at a time
    n = nvals[k]
    est = np.zeros(trials)                # room for one estimate per trial
    for t in range(trials):               # inner loop: one fresh sample at a time
        x = (rng.random(n) < p) * 1.0     # n coin tosses: 1 (heads) with probability p, else 0
        est[t] = np.mean(x) ** 2          # the estimator, computed from this one sample
    avg_est[k] = np.mean(est)             # average over the trials: estimates E[est]

exact = p**2 + p * (1 - p) / nvals        # E[est] = p^2 + p(1 - p)/n

print(f"n = {nvals[0]}:   average {avg_est[0]:.4f}   exact {exact[0]:.4f}   true p^2 = {p**2:.4f}")
print(f"n = {nvals[-1]}: average {avg_est[-1]:.4f}   exact {exact[-1]:.4f}")

plt.plot(nvals, avg_est, label="average of the estimate over 100 trials")
plt.plot(nvals, exact, color="black", label="exact E[est] = p^2 + p(1-p)/n")
plt.axhline(p**2, color="gray", linestyle="--", label="true value p^2 = 0.09")
plt.xlabel("n")
plt.ylabel("average estimate")
plt.title("estimating p^2 by (sample proportion)^2, p = 0.3")
plt.legend()
plt.show()                                # the script finishes when you close the window

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
