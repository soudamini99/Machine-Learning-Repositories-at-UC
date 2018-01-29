%%  Linear Regression

% 
%     plotDataB.m
%     gradientDescentB.m
%     computeCostB.m
%     
%


%% Initialization
clear ; close all; clc


%% ======================= Part 1: Plotting =======================
fprintf('Plotting Data ...\n')

% read in the data set
data = load('HM1data1.txt');

% The data set is 2-dimensional:

% The 1st column, X, is the independent variable,
% and it refers to the population zise in 10,000s

% The second column, y, is the dependent variable, and it y refers to the
% profit in $10,000s

X = data(:, 1); % 1st column of data
y = data(:, 2); % 2nd column of data

m = length(y); % number of training examples

% Write the the function Plot Data, which  plots y against X

plotData(X, y);


%% =================== Part 2: Gradient descent ===================
fprintf('Running Gradient Descent ...\n')

% Extend X by adding a column of ones to the data matrix
X = [ones(m, 1), data(:,1)];


% initialize the weight vector W 

W = zeros(2, 1); 


% Set gradient descent settings: Note that in class, I actually used Matlab

% symolic variables to calculate directly the solution of the optimization

% problem.


% Here we use a NUMERICAL method by recomputing the gradient 

% We set some quantities necessary to do this


iterations = 1500;

alpha = 0.01;


% Compute and display initial cost

% You MUST FILL IN THE NECESSARY CODE FOR THE FUNCTION computeCost

computeCostB(X, y, W)


% Next we need to run the function gradientDescent, whose code YOU MUST

% COMPLETE.  It returns the solution for W

W = gradientDescentB(X, y, W, alpha, iterations);


% print W to screen
fprintf('W found by gradient descent: ');

fprintf('%f %f \n', W(1), W(2));


% Plot the linear fit
hold on; 
% keep previous plot visible


% Recall that the 1st column of X is made up of 1's.  So we need to plot
% against the 2nd column.  Also, the hypothesis is X*W, where * is matrix

% multiplication

plot(X(:,2), X*W, '-'); 

legend('Training data', 'Linear regression')
hold off   
% I this moment, release the figure, so no other plots are made on it


%% Now we use the model to make predictions


% 1. Predict values for population sizes of 35,000 

predict1 = [1, 3.5]*W;

fprintf('For population = 35,000, we predict a profit of %f\n',...
    predict1*10000);


% 2. Predict values for population of size 70,000
predict2 = [1, 7]*W;

fprintf('For population = 70,000, we predict a profit of %f\n',...
    predict2*10000);



%% ============= Part 3: Visualizing the cost function J(w_0, w_1) =============

fprintf('Visualizing J(w_0, w_1) ...\n')


% Grid over which we will calculate J
W0_vals = linspace(-10, 10, 100);
W1_vals = linspace(-1, 4, 100);


% initialize J_vals to a matrix of 0's
J_vals = zeros(length(W0_vals), length(W1_vals));


% Fill out J_vals
for i = 1:length(W0_vals)
    for j = 1:length(W1_vals)
	  t = [W0_vals(i); W1_vals(j)];    
	  J_vals(i,j) = computeCostB(X, y, t);
    end
end



% Because of the way meshgrids work in the surf command, we need to

% transpose J_vals before calling surf, or else the axes will be flipped
J_vals = J_vals';


% Surface plot
figure;
subplot(1,2,1)
surf(W0_vals, W1_vals, J_vals)
xlabel('\w_0'); ylabel('\w_1');
title('Surface')


% Contour plot
subplot(1,2,2)

% Plot J_vals as 15 contours spaced logarithmically between 0.01 and 100
contour(W0_vals, W1_vals, J_vals, logspace(-2, 3, 20))
xlabel('W_0'); ylabel('W_1');
hold on;
plot(W(1), W(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
title('Contour')