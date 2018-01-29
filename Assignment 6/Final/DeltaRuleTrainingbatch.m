function [w, iterations, e]=DeltaRuleTrainingbatch(x, y, eta, error, epochs)
%% Invoke as: [w, iterations, e] = DeltaRuleTraining(Data, Target, eta, error, epochs)
%% implements the delta  rule;
%% Input:
%%  Data is a matrix N x P data points/vectors
%%  Target is vector N x 1 of target values (true output) corresponding to the data points
%%  eta: learning rate; 
%%  error : desired approximation error;
%%  epochs: threshold on the number of epochs (iterations through the whole
%% data set)
%% Output:
%%  w is a vector of dimension P+1 x 1, where w_i is the weight for dimension i of a data point,
%%     for i=1:P, extended with weight w0 for the bias (input = 1)
%%  iterations = MIN{is the number of iterations taken to reach error threshold e, epochs}
%%  e: error threshold

[rd, cd]=size(x);
[rt, ct]=size(y);
if rd ~= rt
    fprintf('num data points not equal to num target');
else
w=rand(1,cd+1);
iterations=1;
e=error;
x=horzcat(x,ones(100,1));
deltaw=0;
while abs(e) >= error &&  iterations <= epochs
iterations=iterations+1;
W=repmat(w,[100 1]);
out = sum(W .* x,2);  % delta rule 
grad= sum(bsxfun(@times, (y' - out'), -x'),2)/numel(out');
w = w' - eta * grad;
w=w';
W=repmat(w,[100 1]);
out = sum(W .* x,2);  % delta rule 
e=sum((y'-out').^2)/rd;
end
end