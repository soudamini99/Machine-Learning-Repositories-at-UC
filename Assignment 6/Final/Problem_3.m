% Loading the dataset
%dataSet = load('TestDataSet1.txt');
data=gen_sigmoid_classes(100)
% Storing the values in seperate vectors 
n = size(data, 2) - 1;
p = data(:, 1:n);
q = data(:, 3);


% Adding a column of ones to the beginning of the 'x' matrix
p=p+p.^2;
p=[ones(length(q),1) p];
disp(p);
% Running gradient descent on the given data
% p - input matrix and q - output vector
% 'parameters' is a matrix containing our initial parameters
parameters = [0.1;0.1;0.1];
learningRate = 0.01;
repetition = 15000;
[parameters, costHistory] = gradient(p, q, parameters, learningRate, repetition);

% Plotting our cost function on a different figure to see how we did
figure;
%plot(costHistory, 1:repetition);
plot(1:repetition, costHistory);
% Finally predicting the output of the provided inputs
inputs =p;
X=0;
for i=1:100
output(i)=inputs(i,:)*parameters;
out(i)=sign(output(i));
if out(i)==data(i,3);
    X=X+1;
end
end

Accuracy_train=X/100;

%test data random
testdata=gen_sigmoid_classes(50);
testinputs=testdata(:,1:2)+testdata(:,1:2).^2;
testinputs=[ones(50,1) testinputs];
X2=0;
for i=1:50
output2(i)=testinputs(i,:)*parameters;
out2(i)=sign(output2(i));
if out(i)==testdata(i,3);
    X2=X2+1;
end
end

Accuracy_test=X2/50;

