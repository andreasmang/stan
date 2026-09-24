# discrete.py
#
# Plot the probability mass functions of the hypergeometric, Bernoulli,
# binomial, geometric, negative binomial, and Poisson distributions, with the
# same parameters as the plots in the notes. Each mass function is typed in
# from its formula in the notes. Needs matplotlib.
#
# Disclaimer: the definitions of the distributions are based on a writeup by
# Prof. Dr. Subramanian Ramakrishnan at the University of Miami.
#
# Run:  python3 discrete.py

import math

import matplotlib.pyplot as plt
from matplotlib.ticker import MaxNLocator


# mass functions f(x) = P(X = x), as in the notes
def hypergeometric(x, n, t, m):
    # x marked objects among m drawn without replacement from n objects, t of
    # them marked; math.comb(a, b) is 0 for b > a, the convention in the notes
    return math.comb(t, x) * math.comb(n - t, m - x) / math.comb(n, m)


def bernoulli(x, p):
    return p**x * (1 - p)**(1 - x)


def binomial(x, n, p):
    return math.comb(n, x) * p**x * (1 - p)**(n - x)


def geometric(x, p):              # x = trials up to and including the first success
    return (1 - p)**(x - 1) * p


def negative_binomial(x, r, p):   # x = trials up to and including the r-th success
    return math.comb(x - 1, r - 1) * (1 - p)**(x - r) * p**r


def poisson(x, lam):              # lambda is a reserved word in Python
    return math.exp(-lam) * lam**x / math.factorial(x)


# a stem plot of the values f at the points xs
def stem(ax, xs, f, title):
    ax.vlines(xs, 0, f, color="#3172AE", linewidth=2)
    ax.plot(xs, f, "o", color="#3172AE")
    ax.set_title(title)
    ax.set_xlabel("x")
    ax.set_ylabel("f(x)")
    ax.set_ylim(bottom=0)
    ax.xaxis.set_major_locator(MaxNLocator(integer=True))   # X takes whole numbers


fig, ax = plt.subplots(2, 3, figsize=(12, 6.5), layout="constrained")

xs = list(range(0, 11))
stem(ax[0, 0], xs, [hypergeometric(x, 50, 20, 10) for x in xs],
     "hypergeometric, n = 50, t = 20, m = 10")

xs = [0, 1]
stem(ax[0, 1], xs, [bernoulli(x, 0.3) for x in xs], "Bernoulli, p = 0.3")
ax[0, 1].set_xlim(-0.5, 1.5)
ax[0, 1].set_xticks(xs)

xs = list(range(0, 11))
stem(ax[0, 2], xs, [binomial(x, 10, 0.3) for x in xs], "binomial, n = 10, p = 0.3")

xs = list(range(1, 13))           # the values go on forever; show the first 12
stem(ax[1, 0], xs, [geometric(x, 0.3) for x in xs], "geometric, p = 0.3")

xs = list(range(3, 17))           # starts at x = r
stem(ax[1, 1], xs, [negative_binomial(x, 3, 0.5) for x in xs],
     "negative binomial, r = 3, p = 0.5")

xs = list(range(0, 11))
stem(ax[1, 2], xs, [poisson(x, 3) for x in xs], "Poisson, λ = 3")

plt.show()                        # the script finishes when you close the window

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
