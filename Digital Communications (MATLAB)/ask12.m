clear;
close all;

load handel.mat

% sound(y, Fs);
audiowrite('sound1.wav',y,Fs);

% Αναπαράσταση του αρχικού σήματος
t = (0:length(y)-1)/Fs;
figure;
subplot(2,1,1);
plot(t, y);
title('Αρχικό Σήμα');
xlabel('Χρόνος sec');
ylabel('Πλάτος');
grid on;
saveas(gcf,'test.png') 

% Υποδειγματοληψία κατά 2
y2 = y(1:2:end);
Fs2 = Fs / 2;
t2 = (0:length(y2)-1)/Fs2;

% Αναπαράσταση του υποδειγματοληπτημένου σήματος
subplot(2,1,2);
plot(t2, y2);
title('Υποδειγματοληπτημένο κατά 2');
xlabel('Χρόνος sec');
ylabel('Πλάτος');
grid on;
saveas(gcf,'test.png') 

% sound(y_downsampled, Fs_downsampled);
audiowrite('sound2.wav',y2,Fs2);

disp(['Αρχική συχνότητα δειγματοληψίας: ', num2str(Fs), ' Hz']);
disp(['Συχνότητα δειγματοληψίας μετά την υποδειγματοληψία: ', num2str(Fs2), ' Hz']);
