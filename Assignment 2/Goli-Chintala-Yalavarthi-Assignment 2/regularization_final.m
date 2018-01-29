% Reading the data from the file
M = importdata('hm2data2.mat');

%Calculating the mean of the dataset
muM=mean(M);

%Calculating the standard deviation of the dataset
stdM=std(M)

%Repeating the Standard Deviation on a matrix
repstd=repmat(stdM,97,1)

%Repeating the Mean values on a matrix
repmu=repmat(muM, 97, 1)

%Calcuating the standardized mean value
standardizedM = (M-repmu)./repstd 

%Creating a matrix with the standardized values
standM = [ones(97,1) standardizedM]

%[mean(standardizedM) ; std(standardizedM)]

%Creating the class data values
class_data = classData(standardizedM);

%Creating the attribute values
observations = attribData(standardizedM);


Exobservations = [ones(97,1) observations]

[p,q] = size(Exobservations);

%Creating the training and test set values
col_val = 4;
[trainingAttributes, trainingClasses,testingAttributes,testingClasses] = divideValues(Exobservations, class_data,col_val);

%Creating the identity matrix
I= eye(q);
I(1,1)= 0;

%Calculating error sum and minimum lambda values
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

%Plotting the graph between the lambda and error sum
plot(l,ersum);
xlabel('Lambda Values');
ylabel('Error Sum');
title('Lambda vs Error Sum');

%Calculating the reduced weight values
redW= w(2:4,:);
[p, k]= min(redW);

standM(:,k+1) = [];

%Saving the values to a mat file to use them for K-Fold 
save datafile.mat standM