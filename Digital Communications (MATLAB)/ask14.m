clear;
close all;

N = 300000; %Δείγματα

% Σήμα λευκού Gaussian θορύβου 1
mu1 = 0.5;
sigma1 = 3;
noise1 = sigma1 * randn(1, N) + mu1;

% Σήμα λευκού Gaussian θορύβου 2
mu2 = -3.5;
sigma2 = 2;
noise2 = sigma2 * randn(1, N) + mu2;

% Γράφημα θορύβων
figure;
subplot(2,1,1);
plot(noise1);
title('Λευκός Gaussian Θόρυβος 1');
xlabel('Δείγμα');
ylabel('Τιμή');
subplot(2,1,2);
plot(noise2);
title('Λευκός Gaussian Θόρυβος 2');
xlabel('Δείγμα');
ylabel('Τιμή');

saveas(gcf,'test.png') 

% Ιστογράμματα σημάτων
figure;
histogram(noise1, 20);
hold on;
histogram(noise2, 20);
title('Ιστόγραμμα Λευκών Gaussian Θορύβων');
xlabel('Τιμή');
ylabel('Συχνότητα');
legend('Θόρυβος 1', 'Θόρυβος 2');
grid on;