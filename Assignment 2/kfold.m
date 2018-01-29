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
%  
% for iteration=1:100
%  
% class_data = classData(M);
% observations = attribData(M);
% col_val=3;
% [trainingAttributes, trainingClasses,testingAttributes,testingClasses] = divideValues(observations,class_data,col_val);
%   [c,d] = size(trainingAttributes);
%     [e,f] = size(testingAttributes);
%     D2train2 = computeVal(trainingAttributes,c);
%     D2test2 = computeVal(testingAttributes,e);
%  if(avgerror1>avgerror2)
%      w2 = (inv((transpose(D2train))*D2train))*(transpose(D2train)*trainingClasses);
%     h2= D2test*w2;
%     error2 = (q-h2).^2;
%     esum2(iteration) = sum(error2,1);
%  else
%     w1 = (inv(transpose(trainingAttributes)*trainingAttributes))*(transpose(trainingAttributes)*trainingClasses);
%     h1= p*w1;
%     error1 = (q-h1).^2;
%     esum1(iteration) = sum(error1,1);
%  end
% end
% 
% m_esum2 = mean(esum2);
% m_esum1 = mean(esum1);
% 
% max_esum2 = max(esum2);
% min_esum2 = min(esum2);
% 
% max_esum1 = max(esum1);
% min_esum1 = min(esum1);