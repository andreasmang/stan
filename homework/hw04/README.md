# Homework 4: helper scripts

Two short scripts with the pieces you need for the programming problem on
Homework 4: a loop over sample sizes with a second loop over trials inside it,
and the two ways of computing a variance. They are not the solution: they use a
different distribution and a different estimator than the problem does. Each
script exists in Python, MATLAB, Julia, and R, and the versions do the same thing,
so use whichever language you have installed. If loops and plots are new to you,
start with the Homework 1 helpers in `../hw01`.

| Script                | What it shows                                                                                                                         |
|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------|
| `average_over_trials` | for n = 3, 4, ..., 100, draw 100 samples of size n, compute an estimator on each, average the 100 values, and plot the averages against n with the exact expected value |
| `variance_two_ways`   | the variance of one sample computed by dividing by n and by n - 1, by hand and with each language's built-in function                  |

The estimator in `average_over_trials` is the square of a sample proportion, used to
estimate p² for a coin with P(heads) = p = 0.3. It is biased: its expected value is
p² + p(1 - p)/n, a little more than p², and the plot shows the averages settling onto
that curve as n grows. The homework asks the same kind of question about a different
estimator.

## Running them

Replace `average_over_trials` with the name of the script you want to run.

| Language | File                     | Run it from this folder                          | Needs                 |
|----------|--------------------------|--------------------------------------------------|-----------------------|
| Python   | `average_over_trials.py` | `python3 average_over_trials.py`                 | `numpy`, `matplotlib` |
| MATLAB   | `average_over_trials.m`  | type `average_over_trials` at the prompt         | nothing extra         |
| Julia    | `average_over_trials.jl` | `include("average_over_trials.jl")` at the REPL  | `Plots`               |
| R        | `average_over_trials.R`  | `source("average_over_trials.R")` in R or RStudio | nothing extra        |

`variance_two_ways` only prints. `average_over_trials` prints two lines and shows a
plot in a window. As for Homework 1, run the Julia and R scripts from inside Julia
or R, not from a terminal.

## Putting the pieces together

Write the program in English first. The programming problem on Homework 4 has five
steps:

1. make the list of sample sizes;
2. make room to store one number for each sample size;
3. for each sample size, repeat 100 times: draw a sample, compute the estimator on
   it, and keep the value; then store the average of the 100 values;
4. plot the stored averages against the sample size;
5. add the curve the theory predicts, to compare.

| Step                                        | Script                | What to look at                                   |
|---------------------------------------------|-----------------------|---------------------------------------------------|
| 1. the list of sample sizes                 | `average_over_trials` | the line that builds `nvals`                      |
| 2. room to store one result per size        | `average_over_trials` | the line that builds `avg_est`                    |
| 3. the two loops, one inside the other      | `average_over_trials` | the outer `for` over `k` and the inner `for` over `t` |
| 3. compute the estimator on one sample      | `variance_two_ways`   | the line that divides by n, not n - 1             |
| 4. plot the averages against n              | `average_over_trials` | the `plot` lines                                  |
| 5. the curve the theory predicts            | `average_over_trials` | the line that builds `exact`                      |

What changes for the homework: the distribution you draw from, the estimator you
compute on each sample, and the formula for the curve the theory predicts.

## Which function does what

| Task                                | Python (`numpy`, `matplotlib.pyplot`) | MATLAB                   | R                          | Julia                          |
|-------------------------------------|---------------------------------------|--------------------------|----------------------------|--------------------------------|
| n = 3, 4, ..., 100                  | `np.arange(3, 101)`                   | `3:100`                  | `3:100`                    | `3:100`                        |
| n draws from N(0, 1)                | `rng.standard_normal(n)`              | `randn(n, 1)`            | `rnorm(n)`                 | `randn(n)`                     |
| a 100 × n matrix of N(0, 1) draws   | `rng.standard_normal((100, n))`       | `randn(100, n)`          | `matrix(rnorm(100*n), 100)` | `randn(100, n)`               |
| average of each row of a matrix     | `np.mean(X, axis=1)`                  | `mean(X, 2)`             | `rowMeans(X)`              | `vec(mean(X; dims = 2))`       |
| variance, dividing by n             | `np.var(x)`                           | `var(x, 1)`              | `mean(x^2) - mean(x)^2`    | `var(x; corrected = false)`    |
| variance, dividing by n - 1         | `np.var(x, ddof=1)`                   | `var(x)`                 | `var(x)`                   | `var(x)`                       |
| room for n results                  | `np.zeros(n)`                         | `zeros(n, 1)`            | `numeric(n)`               | `zeros(n)`                     |
| line plot of y against x            | `plt.plot(x, y)`                      | `plot(x, y)`             | `plot(x, y, type = "l")`   | `plot(x, y)`                   |
| add a second curve                  | `plt.plot(x, y2)`                     | `hold on; plot(x, y2)`   | `lines(x, y2)`             | `plot!(x, y2)`                 |
| horizontal line at c                | `plt.axhline(c)`                      | `yline(c)`               | `abline(h = c)`            | `hline!([c])`                  |

In Julia, `var` and `mean` need `using Statistics`, which comes with Julia.

A few things to watch for:

* **Which variance.** The built-in functions do not agree on what they divide by:
  `np.var` divides by n, while MATLAB's `var`, R's `var`, and Julia's `var` divide by
  n - 1 unless told otherwise. `variance_two_ways` prints both so you can see the
  factor (n - 1)/n between them.
* **The matrix shortcut.** Instead of the inner loop over trials, you can draw all 100
  samples of size n at once as the rows of a 100 × n matrix and work row by row. Make
  sure the variance function works along rows too: in Python, `np.var(X, axis=1)`.
  The loop is easier to get right; use whichever you understand.
* **Reset inside the loop.** The room for the 100 values of one sample size (`est` in
  the script) is made inside the outer loop, so each sample size starts fresh.

## Checking your output

* `variance_two_ways`: the two "divide by n" lines agree with each other, the two
  "divide by n - 1" lines agree with each other, and their ratio is exactly
  (n - 1)/n = 0.8.
* `average_over_trials`: the averages jump around the curve of the exact value, more for small n,
  and settle onto it and toward p² = 0.09 as n grows. At n = 100 the average should
  be within about 0.005 of the exact value 0.0921. At n = 3 it can be off by 0.02 or
  so: 100 trials is not many when a single estimate can be anywhere from 0 to 1.

Each script fixes the random seed, so it prints the same numbers every time you run
it. The four languages use different random number generators, so their numbers
will not match each other, and they do not need to. Delete the seed line to get a
fresh draw.
