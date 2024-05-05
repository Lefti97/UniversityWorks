n = 0:1199;

% Σήματα x1[n], x2[n], x3[n]
x1 = cos(0.2  * pi * n + pi/3);
x2 = cos(0.1  * pi * n + pi/4);
x3 = cos(0.01 * n  + pi/5);

% Γραφικές παραστάσεις  x1[n], x2[n], x3[n]
figure;

subplot(3, 1, 1);
stem(n(1:25), x1(1:25));
title('x1[n] = cos(0.2πn + π/3)');

subplot(3, 1, 2);
stem(n(1:45), x2(1:45));
title('x2[n] = cos(0.1πn + π/4)');

subplot(3, 1, 3);
stem(n, x3);
title('x3[n] = cos(0.01n + π/5)');

% Σήμα y[n] = x1[n] + x2[n]
figure;

y = x1 + x2;
subplot(2, 1, 1);
stem(n(1:50), y(1:50));
title('y[n] = x1[n] + x2[n]');

% Σήμα z[n] = x1[n] + x2[n] + x3[n]
z = x1 + x2 + x3;
subplot(2, 1, 2);
stem(n(1:50), z(1:50));
title('z[n] = x1[n] + x2[n] + x3[n]');
