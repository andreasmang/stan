%% mse_by_simulation.m
%  MATH 166 -- Statistics (Prof. Andreas Mang)
%  Homework 5 helper: the mean squared error (MSE) of an estimator, by simulation.
%
%  Draw a sample of size n = 10 from N(theta, 1) with theta = 2, and estimate the
%  center theta in two ways: by the sample median and by the sample mean.
%  Repeat this for 10,000 samples and average the squared errors (est - theta)^2;
%  that average estimates MSE = E[(est - theta)^2]. The MSE of the sample mean is
%  known exactly, sigma^2/n = 0.1, so the simulation can be checked against it.
%  The MSE of the sample median has no simple formula, which is what the
%  simulation is for. Both estimators are unbiased here, so the MSE is the variance.
%  Base MATLAB only; no toolboxes needed.
%
%  Run:  mse_by_simulation     (at the MATLAB prompt, from this folder)

rng(1);                              % reproducibility (remove for a fresh draw)

theta = 2;                           % the true center, which the estimators target
sigma = 1;
n = 10;                              % sample size
trials = 10000;                      % number of samples
est_median = zeros(trials, 1);       % room for one estimate per sample
est_mean = zeros(trials, 1);

for t = 1:trials                     % one fresh sample at a time
    x = theta + sigma*randn(n, 1);   % n draws from N(theta, sigma^2)
    est_median(t) = median(x);       % the estimators, computed from this one sample
    est_mean(t) = mean(x);
end

mse_median = mean((est_median - theta).^2);   % average squared error: estimates the MSE
mse_mean = mean((est_mean - theta).^2);
exact_mean = sigma^2 / n;            % MSE of the sample mean: no bias, variance sigma^2/n

bias_median = mean(est_median) - theta;
var_median = var(est_median, 1);     % the 1 divides by the number of trials
fprintf('sample median: simulated MSE %.4f   (bias^2 %.6f + variance %.4f)\n', ...
        mse_median, bias_median^2, var_median);
fprintf('sample mean:   simulated MSE %.4f   exact MSE %.4f\n', mse_mean, exact_mean);
fprintf('ratio MSE(median)/MSE(mean): %.2f\n', mse_median / exact_mean);

% -----------------------------------------------------------------------------
% This script is part of STAN (Statistics: Theory, Applications & Numerics),
% the code repository for MATH 166 at Tufts University:
% https://github.com/andreasmang/stan
