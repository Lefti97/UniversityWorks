n = [-20:20];

a = [1 -0.4];   % Μέρος y εξίσωσης
b = [1 0 -0.7]; % Μέρος x εξίσωσης (στην δεύτερη θέση 0 επειδή δεν υπάρχει x[n-1])

% Είσοδος x[n]
x = 2*gauspuls(n+1)+4*gauspuls(n)+8*gauspuls(n-1)+9*gauspuls(n-2);
% Έξοδος y[n] με είσοδο x[n]
y = filter(b,a,x);
% Κρουστική απόκριση y[n]
[h,t] = impz(b,a,n);

subplot(2, 1, 1);
stem(y);
title('Έξοδος y[n]');

subplot(2, 1, 2);
stem(n,h);
title('Κρουστική απόκριση y[n]');
