clear;
close all;

f = 40; % Συχνότητα
fs = 2000; % Συχνότητα δειγματοληψίας
A = 12; % Πλάτος Volt
phi = 2*pi/3; % Φάση σε rad
T = 1.5; % Διάρκεια

% Δημιουργία διανύσματος χρόνου
t = 0:1/fs:T;

% Δημιουργία του ημιτονοειδούς σήματος
x = A * sin(2 * pi * f * t + phi);

% Γραφική παράσταση του ημιτονοειδούς σήματος
figure;
plot(t, x);
title('Ημιτονοειδές Σήμα x');
xlabel('Χρόνος s');
ylabel('Πλάτος V');
grid on;

% Υπολογισμός του φάσματος χρησιμοποιώντας FFT
N = length(x);
X_f = fftshift(fft(x));
f2 = (0:N-1)*(fs/N); % Άξονας συχνοτήτων

% Γραφική παράσταση του φάσματος πλάτους
figure;
plot(f2, abs(X_f));
title('Φάσμα πλάτους X_f');
xlabel('Συχνότητα Hz');
ylabel('|X_f|');
grid on;

% % Υπολογισμός του πλάτους του φάσματος
% amplitude_spectrum = abs(X_f)/N;
% amplitude_spectrum = amplitude_spectrum(1:N/2+1);
% amplitude_spectrum(2:end-1) = 2*amplitude_spectrum(2:end-1);
% 
% % Άξονας συχνοτήτων για το πλάτος φάσματος
% f_axis_amplitude = f2(1:N/2+1);
% % Γραφική παράσταση του φάσματος πλάτους
% figure;
% plot(f_axis_amplitude, amplitude_spectrum);
% title('Φάσμα Πλάτους του Ημιτονοειδούς Σήματος');
% xlabel('Συχνότητα (Hz)');
% ylabel('Πλάτος');
% grid on;