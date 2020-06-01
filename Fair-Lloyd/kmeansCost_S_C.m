function [cost] = kmeansCost_S_C(data, clustering, centers, flag)

% Given the clustering (as an 1*n array having the cluster indices) and 
% the corresponding centers (k*d matrix),
% calculate the k-means cost
% flag is 0 when we calculate the cost by summing squares of distances to
% the center. Flag is 1 when we calculate the cost by calcuting it from
% furmula ....

    k = max(clustering);
    cost = 0;
    for i = 1:k 
        iClusterFlag = (clustering == i);
        if sum(iClusterFlag) == 0
            continue;
        end
        iCluster = data(iClusterFlag, :);
        iClusterSize = sum(iClusterFlag);
        
        if flag == 0
            diff = iCluster - repmat(centers(i,:), iClusterSize, 1);
            iClusterCost = sum(sum(diff.^2));
        else
            diff = iCluster - repmat(mean(iCluster), iClusterSize, 1);
            iClusterCost = sum(sum(diff.^2)) + iClusterSize * norm(mean(iCluster, 1)-centers(i,:))^2;
        end
        
        cost = cost + iClusterCost;
        
    end

end
