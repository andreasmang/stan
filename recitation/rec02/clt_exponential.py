# clt_exponential.py
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Recitation 2: how fast does the central limit theorem kick in?
#
# For n = 1, 5, 30, draw N = 10000 samples of size n from the exponential
# distribution with mean 1 (so mu = sigma = 1), standardize each sample mean,
# Z = sqrt(n) (xbar - 1), and plot a histogram of the N values against the
# N(0,1) density. Prints how often Z > 1.645 and Z < -1.645, which is 0.05 each
# for a standard normal. Needs numpy and matplotlib.
#
# Run:  python3 clt_exponential.py

import numpy as np
import matplotlib.pyplot as plt

rng = np.random.default_rng(0)                  # reproducibility (drop the 0 for a fresh draw)

N = 10000                                       # number of samples for each n
z = np.linspace(-4, 4, 200)
phi = np.exp(-z**2 / 2) / np.sqrt(2 * np.pi)    # the N(0,1) density

fig, ax = plt.subplots(1, 3, figsize=(12, 3.5))
for k, n in enumerate([1, 5, 30]):
    x = rng.exponential(1, size=(N, n))         # N samples of size n, one per row
    Z = np.sqrt(n) * (x.mean(axis=1) - 1)       # N standardized means
    print(f"n = {n:2d}:  P(Z > 1.645) = {np.mean(Z > 1.645):.3f},  "
          f"P(Z < -1.645) = {np.mean(Z < -1.645):.3f}   (normal: 0.050 each)")
    ax[k].hist(Z, bins=60, density=True)
    ax[k].plot(z, phi, linewidth=2)
    ax[k].set_title(f"n = {n}")
    ax[k].set_xlabel("standardized mean")
plt.tight_layout()
plt.show()                                      # the script finishes when you close the window

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
