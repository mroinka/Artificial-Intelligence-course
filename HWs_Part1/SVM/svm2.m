clc;
clear;
close all;

%% Load Data

load mydata;

n=numel(y);

ClassA=find(y==1);
ClassB=find(y==-1);

x(1,ClassB)=x(1,ClassB)-1;
x(2,ClassB)=x(2,ClassB)-1;

%% Design SVM

C=10;

sigma=2.5;

Kernel=@(xi,xj) exp(-1/(2*sigma^2)*norm(xi-xj)^2);

H=zeros(n,n);
for i=1:n
    for j=i:n
        H(i,j)=y(i)*y(j)*Kernel(x(:,i),x(:,j));
        H(j,i)=H(i,j);
    end
end

f=-ones(n,1);

Aeq=y;
beq=0;

lb=zeros(n,1);
ub=C*ones(n,1);

Alg{1}='trust-region-reflective';
Alg{2}='interior-point-convex';
Alg{3}='active-set';

options=optimset('Algorithm',Alg{2},...
    'Display','off',...
    'MaxIter',20);

alpha=quadprog(H,f,[],[],Aeq,beq,lb,ub,[],options)';

AlmostZero=(abs(alpha)<max(abs(alpha))/1e5);

alpha(AlmostZero)=0;

S=find(alpha>0 & alpha<C);

b=0;
for i=S
    b=b+y(i)-MySVRFunc(x(:,i),alpha(S),y(S),x(:,S),Kernel);
end
b=b/numel(S);


%% Plot Results

Curve=@(x1,x2) MySVRFunc([x1; x2],alpha(S),y(S),x(:,S),Kernel)+b;
CurveA=@(x1,x2) MySVRFunc([x1; x2],alpha(S),y(S),x(:,S),Kernel)+b+1;
CurveB=@(x1,x2) MySVRFunc([x1; x2],alpha(S),y(S),x(:,S),Kernel)+b-1;

figure;
plot(x(1,ClassA),x(2,ClassA),'ro');
hold on;
plot(x(1,ClassB),x(2,ClassB),'bs');
plot(x(1,S),x(2,S),'ko','MarkerSize',12);
x1min=min(x(1,:));
x1max=max(x(1,:));
x2min=min(x(2,:));
x2max=max(x(2,:));

handle=ezplot(Curve,[x1min x1max x2min x2max]);
set(handle,'Color','k','LineWidth',2);

handleA=ezplot(CurveA,[x1min x1max x2min x2max]);
set(handleA,'Color','k','LineWidth',1,'LineStyle',':');

handleB=ezplot(CurveB,[x1min x1max x2min x2max]);
set(handleB,'Color','k','LineWidth',1,'LineStyle',':');

legend('Class A','Class B');
