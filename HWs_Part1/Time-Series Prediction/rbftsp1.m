clc;
clear;
close all;

data=load('mgdata.dat');

x=data(:,2)';

Delays=[6 12 18 24];
nDelay=numel(Delays);

MaxDelay=max(Delays);

N=numel(x);
Range=(MaxDelay+1):N;

inputs = zeros(nDelay,numel(Range));
for k=1:nDelay
    d=Delays(k);
    inputs(k,:)=x(Range-d);
end

targets = x(Range);

nData=size(inputs,2);

%Perm=randperm(nData);
Perm=1:nData;

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
Spread=3;
MaxNeuron=50;
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
