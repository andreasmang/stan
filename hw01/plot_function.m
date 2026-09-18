%% plot_function.m
%  MATH 166 -- Statistics (Prof. Andreas Mang)
%  Homework 1 helper: plot a function.
%
%  Evaluate sin(x) and cos(x) on a grid of points in [0, 2*pi] and plot both,
%  with axis labels, a title, a legend, and a reference line at 0. The figure
%  is saved as hw01-sine.png, ready to go into your PDF. Base MATLAB only; no
%  toolboxes needed.
%
%  Run:  plot_function     (at the MATLAB prompt, from this folder)

x = linspace(0, 2*pi, 201);       % 201 equally spaced points from 0 to 2*pi
y = sin(x);                       % sin acts on every entry of x at once

figure;
plot(x, y, 'LineWidth', 1.5); hold on;
plot(x, cos(x), '--', 'LineWidth', 1.5);
yline(0, 'Color', [0.5 0.5 0.5]);                 % reference line at 0
hold off;
xlim([0 2*pi]);
xlabel('x'); ylabel('f(x)');
title('sin(x) and cos(x) on [0, 2\pi]');          % \pi prints the Greek letter
legend('sin(x)', 'cos(x)', 'Location', 'southwest');
exportgraphics(gcf, 'hw01-sine.png', 'Resolution', 150);
fprintf('saved the figure as hw01-sine.png\n');

% -----------------------------------------------------------------------------
% This script is part of STAN (Statistics: Theory, Applications & Numerics),
% the code repository for MATH 166 at Tufts University:
% https://github.com/andreasmang/stan
