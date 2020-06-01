clear;
close all;
%addpath(fullfile('/Users/SamiraSamadi/'));
datasetName = 'adult';
dateString = '_4_1_2020';
filename = [datasetName, dateString];
load(filename);
numCenters = 4:15;
numExp = numCenters(end)-numCenters(1)+1;
costNFarr = zeros(2, numExp);
costNarr = zeros(2, numExp);

for i=numCenters
    costNFarr(:,i-numCenters(1)+1)=CostNF{i};
    costNarr(:,i-numCenters(1)+1)=CostN{i};
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
b=8
%plot(numCenters, costNFarr(1,:), '-', 'Color', [0.6    0.8    0.5], 'LineWidth',b)
plot(numCenters, costNarr(1,:), '-', 'Color',   lightGreen, 'LineWidth',b)
%plot(numCenters, costNFarr(2,:), '-', 'Color', lightBlue, 'LineWidth',b)
plot(numCenters, costNarr(2,:), '-',  'Color', darkBlue,'LineWidth',b)

% legend({['Lloyd (', groupNames{1}, ')'],...
%     'Fair-Lloyd (Equal Cost)',...
%     ['Lloyd (', groupNames{2}, ')']}, 'FontSize', 40, 'Interpreter', 'latex');

legend({groupNames{1},groupNames{2}}, 'FontSize', 40, 'Interpreter', 'latex');


 xlabel('$k$', 'FontSize', 40, 'Interpreter', 'latex');
 ylabel('cost', 'FontSize', 40, 'Interpreter', 'latex');
xlim([3 16]);
%title([datasetName, ' dataset'], 'FontSize', 40, 'FontWeight', 'bold', 'Interpreter', 'latex');
saveas(figc, [filename, '_costIntro.png']);


