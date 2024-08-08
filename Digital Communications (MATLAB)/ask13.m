clear;
close all;

Fs = 1200;
T = 0.02;
t = 0:1/Fs:T;

% Αρχικό σήμα
x = 2*sin(200*pi*t) + 5*cos(100*pi*t);

% Αρχικοποίηση για κβάντιση
Nq = 4; %Επίπεδα κβάντισης
A = max(x); %Full scale range
step = A / (Nq/2); %Βήμα κβάντισης

partition = -A + step:step:A - step; % Όρια ζωνών
codebook = -A + step/2:step:A - step/2; % Επίπεδα κβάντισης

% Κβάντιση σήματος
[index, quants] = quantiz(x, partition, codebook);

% Σφάλμα κβάντισης
q_error = x - quants;

% Σχεδιασμός του σήματος
figure;
plot(t, x, 'b'); 
hold on;
stem(t, quants, 'r');
for i = 1:length(partition)
    yline(partition(i), 'k--');
end
for i = 1:length(codebook)
    yline(codebook(i), 'g--');
end
plot(t, q_error, 'm');
xlabel('Χρόνος sec');
ylabel('Πλάτος');
title('Αρχική, κβαντισμένη, κωδικοποιημένη μορφή σήματος');
grid on;

% Απλός κωδικοποιητής
bin_codes = dec2bin(0:Nq-1);

% Προσθήκη κωδικών λέξεων στο διάγραμμα
for i = 1:length(t)
    text(t(i), quants(i), bin_codes(index(i)+1,:));
end

saveas(gcf,'test.png') 
