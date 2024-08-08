clear;
close all;

x = randi([0 15], 10000, 1);

% Διαμόρφωση 16QAM
x_qammod = qammod(x, 16);

% Διάγραμμα αστερισμού της αθόρυβης διαμορφωμένης ακολουθίας
figure;
scatterplot(x_qammod);
title('Αθόρυβη Διαμορφωμένη Ακολουθία');

% Προσθήκη θορύβου AWGN με SNR = 12 dB
x_qammod_awgn = awgn(x_qammod, 12, 'measured');

% Διάγραμμα αστερισμού της ενθόρυβης διαμορφωμένης ακολουθίας
figure;
scatterplot(x_qammod_awgn);
title('Ενθόρυβη Διαμορφωμένη Ακολουθία');

% Αποδιαμόρφωση της ενθόρυβης ακολουθίας
x_qamdemod = qamdemod(x_qammod_awgn, 16);

% Υπολογισμός του Bit Error Rate (BER)
[numErrors, errorRate] = biterr(x, x_qamdemod);

% Εμφάνιση των αποτελεσμάτων
disp(['Error number: ', num2str(numErrors)]);
disp(['Error Rate: ', num2str(errorRate)]);