# random_numbers.R
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 1 helper: random numbers.
#
# A random number generator produces a sequence of numbers that is fixed by its
# seed. This script shows that the same seed gives the same sequence and a
# different seed a different one, and it draws numbers from a few common
# distributions. It only prints; nothing is plotted or saved. Base R only; no
# packages needed.
#
# Run:  source("random_numbers.R")     (in R or RStudio, from this folder)

print_row <- function(label, x) {
  cat(sprintf("%-24s", label), sprintf("%9.4f", x), "\n", sep = "")
}

# ---- seeds and sequences -----------------------------------------------------
set.seed(2026); print_row("seed 2026", runif(5))
set.seed(2026); print_row("seed 2026 again", runif(5))   # the same five numbers
set.seed(7);    print_row("seed 7", runif(5))          # a different sequence
set.seed(NULL); print_row("no seed", runif(5))         # different every time you run this

# drawing more numbers continues the sequence; it does not start it over
set.seed(2026)
print_row("seed 2026, first 3", runif(3))
print_row("seed 2026, next 3", runif(3))    # starts with entries 4 and 5 above
cat("\n")

# ---- a few distributions, n = 5 draws each -----------------------------------
set.seed(0)
n <- 5
print_row("Uniform(0, 1)", runif(n))
print_row("Uniform(-1, 1)", runif(n, min = -1, max = 1))
print_row("N(0, 1)", rnorm(n))
print_row("N(3, 4)", rnorm(n, mean = 3, sd = 2))      # rnorm takes the sd 2, not the variance 4

# Exponential with rate 2, two ways. The inverse-CDF method: if U ~ Uniform(0, 1)
# and F is a CDF, then F^{-1}(U) has CDF F. Here F(x) = 1 - exp(-2x), so
# F^{-1}(u) = -log(1 - u)/2; and 1 - U is Uniform(0, 1) too, so -log(U)/2 works.
print_row("Exp(2), inverse CDF", -log(runif(n)) / 2)
print_row("Exp(2), built in", rexp(n, rate = 2))      # rexp takes the rate

rolls <- sample(1:6, 10, replace = TRUE)                      # integers 1 to 6
cat(sprintf("%-24s", "die rolls"), paste(rolls, collapse = " "), "\n", sep = "")

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
