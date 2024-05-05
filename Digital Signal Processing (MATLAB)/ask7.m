% Χρόνοι ακολουθιών
n_x = -1:2;
n_y = -2:2;
n_z = -3:4;

% Δημιουργία διανυσμάτων x[n], y[n]
x = 4*gauspuls(n_x + 1) + 9*gauspuls(n_x) - 2*gauspuls(n_x - 2);
y = (n_y/6).*(stepseq(n_y,2) - stepseq(n_y,-2));

% Γινόμενο x[n] * y[n]
z_toeplitz = conv_toeplitz(x, y); % Με Toeplitz
z_conv = conv(x,y);               % Με conv

% Δημιουργία γραφικών παραστάσεων
figure;

subplot(3, 2, 1);
stem(n_x, x);
title('x[n]');

subplot(3, 2, 2);
stem(n_y, y);
title('y[n]');

subplot(3, 1, 2);
stem(n_z, z_toeplitz);
title('z[n] = x[n] * y[n] (with Toeplitz)');

subplot(3, 1, 3);
stem(n_z, z_conv);
title('z[n] = x[n] * y[n] (with conv)');

% Συνάρτηση συνέλιξης με χρήση πίνακα Toeplitz
function res = conv_toeplitz(x, h)
    N = length(x); % Μέγεθος σήματος x
    M = length(h); % Μέγεθος σήματος y

    % Χτίζουμε τις παραμέτρους για την συνάρτηση toeplitz
    c = [h, zeros(1, N-1)];  % Στοιχεία h και Ν-1 μηδενικά (μέγεθος M+N-1)
    r = [c(1) zeros(1,N-1)]; % Πρώτο στοιχείο του h και Ν-1 μηδενικά

    h_t = toeplitz(c, r); % Δημιουργία πίνακα toeplitz

    res = h_t * x'; % Γινόμενο x με τον πίνακα toeplitz
    res = res'; % Αναστροφή αποτελέσματος
end

% Συνάρτηση δημιουργίας μοναδιαίας βηματικής ακολουθίας
function x = stepseq(n,n0)
    k=find(n==0-n0);
    if k > 1
        x = [ zeros(size(n(1):n(k-1))) ones(size(n(k):n(end))) ];
    else
        x = ones(size(n(k):n(end)));
    end
end
