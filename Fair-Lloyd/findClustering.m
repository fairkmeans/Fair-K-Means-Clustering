function [clusterIdx] = findClustering(data, ns, centers, isLast, isFair)

    k = size(centers, 1);
    n = size(data, 1);
    if isFair == 0
        dists = zeros(k, n);
        for i = 1:k
            dists(i, :) = (sum((data - centers(i, :)).^2, 2))';
        end
        [~, clusterIdx] = min(dists);

        if isLast == 0
            clusNum = zeros(1, k);
            for i=1:k
                clusNum(i) = sum(clusterIdx == i);
            end
            for i = 1:k
                if clusNum(i) == 0
                    [~,sArr] = sort(sum((data - centers(i, :)).^2, 2));
                    for j = 1:n
                        temp = clusterIdx(sArr(j));
                        if clusNum(temp) > 1
                            clusNum(i) = clusNum(i) + 1;
                            clusNum(temp) = clusNum(temp) - 1;
                            clusterIdx(sArr(j)) = i;
                            break;
                        end
                    end
                end
            end
        end
    else
        dists = zeros(k, n);
        for i = 1:k
            dists(i, :) = (sum((data - centers(i, :)).^2, 2))';
        end
        [~, clusterTemp] = min(dists);
        clusterIdx = cell(1,2);
        clusterIdx{1} = clusterTemp(1:ns(1));
        clusterIdx{2} = clusterTemp((ns(1)+1):end);

        if isLast == 0
            clusNum = zeros(1, k);
            for i=1:k
                clusNum(i) = sum(clusterTemp == i);
            end
            for i = 1:k
                if clusNum(i) == 0
                    [~,sArr] = sort(sum((data - centers(i, :)).^2, 2));
                    for j = 1:n
                        if sArr(j) <= n1
                            temp = clusterIdx{1}(sArr(j));
                            tempi = 1;
                        else
                            temp = clusterIdx{2}(sArr(j) - n1);
                            tempi = 2;
                        end
                        if clusNum(temp) > 1
                            clusNum(i) = clusNum(i) + 1;
                            clusNum(temp) = clusNum(temp) - 1;
                            if tempi == 1
                                clusterIdx{1}(sArr(j)) = i;
                            else
                                clusterIdx{2}(sArr(j) - n1) = i;
                            end
                            break;
                        end
                    end
                end
            end
        end
    end
end

