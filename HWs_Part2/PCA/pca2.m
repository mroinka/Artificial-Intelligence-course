clc;
clear;
close all;

%% Load Data

N1=200;
MU1=[1 2];
SIGMA1=[2.0  1.0
        1.0  1.0];

X1=mvnrnd(MU1,SIGMA1,N1)';
T1=1*ones(1,N1);

N2=200;
MU2=[3 6];
SIGMA2=[1.0  1.0
        1.0  2.0];

X2=mvnrnd(MU2,SIGMA2,N2)';
T2=2*ones(1,N2);

X=[X1 X2];
T=[T1 T2];


%% Perform PCA

[Q lambda]=PerformPCA(X);

Y=Q'*X;

XHAT1=Q(:,1)*Y(1,:);
E1=X-XHAT1;

XHAT2=Q(:,2)*Y(2,:);
E2=X-XHAT2;


%% Plots

figure;
plot(X(1,T==1),X(2,T==1),'ro');
hold on;
plot(X(1,T==2),X(2,T==2),'bs');

m1=mean(X(1,:));
m2=mean(X(2,:));

lq1=lambda(1)*Q(:,1);
plot([m1 m1+lq1(1)],[m2 m2+lq1(2)],'k','LineWidth',2);

lq2=lambda(2)*Q(:,2);
plot([m1 m1+lq2(1)],[m2 m2+lq2(2)],'k','LineWidth',2);

grid on;

axis equal;

figure;


subplot(2,2,1);
plot(Y(1,T==1),Y(2,T==1),'ro');
hold on;
plot(Y(1,T==2),Y(2,T==2),'bs');
legend('Class A','Class B');
title('Selected Features: Y_1 and Y_2');
grid on;

subplot(2,2,2);
plot(Y(1,T==1),'r-o');
hold on;
plot(Y(1,T==2),'b-s');
legend('Class A','Class B');
title('Selected Feature: Y_1');
grid on;

subplot(2,2,3);
plot(Y(2,T==1),'r-o');
hold on;
plot(Y(2,T==2),'b-s');
legend('Class A','Class B');
title('Selected Feature: Y_2');
grid on;

figure;
plot(E1(1,:),E1(2,:),'k.');
hold on;
plot(E2(1,:),E2(2,:),'m+');




