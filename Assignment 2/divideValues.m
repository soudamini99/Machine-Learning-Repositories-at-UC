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
x = trainAttrib;
y =  trainClass;
k = testAttrib;
l = testClass;
end
