function [dataP] = projectData(data, svar, numFeatures, isFair)
    
    if isFair == 0
        [coeff, score, latent] = pca(data);
        P = coeff(:, 1:numFeatures);
    elseif isFair == 1
        % we do fair PCA here
        P = fairPCA(data, numFeatures, svar); 
    end
    dataP = data * P;
end

