function [V] = fairPCA(M, featureNum, sensitive)

%calculate A, B. Each A and B should be centered
% sensitive attribute has values 1 and 2
%featureNum = 65;
%[~,featureNum] = size(M);

disp("inside fairPCA")
A = M(sensitive == 1,:);
A_copy = A;


B = M(sensitive == 2,:);
B_copy = B;

mean_A = mean(A, 1);
mean_B = mean(B, 1);

% centering data for A and B
size_A = size(A, 1);

for i=1:size_A
   A_copy(i,:) = A_copy(i,:) - mean_A;
end

size_B = size(B, 1);

for i=1:size_B
   B_copy(i,:) = B_copy(i,:) - mean_B;
end

A = A_copy;
B = B_copy;


% parameters of the mw algorithm
eta = 35;
T = 10; 
    
%Fair PCA part
[P_fair, z, P_last, z_last] = mw(A, B, featureNum, eta/featureNum, T);

if z < z_last
    disp("didn't converge")
    P_smart = P_fair;
else
    P_smart = P_last;
end

%P_smart = eye(size(P_smart,1)) - sqrtm(eye(size(P_smart,1))-P_smart);

eigs(P_smart, featureNum)
[V,D] = eigs(P_smart, featureNum);
%[V, D] = eig(P_smart);

%just done with P smart as my fair PCA solution with equal loss
       
end