# Homework 6: helper script

One short script with the pieces you need for the two simulations on Homework 6: the
computational problem on p-values and Chapter 10, #12(b). It runs a Wald test on many
samples, computes a p-value for each, plots a histogram, and counts how often the test
rejects. It is not the solution: it uses a different distribution and a different
standard error than the problems do, and it plots a histogram of W, not of the p-values.
The script exists in Python, MATLAB, Julia, and R, and the versions do the same thing,
so use whichever language you have installed. If loops and plots are new to you, start
with the Homework 1 and Homework 4 helpers in `../hw01` and `../hw04`.

| Script               | What it shows                                                                                                                                     |
|----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| `wald_by_simulation` | draw 10,000 samples of size 25 from an exponential distribution, run the Wald test of H0: θ = 1 on each, plot W, and print how often the test rejects |

Here θ is the mean of the exponential distribution. The estimate is the sample mean,
whose standard error θ/√n is estimated by x̄/√n, so

    W = (x̄ - 1) / (x̄/√n),    p = 2Φ(-|W|).

That standard error belongs to this model. Work out the right one for each problem
before you code it.

## Running it

| Language | File                    | Run it from this folder                          | Needs                   |
|----------|-------------------------|--------------------------------------------------|-------------------------|
| Python   | `wald_by_simulation.py` | `python3 wald_by_simulation.py`                  | `numpy`, `matplotlib`   |
| MATLAB   | `wald_by_simulation.m`  | type `wald_by_simulation` at the prompt          | nothing extra           |
| Julia    | `wald_by_simulation.jl` | `include("wald_by_simulation.jl")` at the REPL   | `Plots`, `Distributions` |
| R        | `wald_by_simulation.R`  | `source("wald_by_simulation.R")` in R or RStudio | nothing extra           |

The script prints four lines and shows a plot in a window. In Julia, install a missing
package once with `import Pkg; Pkg.add("Distributions")`.

## Putting the pieces together

Write the program in English first. A simulation of a test has four steps:

1. fix the true parameter, the value under H0, the sample size, and the number of samples;
2. make room to store one result per sample;
3. repeat many times: draw a sample, compute W from it, compute the p-value, and keep them;
4. summarize what you kept: a histogram, and the fractions of samples that meet a condition.

| Step                                  | What to look at in the script                       |
|---------------------------------------|-----------------------------------------------------|
| 1. the settings                       | the lines that set `theta`, `theta0`, `n`, and `trials` |
| 2. room for one result per sample     | the lines that build `W` and `p`                    |
| 3. the loop over samples              | the `for` loop over `t`                             |
| 4. the histogram and the fractions    | the printed fractions and the histogram call        |

What changes for the homework: the distribution you draw from, the estimate and its
standard error, the value under H0, and what you put in the histogram. For the problem
on p-values, the bins are the ones in the problem: 20 of equal width on [0, 1].

## Which function does what

| Task                                 | Python (`numpy`)              | MATLAB                | R                      | Julia                       |
|--------------------------------------|-------------------------------|-----------------------|------------------------|-----------------------------|
| n draws from N(μ, 1)                 | `mu + rng.standard_normal(n)` | `mu + randn(n, 1)`    | `rnorm(n, mean = mu)`  | `mu .+ randn(n)`            |
| n draws from the exponential with mean θ | `rng.exponential(theta, n)` | `-theta*log(rand(n, 1))` | `rexp(n, rate = 1/theta)` | `theta .* randexp(n)`    |
| n draws from Poisson(λ)              | `rng.poisson(lam, n)`         | `poissrnd(lam, n, 1)` (toolbox) | `rpois(n, lam)` | `rand(Poisson(lam), n)` (`Distributions`) |
| standard normal CDF Φ(x)             | `NormalDist().cdf(x)`, from `statistics` | `normcdf(x)` (toolbox) | `pnorm(x)`  | `cdf(Normal(), x)` (`Distributions`) |
| the p-value 2Φ(-\|W\|)               | `2 * Phi(-abs(W))`            | `erfc(abs(W)/sqrt(2))` | `2 * pnorm(-abs(W))`  | `2 * cdf(Normal(), -abs(W))` |
| fraction of p below .05              | `np.mean(p < 0.05)`           | `mean(p < 0.05)`      | `mean(p < 0.05)`       | `mean(p .< 0.05)`           |
| histogram with 20 bins on [0, 1]     | `plt.hist(p, bins=20, range=(0, 1))` | `histogram(p, 0:0.05:1)` | `hist(p, breaks = seq(0, 1, 0.05))` | `histogram(p; bins = 0:0.05:1)` |

The MATLAB functions marked "toolbox" need the Statistics and Machine Learning Toolbox.
`NormalDist().cdf` takes one number at a time, which is what the loop gives it; for a
whole array at once, use `scipy.stats.norm.cdf`.

A few things to watch for:

* **The p-value is two-sided.** Use the absolute value: 2Φ(-|W|). Without it, 2Φ(-W) is
  larger than 1 whenever W is negative, which no probability can be.
* **A fresh sample in every trial.** Draw inside the loop. A sample drawn once before
  the loop gives the same W every time.
* **Which parameter the function takes.** NumPy's `exponential` takes the mean, and R's
  `rexp` takes the rate, which is 1 over the mean.

## Checking your output

* With θ = 1 and n = 25, the exact probabilities are P(p < .05) = 0.0697 and
  P(p < .01) = 0.0305, computed from the fact that x̄ has a gamma distribution. With
  10,000 samples the simulated values usually land within 0.005 of them.
* The first two printed fractions agree, up to at most a sample or two: the test rejects
  when |W| > 1.96, which is the same as p < .05, except that 1.96 is a rounded value.
* The fractions are above .05 and .01 because this W is only approximately normal, and
  for skewed data and n = 25 the approximation is rough. The histogram shows it: the
  left tail is longer than the right. The exact P(p < .05) falls to 0.0600, 0.0550, and
  0.0513 for n = 50, 100, and 400.
* Set `theta = 1.5` to make H0 false. The fractions below .05 and .01 become about
  0.297 and 0.041.

The script fixes the random seed, so it prints the same numbers every time you run
it. The four languages use different random number generators, so their numbers
will not match each other, and they do not need to. Delete the seed line to get a
fresh draw.
