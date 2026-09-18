# random_numbers.py
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 1 helper: random numbers.
#
# A random number generator produces a sequence of numbers that is fixed by its
# seed. This script shows that the same seed gives the same sequence and a
# different seed a different one, and it draws numbers from a few common
# distributions. It only prints; nothing is plotted or saved. Needs numpy.
#
# Run:  python3 random_numbers.py

import numpy as np


def print_row(label, x):
    print(f"{label:<24}" + "".join(f"{v:9.4f}" for v in x))


# ---- seeds and sequences -----------------------------------------------------
rng = np.random.default_rng(42)
print_row("seed 42", rng.random(5))
rng = np.random.default_rng(42)
print_row("seed 42 again", rng.random(5))    # the same five numbers
rng = np.random.default_rng(7)
print_row("seed 7", rng.random(5))           # a different sequence
rng = np.random.default_rng()
print_row("no seed", rng.random(5))          # different every time you run this

# drawing more numbers continues the sequence; it does not start it over
rng = np.random.default_rng(42)
print_row("seed 42, first 3", rng.random(3))
print_row("seed 42, next 3", rng.random(3))  # starts with entries 4 and 5 above
print()

# ---- a few distributions, n = 5 draws each -----------------------------------
rng = np.random.default_rng(0)
n = 5
print_row("Uniform(0, 1)", rng.random(n))
print_row("Uniform(-1, 1)", -1 + 2 * rng.random(n))         # a + (b - a) * U
print_row("N(0, 1)", rng.standard_normal(n))
print_row("N(3, 4)", 3 + 2 * rng.standard_normal(n))        # mean + sd * Z: sd = 2, not 4

# Exponential with rate 2, two ways. The inverse-CDF method: if U ~ Uniform(0, 1)
# and F is a CDF, then F^{-1}(U) has CDF F. Here F(x) = 1 - exp(-2x), so
# F^{-1}(u) = -log(1 - u)/2; and 1 - U is Uniform(0, 1) too, so -log(U)/2 works.
print_row("Exp(2), inverse CDF", -np.log(rng.random(n)) / 2)
print_row("Exp(2), built in", rng.exponential(scale=1 / 2, size=n))   # numpy takes 1/rate

rolls = rng.integers(1, 7, size=10)                           # 1 to 6: the 7 is left out
print(f"{'die rolls':<24}" + " ".join(str(r) for r in rolls))

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
