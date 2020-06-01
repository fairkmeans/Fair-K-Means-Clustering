clear;
close all;
datasetName = 'adult';
dateString = '_4_1_2020';
filename = [datasetName, dateString];
load(filename);
numCenters = 4:15;
numExp = numCenters(end)-numCenters(1)+1;
costFFarr = zeros(2, numExp);
costFPCALarr = zeros(2, numExp);

for i=numCenters
    costFFarr(:,i-numCenters(1)+1)=CostFF{i};
    costFPCALarr(:,i-numCenters(1)+1)=CostPFL{i};
end


lightGreen = [0.6    0.2    0.5];
%purple= [0.49 0.18 0.56];
purple = [0.2 0.502 0.302];
%lightBlue = [0.6 0.8 1];
lightBlue = [0.9 0.7 0.3];
darkBlue = [0 0 .5];



figc=figure;
set(gca,'FontSize',30);
set(gcf, 'Position', [200, 200, 600, 500])
set(gcf, 'OuterPosition', [100, 100, 800, 650]);
hold on;
a = 9
b=6
%plot(numCenters, costNFarr(1,:), '-', 'Color', [0.6    0.8    0.5], 'LineWidth',b)
plot(numCenters, costFPCALarr(1,:), '-', 'Color',   lightGreen, 'LineWidth',b)
plot(numCenters, costFFarr(2,:), '-', 'Color', lightBlue, 'LineWidth',b)
plot(numCenters, costFPCALarr(2,:), '-',  'Color', darkBlue,'LineWidth',b)

% legend({['Lloyd (', groupNames{1}, ')'],...
%     'Fair-Lloyd (equal cost)',...
%     ['Lloyd (', groupNames{2}, ')']}, 'FontSize', 30, 'Interpreter', 'latex');

% xlabel('$k$', 'FontSize', 30, 'Interpreter', 'latex');
% ylabel('cost', 'FontSize', 30, 'Interpreter', 'latex');
xlim([3 16]);
% title([datasetName, ' dataset'], 'FontSize', 30, 'Interpreter', 'latex');
saveas(figc, [filename, '_cost32.png']);


