clc;
clear;
close all;

x=linspace(0,2*pi,30);

sigma=0.02;
y=sin(x)+sigma*randn(size(x));

inputs = x;
targets = y;

nData=size(inputs,2);

Perm=randperm(nData);

pTrainData=0.7;
nTrainData=round(pTrainData*nData);
trainInd=Perm(1:nTrainData);
Perm(1:nTrainData)=[];
trainInputs = inputs(:,trainInd);
trainTargets = targets(:,trainInd);

pTestData=1-pTrainData;
nTestData=nData-nTrainData;
testInd=Perm;
testInputs = inputs(:,testInd);
testTargets = targets(:,testInd);


% Create and Train RBF Network
Goal=0;
Spread=1;
MaxNeuron=10;
DisplayAt=1;
net = newrb(trainInputs,trainTargets,Goal,Spread,MaxNeuron,DisplayAt);

% Test the Network
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);

% Recalculate Training, Validation and Test Performance
trainOutputs = outputs(:,trainInd);
trainErrors = trainTargets-trainOutputs;
trainPerformance = perform(net,trainTargets,trainOutputs);

testOutputs = outputs(:,testInd);
testError = testTargets-testOutputs;
testPerformance = perform(net,testTargets,testOutputs);

PlotResults(targets,outputs,'All Data');
PlotResults(trainTargets,trainOutputs,'Train Data');
PlotResults(testTargets,testOutputs,'Test Data');

% View the Network
% view(net);
