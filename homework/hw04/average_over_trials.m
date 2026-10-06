%% average_over_trials.m
%  MATH 166 -- Statistics (Prof. Andreas Mang)
%  Homework 4 helper: averaging an estimator over many trials, for many sample sizes.
%
%  Toss a coin that lands heads with probability p = 0.3 and estimate p^2 = 0.09
%  by the square of the sample proportion, est = (mean of the tosses)^2.
%  For n = 3, 4, ..., 100 draw 100 samples of size n, compute the estimate for
%  each sample, and average the 100 values; that average estimates E[est]. Plot it
%  against n, together with the exact value E[est] = p^2 + p(1 - p)/n and the true
%  value p^2. The estimator is biased: it overestimates p^2, by less as n grows.
%  Base MATLAB only; no toolboxes needed.
%
%  Run:  average_over_trials     (at the MATLAB prompt, from this folder)

rng(1);                              % reproducibility (remove for a fresh draw)

p = 0.3;
nvals = 3:100;                       % n = 3, 4, ..., 100
trials = 100;                        % samples per n
avg_est = zeros(size(nvals));        % room for one average per n, filled in below

for k = 1:numel(nvals)               % outer loop: one sample size at a time
    n = nvals(k);
    est = zeros(trials, 1);          % room for one estimate per trial
    for t = 1:trials                 % inner loop: one fresh sample at a time
        x = double(rand(n,1) < p);   % n coin tosses: 1 (heads) with probability p, else 0
        est(t) = mean(x)^2;          % the estimator, computed from this one sample
    end
    avg_est(k) = mean(est);          % average over the trials: estimates E[est]
end

exact = p^2 + p*(1 - p) ./ nvals;    % E[est] = p^2 + p(1 - p)/n

fprintf('n = %d:   average %.4f   exact %.4f   true p^2 = %.4f\n', nvals(1), avg_est(1), exact(1), p^2);
fprintf('n = %d: average %.4f   exact %.4f\n', nvals(end), avg_est(end), exact(end));

figure;
h1 = plot(nvals, avg_est); hold on;
h2 = plot(nvals, exact, 'LineWidth', 2);   % next default colour; visible in light and dark themes
h3 = yline(p^2, '--', 'Color', [0.5 0.5 0.5]);
hold off;
xlabel('n'); ylabel('average estimate');
title('estimating p^2 by (sample proportion)^2, p = 0.3');
legend([h1 h2 h3], {'average of the estimate over 100 trials', ...
    'exact E[est] = p^2 + p(1-p)/n', 'true value p^2 = 0.09'});

% -----------------------------------------------------------------------------
% This script is part of STAN (Statistics: Theory, Applications & Numerics),
% the code repository for MATH 166 at Tufts University:
% https://github.com/andreasmang/stan
