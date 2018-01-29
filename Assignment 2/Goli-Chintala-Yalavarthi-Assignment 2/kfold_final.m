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
    
    %Saving the values of training and testing datasets
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
 
 %Repeating the process for 100 iterations.
 
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

%Plotting the graph for Generalization and Modeling error
i = [1:100];
plot(i,esum);
hold on
plot(i,tsum);
xlabel('Iterations'); ylabel('Error values');
legend('Generalization Error','Modeling Error','Location','northeast');
title('Iteration vs Generalization Error and Modeling Error');

hold off;
%Plotting the regression line graph
figure;
y2 = D2train2(:,2)*w4(2,1);
y3 = D2train2(:,3)*w4(3,1);

plot(D2train2(:,2),y2);
hold on;
plot(D2train2(:,3),y3);

%Contour
test_data = D2train2(:,2:3);

W2_vals = linspace(-10, 10, 100);
W3_vals = linspace(-1, 4, 100);
J_vals = zeros(length(W2_vals), length(W3_vals));
for i = 1:length(W2_vals)
     for j = 1:length(W3_vals)
 	  t = [W2_vals(i); W3_vals(j)];    
 	  J_vals(i,j) = computeCostB(test_data, trainingClasses, t);
     end
end

figure;
contour(W2_vals, W3_vals, J_vals, logspace(-3, 3, 20))

%Calculating the mean, maximum and minimum values of esum
mean_esum = mean(esum);
max_esum = max(esum);
min_esum = min(esum);
