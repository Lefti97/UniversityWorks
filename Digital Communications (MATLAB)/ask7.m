clear;
close all;

Am1 = 1;
Am2 = 2;
fm = 2;
Ac = 1;
fc = 100;
t = 0:0.001:1;

% Σήμα πληροφορίας
s1 = Am1 * sin(2 * pi * fm * t);
s2 = Am2 * sin(2 * pi * fm * t);
% Φέρον σήμα
c = Ac * cos(2 * pi * fc * t);
% Περιβάλλουσα του διαμορφωμένου σήματος
s_AM_env1 = Ac + s1;
s_AM_env2 = Ac + s2;
% Διαμορφωμένο σήμα ΑΜ
s_AM1 = (s_AM_env1) .* cos(2 * pi * fc * t);
s_AM2 = (s_AM_env2) .* cos(2 * pi * fc * t);

% Αναπαράσταση σήματος πληροφορίας
figure;
subplot(2, 1, 1);
plot(t, s1);
title('Σήμα Πληροφορίας s1(t)');
xlabel('Χρόνος s');
ylabel('Πλάτος V');
subplot(2, 1, 2);
plot(t, s2);
title('Σήμα Πληροφορίας s2(t)');
xlabel('Χρόνος s');
ylabel('Πλάτος V');

% Αναπαράσταση φέροντος σήματος
figure
subplot(2, 1, 1);
plot(t, c);
title('Φέρον Σήμα c1');
xlabel('Χρόνος s');
ylabel('Πλάτος V');
subplot(2, 1, 2);
plot(t, c);
title('Φέρον Σήμα c2');
xlabel('Χρόνος s');
ylabel('Πλάτος V');

% Αναπαράσταση διαμορφωμένου σήματος ΑΜ με περιβάλλουσα
figure;
subplot(2, 1, 1);
plot(t, s_AM1);
hold on;
plot(t, s_AM_env1, 'r', 'LineWidth', 1.5); % Περιβάλλουσα
plot(t, -s_AM_env1, 'r', 'LineWidth', 1.5); % Αρνητική περιβάλλουσα
title('Διαμορφωμένο Σήμα ΑΜ s_AM1');
xlabel('Χρόνος s');
ylabel('Πλάτος V');
legend('Διαμ. Σήμα AM', 'Περιβάλλουσα AM');
hold off;
subplot(2, 1, 2);
plot(t, s_AM2);
hold on;
plot(t, s_AM_env2, 'r', 'LineWidth', 1.5); % Περιβάλλουσα
plot(t, -s_AM_env2, 'r', 'LineWidth', 1.5); % Αρνητική περιβάλλουσα
title('Διαμορφωμένο Σήμα ΑΜ s_AM2');
xlabel('Χρόνος s');
ylabel('Πλάτος V');
legend('Διαμ. Σήμα AM', 'Περιβάλλουσα AM');
hold off;