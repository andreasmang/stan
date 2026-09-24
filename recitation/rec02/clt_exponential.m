%% clt_exponential.m
%  MATH 166 -- Statistics (Prof. Andreas Mang)
%  Recitation 2: how fast does the central limit theorem kick in?
%
%  For n = 1, 5, 30, draw N = 10000 samples of size n from the exponential
%  distribution with mean 1 (so mu = sigma = 1), standardize each sample mean,
%  Z = sqrt(n) (xbar - 1), and plot a histogram of the N values against the
%  N(0,1) density. Prints how often Z > 1.645 and Z < -1.645, which is 0.05
%  each for a standard normal. Base MATLAB only; no toolboxes needed.
%
%  Run:  clt_exponential    (at the MATLAB prompt, from this folder)

rng(0);                                 % reproducibility (remove for a fresh draw)

N = 10000;                              % number of samples for each n
z = linspace(-4, 4, 200);
phi = exp(-z.^2/2) / sqrt(2*pi);        % the N(0,1) density
ns = [1 5 30];

figure;
for k = 1:numel(ns)
    n = ns(k);
    x = -log(rand(n, N));               % N samples of size n, one per column:
                                        % -log(U) is exponential with mean 1
    Z = sqrt(n) * (mean(x, 1) - 1);     % N standardized means
    fprintf('n = %2d:  P(Z > 1.645) = %.3f,  P(Z < -1.645) = %.3f   (normal: 0.050 each)\n', ...
            n, mean(Z > 1.645), mean(Z < -1.645));
    subplot(1, 3, k);
    histogram(Z, 60, 'Normalization', 'pdf'); hold on;
    plot(z, phi, 'LineWidth', 1.5); hold off;
    title(sprintf('n = %d', n)); xlabel('standardized mean');
end

% -----------------------------------------------------------------------------
% This script is part of STAN (Statistics: Theory, Applications & Numerics),
% the code repository for MATH 166 at Tufts University:
% https://github.com/andreasmang/stan
