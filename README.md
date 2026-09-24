# STAN

**Statistics: Theory, Applications & Numerics**

Code that accompanies MATH 166 (Statistics) at Tufts University, Department of
Mathematics. The repository holds short programs that support the programming
problems on the homework: you generate data from a model you specify, then check an
analytical result against it.

## Who this is for

Students taking MATH 166. No prior experience with numerical programming is
assumed. Programming is a component of this course, not the bulk of it: roughly one
homework assignment in three carries a programming problem.

## Languages

Examples are written in Python, MATLAB, or R, which are the three languages
accepted for homework. Julia versions are included as well. Where the same example
exists in more than one language, the versions do the same thing.

Python examples assume `numpy`, `scipy`, and `matplotlib`. Julia examples assume
`Plots`. R examples use the base distribution. Download links and install steps are
in [`homework/hw00/README.md`](homework/hw00/README.md).


## Getting set up

You only need to do this once.

### Python

Notice that there are definitely other options to obtain these software packages.
If you like to use a different installation, by all means go ahead and use 
that. Notice that python allows for virtual environments so that you do not
need root access to do installations of packages.

Download Python from <https://www.python.org/downloads/>. Then install `numpy` and
`matplotlib` from a terminal:

```sh
python3 -m pip install numpy matplotlib
```

Typing `python3 -m pip` rather than `pip` installs the packages for the same Python
that runs the script. On Windows, type `python` instead of `python3`, here and in the
table above. If you use [Anaconda](https://www.anaconda.com/download), both packages
are already included.

### MATLAB

Tufts has a campus-wide license, so MATLAB is free for students. Sign in with your
Tufts email at the
[Tufts MATLAB portal](https://www.mathworks.com/academia/tah-portal/tufts-university-974035.html)
and download the installer.
[Tufts Technology Services](https://it.tufts.edu/guides/mathworksmatlab-installation-and-activation/matlab-campus-license)
has step-by-step instructions. Nothing else needs to be installed.

### Julia

Install Julia by following <https://julialang.org/install/>. Then start `julia` and
install `Plots`, which takes a few minutes the first time:

```julia
import Pkg; Pkg.add("Plots")
```

### R

Download R from <https://cran.r-project.org/>. Nothing else needs to be installed.
[RStudio](https://posit.co/download/rstudio-desktop/) is a free editor that makes R
easier to work with, but you do not need it.



## Using it

```sh
git clone https://github.com/andreasmang/stan.git
```

The repository is organised into three folders:

| Folder        | What is in it                                                                 |
|---------------|-------------------------------------------------------------------------------|
| `homework/`   | one folder per assignment (`hw00/`, `hw01/`, ...), with one script per language |
| `recitation/` | one folder per recitation (`rec01/`, `rec02/`, ...)                             |
| `demos/`      | worked examples that are not tied to an assignment                              |

Each folder has a short README of its own. Material is added section by section as
the course moves through the syllabus, so pull before you start an assignment.

`demos/` currently holds `insurance.ipynb` (the law of large numbers and the central
limit theorem applied to risk pooling), `bias_variance.ipynb` (when a biased estimator
beats an unbiased one) and `dists/` (the mass functions and densities of the common
distributions, the companion to Appendix A of the lecture notes, which has scripts as
well as notebooks and so keeps a folder of its own).

Each demo notebook carries its own description, and its output is saved, so it can be
read straight through on GitHub without running anything, or opened in Colab with
nothing installed.

## What is not here

Solutions to graded homework problems or exams. Assignments are posted on Canvas
and handed in there.

## Course links

* Course website: <https://andreasmang.github.io/teaching>
* Canvas: <https://canvas.tufts.edu>
* Textbook: Larry Wasserman, *All of Statistics: A Concise Course in Statistical
  Inference*, 2nd ed., Springer (2005)

## Contact

Prof. Dr. Andreas Mang, <andreas.mang@tufts.edu>
