%Function to calculate the modeling error value
function [htrain,trainerror] = modelingError(x,y,z)
    htrain= x*y; 
    trainerror = (z-htrain).^2;
end
    