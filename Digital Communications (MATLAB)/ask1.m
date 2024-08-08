clear;
close all;

% Χρόνος
dt = 0.0001;
Tw = 0.05;
t = -Tw:dt:Tw;

% Σήμα x(t)
x = sinc(1000 * t);

% α) Γραφική αναπαράσταση x(t) 
figure;
subplot(3,1,1);
plot(t, x);
title('x(t) = sinc(1000t)');
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

% Μετατοπισμένο x1(t)
t1 = t - 0.01;
x1 = sinc(1000 * t1);

% δ) Γραφική απεικόνιση x1(t)
figure;
subplot(3,1,1);
plot(t, x1);
title('Μετατοπισμένο x1(t) = sinc(1000(t+0.01))');
xlabel('Χρόνος s');
ylabel('x1(t)');
grid on;

% ε) Φάσμα πλάτους x1(t)
Xf1 = fftshift(fft(x1));

subplot(3,1,2);
plot(f, abs(Xf1));
title('Φάσμα Πλάτους x1(t)');
xlabel('Συχνότητα Hz');
ylabel('|X1(f)|');
grid on;

% ζ) Φάσμα φάσης x1(t)
Xf1_phase = angle(Xf1);

subplot(3,1,3);
plot(f, Xf1_phase);
title('Φάσμα Φάσης x1(t)');
xlabel('Συχνότητα Hz');
ylabel('Φάση X1(f)');
grid on;