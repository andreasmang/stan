# smoke_test.py
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 0, Problem 4(a): toolchain smoke test.
#
# Draw n = 1000 i.i.d. samples from N(0,1), report the sample mean, and plot a
# histogram. Needs numpy and matplotlib (see README.md to install them).
#
# Run:  python3 smoke_test.py

import numpy as np
import matplotlib.pyplot as plt

rng = np.random.default_rng(0)   # reproducibility (drop the 0 for a fresh draw)

n = 1000
x = rng.standard_normal(n)       # i.i.d. N(0,1)

print(f"sample mean of n = {n} draws: {x.mean():.4f}")

plt.hist(x, bins=30, edgecolor="black")
plt.xlabel("x")
plt.ylabel("count")
plt.title(f"{n} samples from N(0,1), sample mean = {x.mean():.4f}")
plt.savefig("hw00-histogram.png", dpi=150)
plt.show()

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
