# random_numbers.jl
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 1 helper: random numbers.
#
# A random number generator produces a sequence of numbers that is fixed by its
# seed. This script shows that the same seed gives the same sequence and a
# different seed a different one, and it draws numbers from a few common
# distributions. It only prints; nothing is plotted or saved. Needs no packages.
#
# Run:  include("random_numbers.jl")   (at the Julia REPL, from this folder)

using Random, Printf

print_row(label, x) = println(rpad(label, 24), join(@sprintf("%9.4f", v) for v in x))

# ---- seeds and sequences -----------------------------------------------------
Random.seed!(42); print_row("seed 42", rand(5))
Random.seed!(42); print_row("seed 42 again", rand(5))   # the same five numbers
Random.seed!(7);  print_row("seed 7", rand(5))          # a different sequence
Random.seed!();   print_row("no seed", rand(5))         # different every time you run this

# drawing more numbers continues the sequence; it does not start it over
Random.seed!(42)
print_row("seed 42, first 3", rand(3))
print_row("seed 42, next 3", rand(3))    # starts with entries 4 and 5 above
println()

# ---- a few distributions, n = 5 draws each -----------------------------------
Random.seed!(0)
n = 5
print_row("Uniform(0, 1)", rand(n))
print_row("Uniform(-1, 1)", -1 .+ 2 .* rand(n))       # a + (b - a) * U
print_row("N(0, 1)", randn(n))
print_row("N(3, 4)", 3 .+ 2 .* randn(n))              # mean + sd * Z: sd = 2, not 4

# Exponential with rate 2, two ways. The inverse-CDF method: if U ~ Uniform(0, 1)
# and F is a CDF, then F^{-1}(U) has CDF F. Here F(x) = 1 - exp(-2x), so
# F^{-1}(u) = -log(1 - u)/2; and 1 - U is Uniform(0, 1) too, so -log(U)/2 works.
print_row("Exp(2), inverse CDF", -log.(rand(n)) ./ 2)
print_row("Exp(2), built in", randexp(n) ./ 2)        # randexp draws Exp(1); divide by the rate

rolls = rand(1:6, 10)                                         # integers 1 to 6
println(rpad("die rolls", 24), join(rolls, " "))

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
