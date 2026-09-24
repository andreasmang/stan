# running_proportion.py
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Recitation 1: your first simulation.
#
# Flip a fair coin n = 1000 times and plot the running proportion of heads
# against the number of flips. Needs numpy and matplotlib.
#
# Run:  python3 running_proportion.py

import numpy as np
import matplotlib.pyplot as plt

rng = np.random.default_rng(0)            # reproducibility (drop the 0 for a fresh draw)

n = 1000
x = (rng.random(n) < 0.5).astype(float)   # 1 = heads
p = np.cumsum(x) / np.arange(1, n + 1)    # running proportion

print(f"proportion of heads after n = {n} flips: {p[-1]:.4f}")

plt.plot(np.arange(1, n + 1), p)
plt.axhline(0.5, color="gray", linestyle="--")
plt.xlabel("flips")
plt.ylabel("proportion of heads")
plt.title(f"running proportion of heads, n = {n} flips")
plt.show()                                # the script finishes when you close the window

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
