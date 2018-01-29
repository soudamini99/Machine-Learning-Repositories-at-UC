function J = computeCostB(X, y, W)

%COMPUTECOST Compute cost for linear regression

% J = COMPUTECOST(X, y, W) computes the cost of using the weight vector
% W as the parameter for linear regression to fit the data points in X and y


% Initialize some useful values

 m = length(y); 
% extract the number of training examples


% set up a vector of the same length to hold the hypothesis values 
%hX=zeros(m,1);

hX = X*W;
% You need to return the following variables correctly 
%J = 0;
J = transpose(hX-y)*(hX-y)/2,2;

% ====================== INCLUDE YOUR CODE HERE ======================

% Instructions: Compute the cost of a particular choice of W

%               You should set J to the cost.

%hX= ......
% evaluate the hypothesis
 %J = ......
% evaluate the cost : the mean of the square errors 
         
% between the true output, y the output generate by the hypothesis
          
% divide it by 2 as well... 



end
