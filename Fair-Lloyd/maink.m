clear;
close all;

randomSeed=12345;
rng(randomSeed);

% Input of loadData is either 'credit', 'adult', or 'LFW'
% 'svar' is the sensitive variable
datasetName = 'credit';
[dataAll, svarAll, groupNames] = loadData(datasetName);

bestOutOf = 10;
numIters = 10;
numCenters = 4:15;

numAllDataPts = size(dataAll, 1);
randPts = randperm(numAllDataPts);

data = dataAll;
svar = svarAll;

% This function normalize the data (mean 0 & variance 1) + does (fair) PCA
% The second argument determines whether the PCA is fair or not
datawoPCA = normalizeData(data);

if strcmp(datasetName, 'LFW')
    dataN = projectData(datawoPCA, svar, 80, 0);
else
    dataN = datawoPCA;
end

dataP = cell(numCenters(end),1);
dataPF = cell(numCenters(end),1);
randCenters = cell(numCenters(end),1);
randCentersPF = cell(numCenters(end),1);
randCentersN = cell(numCenters(end),1);

centers = cell(numCenters(end),1);
clustering = cell(numCenters(end),1);
runtime = cell(numCenters(end),1);
centersF = cell(numCenters(end),1);
clusteringF = cell(numCenters(end),1);
runtimeF = cell(numCenters(end),1);
centersFF = cell(numCenters(end),1);
clusteringFF = cell(numCenters(end),1);
runtimeFF = cell(numCenters(end),1);
centersN = cell(numCenters(end),1);
clusteringN = cell(numCenters(end),1);
runtimeN = cell(numCenters(end),1);
centersNF = cell(numCenters(end),1);
clusteringNF = cell(numCenters(end),1);
runtimeNF = cell(numCenters(end),1);
centersPFL = cell(numCenters(end),1);
clusteringPFL = cell(numCenters(end),1);
runtimePFL = cell(numCenters(end),1);

Cost = cell(numCenters(end),1);
CostP = cell(numCenters(end),1);
CostF = cell(numCenters(end),1);
CostPF = cell(numCenters(end),1);
CostFF = cell(numCenters(end),1);
CostPFF = cell(numCenters(end),1);
CostN = cell(numCenters(end),1);
CostNF = cell(numCenters(end),1);
CostPFL = cell(numCenters(end),1);
CostPPFL = cell(numCenters(end),1);

for k=numCenters
    disp(k);
    numFeatures = k;
    dataP{k} = projectData(datawoPCA, svar, numFeatures, 0);
    dataPF{k} = projectData(datawoPCA, svar, numFeatures, 1);

    [randCenters{k}, randCentersPF{k}, randCentersN{k}] = giveRandCenters(dataP{k}, dataPF{k}, dataN, k, bestOutOf);

    [centers{k}, clustering{k}, runtime{k}] =...
        lloyd(dataP{k}, svar, k, numIters, bestOutOf, randCenters{k}, 0);

    [centersF{k}, clusteringF{k}, runtimeF{k}] =...
        lloyd(dataP{k}, svar, k, numIters, bestOutOf, randCenters{k}, 1);

    [centersFF{k}, clusteringFF{k}, runtimeFF{k}] =...
        lloyd(dataPF{k}, svar, k, numIters, bestOutOf, randCentersPF{k}, 1);
    
    [centersPFL{k}, clusteringPFL{k}, runtimePFL{k}] =...
        lloyd(dataPF{k}, svar, k, numIters, bestOutOf, randCentersPF{k}, 0);
    
    [centersN{k}, clusteringN{k}, runtimeN{k}] =...
        lloyd(dataN, svar, k, numIters, bestOutOf, randCentersN{k}, 0);
    
    [centersNF{k}, clusteringNF{k}, runtimeNF{k}] =...
        lloyd(dataN, svar, k, numIters, bestOutOf, randCentersN{k}, 1);

    Cost{k} = compCost(datawoPCA, svar, k, clustering{k}, 0);
    CostF{k} = compCost({datawoPCA(svar==1,:), datawoPCA(svar==2,:)}, ...
        svar, k, clusteringF{k}, 1);
    CostFF{k} = compCost({datawoPCA(svar==1,:), datawoPCA(svar==2,:)}, ...
        svar, k, clusteringFF{k}, 1);
    CostN{k} = compCost(datawoPCA, svar, k, clusteringN{k}, 0);
    CostNF{k} = compCost({datawoPCA(svar==1,:), datawoPCA(svar==2,:)}, ...
        svar, k, clusteringNF{k}, 1);
    CostPFL{k} = compCost(datawoPCA, svar, k, clusteringPFL{k}, 0);
    
end

save([datasetName, '_4_26_2020']);
