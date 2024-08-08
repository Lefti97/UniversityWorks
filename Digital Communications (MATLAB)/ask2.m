clear;
close all;

% Χρόνος
dt = 0.0001;
Tw = 0.05;
t = -Tw:dt:Tw;

% Σήμα x(t)
x = sinc(2000 * t);

% α) Γραφική αναπαράσταση x(t) 
figure;
subplot(3,1,1);
plot(t, x);
title('x(t) = sinc(2000t)');
xlabel('Χρόνος s');
ylabel('x(t)');
grid on;

% Πρώτο μηδενικό x(t) 
first_zero = find(abs(x) < 0.0001, 1, 'first'); %<0.0001 λογο float αριθμού
first_zero_t = t(first_zero(1));
disp(['Χρονική στιγμή πρώτου μηδενισμού του σήματος: ', num2str(first_zero_t), ' s']);

% β) Φάσματος πλάτους x(t) 
Xf = fftshift(fft(x));
BW=1/dt;
N=(Tw*2/dt)+1;
df=BW/N;
f=(-BW/2):df:(BW/2-df);

subplot(3,1,2);
plot(f, abs(Xf));
title('Φάσμα Πλάτους x(t)');
xlabel('Συχνότητα Hz');
ylabel('|X(f)|');
grid on;

% γ) Φάσμα φάσης x(t) 
Xf_phase = angle(Xf);

subplot(3,1,3);
plot(f, Xf_phase);
title('Φάσμα Φάσης x(t)');
xlabel('Συχνότητα Hz');
ylabel('Φάση X(f)');
grid on;