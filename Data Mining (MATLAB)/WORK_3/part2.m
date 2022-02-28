load iris.dat
load xV.mat

if not(isfolder('imgs'))
    mkdir('imgs')
end

% ΠΑΡΑΔΕΙΓΜΑ 1

% IRIS Διαστάσεις 3 και 4 [3:4], sqEuclidian απόσταση
X=iris(:,[3:4]);
k=3;
[IDX,C] = kmeans(X,k);
figure(1)
plot(X(IDX==1,1),X(IDX==1,2),'r.','MarkerSize',12)
hold on
plot(X(IDX==2,1),X(IDX==2,2),'b.','MarkerSize',12)
hold on
plot(X(IDX==3,1),X(IDX==3,2),'c.','MarkerSize',12)
hold on
plot(C(:,1),C(:,2),'kx', 'MarkerSize',12,'LineWidth',2)
plot(C(:,1),C(:,2),'ko', 'MarkerSize',12,'LineWidth',2)
legend('C1','C2','C3','Centroids', 'Location','NW')
title('IRIS[3:4] Συσταδοποίηση, sqEuclidian')
exportgraphics(gcf,'imgs/2_iris_34_eucl.png')

% IRIS Όλες οι διαστάσεις [1:4], sqEuclidian απόσταση
X=iris(:,[1:4]);
k=3;
[IDX,C] = kmeans(X,k);
figure(2)
plot(X(IDX==1,1),X(IDX==1,2),'r.','MarkerSize',12)
hold on
plot(X(IDX==2,1),X(IDX==2,2),'b.','MarkerSize',12)
hold on
plot(X(IDX==3,1),X(IDX==3,2),'c.','MarkerSize',12)
hold on
plot(C(:,1),C(:,2),'kx', 'MarkerSize',12,'LineWidth',2)
plot(C(:,1),C(:,2),'ko', 'MarkerSize',12,'LineWidth',2)
legend('C1','C2','C3','Centroids', 'Location','NW')
title('IRIS[1:4] Συσταδοποίηση, sqEuclidian')
exportgraphics(gcf,'imgs/2_iris_1234_eucl.png')

% IRIS Διαστάσεις 1 και 3 [1,3], sqEuclidian απόσταση
X=iris(:,[1,3]);
k=3;
[IDX,C] = kmeans(X,k);
figure(3)
plot(X(IDX==1,1),X(IDX==1,2),'r.','MarkerSize',12)
hold on
plot(X(IDX==2,1),X(IDX==2,2),'b.','MarkerSize',12)
hold on
plot(X(IDX==3,1),X(IDX==3,2),'c.','MarkerSize',12)
hold on
plot(C(:,1),C(:,2),'kx', 'MarkerSize',12,'LineWidth',2)
plot(C(:,1),C(:,2),'ko', 'MarkerSize',12,'LineWidth',2)
legend('C1','C2','C3','Centroids', 'Location','NW')
title('IRIS[1,3] Συσταδοποίηση, sqEuclidian')
exportgraphics(gcf,'imgs/2_iris_13_eucl.png')

% IRIS Διαστάσεις 1 έως 3 [1:3], sqEuclidian απόσταση
X=iris(:,[1:3]);
k=3;
[IDX,C] = kmeans(X,k);
figure(4)
plot(X(IDX==1,1),X(IDX==1,2),'r.','MarkerSize',12)
hold on
plot(X(IDX==2,1),X(IDX==2,2),'b.','MarkerSize',12)
hold on
plot(X(IDX==3,1),X(IDX==3,2),'c.','MarkerSize',12)
hold on
plot(C(:,1),C(:,2),'kx', 'MarkerSize',12,'LineWidth',2)
plot(C(:,1),C(:,2),'ko', 'MarkerSize',12,'LineWidth',2)
legend('C1','C2','C3','Centroids', 'Location','NW')
title('IRIS[1:3] Συσταδοποίηση, sqEuclidian')
exportgraphics(gcf,'imgs/2_iris_123_eucl.png')

% IRIS Διαστάσεις 1, 3 και 4 [1,2,4], sqEuclidian απόσταση
X=iris(:,[1,2,4]);
k=3;
[IDX,C] = kmeans(X,k);
figure(5)
plot(X(IDX==1,1),X(IDX==1,2),'r.','MarkerSize',12)
hold on
plot(X(IDX==2,1),X(IDX==2,2),'b.','MarkerSize',12)
hold on
plot(X(IDX==3,1),X(IDX==3,2),'c.','MarkerSize',12)
hold on
plot(C(:,1),C(:,2),'kx', 'MarkerSize',12,'LineWidth',2)
plot(C(:,1),C(:,2),'ko', 'MarkerSize',12,'LineWidth',2)
legend('C1','C2','C3','Centroids', 'Location','NW')
title('IRIS[1,2,4] Συσταδοποίηση, sqEuclidian')
exportgraphics(gcf,'imgs/2_iris_124_eucl.png')

% IRIS Διαστάσεις 3 και 4, cityblock απόσταση
X=iris(:,[3:4]);
k=3;
[IDX,C] = kmeans(X,k, 'distance','cityblock');
figure(6)
plot(X(IDX==1,1),X(IDX==1,2),'r.','MarkerSize',12)
hold on
plot(X(IDX==2,1),X(IDX==2,2),'b.','MarkerSize',12)
hold on
plot(X(IDX==3,1),X(IDX==3,2),'c.','MarkerSize',12)
hold on
plot(C(:,1),C(:,2),'kx', 'MarkerSize',12,'LineWidth',2)
plot(C(:,1),C(:,2),'ko', 'MarkerSize',12,'LineWidth',2)
legend('C1','C2','C3','Centroids', 'Location','NW')
title('IRIS[3:4] Συσταδοποίηση, cityblock')
exportgraphics(gcf,'imgs/2_iris_34_city.png')

