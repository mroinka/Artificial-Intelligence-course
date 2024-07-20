clc;
clear;
close all;

%% Load Data

MU=[2 4];

SIGMA=[5.0  2.0
       2.0  1.0];

X=mvnrnd(MU,SIGMA,1000)';


%% Perform PCA

[Q lambda]=PerformPCA(X);


%% Plots

figure;
plot(X(1,:),X(2,:),'+');
hold on;

lq1=lambda(1)*Q(:,1);
plot([MU(1) MU(1)+lq1(1)],[MU(2) MU(2)+lq1(2)],'r','LineWidth',2);

lq2=lambda(2)*Q(:,2);
plot([MU(1) MU(1)+lq2(1)],[MU(2) MU(2)+lq2(2)],'r','LineWidth',2);


grid on;

axis equal;

figure;
q1=Q(:,1);
Y1=q1'*X;
q2=Q(:,2);
Y2=q2'*X;
plot(Y1,'b');
hold on;
plot(Y2,'r');

