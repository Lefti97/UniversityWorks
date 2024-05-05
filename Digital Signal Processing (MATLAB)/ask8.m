n = -5:10; % Διάστημα
a = 4; b = 5; % Σταθερές

% Δημιουργία βοηθητικών εισόδων x1, x2
x1 = zeros(size(n));
x1(6:10) = [2 2 3 3 4];
x2 = (stepseq(n,0) - stepseq(n,-6));

% Δημιουργία εξόδων y1,y2 για κάθε βοηθητική είσοδο x1, x2
y1 = 4 * n.^2 .* x1;
y2 = 4 * n.^2 .* x2;

% Δημιουργία εισόδου για επαλήθευση γραμμικότητας
x3 = a*x1 + b*x2;

% Δημιουργία εξόδων συστήματος για επαλήθευση γραμμικότητας
y_x = 4 * n.^2 .* x3;  % 4n^2 (ax1+bx2)
y_y = a * y1 + b * y2; % ay1 + by2

%Δημιουργία γραφικών παραστάσεων
figure;

subplot(2, 2, 1);
stem(n, x1);
title('x1[n]');

subplot(2, 2, 2);
stem(n, x2);
title('x2[n]');

subplot(2, 2, 3);
stem(n, y_x);
title('y[n] = 4n^2 (ax1+bx2)');

subplot(2, 2, 4);
stem(n, y_y);
title('y[n] = ay1 + by2');

% Συνάρτηση δημιουργίας μοναδιαίας βηματικής ακολουθίας
function x = stepseq(n,n0)
    k=find(n==0-n0);
    if k > 1
        x = [ zeros(size(n(1):n(k-1))) ones(size(n(k):n(end))) ];
    else
        x = ones(size(n(k):n(end)));
    end
end
