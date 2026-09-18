%% sample_average.m
%  MATH 166 -- Statistics (Prof. Andreas Mang)
%  Homework 1 helper: the average of a sequence of random numbers.
%
%  Draw n = 1000 numbers from Uniform(0, 1) and compute their average three
%  ways: by hand with a loop, as sum(x)/n, and with mean. All three agree up to
%  rounding error. Base MATLAB only; no toolboxes needed.
%
%  Run:  sample_average    (at the MATLAB prompt, from this folder)

rng(0);                        % reproducibility (remove for a fresh draw)

n = 1000;
x = rand(n,1);                 % n numbers from Uniform(0, 1), whose mean is 1/2

% 1. by hand: add the numbers up one at a time, then divide by how many there are
total = 0;
for i = 1:n                    % i = 1, 2, ..., n: MATLAB counts from 1
    total = total + x(i);
end
avg_loop = total / n;

% 2. add them up with sum, then divide
avg_sum = sum(x) / n;

% 3. let MATLAB do both steps
avg_mean = mean(x);

fprintf('by hand, with a loop: %.15f\n', avg_loop);
fprintf('sum(x) / n:           %.15f\n', avg_sum);
fprintf('mean(x):              %.15f\n', avg_mean);
% sum may add the numbers in a different order than the loop, so the last digit
% or two can differ: a computer rounds every sum to about 16 significant digits
fprintf('loop minus mean:      %.1e\n', avg_loop - avg_mean);
fprintf('\n');
fprintf('average of the first 10 numbers, mean(x(1:10)): %.4f\n', mean(x(1:10)));

% -----------------------------------------------------------------------------
% This script is part of STAN (Statistics: Theory, Applications & Numerics),
% the code repository for MATH 166 at Tufts University:
% https://github.com/andreasmang/stan
