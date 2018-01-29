%Implementing delta rule in an incremental fashion

a=0;
b=0;
c=0;

rng('default');

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
r=0.001;
error=0.1;
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
error=0.1;
iterations=0;
epochs=10000;

[rd, cd]=size(p);
[rt, ct]=size(q);

tic;
[w1,iteration1,e1]=DeltaRuleTrainingbatch(p,q',r,error,epochs); 
fprintf('Batch Mode:');

toc;
fprintf('Number of times weights updated');
iteration1
tic;
[w2,iteration2,e2]=DeltaRuleTraining(p,q',r,error,epochs); 
fprintf('Incremental Mode:');
toc;
fprintf('Number of times weights updated');
iteration2




