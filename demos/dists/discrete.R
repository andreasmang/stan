# discrete.R
#
# Plot the probability mass functions of the hypergeometric, Bernoulli,
# binomial, geometric, negative binomial, and Poisson distributions, with the
# same parameters as the plots in the notes. Uses R's built-in mass functions;
# some count differently from the notes (see README.md). Base R only; no
# packages needed.
#
# Disclaimer: the definitions of the distributions are based on a writeup by
# Prof. Dr. Subramanian Ramakrishnan at the University of Miami.
#
# Run:  source("discrete.R")     (in R or RStudio, from this folder)

blue <- "#3172AE"

# stem plot of the values f at the points x, titled with the name of the
# distribution and, on a second line, its parameters
stem <- function(x, f, name, params, ...) {
  plot(x, f, type = "h", lwd = 2, col = blue, ylim = c(0, max(f)),
       xlab = "x", ylab = "f(x)", main = name, ...)
  points(x, f, pch = 19, col = blue)
  mtext(params, side = 3, line = 0.25, cex = 0.8)
}

par(mfrow = c(2, 3))             # 2 rows, 3 columns of plots

# hypergeometric: m = 10 drawn from n = 50 objects, t = 20 of them marked;
# dhyper takes the numbers of marked (t) and unmarked (n - t) objects
x <- 0:10
stem(x, dhyper(x, 20, 30, 10), "hypergeometric", "n = 50, t = 20, m = 10")

# Bernoulli: a binomial with a single trial
x <- 0:1
stem(x, dbinom(x, 1, 0.3), "Bernoulli", "p = 0.3", xlim = c(-0.5, 1.5), xaxt = "n")
axis(1, at = x)

x <- 0:10
stem(x, dbinom(x, 10, 0.3), "binomial", "n = 10, p = 0.3")

# geometric: x = trials up to and including the first success;
# dgeom counts the failures before it, which is x - 1
x <- 1:12                        # the values go on forever; show the first 12
stem(x, dgeom(x - 1, 0.3), "geometric", "p = 0.3")

# negative binomial: x = trials up to and including the r-th success;
# dnbinom counts the failures before it, which is x - r
x <- 3:16
stem(x, dnbinom(x - 3, 3, 0.5), "negative binomial", "r = 3, p = 0.5")

x <- 0:10
stem(x, dpois(x, 3), "Poisson", expression(lambda == 3))

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
