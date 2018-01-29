load iris.dat

iris

attributes = iris(:, 1:4);
class_data = iris(:, 5);

col_val = 4;
[trainAttrib, trainClass,testAttrib,testClass] = dataPartitions(attributes,class_data,col_val);


[n1,x1]=hist(iris(:,:), 5)
[n2,x2]=hist(iris(:,:), 10)
[n3,x3]=hist(iris(:,:), 15)
[n4,x4]=hist(iris(:,:), 20)

p1 = n1/sum(n1);
p2 = n2/sum(n2);
p3 = n3/sum(n3);
p4 = n4/sum(n4);

s1 = sum(p1);
s2 = sum(p2);
s3 = sum(p3);
s4 = sum(p4);

logp1 = log2(p1);
logp2= log2(p2);
logp3 = log2(p3);
logp4 = log2(p4);

Entropy1 = -sum(logp1 .* p1);
Entropy2 = -sum(logp2 .* p2);
Entropy3 = -sum(logp3 .* p3);
Entropy4 = -sum(logp4 .* p4);
EntropyArray = [Entropy1 Entropy2 Entropy3 Entropy4];


highEntropy = max(EntropyArray);


rootEntropy = log2(3);

