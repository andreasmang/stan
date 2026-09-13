%% running_proportion.m
%  MATH 166 -- Statistics (Prof. Andreas Mang)
%  Recitation 1: your first simulation.
%
%  Flip a fair coin n = 1000 times and plot the running proportion of heads
%  against the number of flips. Base MATLAB only; no toolboxes needed.
%
%  Run:  running_proportion   (at the MATLAB prompt, from this folder)

rng(0);                           % reproducibility (remove for a fresh draw)

n = 1000;
x = rand(n,1) < 0.5;              % 1 = heads
p = cumsum(x) ./ (1:n)';          % running proportion

fprintf('proportion of heads after n = %d flips: %.4f\n', n, p(end));

figure;
plot(1:n, p); yline(0.5, '--');
xlabel('flips'); ylabel('proportion of heads');
title(sprintf('running proportion of heads, n = %d flips', n));

% -----------------------------------------------------------------------------
% This script is part of STAN (Statistics: Theory, Applications & Numerics),
% the code repository for MATH 166 at Tufts University:
% https://github.com/andreasmang/stan
