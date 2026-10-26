# Recitation 7: size, power, and the delta method

The take-home problem on the Recitation 7 sheet.

| Language | File                 | Run it                                          | Needs             |
|----------|----------------------|-------------------------------------------------|-------------------|
| Python   | `testing_demo.ipynb` | open in [Colab](https://colab.research.google.com/github/andreasmang/stan/blob/main/recitation/rec07/testing_demo.ipynb), or in Jupyter or VS Code | nothing, in Colab |

The notebook has five short sections:

1. the power function of the coin test "reject H0: p <= 1/2 if S >= c" for n = 10 tosses and
   c = 7, 8, 9, with the size and the power at p = 0.7;
2. the same numbers by simulation, 20000 repetitions of the experiment;
3. tests of level 0.05 for n = 10, 40, 160 tosses: the power curves get steeper;
4. a simulation check of the delta-method standard error of P(X > 1) = exp(-lambda) for
   exponential data (Problem 2 on the sheet), and how often its 95% interval covers;
5. a look ahead: 20 tests at level 0.05 when every null hypothesis is true.

Every cell marked `# <-` has a number worth changing. The output is saved, so you can also
just read the notebook here on GitHub. The random seed is fixed; delete the `0` in
`default_rng(0)` for a fresh draw.

## Checking your output

| c | size = P(S >= c) at p = 1/2 | power at p = 0.7 |
|---|-----------------------------|------------------|
| 7 | 0.172                       | 0.650            |
| 8 | 0.055                       | 0.383            |
| 9 | 0.011                       | 0.149            |

For the level 0.05 tests, the power at p = 0.7 is 0.149 (n = 10), 0.807 (n = 40) and
0.9998 (n = 160). In Section 4 the delta method overstates the spread by about 13% for
n = 5, and agrees to within 1% for n = 50; the 95% interval covers about 86% and 94% of
the time. In Section 5, at least one of 20 tests rejects about 64% of the time
(exactly 1 - 0.95^20 = 0.642).
