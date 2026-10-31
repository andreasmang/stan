%% wald_by_simulation.m
%  MATH 166 -- Statistics (Prof. Andreas Mang)
%  Homework 6 helper: a Wald test and its p-value, repeated by simulation.
%
%  Draw a sample of size n = 25 from the exponential distribution with mean theta,
%  and test H0: theta = 1 against H1: theta != 1 with the Wald test. The estimate is
%  the sample mean. Its standard error is theta/sqrt(n), which we estimate by
%  xbar/sqrt(n), so W = (xbar - 1)/(xbar/sqrt(n)) and the p-value is 2*Phi(-|W|).
%  Repeat this for 10,000 samples, keep W and the p-value of each, plot a histogram
%  of W, and print how often the test rejects. Change theta to see what happens
%  when H0 is false.
%  Base MATLAB only; no toolboxes needed.
%
%  Run:  wald_by_simulation     (at the MATLAB prompt, from this folder)

rng(1);                              % reproducibility (remove for a fresh draw)

theta = 1;                           % the true mean: change this to make H0 false
theta0 = 1;                          % the value of theta under H0
n = 25;                              % sample size
trials = 10000;                      % number of samples
W = zeros(trials, 1);                % room for one statistic per sample
p = zeros(trials, 1);                % room for one p-value per sample

for t = 1:trials                     % one fresh sample at a time
    x = -theta*log(rand(n, 1));      % n draws from the exponential with mean theta
    xbar = mean(x);                  % the estimate, computed from this one sample
    se = xbar / sqrt(n);             % its estimated standard error
    W(t) = (xbar - theta0) / se;     % the Wald statistic
    p(t) = erfc(abs(W(t))/sqrt(2));  % the two-sided p-value: this equals 2*Phi(-|W|)
end

fprintf('true mean %g, H0: theta = %g, n = %d\n', theta, theta0, n);
fprintf('fraction with |W| > 1.96: %.4f\n', mean(abs(W) > 1.96));
fprintf('fraction with p < .05:    %.4f\n', mean(p < 0.05));
fprintf('fraction with p < .01:    %.4f\n', mean(p < 0.01));

figure;
histogram(W, 40);                    % 40 bins of equal width
xline(-1.96, '--');
xline(1.96, '--');                   % the test rejects outside these lines
xlabel('W'); ylabel('number of samples');
title(sprintf('the Wald statistic, true mean %g', theta));

% -----------------------------------------------------------------------------
% This script is part of STAN (Statistics: Theory, Applications & Numerics),
% the code repository for MATH 166 at Tufts University:
% https://github.com/andreasmang/stan
