clear;
close all;
datasetName = 'adult';
dateString = '_4_1_2020';
filename = [datasetName, dateString];
load(filename);
numCenters = 4:15;
numExp = numCenters(end)-numCenters(1)+1;

% lloyd: original data, pca, fair pca
costNarr = zeros(2, numExp);
costarr = zeros(2, numExp);
costFPCALarr = zeros(2, numExp);

% fair-lloyd: original data, pca, fair pca
costNFarr = zeros(2, numExp);
costFarr = zeros(2, numExp);
costFFarr = zeros(2, numExp);


for i=numCenters
    costNarr(:,i-numCenters(1)+1) = CostN{i};
    costarr(:,i-numCenters(1)+1)=Cost{i};
    costFPCALarr(:,i-numCenters(1)+1)= CostPFL{i};
    
    costNFarr(:,i-numCenters(1)+1)=CostNF{i};
    costFarr(:,i-numCenters(1)+1)=CostF{i};
    costFFarr(:,i-numCenters(1)+1)=CostFF{i};
    
end

color1 = [0    0    0.8]; %dark blue
color2= [0.49 0.18 0.56];
color3 = [0.2 0.502 0.302];
color4 = [0.6 0.8 1]; % light blue
color5 = [0.9 0.7 0.3]; % yellow
color6 = 'black';
color7 = [.5 .5 .5]; % gray
color8 = [0.8510    0.3294    0.1020];
color9 =   [0.1020    0.5020    0.5020];
color10 = [0 0 1]; % blue 
color11 = [0.3020    0.7490    0.9294] % light blue
color12 = [0    0.6000    0.7412] %another blue
%color13 = [0.9020    0.3098    0.2000] %orange
color13 = [0.6    0.2    0.2]



figc=figure;
set(gca,'FontSize',30);
set(gcf, 'Position', [200, 200, 600, 500])
set(gcf, 'OuterPosition', [100, 100, 800, 650]);
hold on;
a = 10
b=4
c=6
%plot(numCenters, costNFarr(1,:), '-', 'Color', [0.6    0.8    0.5], 'LineWidth',b)

plot(numCenters, costNarr(1,:), '-o',  'Color', color6,'MarkerSize',a, 'LineWidth',b-1)
plot(numCenters, costarr (1,:), '-s',  'Color', color13,'MarkerSize',a, 'LineWidth',b-1)
plot(numCenters, costFPCALarr(1,:), '-*',  'Color', color12,'MarkerSize',a, 'LineWidth',b-1)

plot(numCenters, costNFarr(2,:), ':',  'Color', color6,'LineWidth',c)
plot(numCenters, costFarr(2,:), ':',  'Color', color13,'LineWidth',c)
plot(numCenters, costFFarr(2,:), ':',  'Color', color12,'LineWidth',c)

plot(numCenters, costNarr(2,:), '-', 'Color',   color6, 'LineWidth',b)
plot(numCenters, costarr(2,:), '-',  'Color', color13, 'LineWidth',b)
plot(numCenters, costFPCALarr(2,:), '-', 'Color', color12,'LineWidth',b)




 legend({['Lloyd w/o PCA (', groupNames{1}, ')'],...
     ['Lloyd w/ PCA (', groupNames{1}, ')'],...
     ['Lloyd w/ Fair-PCA (', groupNames{1}, ')'],...
     'Fair-Lloyd w/o PCA (Equal Cost)',...
     'Fair-Lloyd w/ PCA (Equal Cost)'...
     'Fair-Lloyd w/ Fair-PCA (Equal Cost)'...
     ['Lloyd w/o PCA (', groupNames{2}, ')'],...
     ['Lloyd w/ PCA (', groupNames{2}, ')'],...
     ['Lloyd w/ Fair-PCA (', groupNames{2}, ')']}, 'FontSize', 30, 'Interpreter', 'latex');

  xlabel('$k$', 'FontSize', 40, 'Interpreter', 'latex');
  ylabel('cost', 'FontSize', 40, 'Interpreter', 'latex');
xlim([3 16]);
%title([datasetName, ' dataset'], 'FontSize', 30, 'Interpreter', 'latex');
saveas(figc, [filename, '_cost41.png']);


