# Homework 1: helper scripts

Four short scripts with the pieces you need for the programming problem on
Homework 1: plotting a function, drawing random numbers, computing an average, and
looping over sample sizes. They are not the solution: they use other distributions
and other numbers than the problem does. Each script exists in Python, MATLAB,
Julia, and R, and the versions do the same thing, so use whichever language you
have installed.

**Never written a program before?** Start with the notebook `walkthrough.ipynb`. It
builds one complete small program from nothing, one line at a time, explaining what
each line does, and it answers a different question than the homework (how the
average of die rolls settles down). You can read it here on GitHub without installing
anything, or run it in your browser with
[Colab](https://colab.research.google.com/github/andreasmang/stan/blob/main/hw01/walkthrough.ipynb).

| Script           | What it shows                                                                                                                                  |
|------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| `plot_function`  | evaluate sin(x) and cos(x) on a grid of points, plot them with labels, a legend, and a reference line, and save the figure as `hw01-sine.png` |
| `random_numbers` | the same seed gives the same sequence of random numbers, a different seed a different one; draws from uniform, normal, and exponential distributions and a die |
| `sample_average` | the average of 1000 random numbers computed three ways: by hand with a loop, as sum/n, and with the built-in mean                              |
| `mean_vs_n`      | a loop over the sample sizes n = 5, 10, ..., 1000 that stores one average per n and plots the averages against n                               |
| `walkthrough.ipynb` | a notebook (Python only) that builds a whole small program step by step, with the output of every step and a troubleshooting list          |

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

The notebook is Python. Open it in Jupyter (`python3 -m pip install notebook`, then
`python3 -m notebook`) or in VS Code, or click the Colab link above to run it in a
browser with nothing installed. Run its cells in order, from the top.

## Putting the pieces together

If you have not programmed before, the hard part is not any single line, it is
turning the problem into a program. The notebook `walkthrough.ipynb` does exactly
this, step by step, for a question of the same shape; work through it first and then
come back here. In short: write the program in English first. The programming
problem on Homework 1 has five steps:

1. make the list of sample sizes;
2. make room to store one number for each sample size;
3. for each sample size: draw that many random numbers, average them, and store
   the average;
4. plot the stored averages against the sample size;
5. do the same for the second distribution.

Each step is in one of the four scripts:

| Step                                   | Script           | What to look at                          |
|----------------------------------------|------------------|------------------------------------------|
| 1. the list of sample sizes            | `mean_vs_n`      | the line that builds `nvals`             |
| 2. room to store one result per size   | `mean_vs_n`      | the line that builds `avg`               |
| 3. draw that many random numbers       | `random_numbers` | the "a few distributions" block          |
| 3. average them                        | `sample_average` | the three ways to take a mean            |
| 3. the loop that fills in the results  | `mean_vs_n`      | the `for` loop                           |
| 4. plot, label, and save the figure    | `plot_function`  | the plotting block                       |

Start from `mean_vs_n` and change it. It already loops over sample sizes, stores
one number per size, and plots the result, which is the shape you need; mostly you
change which distribution is drawn and what the axis labels say.

Four habits that make this much easier:

* **Run after every step.** Do not write the whole program and then run it. Add a
  line or two, run it, look at the output, then add the next line.
* **Start small, then grow.** Use ten sample sizes up to 100 before you use a
  thousand of them up to 10000. A mistake then shows up in a second instead of a
  minute, and the numbers are small enough to check by eye.
* **Print what you have.** If you are not sure what is in a variable, print it, and
  print how many entries it has. Take the prints out at the end.
* **Read an error from the bottom up.** The last line says what went wrong, and the
  line above it usually says which line of your code caused it.

If you are stuck for more than ten or fifteen minutes, that is what office hours and
recitation are for. Bring the code that does not work; a broken attempt is a much
better starting point than a blank page.

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
