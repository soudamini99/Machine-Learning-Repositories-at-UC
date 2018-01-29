% Reading the data from the file
D = importdata('hm2data.mat');
muM=mean(D);

stdM=std(D)

repstd=repmat(stdM,97,1)

repmu=repmat(muM, 97, 1)

standardizedM = (D-repmu)./repstd 

%[mean(standardizedM) ; std(standardizedM)]

for i=1:97
    class_data(i,1)= standardizedM (i, 4);    
end

for i=1:97
    for j=1:3
        observations(i,j)=standardizedM (i, j);
    end
end

Exobservations = [ones(97,1) observations]

[p,q] = size(Exobservations);

[trainInd,valInd,testInd] = dividerand(97,0.5,0.0,0.5);

[a,b] = size(trainInd);
trainingAttributes = zeros(b,4);
trainingClasses = zeros(b,1);

for i = 1:b
    trainingAttributes(i,:) = Exobservations(trainInd(i),:);
    trainingClasses(i,1) = class_data(trainInd(i),1);
end

x = trainingAttributes;
y =  trainingClasses;

[a,b] = size(testInd);
testingAttributes = zeros(b,4);
testingClasses = zeros(b,1);

for i = 1:b
    testingAttributes(i,:) = Exobservations(testInd(i),:);
    testingClasses(i,1) = class_data(testInd(i),1);
end

u = testingAttributes;
v = testingClasses;
I= eye(q);
I(1,1)= 0;
I
lambda=0;
for i=1:300
    l(i) = lambda;
    w = (inv((transpose(x)*x) + lambda*I))*transpose(x)*y;
    h2 = u*w;
    error = (v-h2).^2;
    ersum(i) = sum(error,1);
    lambda=lambda+0.1; 
end
ersum

[D,I] = min(ersum);
D
I
minlambda = 0;
for i=1:I
    minlambda=minlambda+0.1
end


%for k=1:299
 %   if(ersum(k)<ersum(k+1))
  %      minersum = ersum(k);
  %      minlambda = l(k);
   % end
%end

%minersum
minlambda
plot(l,ersum);