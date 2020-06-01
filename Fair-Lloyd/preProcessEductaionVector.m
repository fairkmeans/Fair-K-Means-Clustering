function [sensitive] = preProcessEductaionVector(vec)

    n = size(vec, 1);
    sensitive = zeros(1, n);
    
    % education = 1&2 --> 1
    % otherwise  -->2
    
    for i=1:n
        if (vec(i) ==1 || vec(i)==2)
            sensitive(i) = 1;
        else
            sensitive(i) = 2;      
        end
    end
         
end