function [ parameters, costHistory ] = gradient( x, y, parameters, learningRate, repetition )
    %   Main algorithm that tries to minimize our cost functions
    
    % Getting the length of our dataset
    p = length(y);
    q = length(parameters);
    
    % Creating a vector of zeros for storing our cost function history
    costHistory = zeros(repetition, 1);
    
    % Creating a vector for storing our parameter caches
    parameterCaches = zeros(q, 1);
    
    % Running gradient descent
    for i = 1:repetition
        
        % Calculating the transpose of our hypothesis
         for j = 1:p
            r(1,j) = parameters(1,1)*x(j,1) + parameters(2,1) * x(j,2) + parameters(3,1) * x(j,3);
         end
        % Caching the new theta and slope for simultaneous update
        for j = 1:q
            parameterCaches(j) = parameters(j) - learningRate * (1/p) * (r-y') * x(:, j);
        end
       %fprintf("parametrs");
       disp(parameterCaches); 
        
        % Updating the parameters simultaneously
        for j = 1:q
            parameters(j) = parameterCaches(j);
        end
        % Keeping track of the cost function
        costHistory(i) = cost(x, y, parameters, r);
        
    end
        disp(size(y));
        disp(size(x));
        disp(size(r));
        disp(size(parameters));
    
end

