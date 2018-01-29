function [ cost ] = cost( x, y, parameters, h )
    %   Calculates the cost function
    
    for i = 1:length(y)
        error(1,i) = (h(1,i) - y(i,1)).^2;
    end
    
    cost = sum(error)/ 2 * length(y);
   %disp(cost); 
end
