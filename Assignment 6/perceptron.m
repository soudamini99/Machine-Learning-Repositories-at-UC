function [w, iterations, e] = perceptron(x, y, eta, error, i0)%% Parameters  %[w, iterations, e] = delta(x,y, eta, error, i0)% implements the basic perceptron   rule;% x : data ; % y : true output; eta: learning rate; % error : desired approximation error;% i0: threshold on the number of epochs % (iterations through the whole data set%% Algorithm[r, c]=size(x); w=rand(1,c+1); iterations=0;e=error;while e >= error &&  iterations <=i0 iterations=iterations+1; wrong=0; for i=1:r,    if sum(w .* [x(i,:),1])<0, out=-1; else out=1; end     dw=eta*(y(i)-out)*[x(i,:),1];     w=w+dw; end %% Compute current errorfor i=1:r,    if y(i)*(sum(w .* [x(i,:),1])) < 0, wrong=wrong+1; endende=wrong/r;end