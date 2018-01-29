% Reading the data from the file
M = importdata('hm2data2.mat');

muM=mean(M);

stdM=std(M)

repstd=repmat(stdM,97,1)

repmu=repmat(muM, 97, 1)

standardizedM = (M-repmu)./repstd 

%[mean(standardizedM) ; std(standardizedM)]

class_data = classData(standardizedM);

observations = attribData(standardizedM);


Exobservations = [ones(97,1) observations]

[p,q] = size(Exobservations);
col_val = 4;
[trainingAttributes, trainingClasses,testingAttributes,testingClasses] = divideValues(Exobservations, class_data,col_val);

I= eye(q);
I(1,1)= 0;
lambda=-2000;
for i=1:1000
    l(i) = lambda;
    w = (inv((transpose(trainingAttributes)*trainingAttributes) + lambda*I))*transpose(trainingAttributes)*trainingClasses;
    h2 = testingAttributes*w;
    error = (testingClasses-h2).^2;
    ersum(i) = sum(error,1);
    lambda=lambda+0.2; 
end
ersum(1)
[m, i] = min(ersum);
minlambda = 0.2*(i-1);
minlambda

plot(l,ersum);

redW= w(2:4,:);
[p, k]= min(redW);

Exobservations(:,k) = [];
Exobservations

save datafile.mat Exobservations