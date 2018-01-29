%Problem 1
a=0;
b=0;
c=0;

rng('default');

%Generating the random pairs and assigning them to different classes
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
alpha=0.01;
error=0.2;
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


for i=1:100
[~,~,e(i)]=DeltaRuleTrainingbatch(p,q',alpha,error,i);
end

%Plotting iterations and errors

subplot(2,1,1);

iterations=[1:100];
plot(iterations,e);
xlabel 'Iterations';
ylabel 'Errors';
title 'Iterations over Errors'; 

%plotting decision surfaces after 5,10,50 iterations

for i=[5 10 50 100]
    [w(i,:),~,~]=DeltaRuleTrainingbatch(p,q',alpha,error,i);
    
end


subplot(2,1,2);
hold on;
p2=linspace(0,1);
p3=linspace(0,1);

for i=1:100
q1(i)=(p2(i)+2*p3(i)-2);
end

plot(p(:,1),p(:,2),'*');

p4=[p2; p3];
p4=p4';

plot(p4,q1','g');


for i=1:100
q2(i)=sum(w(5,:) .* [p4(i,:),1]);
end
plot(p4,q2','y');

for i=1:100
q3(i)=sum(w(10,:) .* [p4(i,:),1]);
end
plot(p4,q3','r');

for i=1:100
q4(i)=sum(w(50,:) .* [p4(i,:),1]);
end
plot(p4,q4','k');

for i=1:100
q5(i)=sum(w(100,:) .* [p4(i,:),1]);
end
plot(p4,q5','c');

hold off;



