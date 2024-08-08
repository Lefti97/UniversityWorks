clear;
close all;

A = 3; % Πλάτος V
f = 60; % Συχνότητα Hz
T = 0.1; % Διάρκεια sec

% Δειγματοληψία με 400Hz
fs1 = 400;
t1 = 0:1/fs1:T;
x1 = A * sin(2 * pi * f * t1);

% Δειγματοληψία με 70Hz
fs2 = 70;
t2 = 0:1/fs2:T;
x2 = A * sin(2 * pi * f * t2);

% Σχεδιασμός σήματος και δειγμάτων
figure;
subplot(3,1,1);
plot(t1, x1, 'r', 'DisplayName', 'Δειγμ. 400Hz');
hold on;
plot(t2, x2, 'b', 'DisplayName', 'Δειγμ. 70Hz');
xlabel('Χρόνος sec');
ylabel('Πλάτος V');
title('Σήμα ημίτονου με διάφορες δειγματοληψίες');
legend;
grid on;
saveas(gcf,'test.png') 

% Συνημίτονο που περνάει από τα δείγματα του σήματος 70Hz
f_cos = 9;
x_cos = A * cos(2 * pi * f_cos * t2);

subplot(3,1,2);
plot(t2, x2, 'r', 'DisplayName', 'sine 60Hz');
hold on;
plot(t2, x_cos, 'b', 'DisplayName', 'cosine 10Hz');
xlabel('Χρόνος sec');
ylabel('Πλάτος V');
title('Συνημίτονο που περνάει από τα δείγματα της δειγματοληψίας με 70Hz');
legend;
grid on;
saveas(gcf,'test.png') 

% Δειγματοληψία με συχνότητα Nyquist
fs_nyquist = 2 * f;
t_nyquist = 0:1/fs_nyquist:T;
x_nyquist = A * sin(2 * pi * f * t_nyquist);

subplot(3,1,3);
plot(t_nyquist, x_nyquist);
xlabel('Χρόνος sec');
ylabel('Πλάτος V');
title('Δειγματοληψία με συχνότητα Nyquist (120 Hz)');
grid on;
saveas(gcf,'test.png') 