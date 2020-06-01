function [centers] = findCenters(data, svar, k, clustering, isFair)

    if isFair == 0
        [n, d] = size(data);
        centers = inf(k,d);
        for i = 1:k
            iClusterSize = sum(clustering == i);
            if iClusterSize ~= 0
                iCluster = data(clustering == i, :);
                centers(i, :) = mean(iCluster, 1);
            end
        end
        
    elseif isFair == 1
        [n1, d] = size(data{1});
        [n2, ~] = size(data{2});
        centers = inf(k,d);
        muA = inf(k,d);
        muB = zeros(k,d);
        l = zeros(k, 1);
        alphaA = zeros(k,1);
        alphaB = zeros(k,1);
        deltaA = 0;
        deltaB = 0;
        for i = 1:k
            data1 = data{1}(clustering{1} == i, :);
            data2 = data{2}(clustering{2} == i, :);
            alphaA(i) = size(data1, 1) / n1;
            alphaB(i) = size(data2, 1) / n2;
            if alphaA(i) + alphaB(i) ~= 0
                if alphaA(i) == 0 || alphaB(i) == 0
                    muA(i, :) = mean([data1;data2], 1);
                    muB(i, :) = muA(i, :);
                else
                    muA(i, :) = mean(data1, 1);
                    muB(i, :) = mean(data2, 1);
                end
                l(i) = norm(muA(i, :) - muB(i, :));
                deltaA = deltaA + sum(sum((data1 - repmat(muA(i,:), size(data1, 1), 1)).^2));
                deltaB = deltaB + sum(sum((data2 - repmat(muB(i,:), size(data2, 1), 1)).^2));
            end
        end
        
        deltaA = deltaA / n1;
        
        deltaB = deltaB / n2;
        
        [cost, x] = bSearch(deltaA, deltaB, alphaA, alphaB, l);
        centers = inf(k, d);
        for i = 1:k
            if l(i) == 0
                centers(i, :) = muA(i, :);
            else
                centers(i, :) = ((l(i)-x(i))*muA(i, :) + x(i)*muB(i,:))/l(i);
            end
        end

    end
end

