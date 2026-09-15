# continuous.py
#
# Plot the densities of the uniform, exponential, gamma, standard normal,
# normal, chi-square, and beta distributions, with the same parameters as the
# plots in the notes. Each density is typed in from its formula in the notes.
# Needs numpy and matplotlib.
#
# Disclaimer: the definitions of the distributions are based on a writeup by
# Prof. Dr. Subramanian Ramakrishnan at the University of Miami.
#
# Run:  python3 continuous.py

import math

import numpy as np
import matplotlib.pyplot as plt


# densities f(x), as in the notes (math.gamma is the gamma function)
def uniform(x, a, b):
    return np.where((a < x) & (x < b), 1 / (b - a), 0.0)


def exponential(x, lam):          # for x > 0; lambda is a reserved word in Python
    return lam * np.exp(-lam * x)


def gamma(x, alpha, lam):         # for x > 0
    return lam**alpha / math.gamma(alpha) * x**(alpha - 1) * np.exp(-lam * x)


def standard_normal(z):
    return np.exp(-z**2 / 2) / math.sqrt(2 * math.pi)


def normal(x, mu, sigma2):        # sigma2 is the variance
    return np.exp(-(x - mu)**2 / (2 * sigma2)) / math.sqrt(2 * math.pi * sigma2)


def chi_square(x, n):             # for x > 0
    return 0.5**(n / 2) / math.gamma(n / 2) * x**(n / 2 - 1) * np.exp(-x / 2)


def beta(x, a, b):                # for 0 < x < 1
    return (math.gamma(a + b) / (math.gamma(a) * math.gamma(b))
            * x**(a - 1) * (1 - x)**(b - 1))


# the curves fs against x, with a legend when there is more than one
STYLES = [dict(color="#3172AE", linestyle="-"),    # the same colours and line
          dict(color="#D55E00", linestyle="--"),   # styles as the plots in the
          dict(color="#404040", linestyle=":")]    # notes


def curves(ax, x, fs, labels, title, xlabel="x", ylabel="f(x)"):
    for f, label, style in zip(fs, labels, STYLES):
        ax.plot(x, f, label=label, linewidth=2, **style)
    ax.set_title(title)
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.set_ylim(bottom=0)
    if len(fs) > 1:
        ax.legend()


fig, ax = plt.subplots(2, 4, figsize=(15, 6.5), layout="constrained")

x = np.linspace(-1.5, 3.5, 1001)
curves(ax[0, 0], x, [uniform(x, 0, 1), uniform(x, -1, 3)],
       ["a = 0, b = 1", "a = -1, b = 3"], "uniform")
ax[0, 0].set_ylim(0, 1.4)

x = np.linspace(0, 4, 401)
curves(ax[0, 1], x, [exponential(x, 0.5), exponential(x, 1), exponential(x, 2)],
       [r"$\lambda = 0.5$", r"$\lambda = 1$", r"$\lambda = 2$"], "exponential")

x = np.linspace(0, 15, 401)
curves(ax[0, 2], x, [gamma(x, 2, 1), gamma(x, 4, 1), gamma(x, 8, 1)],
       [r"$\alpha = 2,\ \lambda = 1$", r"$\alpha = 4,\ \lambda = 1$",
        r"$\alpha = 8,\ \lambda = 1$"], "gamma")

z = np.linspace(-3.5, 3.5, 401)
curves(ax[0, 3], z, [standard_normal(z)], [None], "standard normal",
       xlabel="z", ylabel=r"$\phi(z)$")

x = np.linspace(-5, 5, 401)
curves(ax[1, 0], x, [normal(x, 0, 1), normal(x, 0, 4), normal(x, 2, 0.25)],
       [r"$\mathcal{N}(0, 1)$", r"$\mathcal{N}(0, 4)$", r"$\mathcal{N}(2, 1/4)$"],
       "normal")

x = np.linspace(0, 16, 401)
curves(ax[1, 1], x, [chi_square(x, 2), chi_square(x, 4), chi_square(x, 8)],
       ["n = 2", "n = 4", "n = 8"], "chi-square")

x = np.linspace(0.001, 0.999, 999)   # the a = b = 1/2 density is infinite at 0 and 1
curves(ax[1, 2], x, [beta(x, 2, 5), beta(x, 2, 2), beta(x, 0.5, 0.5)],
       ["a = 2, b = 5", "a = 2, b = 2", "a = b = 1/2"], "beta")
ax[1, 2].set_ylim(0, 4.5)

ax[1, 3].axis("off")                 # seven distributions, eight panels

plt.show()                           # the script finishes when you close the window

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
