a=0;
b=0;
c=0;

rng('default');
%step-1

for i=1:100
p1(i,:)=rand(1,2);
if (p1(i,1)+2*p1(i,2)-2)>0
    p(i,:)=p1(i,:);
    a=a+1;
    q(i)=1;
elseif (p1(i,1)+2*p1(i,2)-2)<0
    p(i,:)=p1(i,:);
    q(i)=0;
    b=b+1;
else
    i=i-1;
    c=c+1;
    continue;
end
end
a1=0;
for i=1:100
if (p(i,1)+2*p(i,2)-2)>0
  if q(i)==1
    a1=a1+1;
  end
end
if (p(i,1)+2*p(i,2)-2)<0
  if q(i)==0
    a1=a1+1;
  end
end
end

[rd, cd]=size(p);
[rt, ct]=size(q);

wold=rand(1,cd+1);
iterations=1;
r=0.2;
x=0.7;
X=1.05;
error=0.1;
e=error;
p=horzcat(p,ones(100,1));
deltaw=0;
epochs=1000;
while abs(e) >= error &&  iterations <= epochs
iterations=iterations+1;
Wold=repmat(wold,[100 1]);
out = sum(Wold.* p,2);  %Implementing the delta rule 
errorold=sum((q-out').^2)/rd;
grad= sum(bsxfun(@times, (q - out'), -p'),2)/numel(out');

%step-2

wnew = wold' - r * grad;      
wnew=wnew';
Wnew=repmat(wnew,[100 1]);
out = sum(Wnew .* p,2);  %Implementing the delta rule 
errornew=sum((q-out').^2)/rd;
%step-4

if errornew<errorold      
    r=r*X;    
    wold=wnew;         
end

%step-3

if errornew>error    
    r=r*x;          
end
end