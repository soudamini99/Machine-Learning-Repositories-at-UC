%Function to divide the values as training and testing dataset values in
%Regularization
function [x,y,k,l] = divideValues(m,n,col_val)

[trainInd,valInd,testInd] = dividerand(97,0.5,0.0,0.5);

[a,b] = size(trainInd);
[p,q] = size(testInd);
trainAttrib = zeros(b,col_val);
trainClass = zeros(b,1);

for i = 1:b
    trainAttrib(i,:) = m(trainInd(i),:);
    trainClass(i,1) = n(trainInd(i),1);
end
testAttrib = zeros(q,col_val);
testClass = zeros(q,1);

for i= 1:q
    testAttrib(i,:) = m(testInd(i),:);
    testClass(i,1) = n(testInd(i),1);
end
x = trainAttrib; %We get the training attribute values
y =  trainClass; %We get the training class values
k = testAttrib; %We get the testing attribute values
l = testClass;%We get the testing class values
end
