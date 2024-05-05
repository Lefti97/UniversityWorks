n = -12:12;

% Κρουστική απόκριση h[n]
h = sqrt(8*abs(n)).*(2*gauspuls(n + 4) + (stepseq(n,1) - 3*stepseq(n,-2)));

% Είσοδος x[n]
x = 4*gauspuls(n + 3) + 2*gauspuls(n) - gauspuls(n - 1) + 5*gauspuls(n-3);

% Έξοδος με χρήση συνέλιξης
y = conv(x, h);

% Γραφική παράσταση
figure;

subplot(3, 1, 1);
stem(n, h);
title('Κρουστική Απόκριση h[n]');

subplot(3, 1, 2);
stem(n, x);
title('Είσοδος x[n]');

subplot(3, 1, 3);
stem(-7:15, y(18:40));
title('Έξοδος y[n]');

% Συνάρτηση μοναδιαίας βηματικής ακολουθίας
function x = stepseq(n,n0)
    k=find(n==0-n0);
    x = [ zeros(size(n(1):n(k-1))) ones(size(n(k):n(end))) ];
end
