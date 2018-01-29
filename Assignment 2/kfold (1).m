%M = xlsread('data2.xlsx');
M = importdata('datafile.mat');
% M = importdata('hm2data2.mat');
% M = M.Sheet1;

Indices = crossvalind('Kfold', 97, 3)

for i = 1:3
    training = [];
    testing = [];
    trainingIndex = 1;
    testingIndex = 1;
    for j = 1:97
        if(Indices(j,1) == i)
            training(trainingIndex,:) = M(j,:);
            trainingIndex = trainingIndex + 1;
        else
            testing(testingIndex,:) = M(j,:);
            testingIndex = testingIndex + 1; 
        end
    end
    
    training_attributes = training(:,1:3);
    training_classes = training(:,4);
    
    testing_attributes = testing(:,1:3);
    testing_classes = testing(:,4);
    
    x=training_attributes;
    [r,s] = size(x);
    y=training_classes;
    
    p= testing_attributes;
    [a,b]= size(p);
    q= testing_classes;
    
    % D1 polynomial
    
    w1 = (inv(transpose(x)*x))*(transpose(x)*y);
    h1= p*w1;
    error1 = (q-h1).^2;
    esum1(i) = sum(error1,1);
    
    % D2 polynomial
    
    D2train = computeVal(x,r);
    D2test = computeVal(p,a);
 
    w2 = (inv((transpose(D2train))*D2train))*(transpose(D2train)*y);
    h2= D2test*w2;
    error2 = (q-h2).^2;
    esum2(i) = sum(error2,1);
end

 avgerror1= mean(esum1);
 avgerror2= mean(esum2);
 
for iteration=1:100
 
class_data = classData(M);
observations = attribData(M);
col_val=3;
[trainingAttributes, trainingClasses,testingAttributes,testingClasses] = divideValues(observations,class_data,col_val);
  [c,d] = size(trainingAttributes);
   [e,f] = size(testingAttributes);
    D2train2 = computeVal(trainingAttributes,c);
    D2test2 = computeVal(testingAttributes,e);
 if(avgerror1>avgerror2)
    w4 = (inv((transpose(D2train2))*D2train2))*(transpose(D2train2)*trainingClasses);
    htrain= D2train2*w4;
    trainerror = (trainingClasses-htrain).^2;
    tsum(iteration) = sum(trainerror,1);
    h4= D2test2*w4;
    error4 = (testingClasses-h4).^2;
    esum(iteration) = sum(error4,1);
 else
    w3 = (inv(transpose(trainingAttributes)*trainingAttributes))*(transpose(trainingAttributes)*trainingClasses);
    h3= testingAttributes*w3;
    htrain= trainingAttributes*w3;
    trainerror = (trainingClasses-htrain).^2;
    tsum(iteration)= sum(trainerror,1);
    error3 = (testingClasses-h3).^2;
    esum(iteration) = sum(error4,1);
 end
end

i = [1:100];
plot(i,esums);
hold on
plot(i,tsum);
 
mean_esum = mean(esum);
max_esum = max(esum);
min_esum = min(esum);
