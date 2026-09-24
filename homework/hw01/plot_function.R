# plot_function.R
# MATH 166 -- Statistics (Prof. Andreas Mang)
# Homework 1 helper: plot a function.
#
# Evaluate sin(x) and cos(x) on a grid of points in [0, 2*pi] and plot both,
# with axis labels, a title, a legend, and a reference line at 0. The figure is
# saved as hw01-sine.png, ready to go into your PDF. Base R only; no packages
# needed.
#
# Run:  source("plot_function.R")     (in R or RStudio, from this folder)

x <- seq(0, 2 * pi, length.out = 201)    # 201 equally spaced points from 0 to 2*pi
y <- sin(x)                               # sin acts on every entry of x at once

# the plot, as a function, so that we can draw it twice: on the screen and into a file
draw_plot <- function() {
  plot(x, y, type = "l", lwd = 2, xlab = "x", ylab = "f(x)",
       main = "sin(x) and cos(x) on [0, 2*pi]")
  lines(x, cos(x), lwd = 2, lty = 2)
  abline(h = 0, col = "gray")                                # reference line at 0
  legend("bottomleft", legend = c("sin(x)", "cos(x)"), lwd = 2, lty = c(1, 2),
         bty = "n")
}

draw_plot()                                                  # on the screen

png("hw01-sine.png", width = 960, height = 720, res = 150)   # open a file to draw into
draw_plot()
invisible(dev.off())                                         # close it: this writes the file
cat("saved the figure as hw01-sine.png\n")

# -----------------------------------------------------------------------------
# This script is part of STAN (Statistics: Theory, Applications & Numerics),
# the code repository for MATH 166 at Tufts University:
# https://github.com/andreasmang/stan
