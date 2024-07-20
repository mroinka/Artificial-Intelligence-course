clc;
clear;
close all;

%% Load Data

data=load('mgdata.dat');

s=data(1:200,2)';

Delays=[6 12 18 24];
nDelay=numel(Delays);

MaxDelay=max(Delays);

N=numel(s);
Range=(MaxDelay+1):N;

x = zeros(nDelay,numel(Range));
for k=1:nDelay
    d=Delays(k);
    x(k,:)=s(Range-d);
end

t = s(Range);

n=numel(t);


%% Design SVR

epsilon=0.02;

C=1000;

sigma=0.5;

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

y=y+b;

%% Plot Results

% xmin=min(x);
% xmax=max(x);
% xx=linspace(xmin,xmax,500);
% yy=zeros(size(xx));
% for k=1:numel(yy)
%     yy(k)=MySVRFunc(xx(:,k),eta(S),x(:,S),Kernel)+b;
% end

figure;
plot(t,'k:o');
hold on;
plot(y,'r-s');
