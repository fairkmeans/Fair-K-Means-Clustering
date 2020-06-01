clear;
close all;
addpath('resultsData');
datasetName = 'LFW';
dateString = '_4_25_2020';
filename = [datasetName, dateString];
load(filename);
numCenters = 4:15;
numExp = numCenters(end)-numCenters(1)+1;
costarr = zeros(2, numExp);
costFarr = zeros(2, numExp);

for i=numCenters
    costarr(:,i-numCenters(1)+1)=Cost{i};
    costFarr(:,i-numCenters(1)+1)=CostF{i};
end



figc=figure;
set(gca,'FontSize',30);
set(gcf, 'Position', [200, 200, 600, 500])
set(gcf, 'OuterPosition', [100, 100, 800, 650]);
hold on;
a = 9
b=6

lightGreen = [0.6    0.2    0.5];
%purple= [0.49 0.18 0.56];
purple = [0.2 0.502 0.302];
%lightBlue = [0.6 0.8 1];
lightBlue = [0.9 0.7 0.3];
darkBlue = [0 0 .5];



plot(numCenters, costarr(1,:), '-', 'Color', lightGreen, 'LineWidth',b)
plot(numCenters, costFarr(1,:), '-o', 'Color',   purple, 'MarkerSize',a, 'LineWidth',b)
plot(numCenters, costFarr(2,:), '-', 'Color',   lightBlue, 'LineWidth',b)
plot(numCenters, costarr(2,:), '-',  'Color', darkBlue,'LineWidth',b)

% legend({['Lloyd (',groupNames{1}, ')'], ...
%     ['Fair-Lloyd (',groupNames{1}, ')'], ...
%     ['Fair-Lloyd (', groupNames{2}, ')'],...
%     ['Lloyd (', groupNames{2}, ')']}, 'FontSize', 30, 'Interpreter', 'latex');
xlabel('$k$', 'FontSize', 40, 'Interpreter', 'latex');
ylabel('cost', 'FontSize', 40, 'Interpreter', 'latex');
xlim([3 16]);
%title([datasetName, ' dataset'], 'FontSize', 30, 'Interpreter', 'latex');
saveas(figc, [filename, '_cost21.png']);


