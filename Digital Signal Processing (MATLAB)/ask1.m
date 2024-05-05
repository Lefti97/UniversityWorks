n = -6:18;
nLen = length(n);
k=find(n==0); % Σημείο 0 στο n
seq = [1 2 3 4 5 6 7 6 5 4 3 2 1]; % Ακολουθία σήματος
sLen = length(seq);  % Μέγεθος ακολουθίας
x = zeros(1,nLen)    % Αρχικοποιούμε το x με 0
x(k:k+sLen-1) = seq; % Βάζουμε την ακολυθία απο το σημείο 0

% Γραφικές παραστάσεις x[n]
% a) x[n]
subplot(3, 2, 1);
stem(n, x);
title('a) x[n]');

% b) x[n-5]
subplot(3, 2, 2);
% Χτίζουμε το σήμα x[n-5] βάζοντας τα στοιχεία του σήματος απο το σημείο k+5=5
xB = zeros(1,nLen);
xB(k+5:k+sLen+5-1) = seq;
stem(n, xB);
title('b) x[n-5]');

% c) x[n+4]
subplot(3, 2, 3);
% Χτίζουμε το σήμα x[n+4] βάζοντας τα στοιχεία του σήματος απο το σημείο k-4=-4
xC = zeros(1,nLen);
xC(k-4:k+sLen-4-1) = seq;
stem(n, xC);
title('c) x[n+4]');

% d) x[-n]
subplot(3, 2, 4);
% Χτίζουμε το σήμα x[-n] βάζοντας τα στοιχεία του αντίστροφου σήματος απο το σημείο k=0.
% fliplr(seq) αντιστρέφει την ακολουθία.
xD = zeros(1,nLen);
xD(k:k+sLen-1) = fliplr(seq);
stem(n, xD);
title('d) x[-n]');

% e) x[n/2]
subplot(3, 2, 5);
% Χτίζουμε το σήμα x[n/2] βάζοντας κάθε στοιχείο του σήματος σε κάθε δεύτερη θέση
xE = zeros(1,nLen);
xE(1:2:nLen) = seq;
stem(n, xE);
title('e) x[n/2]');

% st) x[2n]
subplot(3, 2, 6);
xF = zeros(1,nLen);
min = k+((sLen-1)/4);   % Αρχικό σημείο του σήματος = k συν το ¼ του μεγέθους του σήματος x[n]
max = min+((sLen-1)/2); % Τελευταίο σημείο του σήματος = min συν το μισό του μεγέθου του σήματος x[n]
xF(min:max) = seq(1:2:end);
stem(n, xF);
title('st) x[2n]');

sgtitle('Γραφικές παραστάσεις του σήματος x[n]');
