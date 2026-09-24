# plot_function.py
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 1 helper: plot a function.
#
# Evaluate sin(x) and cos(x) on a grid of points in [0, 2*pi] and plot both,
# with axis labels, a title, a legend, and a reference line at 0. The figure is
# saved as hw01-sine.png, ready to go into your PDF. Needs numpy and matplotlib.
#
# Run:  python3 plot_function.py

import numpy as np
import matplotlib.pyplot as plt

x = np.linspace(0, 2 * np.pi, 201)    # 201 equally spaced points from 0 to 2*pi
y = np.sin(x)                         # np.sin acts on every entry of x at once

plt.plot(x, y, label="sin(x)")
plt.plot(x, np.cos(x), linestyle="--", label="cos(x)")
plt.axhline(0, color="gray", linewidth=0.8)       # reference line at 0
plt.xlim(0, 2 * np.pi)
plt.xlabel("x")
plt.ylabel("f(x)")
plt.title(r"sin(x) and cos(x) on $[0, 2\pi]$")
plt.legend(loc="lower left")
plt.savefig("hw01-sine.png", dpi=150)             # save before plt.show(), not after
print("saved the figure as hw01-sine.png")
plt.show()                                        # the script finishes when you close the window

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
