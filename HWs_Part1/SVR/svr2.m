clc;
clear;
close all;

%% Load Data

x=linspace(0,4*pi,40);

t=sin(x).*exp(-0.2*x)+0.1*randn(size(x));

n=numel(t);


%% Design SVR

epsilon=0.15;

C=1000;

sigma=1;

Kernel=@(xi,xj) exp(-1/(2*sigma^2)*norm(xi-xj)^2);

H=zeros(n,n);
for i=1:n
    for j=i:n
        H(i,j)=Kernel(x(:,i),x(:,j));
        H(j,i)=H(i,j);
    end
end

HH=[ H -H
    -H  H];

f=[-t'; t']+epsilon;

Aeq=[ones(1,n) -ones(1,n)];
beq=0;

lb=zeros(2*n,1);
ub=C*ones(2*n,1);

options=optimset('Display','iter','MaxIter',1000);

alpha=quadprog(HH,f,[],[],Aeq,beq,lb,ub,[],options);

alpha=alpha';

AlmostZero=(abs(alpha)<max(abs(alpha))*1e-4);

alpha(AlmostZero)=0;

alpha_plus=alpha(1:n);
alpha_minus=alpha(n+1:end);

eta=alpha_plus-alpha_minus;

S=find(alpha_plus+alpha_minus>0 & alpha_plus+alpha_minus<C);

y=zeros(size(t));
for i=1:n
    y(i)=MySVRFunc(x(:,i),eta(S),x(:,S),Kernel);
end

b=mean(t(S)-y(S)-sign(eta(S))*epsilon);

%% Plot Results

xmin=min(x);
xmax=max(x);
xx=linspace(xmin,xmax,500);
yy=zeros(size(xx));
for k=1:numel(yy)
    yy(k)=MySVRFunc(xx(:,k),eta(S),x(:,S),Kernel)+b;
end

figure;
plot(x,t,'o');
hold on;
plot(xx,yy,'k','LineWidth',2);
plot(xx,yy+epsilon,'r:');
plot(xx,yy-epsilon,'r:');
grid on;

