function [costs] = compCost(data, svar, k, clustering, isFair)


    centers = findCenters(data, svar, k, clustering, isFair);    
    
    costs = zeros(2, 1);
    
    if isFair == 0
    
        g1 = (svar == 1);
        g2 = (svar == 2);

        costs(1) = kmeansCost_S_C(data(g1,:), clustering(g1), centers, 1) / sum(g1);
        costs(2) = kmeansCost_S_C(data(g2,:), clustering(g2), centers, 1) / sum(g2);
        
    else
        
        costs(1) = kmeansCost_S_C(data{1}, clustering{1}, centers, 1) / size(data{1}, 1);
        costs(2) = kmeansCost_S_C(data{2}, clustering{2}, centers, 1) / size(data{2}, 1);
        
    end

end

