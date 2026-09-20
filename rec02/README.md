# Recitation 2: how fast does the central limit theorem kick in?

For n = 1, 5, and 30, draw 10000 samples of size n from the exponential
distribution with mean 1, standardize each sample mean, Z = sqrt(n) (xbar - 1), and
plot a histogram of the 10000 values against the N(0, 1) density. The four scripts
do the same thing, so use whichever language you have installed.

| Language | File                 | Run it from this folder                         | Needs                 |
|----------|----------------------|-------------------------------------------------|-----------------------|
| Python   | `clt_demo.ipynb`     | open in [Colab](https://colab.research.google.com/github/andreasmang/stan/blob/main/rec02/clt_demo.ipynb), or in Jupyter or VS Code | nothing, in Colab |
| Python   | `clt_exponential.py` | `python3 clt_exponential.py`                    | `numpy`, `matplotlib` |
| MATLAB   | `clt_exponential.m`  | type `clt_exponential` at the prompt            | nothing extra         |
| Julia    | `clt_exponential.jl` | `include("clt_exponential.jl")` at the REPL     | `Plots`               |
| R        | `clt_exponential.R`  | `source("clt_exponential.R")` in R or RStudio   | nothing extra         |

`clt_demo.ipynb` runs in a browser through Colab with nothing installed, draws
the same three histograms, prints the tail frequencies, and ends with the same
experiment for the uniform distribution, which needs a much smaller n. Its
output is saved, so you can also just read it here on GitHub.

Each script prints, for each n, how often Z > 1.645 and how often Z < -1.645, and
shows the three histograms in a window; nothing is written to disk. They are the
take-home problem on the Recitation 2 sheet, with a fixed seed and the printout added.

Run the Julia and R scripts from inside Julia or R, not from a terminal. A script
started with `julia` closes its plot window as soon as it finishes, and `Rscript` has
no screen to draw on, so it saves the plot to a file called `Rplots.pdf` instead.

## Checking your output

For n = 1 the histogram is the exponential density shifted left by 1: nothing
below -1 and a long right tail. By n = 5 it is bell-shaped but still skewed to the
right, and by n = 30 it is close to the normal curve. For a standard normal, both
printed frequencies would be 0.05. The exact values for the exponential are

| n  | P(Z > 1.645) | P(Z < -1.645) |
|----|--------------|---------------|
| 1  | 0.071        | 0.000         |
| 5  | 0.067        | 0.011         |
| 30 | 0.059        | 0.037         |

and with 10000 samples the printed frequencies land within about 0.005 of these.

The right tail is too heavy and the left tail too light, and both errors shrink as n
grows. Do not check the fit by counting how often |Z| > 1.96: for n = 1 that
frequency is already about 0.05, because the two errors cancel.

Each script fixes the random seed, so it prints the same numbers every time you run
it. The four languages use different random number generators, so their numbers
will not match each other, and they do not need to. Delete the seed line to get a
fresh draw.
