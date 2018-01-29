%Importing the data from the regularization output
M = importdata('datafile.mat');

%Applying the K-Fold for the indices
Indices = crossvalind('Kfold', 97, 3)

%Dividing the dataset into training and testing data
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
    
    %Training dataset with the training attributes and training classes
    training_attributes = training(:,1:3);
    training_classes = training(:,4);
    
    %Testing dataset with attributes and values
    testing_attributes = testing(:,1:3);
    testing_classes = testing(:,4);
    
    x=training_attributes;
    [r,s] = size(x);
    y=training_classes;
    
    p= testing_attributes;
    [a,b]= size(p);
    q= testing_classes;
    
    %Calculating the D1 polynomial  
    [w1,h1,error1] = calculateError(x, y, p, q);
    esum1(i) = sum(error1,1);  %Calculating the errorsum value
    
    %Degree 2 training set
    D2train = computeVal(x,r);
    %Degree 2 test set
    D2test = computeVal(p,a);
    
    %Calculating the D2 polynomial
    [w2,h2,error2] = calculateError(D2train, y, D2test, q);
    esum2(i) = sum(error2,1); %Calculating the errorsum value
end

%Calculating the average error for D1 and D2 polynomial
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
     [w4,h4,error4] = calculateError(D2train2, trainingClasses, D2test2, testingClasses);
     [htrain, trainerror] = modelingError(D2train2, w4, trainingClasses);
     tsum(iteration) = sum(trainerror,1);
    esum(iteration) = sum(error4,1); %Calculating the errorsum value
 else
     [w3,h3,error3] = calculateError(trainingAttributes, trainingClasses, testingAttributes, testingClasses);
     [htrain, trainerror] = modelingError(trainingAttributes, w3, trainingClasses);
     tsum(iteration)= sum(trainerror,1);
    esum(iteration) = sum(error4,1);  %Calculating the errorsum value
 end
end

%Plotting the graph
i = [1:100];
plot(i,esum);
hold on
plot(i,tsum);

%Calculating the mean, maximum and minimum values of esum
mean_esum = mean(esum);
max_esum = max(esum);
min_esum = min(esum);
