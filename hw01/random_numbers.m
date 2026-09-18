%% random_numbers.m
%  MATH 166 -- Statistics (Prof. Andreas Mang)
%  Homework 1 helper: random numbers.
%
%  A random number generator produces a sequence of numbers that is fixed by
%  its seed. This script shows that the same seed gives the same sequence and a
%  different seed a different one, and it draws numbers from a few common
%  distributions. It only prints; nothing is plotted or saved. Base MATLAB
%  only; no toolboxes needed.
%
%  Run:  random_numbers    (at the MATLAB prompt, from this folder)

% ---- seeds and sequences -----------------------------------------------------
rng(42);        print_row('seed 42', rand(1,5));
rng(42);        print_row('seed 42 again', rand(1,5));   % the same five numbers
rng(7);         print_row('seed 7', rand(1,5));          % a different sequence
rng('shuffle'); print_row('no seed', rand(1,5));         % different every time you run this

% drawing more numbers continues the sequence; it does not start it over
rng(42);
print_row('seed 42, first 3', rand(1,3));
print_row('seed 42, next 3', rand(1,3));   % starts with entries 4 and 5 above
fprintf('\n');

% ---- a few distributions, n = 5 draws each -----------------------------------
rng(0);
n = 5;
print_row('Uniform(0, 1)', rand(1,n));
print_row('Uniform(-1, 1)', -1 + 2*rand(1,n));          % a + (b - a) * U
print_row('N(0, 1)', randn(1,n));
print_row('N(3, 4)', 3 + 2*randn(1,n));                 % mean + sd * Z: sd = 2, not 4

% Exponential with rate 2 by the inverse-CDF method: if U ~ Uniform(0, 1) and F
% is a CDF, then F^{-1}(U) has CDF F. Here F(x) = 1 - exp(-2x), so
% F^{-1}(u) = -log(1 - u)/2; and 1 - U is Uniform(0, 1) too, so -log(U)/2 works.
% (exprnd(1/2, 1, n) does the same, but needs the Statistics and Machine
% Learning Toolbox, and takes the mean 1/rate.)
print_row('Exp(2), inverse CDF', -log(rand(1,n))/2);

rolls = randi(6, 1, 10);                                      % integers 1 to 6
fprintf('%-24s%s\n', 'die rolls', strjoin(string(rolls), ' '));

function print_row(label, x)
    fprintf('%-24s', label); fprintf('%9.4f', x); fprintf('\n');
end

% -----------------------------------------------------------------------------
% This script is part of STAN (Statistics: Theory, Applications & Numerics),
% the code repository for MATH 166 at Tufts University:
% https://github.com/andreasmang/stan
