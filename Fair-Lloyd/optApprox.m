function [Mhat] = optApprox(M, d)

coeff = pca(M, 'NumComponents', d);
P = coeff * transpose(coeff);
Mhat = M*P;

end

