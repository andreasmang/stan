# Distances between distributions

How different are two distributions? These notebooks look at three ways to answer
that question, one at a time, and then compare them on the same examples.

| Notebook             | What it covers                                                                 |
|----------------------|--------------------------------------------------------------------------------|
| `lp.ipynb`           | L^r distances between densities and mass functions; total variation           |
| `kl.ipynb`           | the Kullback–Leibler divergence; why it is not symmetric; maximum likelihood   |
| `wasserstein.ipynb`  | the Wasserstein (earth mover's) distance; CDFs, quantiles, samples; the Kolmogorov distance |
| `probdistance.ipynb` | all of them side by side: shifts, non-overlapping supports, units, Pinsker's inequality, mixtures |

Read the first three in any order, then `probdistance.ipynb`.

The plots and printed results are saved inside the notebooks, so you can read them
(on GitHub, for example) without running anything. To run them, click the
**Open in Colab** link at the top of a notebook, or install Jupyter with
`python3 -m pip install notebook` and start it with `python3 -m notebook`, or open the
notebooks in VS Code. They need only `numpy` and `matplotlib`, and each one runs in a
few seconds.

Every integral is computed numerically on a fine grid and, where a formula exists,
checked against it. Each notebook ends with a few things to try.
