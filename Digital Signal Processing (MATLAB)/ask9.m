n = 10;

a = [ 1 3 -5 ]; % Μέρος y εξίσωσης
b = [ 0.5 -1];  % Μέρος x εξίσωσης

d = [ 1 zeros(1,n-1)]; % Είσοδος δ(n)
h1 = filter(b,a,d); % Κρουστική απόκριση του φίλτρου

% α) Γραφική παράσταση κρουστικής απόκρισης
figure;
stem(0:n-1, h1);
xlim([-.5 n]);
title('α) Γραφική παράσταση κρουστικής απόκρισης');

% γ)
x1 = [2 1 1 1 0 0 1 1 0 0 2];
y2 = conv(h1,x1);
x1(20)=0;
y1 = filter(b,a,x1);

% δ)
x2 = 2*cos(3*pi*[0:20]);;
y3 = conv(h1,x2);
y4 = filter(b,a,x2);

% Γραφικές παραστάσεις ερωτημάτων γ, δ
figure;
subplot(2, 2, 1);
stem(y2);
title('γ) filter');
subplot(2, 2, 3);
stem(y1);
title('γ) conv');
subplot(2, 2, 2);
stem(y4);
title('δ) filter');
subplot(2, 2, 4);
stem(y3);
title('δ) conv');
