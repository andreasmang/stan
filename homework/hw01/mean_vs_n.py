# mean_vs_n.py
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 1 helper: a loop over sample sizes.
#
# For n = 5, 10, 15, ..., 1000 draw a fresh sample of n numbers from
# Uniform(0, 1), store its average, and plot the averages against n. The plot
# also shows the true mean 1/2 and the band 1/2 +- 2 sigma/sqrt(n) of two
# standard errors, where sigma^2 = 1/12 is the variance of Uniform(0, 1).
# Needs numpy and matplotlib.
#
# Run:  python3 mean_vs_n.py

import numpy as np
import matplotlib.pyplot as plt

rng = np.random.default_rng(0)            # reproducibility (drop the 0 for a fresh draw)

nvals = np.arange(5, 1001, 5)             # n = 5, 10, ..., 1000: arange leaves out the end, 1001
avg = np.zeros(nvals.size)                # room for one average per n, filled in below

for k in range(nvals.size):               # k = 0, 1, ..., 199 numbers the entries of nvals
    n = nvals[k]
    x = rng.random(n)                     # a fresh sample of size n
    avg[k] = np.mean(x)

band = 2 * np.sqrt(1 / 12 / nvals)        # two standard errors, 2 sigma / sqrt(n), for every n
inside = np.mean(np.abs(avg - 0.5) <= band)   # the mean of 0s and 1s is a proportion

print(f"average at n = {nvals[-1]}: {avg[-1]:.4f}   (true mean 0.5)")
print(f"proportion of the {nvals.size} averages inside the band: {inside:.2f}")

plt.plot(nvals, avg, label="sample average")
plt.axhline(0.5, color="black", linestyle="--", label="true mean 1/2")
plt.plot(nvals, 0.5 + band, color="gray", linestyle=":", label="1/2 ± 2 standard errors")
plt.plot(nvals, 0.5 - band, color="gray", linestyle=":")
plt.xlabel("n")
plt.ylabel("sample average")
plt.title("averages of n draws from Uniform(0, 1)")
plt.legend()
plt.show()                                # the script finishes when you close the window

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
