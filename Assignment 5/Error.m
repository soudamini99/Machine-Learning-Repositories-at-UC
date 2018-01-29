function Error = E(alpha, y, x, xi, yi, b)
n = length(y);
E=0;
for j = 1:n
    Error = (alpha(j)*y(j)*Kernel(xi,x(j))+b)-yi;
end
