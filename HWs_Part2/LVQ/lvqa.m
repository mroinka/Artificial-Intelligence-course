clc;
clear;
close all;

%% Load Data

data=load('simplecluster_dataset');

inputs=data.simpleclusterInputs;
targets=data.simpleclusterTargets;

targets_class=vec2ind(targets);

%% Create and Train LVQ

nCluster=4;
LearningRate=0.01;
LearningFcn='learnlv1';

net=lvqnet(nCluster,LearningRate,LearningFcn);

net.trainFcn='trainr';

net.trainParam.epochs=20;
net.trainParam.showWindow=true;
net.trainParam.showCommandLine=true;
net.trainParam.show=1;
net.trainParam.goal=0.1;

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
plotvec(inputs,targets_class,'+');
title('Targets');

subplot(1,2,2);
plotvec(inputs,outputs_class,'+');
title('Outputs');

