clc;
clear;
close all;

%% Load Data

data=load('iris_dataset');

inputs=data.irisInputs;
targets=data.irisTargets;

targets_class=vec2ind(targets);

%% Create and Train LVQ

nCluster=size(targets,1);
LearningRate=0.01;
LearningFcn='learnlv2';

net=lvqnet(nCluster,LearningRate,LearningFcn);

net.trainFcn='trainr';

net.trainParam.epochs=40;
net.trainParam.showWindow=true;
net.trainParam.showCommandLine=true;
net.trainParam.show=1;
net.trainParam.goal=0.01;

net.divideFcn='dividerand';

net.divideParam.TrainRatio=70/100;
net.divideParam.ValRatio=0/100;
net.divideParam.TestRatio=30/100;

[net tr]=train(net,inputs,targets);

%% Apply Network

outputs=net(inputs);

outputs_class=vec2ind(outputs);

perf=perform(net,targets,outputs);


%% Plot Results

figure;

subplot(1,2,1);
plotvec(inputs([2 4],:),targets_class,'+');
title('Targets');

subplot(1,2,2);
plotvec(inputs([2 4],:),outputs_class,'+');
title('Outputs');

