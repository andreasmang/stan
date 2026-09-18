%% mean_vs_n.m
%  MATH 166 -- Statistics (Prof. Andreas Mang)
%  Homework 1 helper: a loop over sample sizes.
%
%  For n = 5, 10, 15, ..., 1000 draw a fresh sample of n numbers from
%  Uniform(0, 1), store its average, and plot the averages against n. The plot
%  also shows the true mean 1/2 and the band 1/2 +- 2 sigma/sqrt(n) of two
%  standard errors, where sigma^2 = 1/12 is the variance of Uniform(0, 1).
%  Base MATLAB only; no toolboxes needed.
%
%  Run:  mean_vs_n         (at the MATLAB prompt, from this folder)

rng(0);                              % reproducibility (remove for a fresh draw)

nvals = 5:5:1000;                    % n = 5, 10, ..., 1000
avg = zeros(size(nvals));            % room for one average per n, filled in below

for k = 1:numel(nvals)               % k = 1, 2, ..., 200 numbers the entries of nvals
    n = nvals(k);
    x = rand(n,1);                   % a fresh sample of size n
    avg(k) = mean(x);
end

band = 2*sqrt(1/12 ./ nvals);        % two standard errors, 2 sigma / sqrt(n), for every n
inside = mean(abs(avg - 0.5) <= band);   % the mean of 0s and 1s is a proportion

fprintf('average at n = %d: %.4f   (true mean 0.5)\n', nvals(end), avg(end));
fprintf('proportion of the %d averages inside the band: %.2f\n', numel(nvals), inside);

figure;
h1 = plot(nvals, avg); hold on;
h2 = yline(0.5, 'k--');
h3 = plot(nvals, 0.5 + band, ':', 'Color', [0.5 0.5 0.5]);
plot(nvals, 0.5 - band, ':', 'Color', [0.5 0.5 0.5]);
hold off;
xlabel('n'); ylabel('sample average');
title('averages of n draws from Uniform(0, 1)');
legend([h1 h2 h3], {'sample average', 'true mean 1/2', '1/2 \pm 2 standard errors'});

% -----------------------------------------------------------------------------
% This script is part of STAN (Statistics: Theory, Applications & Numerics),
% the code repository for MATH 166 at Tufts University:
% https://github.com/andreasmang/stan
