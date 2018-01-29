%Function to compute the values of D1 and D2 polynomial training set

function f = computeVal(m,n)
    c=[];
    k =1;
    for l = 1:n
        c(l,k) = m(l,2)*m(l,3);
        c(l,k+1) = m(l,2)*m(l,2);
        c(l,k+2) = m(l,3)*m(l,3);      
    end
    f = horzcat(m,c);
 
end
