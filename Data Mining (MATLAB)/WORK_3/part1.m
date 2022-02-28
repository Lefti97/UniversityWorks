load enron100.mat;

if not(isfolder('imgs'))
    mkdir('imgs')
end

% 1)
d=pdist(en2(1:100,2:3),'jaccard');
Z=linkage(d);
figure(1)
[H,T]=dendrogram(Z,'ColorThreshold','default');
title('1) Μέθοδος απλού δεσμού με δείκτη Jaccard')
exportgraphics(gcf,'imgs/1_simple_Jaccard.png')

% 2)
d=pdist(en2(1:100,2:3),'cosine');
Z=linkage(d);
figure(2)
[H,T]=dendrogram(Z,'ColorThreshold','default');
title('2) Μέθοδος απλού δεσμού με δείκτη Cosine')
exportgraphics(gcf,'imgs/1_simple_Cosine.png')

% 3)
d=pdist(en2(1:100,2:3),'cosine');
Z=linkage(d, 'median');
figure(3)
[H,T]=dendrogram(Z,'ColorThreshold','default');
title('3) Μέθοδος μέσου δεσμού με δείκτη Cosine')
exportgraphics(gcf,'imgs/1_median_Cosine.png')