clear;
close all;
datasetName = 'adult';
dateString = '_4_20_2020';
filename = [datasetName, dateString];
load(filename);
numCenters = 4:15;
numExp = numCenters(end)-numCenters(1)+1;


timearr = zeros(numExp, 1);
timeFarr = zeros(numExp, 1);
for i=numCenters
    timearr(i-numCenters(1)+1) = runtime{i};
    timeFarr(i-numCenters(1)+1) = runtimeF{i};
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

a = 10;
b=5;
c=6;

figt = figure;
set(gca,'FontSize',30);
set(gcf, 'Position', [200, 200, 600, 500])
set(gcf, 'OuterPosition', [100, 100, 800, 650]);
hold on;

plot(numCenters, timeFarr,'-o', 'MarkerSize', 14, 'Color', color2, 'LineWidth',b-1);
plot(numCenters, timearr, '-',  'Color', color12,'LineWidth',b+1)

%legend({'Fair-Lloyd', 'Lloyd'}, 'FontSize', 40, 'Interpreter', 'latex', 'Location', 'northwest');

%xlabel('k', 'FontSize', 40, 'Interpreter', 'latex');
%ylabel('running time', 'FontSize', 40, 'Interpreter', 'latex');
xlim([3 16]);
%title([datasetName, ' dataset']);
saveas(figt, [filename, '_runtime.png']);