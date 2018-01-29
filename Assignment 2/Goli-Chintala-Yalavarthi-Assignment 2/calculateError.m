%Function to calculate the error value 
function [w, h, error] = calculateError(x,y,z,w1)  

    w = (inv((transpose(x))*x))*(transpose(x)*y); %Calculating the Weight vector 
    h= z*w; %Calculating the hypothesis
    error = (w1-h).^2; %Calculating the error value
end