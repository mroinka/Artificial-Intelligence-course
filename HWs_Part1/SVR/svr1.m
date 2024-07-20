clc;
clear;
close all;

%% Load Data

x=linspace(0,10,40);

%t=sin(x);

t=-2*x+7+1*randn(size(x));

n=numel(t);


%% Design SVR

epsilon=1;

C=1;

H=zeros(n,n);
for i=1:n
    for j=i:n
        H(i,j)=x(:,i)'*x(:,j);
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

w=0;
for i=1:n
    w=w+eta(i)*x(:,i);
end

b=mean(t(S)-w'*x(:,S)-sign(eta(S))*epsilon);

%% Plot Results

figure;
plot(x,t,'o');
hold on;
xmin=min(x);
xmax=max(x);
xx=linspace(xmin,xmax,500);
yy=w'*xx+b;
plot(xx,yy,'k','LineWidth',2);
plot(xx,yy+epsilon,'r:');
plot(xx,yy-epsilon,'r:');
grid on;
axis equal;






