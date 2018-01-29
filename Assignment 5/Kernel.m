function Kernel = K(X1,X2)
if nargin == 1
    Kernel = sum(X1*transpose(X1));
else
    Kernel = sum(X1*transpose(X2));
end
end
