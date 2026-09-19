# Homework 1: helper scripts

Four short scripts with the pieces you need for the programming problem on
Homework 1: plotting a function, drawing random numbers, computing an average, and
looping over sample sizes. They are not the solution: they use other distributions
and other numbers than the problem does. Each script exists in Python, MATLAB,
Julia, and R, and the versions do the same thing, so use whichever language you
have installed.

| Script           | What it shows                                                                                                                                  |
|------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| `plot_function`  | evaluate sin(x) and cos(x) on a grid of points, plot them with labels, a legend, and a reference line, and save the figure as `hw01-sine.png` |
| `random_numbers` | the same seed gives the same sequence of random numbers, a different seed a different one; draws from uniform, normal, and exponential distributions and a die |
| `sample_average` | the average of 1000 random numbers computed three ways: by hand with a loop, as sum/n, and with the built-in mean                              |
| `mean_vs_n`      | a loop over the sample sizes n = 5, 10, ..., 1000 that stores one average per n and plots the averages against n                               |

## Running them

Replace `plot_function` with the name of the script you want to run.

| Language | File               | Run it from this folder                      | Needs                 |
|----------|--------------------|----------------------------------------------|-----------------------|
| Python   | `plot_function.py` | `python3 plot_function.py`                   | `numpy`, `matplotlib` |
| MATLAB   | `plot_function.m`  | type `plot_function` at the prompt           | nothing extra         |
| Julia    | `plot_function.jl` | `include("plot_function.jl")` at the REPL    | `Plots`               |
| R        | `plot_function.R`  | `source("plot_function.R")` in R or RStudio  | nothing extra         |

`random_numbers` and `sample_average` only print. `plot_function` and `mean_vs_n`
also show a plot in a window, and `plot_function` saves it as `hw01-sine.png` in the
folder you ran it from.

Run the Julia and R scripts from inside Julia or R, not from a terminal. A script
started with `julia` closes its plot window as soon as it finishes, and `Rscript` has
no screen to draw on, so it saves the plot to a file called `Rplots.pdf` instead.

## Which function does what

| Task                          | Python (`numpy`, `matplotlib.pyplot`) | MATLAB                          | R                               | Julia                        |
|-------------------------------|---------------------------------------|---------------------------------|---------------------------------|------------------------------|
| 201 points from a to b        | `np.linspace(a, b, 201)`              | `linspace(a, b, 201)`           | `seq(a, b, length.out = 201)`   | `range(a, b; length = 201)`  |
| n = 5, 10, ..., 1000          | `np.arange(5, 1001, 5)`               | `5:5:1000`                      | `seq(5, 1000, by = 5)`          | `5:5:1000`                   |
| fix the seed                  | `rng = np.random.default_rng(42)`     | `rng(42)`                       | `set.seed(42)`                  | `Random.seed!(42)`           |
| n draws from Uniform(0, 1)    | `rng.random(n)`                       | `rand(n, 1)`                    | `runif(n)`                      | `rand(n)`                    |
| n draws from N(0, 1)          | `rng.standard_normal(n)`              | `randn(n, 1)`                   | `rnorm(n)`                      | `randn(n)`                   |
| n draws from N(μ, σ²)         | `mu + sigma * rng.standard_normal(n)` | `mu + sigma*randn(n, 1)`        | `rnorm(n, mu, sigma)`           | `mu .+ sigma .* randn(n)`    |
| n draws from Exponential(λ)   | `rng.exponential(1/lam, n)`           | `-log(rand(n, 1))/lam`          | `rexp(n, lam)`                  | `randexp(n) ./ lam`          |
| n rolls of a die              | `rng.integers(1, 7, n)`               | `randi(6, n, 1)`                | `sample(1:6, n, replace = TRUE)`| `rand(1:6, n)`               |
| average of x                  | `np.mean(x)`                          | `mean(x)`                       | `mean(x)`                       | `mean(x)`                    |
| room for n results            | `np.zeros(n)`                         | `zeros(n, 1)`                   | `numeric(n)`                    | `zeros(n)`                   |
| line plot of y against x      | `plt.plot(x, y)`                      | `plot(x, y)`                    | `plot(x, y, type = "l")`        | `plot(x, y)`                 |
| horizontal line at 0          | `plt.axhline(0)`                      | `yline(0)`                      | `abline(h = 0)`                 | `hline!([0])`                |
| save the figure               | `plt.savefig("f.png")`                | `exportgraphics(gcf, "f.png")`  | `png("f.png")`, plot, `dev.off()` | `savefig("f.png")`         |

In Julia, `Random.seed!` and `randexp` need `using Random`, and `mean` needs
`using Statistics`; both come with Julia. `import numpy as np` and
`import matplotlib.pyplot as plt` give the short names used in the Python column.

A few things to watch for:

* **Counting from 0 or from 1.** Python numbers the entries of an array 0, 1, 2, ...
  and leaves the end point out of `np.arange` and `rng.integers`: `rng.integers(1, 7)`
  rolls 1 to 6. MATLAB, R, and Julia count from 1 and include the end point.
* **Standard deviation, not variance.** To draw from N(μ, σ²), scale N(0, 1) draws
  by σ, the square root of the variance, and `rnorm` takes σ as well: N(3, 4) is
  `3 + 2 * Z` or `rnorm(n, 3, 2)`.
* **Rate or scale.** `numpy`'s `exponential` takes the scale 1/λ; R's `rexp` takes
  the rate λ.
* **Save before you show.** In Python, call `plt.savefig` before `plt.show()`: once
  you close the window, the figure is gone, and `savefig` writes an empty file.
* **The inverse-CDF method.** If U is Uniform(0, 1) and F is a CDF, then F⁻¹(U) has
  CDF F. `random_numbers` uses it to turn uniform numbers into exponential ones; it
  works for any distribution whose CDF you can invert.

## Checking your output

* `plot_function`: sin(x) starts at 0, reaches 1 at π/2, and crosses 0 again at π;
  cos(x) is the same curve shifted left by π/2.
* `random_numbers`: the first two rows are identical, the third is different, and the
  "no seed" row changes every time you run the script. The row "seed 2026, next 3"
  starts with the 4th and 5th numbers of the first row.
* `sample_average`: the three averages agree in the first 15 or so digits; the
  difference, if any, is around 1e-16, which is rounding error. The average is close
  to 1/2: its standard error is sqrt(1/12/1000), about 0.009, so a value between
  about 0.48 and 0.52 is typical.
* `mean_vs_n`: the averages jump around for small n and settle toward 1/2 as n
  grows, and about 95% of them fall inside the band of two standard errors. The
  script prints that proportion; anything between about 0.9 and 1 is fine.

Each script fixes the random seed, so it prints the same numbers every time you run
it. The four languages use different random number generators, so their numbers
will not match each other, and they do not need to. Delete the seed line to get a
fresh draw.
