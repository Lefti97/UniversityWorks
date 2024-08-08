clear;
close all;

Am = 0.5;
fm = 2;
Ac = 1;
fc = 100;
t = 0:0.001:1;

% Σήμα πληροφορίας
s = Am * sin(2 * pi * fm * t);

% Φέρον σήμα
c = Ac * cos(2 * pi * fc * t);

% Περιβάλλουσα του διαμορφωμένου σήματος
s_AM_env = Ac + s;

% Διαμορφωμένο σήμα ΑΜ
s_AM = (s_AM_env) .* cos(2 * pi * fc * t);

% Αναπαράσταση σήματος πληροφορίας
figure;
subplot(2, 1, 1);
plot(t, s);
title('Σήμα Πληροφορίας s(t)');
xlabel('Χρόνος s');
ylabel('Πλάτος V');

% Αναπαράσταση φέροντος σήματος
subplot(2, 1, 2);
plot(t, c);
title('Φέρον Σήμα');
xlabel('Χρόνος s');
ylabel('Πλάτος V');

% Αναπαράσταση διαμορφωμένου σήματος ΑΜ με περιβάλλουσα
figure;
plot(t, s_AM);
hold on;
plot(t, s_AM_env, 'r', 'LineWidth', 1.5); % Περιβάλλουσα
plot(t, -s_AM_env, 'r', 'LineWidth', 1.5); % Αρνητική περιβάλλουσα
title('Διαμορφωμένο Σήμα ΑΜ');
xlabel('Χρόνος s');
ylabel('Πλάτος V');
legend('Διαμ. Σήμα AM', 'Περιβάλλουσα AM');
hold off;