% IRIS Διαστάσεις 3 και 4, cosine απόσταση
X=iris(:,[3:4]);
k=3;
[IDX,C] = kmeans(X,k, 'distance','cosine');
figure(7)
plot(X(IDX==1,1),X(IDX==1,2),'r.','MarkerSize',12)
hold on
plot(X(IDX==2,1),X(IDX==2,2),'b.','MarkerSize',12)
hold on
plot(X(IDX==3,1),X(IDX==3,2),'c.','MarkerSize',12)
hold on
plot(C(:,1),C(:,2),'kx', 'MarkerSize',12,'LineWidth',2)
plot(C(:,1),C(:,2),'ko', 'MarkerSize',12,'LineWidth',2)
legend('C1','C2','C3','Centroids', 'Location','NW')
title('IRIS[3:4] Συσταδοποίηση, cosine')
exportgraphics(gcf,'imgs/2_iris_34_cos.png')

% IRIS Διαστάσεις 3 και 4, correlation απόσταση
X=iris(:,[3:4]);
k=3;
[IDX,C] = kmeans(X,k, 'distance','correlation');
figure(8)
plot(X(IDX==1,1),X(IDX==1,2),'r.','MarkerSize',12)
hold on
plot(X(IDX==2,1),X(IDX==2,2),'b.','MarkerSize',12)
hold on
plot(X(IDX==3,1),X(IDX==3,2),'c.','MarkerSize',12)
hold on
plot(C(:,1),C(:,2),'kx', 'MarkerSize',12,'LineWidth',2)
plot(C(:,1),C(:,2),'ko', 'MarkerSize',12,'LineWidth',2)
legend('C1','C2','C3','Centroids', 'Location','NW')
title('IRIS[3:4] Συσταδοποίηση, correlation')
exportgraphics(gcf,'imgs/2_iris_34_corr.png')


% ΠΑΡΑΔΕΙΓΜΑ 2

% xV Αντικατάσταση Nans με την μέση τιμή της στήλης
notNaN=~isnan(xV);
xV(~notNaN)=0;
totalNo=sum(notNaN);
columnTot=sum(xV);
colMean=columnTot./totalNo;
for i = 1:length(colMean)
    xV(find(notNaN(:,i)==0),i)=colMean(i);
end

% xV Διαστάσεις 1 και 2 [1:2], sqEuclidian απόσταση
X=xV(:,[1:2]);
k=3;
[IDX,C] = kmeans(X,k);
figure(9)
plot(X(IDX==1,1),X(IDX==1,2),'r.','MarkerSize',12)
hold on
plot(X(IDX==2,1),X(IDX==2,2),'b.','MarkerSize',12)
hold on
plot(X(IDX==3,1),X(IDX==3,2),'c.','MarkerSize',12)
hold on
plot(C(:,1),C(:,2),'kx', 'MarkerSize',12,'LineWidth',2)
plot(C(:,1),C(:,2),'ko', 'MarkerSize',12,'LineWidth',2)
legend('C1','C2','C3','Centroids', 'Location','NW')
title('xV[1:2] Συσταδοποίηση, sqEuclidian')
exportgraphics(gcf,'imgs/2_xV_12_eucl.png')

% xV όλες οι διαστάσεις, sqEuclidian απόσταση
X=xV(:,:);
k=3;
[IDX,C] = kmeans(X,k);
figure(10)
plot(X(IDX==1,1),X(IDX==1,2),'r.','MarkerSize',12)
hold on
plot(X(IDX==2,1),X(IDX==2,2),'b.','MarkerSize',12)
hold on
plot(X(IDX==3,1),X(IDX==3,2),'c.','MarkerSize',12)
hold on
plot(C(:,1),C(:,2),'kx', 'MarkerSize',12,'LineWidth',2)
plot(C(:,1),C(:,2),'ko', 'MarkerSize',12,'LineWidth',2)
legend('C1','C2','C3','Centroids', 'Location','NW')
title('xV[Όλα] Συσταδοποίηση, sqEuclidian')
exportgraphics(gcf,'imgs/2_xV_all_eucl.png')

% xV Διαστάσεις 295 και 305 [295,305], sqEuclidian απόσταση
X=xV(:,[295,305]);
k=3;
[IDX,C] = kmeans(X,k);
figure(11)
plot(X(IDX==1,1),X(IDX==1,2),'r.','MarkerSize',12)
hold on
plot(X(IDX==2,1),X(IDX==2,2),'b.','MarkerSize',12)
hold on
plot(X(IDX==3,1),X(IDX==3,2),'c.','MarkerSize',12)
hold on
plot(C(:,1),C(:,2),'kx', 'MarkerSize',12,'LineWidth',2)
plot(C(:,1),C(:,2),'ko', 'MarkerSize',12,'LineWidth',2)
legend('C1','C2','C3','Centroids', 'Location','NW')
title('xV[295,305] Συσταδοποίηση, sqEuclidian')
exportgraphics(gcf,'imgs/2_xV_295_305_eucl.png')