# plot_function.jl
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 1 helper: plot a function.
#
# Evaluate sin(x) and cos(x) on a grid of points in [0, 2*pi] and plot both,
# with axis labels, a title, a legend, and a reference line at 0. The figure is
# saved as hw01-sine.png, ready to go into your PDF. Needs the Plots package.
#
# Run:  include("plot_function.jl")   (at the Julia REPL, from this folder)

using Plots

x = range(0, 2π; length = 201)   # 201 equally spaced points from 0 to 2π (type 2\pi, then Tab)
y = sin.(x)                      # the dot applies sin to every entry of x

p = plot(x, y; label = "sin(x)", linewidth = 2, xlabel = "x", ylabel = "f(x)",
         title = "sin(x) and cos(x) on [0, 2π]", xlims = (0, 2π), legend = :bottomleft)
plot!(p, x, cos.(x); label = "cos(x)", linewidth = 2, linestyle = :dash)
hline!(p, [0]; color = :gray, label = "")          # reference line at 0
savefig(p, "hw01-sine.png")
println("saved the figure as hw01-sine.png")
display(p)

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
