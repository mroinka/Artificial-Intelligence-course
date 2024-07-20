clc;
clear;
close all;

%% Load Data

m=25;

rA=unifrnd(0,1,1,m);
rB=unifrnd(1,2,1,m);
r=[rA rB];
theta=unifrnd(0,2*pi,1,2*m);
x(1,:)=r.*cos(theta);
x(2,:)=r.*sin(theta);
y(1:m)=1;
y(m+1:2*m)=-1;

ClassA=find(y==1);
ClassB=find(y==-1);

TrainInputs=x';
TrainTargets=y';

n=numel(TrainTargets);

%% Design SVM

C=10;

svmstruct=svmtrain(TrainInputs,TrainTargets,...
    'boxconstraint',C,...
    'kernel_function','rbf',...
    'rbf_sigma',0.4,...
    'polyorder',2,...
    'mlp_params',[1 -1],...
    'showplot',true);


%% Test SVM

nTestData=100;

TestInputs=unifrnd(-2,2,nTestData,2);

TestTargets=zeros(nTestData,1);

rTest=sqrt(TestInputs(:,1).^2+TestInputs(:,2).^2);

TestTargets(rTest<=1)=1;
TestTargets(rTest>1)=-1;

TestOutputs=svmclassify(svmstruct,TestInputs,'showplot',true);






