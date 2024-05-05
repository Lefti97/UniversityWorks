% a) y[n]
% y[n] = 2 ∗ u[n − (2 + 8 mod 5)] − 8 ∗ δ[n − 8 mod 4] =>
% y[n] = 2 * u[n − 5] − 8 ∗ δ[n]
% για n = −20 − (8 mod 2): 20 + (8 mod 2) => n = -20:20

nY = -20:20;
y1 = 2 * [zeros(size(-20:4)) ones(size(5:20))]; % 2 * u[n − 5]
y2 = 8 * gauspuls(-20:20);                      % 8 ∗ δ[n]
y  = y1 - y2;

% Γραφική παράσταση y[n]
subplot(2, 1, 1);
stem(nY,y);
title('a) y[n]');

% b) x[n]
% για − 5 ≤ n ≤ −1 , τότε 3 ∗ n
% για − 1 < n ≤  2 , τότε e ^ n
% για   2 < n ≤ 10 , τότε sqr(4 * sum(AM)) => sqr(8)

nX = -5:10;
x1 = 3 * [-5:-1];
x2 = exp(0:2);
x3 = sqrt(8) * ones(size(3:10));
x = [x1 x2 x3];

subplot(2, 1, 2);
stem(nX,x);
title('b) x[n]');
