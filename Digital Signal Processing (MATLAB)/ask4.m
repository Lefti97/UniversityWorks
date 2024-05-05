% x[n] from 2b
n = -5:10;
x1 = 3 * [-5:-1];
x2 = exp(0:2);
x3 = sqrt(8) * ones(size(3:10));
x = [x1 x2 x3];

[xEv, xOd, xM] = func(x,n);

function [ev,od,m] = func(x,n)
    xr = fliplr(x);      % Αντίστροφο x
    ev = 0.5 * (x + xr); % Άρτιο σήμα
    od = 0.5 * (x - xr); % Περιττό σήμα
    m  = n; % Χρονικός άξονας (ίδιο με n)

    % Γραφικές παραστάσεις
    subplot(3, 1, 1);
    stem(n, x);
    title('Αρχικό Σήμα x[n]');

    subplot(3, 1, 2);
    stem(m, ev);
    title('Άρτιο Μέρος ev[n]');

    subplot(3, 1, 3);
    stem(m, od);
    title('Περιττό Μέρος od[n]');
end
