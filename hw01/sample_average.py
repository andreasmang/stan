# sample_average.py
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 1 helper: the average of a sequence of random numbers.
#
# Draw n = 1000 numbers from Uniform(0, 1) and compute their average three ways:
# by hand with a loop, as np.sum(x)/n, and with np.mean. All three agree up to
# rounding error. Needs numpy.
#
# Run:  python3 sample_average.py

import numpy as np

rng = np.random.default_rng(0)       # reproducibility (drop the 0 for a fresh draw)

n = 1000
x = rng.random(n)                    # n numbers from Uniform(0, 1), whose mean is 1/2

# 1. by hand: add the numbers up one at a time, then divide by how many there are
total = 0.0
for i in range(n):                   # i = 0, 1, ..., n-1: Python counts from 0
    total = total + x[i]
avg_loop = total / n

# 2. add them up with np.sum, then divide
avg_sum = np.sum(x) / n

# 3. let numpy do both steps (x.mean() is the same thing)
avg_mean = np.mean(x)

print(f"by hand, with a loop: {avg_loop:.15f}")
print(f"np.sum(x) / n:        {avg_sum:.15f}")
print(f"np.mean(x):           {avg_mean:.15f}")
# np.sum adds the numbers in a different order than the loop, so the last digit
# or two can differ: a computer rounds every sum to about 16 significant digits
print(f"loop minus np.mean:   {avg_loop - avg_mean:.1e}")
print()
print(f"average of the first 10 numbers, np.mean(x[:10]): {np.mean(x[:10]):.4f}")

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
