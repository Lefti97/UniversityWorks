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
