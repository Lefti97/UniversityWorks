close all;
clear all;
clc;

if not(isfolder('imgs'))
    mkdir('imgs')
end

% 1.6: Εισαγωγή NaNs στο Iris dataset
load iris.dat;
p = 0.60;
irisV=iris;
[ro,co]=size(iris);
r1=randperm(ro);
irisV(r1(1:p*ro),1)=NaN;
r1=randperm(ro);
irisV(r1(1:p*ro),2)=NaN;
r1=randperm(ro);
irisV(r1(1:p*ro),3)=NaN;
r1=randperm(ro);
irisV(r1(1:p*ro),4)=NaN;

%1.α
%1.7: Αντικατάσταση/Διαγραφή NaNs στο Iris dataset
%1: Διαγραφή γραμμών με NaNs
irisVtmp=irisV;
irisVtmp(any(isnan(irisVtmp),2),:)=[];
plot(irisVtmp);
title('1α) Διαγραφή γραμμών με NaNs')
exportgraphics(gcf,'imgs/1_α1.png')

%2: Διαγραφή στηλών με NaNs
irisVtmp=irisV;
irisVtmp(:,any(isnan(irisVtmp),1))=[];
plot(irisVtmp);
title('1α) Διαγραφή στηλών με NaNs')
exportgraphics(gcf,'imgs/1_α2.png')

%3: Αντικατάσταση NaN με 0
irisVtmp=irisV;
notNaN=~isnan(irisVtmp);
irisVtmp(~notNaN)=0;
plot(irisVtmp);
title('1α) Αντικατάσταση NaNs με 0')
exportgraphics(gcf,'imgs/1_α3.png')

%4: Αντικατάσταση NaN με την μέση τιμή στήλης
irisVtmp=irisV;
notNaN=~isnan(irisVtmp);
irisVtmp(~notNaN)=0;
totalNo=sum(notNaN);
columnTot=sum(irisVtmp);
colMean=columnTot./totalNo;
for i = 1:length(colMean)
    irisVtmp(find(notNaN(:,i)==0),i)=colMean(i);
end
plot(irisVtmp);
title('1α) Αντικατάσταση NaNs με την μέση τιμή')
exportgraphics(gcf,'imgs/1_α4.png')

%1.β
%1.8: Κανονικοποίηση δεδομένων

data = [-0.3999 -0.2625 -1.0106
        0.6900 0.2573 0.6145
        0.8156 -1.0565 0.5077
        0.7119 -0.2625 -0.0708
        0.4376 -0.8051 0.5913
        0.6686 0.5287 -0.6436
        1.1908 0.2193 0.3803
        0.4376 -0.9219 -1.0091
        -0.0198 -0.2625 -0.0195
        -0.1567 -0.0592 -0.0482];

% Κανονικοποίηση data
% Data στήλη 1
ltData = LinearTransform(data(:,1));
zsData = zscoreTransform(data(:,1));

subplot(3,1,1);
plot(data(:,1));
title('Initial')  
subplot(3,1,2);
plot(ltData);
title('Linear Transformation')  
subplot(3,1,3);
plot(zsData);
title('Zscore Transformation')  
sgtitle('1β) Data στήλη 1 ') 
exportgraphics(gcf,'imgs/1_β_data1.png')

% Data στήλη 2
ltData = LinearTransform(data(:,2));
zsData = zscoreTransform(data(:,2));

subplot(3,1,1);
plot(data(:,2));
title('Initial')  
subplot(3,1,2);
plot(ltData);
title('Linear Transformation')  
subplot(3,1,3);
plot(zsData);
title('Zscore Transformation')  
sgtitle('1β) Data στήλη 2 ') 
exportgraphics(gcf,'imgs/1_β_data2.png')

% Data στήλη 3
ltData = LinearTransform(data(:,3));
zsData = zscoreTransform(data(:,3));

subplot(3,1,1);
plot(data(:,3));
title('Initial')  
subplot(3,1,2);
plot(ltData);
title('Linear Transformation')  
subplot(3,1,3);
plot(zsData);
title('Zscore Transformation')  
sgtitle('1β) Data στήλη 3 ') 
exportgraphics(gcf,'imgs/1_β_data3.png')


% Κανονικοποίηση iris

% Iris στήλη 1
ltIris = LinearTransform(iris(:,1));
zsIris = zscoreTransform(iris(:,1));

subplot(3,1,1);
plot(iris(:,1));
title('Initial')  
subplot(3,1,2);
plot(ltIris);
title('Linear Transformation')  
subplot(3,1,3);
plot(zsIris);
title('Zscore Transformation')  
sgtitle('1β) IRIS στήλη 1 ') 
exportgraphics(gcf,'imgs/1_β_iris1.png')

% Iris στήλη 2
ltIris = LinearTransform(iris(:,2));
zsIris = zscoreTransform(iris(:,2));

subplot(3,1,1);
plot(iris(:,2));
title('Initial')  
subplot(3,1,2);
plot(ltIris);
title('Linear Transformation')  
subplot(3,1,3);
plot(zsIris);
title('Zscore Transformation')  
sgtitle('1β) IRIS στήλη 2 ') 
exportgraphics(gcf,'imgs/1_β_iris2.png')

% Iris στήλη 3
ltIris = LinearTransform(iris(:,3));
zsIris = zscoreTransform(iris(:,3));

subplot(3,1,1);
plot(iris(:,3));
title('Initial')  
subplot(3,1,2);
plot(ltIris);
title('Linear Transformation')  
subplot(3,1,3);
plot(zsIris);
title('Zscore Transformation')  
sgtitle('1β) IRIS στήλη 3 ') 
exportgraphics(gcf,'imgs/1_β_iris3.png')

% Iris στήλη 4
ltIris = LinearTransform(iris(:,4));
zsIris = zscoreTransform(iris(:,4));

subplot(3,1,1);
plot(iris(:,4));
title('Initial')  
subplot(3,1,2);
plot(ltIris);
title('Linear Transformation')  
subplot(3,1,3);
plot(zsIris);
title('Zscore Transformation')  
sgtitle('1β) IRIS στήλη 4 ') 
exportgraphics(gcf,'imgs/1_β_iris4.png')
