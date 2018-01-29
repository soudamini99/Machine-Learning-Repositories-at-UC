%(c)Use different learning rates, analyze which works better and explain why

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
r=0.1;
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

%Calculating the error values

for i=[1:10]
 
    [w(i,:),~,e(i)]=DeltaRuleTrainingbatch(p,q',r,error,1000);
    r=r*0.1;
end
   
%Plotting decision surfaces
 
 hold on;
 x2=linspace(0,1);
 x3=linspace(0,1);
 
 for i=1:100
 y1(i)=(x2(i)+2*x3(i)-2);
 end
 
 plot(p(:,1),p(:,2),'*');
 
 x4=[x2; x3];
 x4=x4';
 
 plot(x4,y1','g');
 
 
 for i=1:100
 y2(i)=sum(w(1,:) .* [x4(i,:),1]);
 end
 plot(x4,y2','y');
 
 for i=1:100
 y3(i)=sum(w(2,:) .* [x4(i,:),1]);
 end
 plot(x4,y3','r');
 
 for i=1:100
 y4(i)=sum(w(3,:) .* [x4(i,:),1]);
 end
 plot(x4,y4','k');
 
 for i=1:100
 y5(i)=sum(w(6,:) .* [x4(i,:),1]);
 end
 plot(x4,y5','c');
 
 for i=1:100
 y6(i)=sum(w(8,:) .* [x4(i,:),1]);
 end
 plot(x4,y6','m');
 
hold off;

