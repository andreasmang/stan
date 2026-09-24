# Homework 0: toolchain smoke test

draw 1000 samples from N(0,1), report the sample mean, and plot a histogram. 
The four scripts do the same thing, so use whichever language you have installed.

| Language | File            | Run it from this folder             | Needs                 |
|----------|-----------------|-------------------------------------|-----------------------|
| Python   | `smoke_test.py` | `python3 smoke_test.py`             | `numpy`, `matplotlib` |
| MATLAB   | `smoke_test.m`  | type `smoke_test` at the prompt     | nothing extra         |
| Julia    | `smoke_test.jl` | `julia smoke_test.jl`               | `Plots`               |
| R        | `smoke_test.R`  | `Rscript smoke_test.R`              | nothing extra         |

Each script prints the sample mean and saves the histogram as `hw00-histogram.png`
in the folder you ran it from. The number goes in your PDF, and the script goes to 
`hw00-code` on Gradescope.

## Checking your output

The sample mean should be close to 0. Its standard error is 1/sqrt(1000), about
0.032, so a value between about -0.06 and 0.06 is typical. The histogram should be
a bell shape centered at 0, with nearly all of the samples between -3 and 3.

Each script fixes the random seed, so it prints the same number every time you run
it. The four languages use different random number generators, so their numbers
will not match each other, and they do not need to. Delete the seed line to get a
fresh draw.
