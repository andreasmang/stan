# Homework 5: helper script

One short script with the pieces you need for the simulation in Problem 1
(Chapter 9, #2(d)): estimating the mean squared error (MSE) of an estimator by
simulation. It is not the solution: it uses a different distribution and different
estimators than the problem does. The script exists in Python, MATLAB, Julia, and R,
and the versions do the same thing, so use whichever language you have installed.
If loops are new to you, start with the Homework 1 and Homework 4 helpers in
`../hw01` and `../hw04`.

| Script              | What it shows                                                                                                               |
|---------------------|-----------------------------------------------------------------------------------------------------------------------------|
| `mse_by_simulation` | draw 10,000 samples of size 10 from N(2, 1), compute two estimators of the center on each, and average their squared errors |

The two estimators are the sample median and the sample mean. The MSE of the sample
mean is known exactly, σ²/n = 1/10 = 0.1, so the script prints the simulated value
next to the exact one: that is how you know the simulation works. The MSE of the
sample median has no simple formula, and that is what a simulation is for. The
script also splits the simulated MSE into bias² + variance, to show that
MSE = bias² + variance holds for the simulated values too.

## Running it

| Language | File                   | Run it from this folder                         | Needs         |
|----------|------------------------|-------------------------------------------------|---------------|
| Python   | `mse_by_simulation.py` | `python3 mse_by_simulation.py`                  | `numpy`       |
| MATLAB   | `mse_by_simulation.m`  | type `mse_by_simulation` at the prompt          | nothing extra |
| Julia    | `mse_by_simulation.jl` | `include("mse_by_simulation.jl")` at the REPL   | nothing extra |
| R        | `mse_by_simulation.R`  | `source("mse_by_simulation.R")` in R or RStudio | nothing extra |

The script only prints; there is no plot.

## Putting the pieces together

Write the program in English first. A simulation of an MSE has four steps:

1. fix the true parameter, the sample size, and the number of samples;
2. make room to store one estimate per sample;
3. repeat many times: draw a sample, compute the estimator on it, and keep the value;
4. average the squared errors (estimate − true value)².

| Step                                     | What to look at in the script                 |
|------------------------------------------|-----------------------------------------------|
| 1. the true value, n, and the number of samples | the lines that set `theta`, `n`, and `trials` |
| 2. room for one estimate per sample      | the lines that build `est_median` and `est_mean` |
| 3. the loop over samples                 | the `for` loop over `t`                       |
| 4. the average squared error             | the lines that compute `mse_median` and `mse_mean` |

What changes for the homework: the distribution you draw from, the estimator you
compute on each sample, the true value it targets, and the exact MSE you compare with.
Work out the true value from the model before you simulate; the simulation cannot
tell you what it is.

## Which function does what

| Task                                 | Python (`numpy`)            | MATLAB              | R                    | Julia                       |
|--------------------------------------|-----------------------------|---------------------|----------------------|-----------------------------|
| n draws from N(μ, σ²)                | `mu + sigma * rng.standard_normal(n)` | `mu + sigma*randn(n, 1)` | `rnorm(n, mu, sigma)` | `mu .+ sigma .* randn(n)` |
| n draws from Uniform(a, b)           | `rng.uniform(a, b, n)`      | `a + (b - a)*rand(n, 1)` | `runif(n, a, b)` | `a .+ (b - a) .* rand(n)`   |
| smallest and largest value of x      | `np.min(x)`, `np.max(x)`    | `min(x)`, `max(x)`  | `min(x)`, `max(x)`   | `minimum(x)`, `maximum(x)`  |
| sample mean and median               | `np.mean(x)`, `np.median(x)` | `mean(x)`, `median(x)` | `mean(x)`, `median(x)` | `mean(x)`, `median(x)` |
| room for T results                   | `np.zeros(T)`               | `zeros(T, 1)`       | `numeric(T)`         | `zeros(T)`                  |
| average of the squared errors        | `np.mean((est - theta)**2)` | `mean((est - theta).^2)` | `mean((est - theta)^2)` | `mean((est .- theta) .^ 2)` |

In Julia, `mean`, `median`, and `var` need `using Statistics`, which comes with Julia.

A few things to watch for:

* **Square, then average.** The MSE is the average of the squared errors, not the
  square of the average error. The square of the average error is bias², which is
  close to 0 for an unbiased estimator.
* **Error against the true value.** Subtract the true value of the parameter, which
  you set in the script, not the average of the estimates. Subtracting the average
  gives the variance, which equals the MSE only when the estimator is unbiased.
* **Which variance.** If you check MSE = bias² + variance, the variance must divide by
  the number of samples, not by the number minus 1: `np.var(est)`, `var(est, 1)` in
  MATLAB, `var(est; corrected = false)` in Julia. R's `var` always divides by the
  number minus 1, so the R script computes the variance by hand. With 10,000 samples
  the difference is too small to see.

## Checking your output

* The simulated MSE of the sample mean is close to the exact value 0.1, usually within
  0.003 or so. The simulated MSE of the sample median is about 0.14, and so the median
  has about 1.4 times the MSE of the mean for normal data.
* The bias² of the sample median is close to 0, and its variance is close to its MSE:
  for normal data the median is an unbiased estimator of the center.
* With 10,000 samples, a simulated MSE is accurate to about two decimal places. More
  samples give more accuracy, but slowly: 100 times as many samples gives one more
  correct digit.

The script fixes the random seed, so it prints the same numbers every time you run
it. The four languages use different random number generators, so their numbers
will not match each other, and they do not need to. Delete the seed line to get a
fresh draw.
