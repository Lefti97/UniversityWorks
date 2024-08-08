clear;
close all;

Fs = 80; % Συχνότητα δειγματοληψίας (Hz)
T = 0.8; % Διάρκεια σήματος (sec)
dt = 1/Fs; % Βήμα δειγματοληψίας
t = 0:dt:T; % Χρόνος

% Σήμα x(t)
x = 3*cos(4*pi*t) + 2*cos(8*pi*t) + sin(12*pi*t);

% Γραφική αναπαράσταση x(t)
figure;
plot(t, x);
title('x(t) = 3cos(4πt) + 2cos(8πt) + sin(12πt)');
xlabel('Χρόνος s');
ylabel('x(t)');
grid on;

% Υπολογισμός FFT και φάσματος πλάτους με αρχική ανάλυση συχνότητας
N = length(t); % Πλήθος σημείων t
X = fftshift(fft(x)); % Φάσμα πλάτους x(t)
f = (0:N-1)*(Fs/N); % Συχνότητες

% Γραφική παράσταση του φάσματος πλάτους (αρχικό)
figure
subplot(2,1,1);
plot(f, abs(X));
title('Φάσμα Πλάτους x(t) (Αρχικό)');
xlabel('Συχνότητα Hz');
ylabel('|X(f)|');
grid on;

% Υπολογισμός ανάλυσης συχνοτήτων (Αρχικό)
disp(['Ανάλυση συχνοτήτων(Αρχικό): ', num2str(Fs/N), ' Hz']);

% Αύξηση πλήθους σημείων του FFT
Nf = 2^ceil(log2(N)); % Αριθμός σημείων FFT
X_interp = fftshift(fft(x, Nf)); % Interpolated Φάσμα πλάτους x(t)
f_interp = (0:Nf-1)*(Fs/Nf); % Συχνότητες

% Γραφική παράσταση του φάσματος πλάτους με αυξημένο πλήθος σημείων
subplot(2,1,2);
plot(f_interp, abs(X_interp));
title('Φάσμα Πλάτους x(t) (Interpolated)');
xlabel('Συχνότητα Hz');
ylabel('|X(f)|');
grid on;

% Υπολογισμός ανάλυσης συχνοτήτων (Αυξημένο Πλήθος Σημείων)
disp(['Ανάλυση συχνοτήτων(Interpolated): ', num2str(Fs/Nf), ' Hz']);