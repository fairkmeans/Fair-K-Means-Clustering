function [cost, x] = bSearch(deltaA, deltaB, alphaA, alphaB, l)

    gamma = 0.5;
    gammal = 1;
    gammah = 0;
    
    for i = 1:64
        
        x = (1 - gamma) * alphaB .* l ./ (gamma * alphaA + (1 - gamma) * alphaB);
        
        f = deltaA + sum(x .* alphaA .* x);
        g = deltaB + sum((l-x) .* alphaB .* (l-x));
        
        cost = max(f, g);
        
        if abs(f - g) < 10^(-10)
            break;
        end
        
        if f > g
            gammah = gamma;
            gamma = (gamma + gammal) / 2;
        elseif f < g
            gammal = gamma;
            gamma = (gamma + gammah) / 2;
        end
    end
end

