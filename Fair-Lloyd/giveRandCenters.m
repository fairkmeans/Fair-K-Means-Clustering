function [randCenters, randCentersPF, randCentersN] = giveRandCenters(data, dataPF, dataN, k, bestOutOf)

    [n, d] = size(data);
    [n, dp] = size(dataN);
    randCenters = zeros(bestOutOf, k, d);
    randCentersPF = zeros(bestOutOf, k, d);
    randCentersN = zeros(bestOutOf, k, dp);
    for i = 1:bestOutOf
        randPermutation = randperm(n);
        randCenters(i, :, :) = data(randPermutation(1:k), :);
        randCentersPF(i, :, :) = dataPF(randPermutation(1:k), :);
        randCentersN(i, :, :) = dataN(randPermutation(1:k), :);
    end
end

