# Common distributions

Plot the mass functions and densities of the common distributions. Change the numbers
to see how each distribution changes shape. The Python and R scripts draw the same
plots, so use whichever language you have installed.

**Disclaimer:** the definitions of the distributions are based on a writeup by 
Prof. Dr. Subramanian Ramakrishnan at the University of Miami.

| Language | File            | Run it from this folder                       | Needs                 |
|----------|-----------------|-----------------------------------------------|-----------------------|
| Python   | `discrete.py`   | `python3 discrete.py`                         | `matplotlib`          |
| Python   | `continuous.py` | `python3 continuous.py`                       | `numpy`, `matplotlib` |
| Python   | `discrete.ipynb`   | open in Jupyter or VS Code                 | `matplotlib`, Jupyter |
| Python   | `continuous.ipynb` | open in Jupyter or VS Code                 | `numpy`, `matplotlib`, Jupyter |
| R        | `discrete.R`    | `source("discrete.R")` in R or RStudio        | nothing extra         |
| R        | `continuous.R`  | `source("continuous.R")` in R or RStudio      | nothing extra         |

`discrete` plots the hypergeometric, Bernoulli, binomial, geometric, negative
binomial, and Poisson mass functions. `continuous` plots the uniform,
exponential, gamma, standard normal, normal, chi-square, and beta densities.

The notebooks put the notes from Appendix A next to the code. Each distribution
has its formulas, mean, variance, and moment generating function; a cell that plots
it; and a check that the total probability, mean, and variance computed from f(x)
match the notes. The plots are saved inside the notebooks, so you can read them
(on GitHub, for example) without running anything. To run them yourself, install
Jupyter with `python3 -m pip install notebook` and start it with
`python3 -m notebook`, or open the notebooks in VS Code.

Each script shows its plots in one window; nothing is written to disk. Run the R
scripts from inside R, not from a terminal: `Rscript` has no screen to draw on, so
it saves the plots to a file called `Rplots.pdf` instead. If the legends in the R
plots cover the curves, make the plot window wider (in RStudio, click Zoom).

## Formulas and built-in functions

The Python scripts type in each formula from the notes, so you can read the two side
by side. The R scripts call R's built-in functions instead, and in your own code you
will usually want those, or their Python counterparts in `scipy.stats`. Several of
them take different parameters than the notes. Each row below gives the call that
matches f(x) in the notes:

| Notes                   | R                                         | Python (`from scipy import stats`)        |
|-------------------------|-------------------------------------------|-------------------------------------------|
| hypergeometric(n, t, m) | `dhyper(x, t, n - t, m)`                  | `stats.hypergeom.pmf(x, n, t, m)`         |
| Bernoulli(p)            | `dbinom(x, 1, p)`                         | `stats.bernoulli.pmf(x, p)`               |
| binomial(n, p)          | `dbinom(x, n, p)`                         | `stats.binom.pmf(x, n, p)`                |
| geometric(p)            | `dgeom(x - 1, p)`                         | `stats.geom.pmf(x, p)`                    |
| negative binomial(r, p) | `dnbinom(x - r, r, p)`                    | `stats.nbinom.pmf(x - r, r, p)`           |
| Poisson(λ)              | `dpois(x, lambda)`                        | `stats.poisson.pmf(x, lam)`               |
| uniform(a, b)           | `dunif(x, a, b)`                          | `stats.uniform.pdf(x, a, b - a)`          |
| exponential(λ)          | `dexp(x, rate = lambda)`                  | `stats.expon.pdf(x, scale=1/lam)`         |
| gamma(α, λ)             | `dgamma(x, shape = alpha, rate = lambda)` | `stats.gamma.pdf(x, alpha, scale=1/lam)`  |
| standard normal         | `dnorm(z)`                                | `stats.norm.pdf(z)`                       |
| normal(μ, σ²)           | `dnorm(x, mu, sqrt(sigma2))`              | `stats.norm.pdf(x, mu, np.sqrt(sigma2))`  |
| chi-square(n)           | `dchisq(x, n)`                            | `stats.chi2.pdf(x, n)`                    |
| beta(a, b)              | `dbeta(x, a, b)`                          | `stats.beta.pdf(x, a, b)`                 |

Three things to watch for:

* **Trials or failures.** In the notes, a geometric or negative binomial X counts the
  trials up to and including the first (r-th) success. R's `dgeom` and `dnbinom`, and
  `stats.nbinom`, count the failures before it, which is X - 1 (X - r).
  `stats.geom` counts trials, like the notes.
* **Standard deviation, not variance.** `dnorm` and `stats.norm` take σ, so
  N(0, 4) is `dnorm(x, 0, 2)`.
* **Rate or scale.** The notes use the rate λ for the exponential and gamma
  distributions, and so do R's `dexp` and `dgamma`. `scipy.stats` uses the scale
  1/λ, and so does Wasserman, who writes it β.

The same parameters go into the CDF, quantile, and sampling functions: `pbinom`,
`qbinom`, `rbinom` in R, and `.cdf`, `.ppf`, `.rvs` in `scipy.stats`.

## Checking your output

The plots should match the ones in the notes. A quick check on a mass function
is that its values add up to 1 over all x; a sum a little below 1 is fine for
the geometric, negative binomial, and Poisson plots, which show only the first
values of x.
