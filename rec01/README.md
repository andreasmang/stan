# Recitation 1: your first simulation

Flip a fair coin 1000 times and plot the running proportion of heads against the
number of flips. The four scripts do the same thing, so use whichever language you
have installed.

| Language | File                    | Run it from this folder                            | Needs                 |
|----------|-------------------------|----------------------------------------------------|-----------------------|
| Python   | `lln_demo.ipynb`        | open in [Colab](https://colab.research.google.com/github/andreasmang/stan/blob/main/rec01/lln_demo.ipynb), or in Jupyter or VS Code | nothing, in Colab |
| Python   | `running_proportion.py` | `python3 running_proportion.py`                    | `numpy`, `matplotlib` |
| MATLAB   | `running_proportion.m`  | type `running_proportion` at the prompt            | nothing extra         |
| Julia    | `running_proportion.jl` | `include("running_proportion.jl")` at the REPL     | `Plots`               |
| R        | `running_proportion.R`  | `source("running_proportion.R")` in R or RStudio   | nothing extra         |

`lln_demo.ipynb` is the version used in class: it runs in a browser through Colab with
nothing installed, plots one run, then five runs against the band of two standard errors,
and ends with a table of the 1/sqrt(n) rate. Its output is saved, so you can also just
read it here on GitHub.

Each script prints the proportion of heads after the last flip and shows the plot in
a window; nothing is written to disk. They are the take-home problem on the Recitation 1
sheet, with a fixed seed and the printout added.

Run the Julia and R scripts from inside Julia or R, not from a terminal. A script
started with `julia` closes its plot window as soon as it finishes, and `Rscript` has
no screen to draw on, so it saves the plot to a file called `Rplots.pdf` instead.

## Checking your output

The curve jumps around over the first few dozen flips, then settles toward 0.5, and
the wiggles keep shrinking as the number of flips grows. That is the law of large
numbers at work. After 1000 flips the proportion has standard error
sqrt(0.25/1000), about 0.016, so a final value between about 0.47 and 0.53 is
typical.

Each script fixes the random seed, so it prints the same number every time you run
it. The four languages use different random number generators, so their numbers
will not match each other, and they do not need to. Delete the seed line to get a
fresh run of flips.
