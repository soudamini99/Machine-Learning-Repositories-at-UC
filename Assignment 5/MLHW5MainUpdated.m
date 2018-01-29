%#####################################################################
% Group : GOLI, CHINTALA, YALAVARTHI
% Students names : Venkata Sai Ram Goli, Sai Soudamini Chintala, Deepthi Yalavarthi    
% M# : M12510251, M12484209, M12507407
%##################################################################### 
%#####################################################################
%##                Machine Learning HW5                     ##
%## Implementing SVM using Sequential Minimal Optimization (SMO) ##
%#####################################################################
%#####################################################################

%#####################################################################

clear all;
clc; 
% Loading the fisheriris data
data = importdata('fisheriris.mat');
% Mean Standard deviation normalization
muM=mean(data.meas);
stdM=std(data.meas);
repstd=repmat(stdM,150,1);
repmu=repmat(muM, 150, 1);
norm_data = (data.meas-repmu)./repstd;
n=length(data.species);
x = norm_data;

%replace species names with numerical values
for i = 1:n
    if strcmp(data.species(i,1),'setosa')
        y(i,1) = num2cell(1);
    elseif strcmp(data.species(i,1),'versicolor')
        y(i,1) = num2cell(-1);
    elseif strcmp(data.species(i,1),'virginica')
        y(i,1) = num2cell(-1);
    end
end

%convert species values from cells to numerical data
numerical_species = cell2mat(y);
while(1)
    
%merged_data = horzcat(x, numerical_species);
col_value = 4;
[trainingAttributes, trainingClasses,testingAttributes,testingClasses] = divideValues(x, numerical_species,col_value);
[p q] = size(trainingAttributes);
[r s] = size(testingAttributes);

% step1 : Randomly initialising the alpha values subject to the given
% constraints
alpha = zeros(n,1);
alpha(1:n-1,1) = rand(n-1,1);
sum1 = 0;
 for i=1:p-1
     sum1 = alpha(i,1)*trainingClasses(i,1) + sum1;
 end
alpha(p) = - sum1/ trainingClasses(p,1);
total_sum = sum1 + (alpha(p)*trainingClasses(p,1));

% step 2: Calculating the Weight vector W
for i=1:p
    temp(i,:) = alpha(i).*trainingClasses(i).*trainingAttributes(i,:);
end
w = sum(temp);

%step 3: Calculating KKT Conditions
b=0;
for i=1:p
    KKT(i) = alpha(i)*(trainingClasses(i)*(w*transpose(trainingAttributes(i,:))+ b)-1);
end 

% Step 4
%4a: ArgMax of KKT
[M I] = max(KKT);

%4b: Picking X1 
x1 = trainingAttributes(I,:);
y1 = trainingClasses(I);
alpha1 = alpha(I);

%4c: To Calculate error e(i)
E_1 = Error(alpha, trainingClasses, trainingAttributes, x1, y1, b);
for i = 1:p
    E(i) = Error(alpha, trainingClasses, trainingAttributes, trainingAttributes(i), trainingClasses(i), b);
    e(i) = E_1-E(i);
end

% 4d: Argmax of error e
[m i] = max(e);

% 4e: Picking x2
x2 = trainingAttributes(i,:);
y2 = trainingClasses(i);
alpha2 = alpha(i);

% 4f: Calculating K value
K11 = Kernel(x1);
K22 = Kernel(x2);
K12 = Kernel(x1, x2);
k = K11 + K22 - 2 * K12

%step 5: Updating new alpha2 value
E_2 = Error(alpha, trainingClasses, trainingAttributes, x2, y2, b);
alpha2new = alpha2 - y2*(E_1-E_2)/k;

%step 6: Updatine new alpha1 value
alpha1new = alpha1 + y1*y2*(alpha2-alpha2new);

%step 7:Replacing alpha values with 0 where (alpha<epsilon)

epsilon = 0;
for i = 1:p
    if(alpha(i)<epsilon)
        alpha(i) = 0;
    end
end

%step 8: Calculating bias value 
   b_I = zeros(p,1);
    for i=1:p,
        if(alpha(i) > 0)
            b_I(i,:) = ((KKT(i)-1)/(alpha(i)*trainingClasses(i))) - trainingAttributes(i,:)*transpose(w);
        end
    end
 bias = mean(b_I);

%step 9 : Test for Classification
count=0;
for i = 1:r
    yPredicted(i,1)= w*transpose(testingAttributes(i,:))+bias;
    if(sign(yPredicted(i,1)) == sign(testingClasses(i,:)))
        count = count + 1;
    end
end

%step 10: To check whether the data is classified or not and repeat the
%process

countThreshold = 0.9*r
if(count>countThreshold)
    break
else
    continue
end
end
