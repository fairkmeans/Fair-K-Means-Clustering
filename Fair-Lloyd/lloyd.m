function [centers, clustering, runtime] =...
    lloyd(data, svar, k, numIters, bestOutOf, randCenters, isFair)
    
    minCost = inf;
    runtime = 0;
    datasep = cell(1,2);
    if isFair == 1
        datasep{1} = data(svar == 1, :);
        datasep{2} = data(svar == 2, :);
        data = datasep;
        dataTemp = [data{1};data{2}];
        ns = [size(data{1}, 1), size(data{2}, 1)];
    else
        dataTemp = data;
        ns = [1, 1];
    end
    for i = 1:bestOutOf
        disp(i);
        currentCenters = squeeze(randCenters(i, :, :));
        
        tStart = tic;
        
        for j = 1:numIters
            if j == numIters
                currentClustering = findClustering(dataTemp, ns, currentCenters, 1, isFair);
            else
                currentClustering = findClustering(dataTemp, ns, currentCenters, 0, isFair);
                currentCenters =...
                    findCenters(data, svar, k, currentClustering, isFair);
            end
        end
        
        runtime = runtime + toc(tStart);
        
        currentCost = compCost(data, svar, k, currentClustering, isFair);
        
        if minCost > currentCost
            minCost = currentCost;
            centers = currentCenters;
            clustering = currentClustering;
        end
    end
    
    runtime = runtime / bestOutOf;
end

