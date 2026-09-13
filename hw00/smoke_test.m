%% smoke_test.m
%  MATH 166 -- Statistics (Prof. Andreas Mang)
%  Homework 0, Problem 4(a): toolchain smoke test.
%
%  Draw n = 1000 i.i.d. samples from N(0,1), report the sample mean, and plot a
%  histogram. Base MATLAB only; no toolboxes needed.
%
%  Run:  smoke_test          (at the MATLAB prompt, from this folder)

rng(0);                        % reproducibility (remove for a fresh draw)

n = 1000;
x = randn(n,1);                % i.i.d. N(0,1)

fprintf('sample mean of n = %d draws: %.4f\n', n, mean(x));

figure;
histogram(x, 30);
xlabel('x'); ylabel('count');
title(sprintf('%d samples from N(0,1), sample mean = %.4f', n, mean(x)));
exportgraphics(gcf, 'hw00-histogram.png', 'Resolution', 150);

% -----------------------------------------------------------------------------
% This script is part of STAN (Statistics: Theory, Applications & Numerics),
% the code repository for MATH 166 at Tufts University:
% https://github.com/andreasmang/stan
