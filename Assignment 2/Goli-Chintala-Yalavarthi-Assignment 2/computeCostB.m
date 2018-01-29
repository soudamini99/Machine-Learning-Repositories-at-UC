function J = computeCostB(X, y, W)

% Initialize some useful values
 m = length(y); 

% set up a vector of the same length to hold the hypothesis values 
hX = X*W;
% You need to return the following variables correctly 
%J = 0;
J = transpose(hX-y)*(hX-y)/2,2;

end
