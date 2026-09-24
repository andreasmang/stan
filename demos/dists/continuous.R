# continuous.R
#
# Plot the densities of the uniform, exponential, gamma, standard normal,
# normal, chi-square, and beta distributions, with the same parameters as the
# plots in the notes. Uses R's built-in densities; some take different
# parameters from the notes (see README.md). Base R only; no packages needed.
#
# Disclaimer: the definitions of the distributions are based on a writeup by
# Prof. Dr. Subramanian Ramakrishnan at the University of Miami.
#
# Run:  source("continuous.R")     (in R or RStudio, from this folder)

cols <- c("#3172AE", "#D55E00", "#404040")   # the same colours and line styles
ltys <- c(1, 2, 3)                           # as the plots in the notes

# the columns of f against x, with a legend when there is more than one
curves <- function(x, f, labels, title, where = "topright",
                   xlab = "x", ylab = "f(x)", ylim = NULL, ...) {
  f <- as.matrix(f)
  if (is.null(ylim))             # with a legend, leave room for it at the top
    ylim <- c(0, max(f) * (if (ncol(f) > 1) 1.5 else 1))
  matplot(x, f, type = "l", lty = ltys, col = cols, lwd = 2, ylim = ylim,
          xlab = xlab, ylab = ylab, main = title, ...)
  if (ncol(f) > 1)
    legend(where, legend = labels, lty = ltys, col = cols, lwd = 2, bty = "n",
           cex = 0.85)
}

par(mfrow = c(2, 4))             # 2 rows, 4 columns of plots

x <- seq(-1.5, 3.5, length.out = 1001)
curves(x, cbind(dunif(x, 0, 1), dunif(x, -1, 3)),
       c("a = 0, b = 1", "a = -1, b = 3"), "uniform", ylim = c(0, 1.4))

# dexp and dgamma take the rate lambda, as in the notes
x <- seq(0, 4, length.out = 401)
curves(x, cbind(dexp(x, rate = 0.5), dexp(x, rate = 1), dexp(x, rate = 2)),
       expression(lambda == 0.5, lambda == 1, lambda == 2), "exponential")

x <- seq(0, 15, length.out = 401)
curves(x, cbind(dgamma(x, shape = 2, rate = 1), dgamma(x, shape = 4, rate = 1),
                dgamma(x, shape = 8, rate = 1)),
       expression(list(alpha == 2, lambda == 1), list(alpha == 4, lambda == 1),
                  list(alpha == 8, lambda == 1)), "gamma")

z <- seq(-3.5, 3.5, length.out = 401)
curves(z, dnorm(z), NULL, "standard normal", xlab = "z", ylab = expression(phi(z)))

# dnorm takes the standard deviation sigma, not the variance sigma^2
x <- seq(-5, 5, length.out = 401)
curves(x, cbind(dnorm(x, 0, 1), dnorm(x, 0, 2), dnorm(x, 2, 0.5)),
       c("N(0, 1)", "N(0, 4)", "N(2, 1/4)"), "normal", where = "topleft")

x <- seq(0, 16, length.out = 401)
curves(x, cbind(dchisq(x, 2), dchisq(x, 4), dchisq(x, 8)),
       c("n = 2", "n = 4", "n = 8"), "chi-square")

x <- seq(0.001, 0.999, length.out = 999)   # the a = b = 1/2 density is infinite at 0 and 1
curves(x, cbind(dbeta(x, 2, 5), dbeta(x, 2, 2), dbeta(x, 0.5, 0.5)),
       c("a = 2, b = 5", "a = 2, b = 2", "a = b = 1/2"), "beta",
       where = "top", ylim = c(0, 4.5))

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
