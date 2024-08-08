clear;
close all;

% Διαβάστε το σήμα ομιλίας 3WORDS.WAV
[x, Fs] = audioread('3WORDS.WAV');
t = (0:length(x)-1)/Fs;

% Γραφική παράσταση της κυματομορφής του σήματος
figure;
subplot(2,1,1);
plot(t, x);
xlabel('Χρόνος s');
ylabel('Πλάτος');
title('Κυματομορφή σήματος ομιλίας x');

% Φάσμα πλάτους του σήματος
X = fftshift(fft(x));
f = (0:length(X)-1)*Fs/length(X);

% Γραφική παράσταση του φάσματος πλάτους του σήματος
subplot(2,1,2);
plot(f, abs(X));
xlabel('Συχνότητα Hz');
ylabel('Πλάτος');
title('Φάσμα πλάτους σήματος ομιλίας X');

% Πρώτα 50000 δείγματα του αρχικού σήματος ομιλίας
x2 = x(1:50000);

% Διαμόρφωση κατά DSB
fc = 100000; % 100KHz
Ac = 1; % 1 Volt
t2 = (0:length(x2)-1)/Fs;
loc_osc = cos(2 * pi * fc * t2);
c = Ac * loc_osc;
sig_dsb = x2' .* c;

% Γραφική παράσταση του διαμορφωμένου σήματος
figure;
plot(t2, sig_dsb);
xlabel('Χρόνος (s)');
ylabel('Πλάτος');
title('Διαμορφωμένο σήμα DSB');

% Αποδιαμόρφωση του σήματος με μη ιδανικό τοπικό ταλαντωτή
offset = 0.9 * pi * rand(size(t2)); % Μεταβλητή διαφορά φάσης
loc_osc_nonid = cos(2 * pi * fc * t2 + offset);
sig_demod_nonid = sig_dsb .* loc_osc_nonid;

% Χαμηλοπερατό φίλτρο Butterworth
order = 5;
fcut = 4000;
fcenter = 0;
[sig_butterworth_nonid, ~] = butterworth_filter(sig_demod_nonid, 1/Fs, order, fcut, fcenter);

% Γραφική παράσταση του αποδιαμορφωμένου σήματος
figure;
plot(t2, sig_butterworth_nonid);
xlabel('Χρόνος (s)');
ylabel('Πλάτος');
title('Αποδιαμ. με μεταβλητό μη ιδανικό τοπικό ταλαντωτή (butterworth filter)');
saveas(gcf,'test.png')

% Ακούστε το αποδιαμορφωμένο σήμα
% sound(real(double(sig_butterworth)), Fs);
audiowrite('sound_nonid2.wav',real(double(sig_butterworth_nonid)),Fs);
