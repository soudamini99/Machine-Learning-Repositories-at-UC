function [htrain,trainerror] = modelingError(x,y,z)
    
    htrain= x*y; %d2train2 = x, w4 = y, training classes=z
    trainerror = (z-htrain).^2;
end
    