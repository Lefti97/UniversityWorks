close all;
clear all;
clc;

if not(isfolder('imgs'))
    mkdir('imgs')
end

load iris.dat;

% 2.α)
euclD4 = pdist(iris(:,1:4), 'euclidean');
euclZ4 = squareform(euclD4);


% 2.β)
plot(euclZ4(1,:));
title('2.β) Ευκλείδια απόσταση IRIS (4 στήλες)')
exportgraphics(gcf,'imgs/2_β.png')


% 2.γ)
cityD4 = pdist(iris(:,1:4), 'cityblock');
cityZ4 = squareform(cityD4);

C4=cov(iris(:,1:4));
mahaD4 = pdist(iris(:,1:4), 'mahalanobis', C4);
mahaZ4 = squareform(mahaD4);

plot([euclZ4(1,:)' cityZ4(1,:)' mahaZ4(1,:)']);
title('2.γ) Διάφορες αποστάσεις IRIS (4 στήλες)')
legend('euclidean', 'cityblock', 'mahalanobis')
exportgraphics(gcf,'imgs/2_γ.png')


% 2.δ)
euclD = pdist(iris(:,1:2), 'euclidean');
euclZ = squareform(euclD);

cityD = pdist(iris(:,1:2), 'cityblock');
cityZ = squareform(cityD);

C=cov(iris(:,1:2));
mahaD = pdist(iris(:,1:2), 'mahalanobis', C);
mahaZ = squareform(mahaD);

plot([euclZ4(1,:)' euclZ(1,:)']);
title('2.δ) Ευκλείδια απόσταση IRIS')
legend('1-4 στήλες', '1-2 στήλες')
exportgraphics(gcf,'imgs/2_δ_ευκλ.png')

plot([cityZ4(1,:)' cityZ(1,:)']);
title('2.δ) Cityblock απόσταση IRIS')
legend('1-4 στήλες', '1-2 στήλες')
exportgraphics(gcf,'imgs/2_δ_city.png')

plot([mahaZ4(1,:)' mahaZ(1,:)']);
title('2.δ) Mahalanobis απόσταση IRIS')
legend('1-4 στήλες', '1-2 στήλες')
exportgraphics(gcf,'imgs/2_δ_maha.png')



% 2.ε)

% Πρώτο και τρίτο χαρακτηριστικό
euclD = pdist(iris(:,[1,3]), 'euclidean');
euclZ = squareform(euclD);

cityD = pdist(iris(:,[1,3]), 'cityblock');
cityZ = squareform(cityD);

C=cov(iris(:,[1,3]));
mahaD = pdist(iris(:,[1,3]), 'mahalanobis', C);
mahaZ = squareform(mahaD);

plot([euclZ4(1,:)' euclZ(1,:)']);
title('2.ε1) Ευκλείδια απόσταση IRIS')
legend('1-4 στήλες', '1,3 στήλες')
exportgraphics(gcf,'imgs/2_ε1_ευκλ.png')

plot([cityZ4(1,:)' cityZ(1,:)']);
title('2.ε1) Cityblock απόσταση IRIS')
legend('1-4 στήλες', '1,3 στήλες')
exportgraphics(gcf,'imgs/2_ε1_city.png')

plot([mahaZ4(1,:)' mahaZ(1,:)']);
title('2.ε1) Mahalanobis απόσταση IRIS')
legend('1-4 στήλες', '1,3 στήλες')
exportgraphics(gcf,'imgs/2_ε1_maha.png')



% Τρίτο και τέταρτο χαρακτηριστικό
euclD = pdist(iris(:,[3,4]), 'euclidean');
euclZ = squareform(euclD);

cityD = pdist(iris(:,[3,4]), 'cityblock');
cityZ = squareform(cityD);

C=cov(iris(:,[3,4]));
mahaD = pdist(iris(:,[3,4]), 'mahalanobis', C);
mahaZ = squareform(mahaD);

plot([euclZ4(1,:)' euclZ(1,:)']);
title('2.ε2) Ευκλείδια απόσταση IRIS')
legend('1-4 στήλες', '3,4 στήλες')
exportgraphics(gcf,'imgs/2_ε2_ευκλ.png')

plot([cityZ4(1,:)' cityZ(1,:)']);
title('2.ε2) Cityblock απόσταση IRIS')
legend('1-4 στήλες', '3,4 στήλες')
exportgraphics(gcf,'imgs/2_ε2_city.png')

plot([mahaZ4(1,:)' mahaZ(1,:)']);
title('2.ε2) Mahalanobis απόσταση IRIS')
legend('1-4 στήλες', '3,4 στήλες')
exportgraphics(gcf,'imgs/2_ε2_maha.png')


% Πρώτα τρία χαρακτηριστικό
euclD = pdist(iris(:,1:3), 'euclidean');
euclZ = squareform(euclD);

cityD = pdist(iris(:,1:3), 'cityblock');
cityZ = squareform(cityD);

C=cov(iris(:,1:3));
mahaD = pdist(iris(:,1:3), 'mahalanobis', C);
mahaZ = squareform(mahaD);

plot([euclZ4(1,:)' euclZ(1,:)']);
title('2.ε3) Ευκλείδια απόσταση IRIS')
legend('1-4 στήλες', '1-3 στήλες')
exportgraphics(gcf,'imgs/2_ε3_ευκλ.png')

plot([cityZ4(1,:)' cityZ(1,:)']);
title('2.ε3) Cityblock απόσταση IRIS')
legend('1-4 στήλες', '1-3 στήλες')
exportgraphics(gcf,'imgs/2_ε3_city.png')

plot([mahaZ4(1,:)' mahaZ(1,:)']);
title('2.ε3) Mahalanobis απόσταση IRIS')
legend('1-4 στήλες', '1-3 στήλες')
exportgraphics(gcf,'imgs/2_ε3_maha.png')


% Πρώτο, δεύτερο και τέταρτο χαρακτηριστικό
euclD = pdist(iris(:,[1,2,4]), 'euclidean');
euclZ = squareform(euclD);

cityD = pdist(iris(:,[1,2,4]), 'cityblock');
cityZ = squareform(cityD);

C=cov(iris(:,[1,2,4]));
mahaD = pdist(iris(:,[1,2,4]), 'mahalanobis', C);
mahaZ = squareform(mahaD);

plot([euclZ4(1,:)' euclZ(1,:)']);
title('2.ε4) Ευκλείδια απόσταση IRIS')
legend('1-4 στήλες', '1,2,4 στήλες')
exportgraphics(gcf,'imgs/2_ε4_ευκλ.png')

plot([cityZ4(1,:)' cityZ(1,:)']);
title('2.ε4) Cityblock απόσταση IRIS')
legend('1-4 στήλες', '1,2,4 στήλες')
exportgraphics(gcf,'imgs/2_ε4_city.png')

plot([mahaZ4(1,:)' mahaZ(1,:)']);
title('2.ε4) Mahalanobis απόσταση IRIS')
legend('1-4 στήλες', '1,2,4 στήλες')
exportgraphics(gcf,'imgs/2_ε4_maha.png')
