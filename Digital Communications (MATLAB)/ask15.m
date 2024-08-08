clear;
close all;

SN0 = 200; % S/N0
B = 1:300000; % Εύρος ζώνης

% Υπολογισμός χωρητικότητας καναλιού
C = B .* log2(1 + SN0);

% Αναπαράσταση της χωρητικότητας καναλιού
figure;
semilogx(B, C);
xlabel('B (Hz)');
ylabel('C (bits/sec)');
title('Χωρητικότητα Καναλιού');
grid on;

saveas(gcf,'test.png') 
