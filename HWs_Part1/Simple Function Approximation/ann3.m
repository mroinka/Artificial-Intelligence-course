clc;
clear;
close all;

data=load('engine_dataset');

inputs = data.engineInputs;
targets = data.engineTargets;

% Create a Fitting Network
hiddenLayerSize = 5;
TF={'tansig','purelin'};
net = newff(inputs,targets,hiddenLayerSize,TF);

% Choose Input and Output Pre/Post-Processing Functions
% For a list of all processing functions type: help nnprocess
net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};


% Setup Division of Data for Training, Validation, Testing
% For a list of all data division functions type: help nndivide
net.divideFcn = 'dividerand';  % Divide data randomly
net.divideMode = 'sample';  % Divide up every sample
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% For help on training function 'trainlm' type: help trainlm
% For a list of all training functions type: help nntrain
net.trainFcn = 'trainlm';  % Levenberg-Marquardt

% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
net.performFcn = 'mse';  % Mean squared error

% Choose Plot Functions
% For a list of all plot functions type: help nnplot
net.plotFcns = {'plotperform','ploterrhist','plotregression','plotfit'};

net.trainParam.showWindow=true;
net.trainParam.showCommandLine=false;
net.trainParam.show=1;
net.trainParam.epochs=500;
net.trainParam.goal=1e-8;
net.trainParam.max_fail=20;

% Train the Network
[net,tr] = train(net,inputs,targets);

% Test the Network
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);

% Recalculate Training, Validation and Test Performance
trainInd=tr.trainInd;
trainInputs = inputs(:,trainInd);
trainTargets = targets(:,trainInd);
trainOutputs = outputs(:,trainInd);
trainErrors = trainTargets-trainOutputs;
trainPerformance = perform(net,trainTargets,trainOutputs);

valInd=tr.valInd;
valInputs = inputs(:,valInd);
valTargets = targets(:,valInd);
valOutputs = outputs(:,valInd);
valErrors = valTargets-valOutputs;
valPerformance = perform(net,valTargets,valOutputs);

testInd=tr.testInd;
testInputs = inputs(:,testInd);
testTargets = targets(:,testInd);
testOutputs = outputs(:,testInd);
testError = testTargets-testOutputs;
testPerformance = perform(net,testTargets,testOutputs);

% Results for Target #1
PlotResults(targets(1,:),outputs(1,:),'All Data (1)');
PlotResults(trainTargets(1,:),trainOutputs(1,:),'Train Data (1)');
PlotResults(valTargets(1,:),valOutputs(1,:),'Validation Data (1)');
PlotResults(testTargets(1,:),testOutputs(1,:),'Test Data (1)');

% Results for Target #2
PlotResults(targets(2,:),outputs(2,:),'All Data (2)');
PlotResults(trainTargets(2,:),trainOutputs(2,:),'Train Data (2)');
PlotResults(valTargets(2,:),valOutputs(2,:),'Validation Data (2)');
PlotResults(testTargets(2,:),testOutputs(2,:),'Test Data (2)');


% View the Network
% view(net);

% Plots
% Uncomment these lines to enable various plots.

% figure;
% plotperform(tr);

% figure;
% plottrainstate(tr);

% figure;
% plotfit(net,inputs,targets);

%  figure;
%  plotregression(trainTargets,trainOutputs,'Train Data',...
%      valTargets,valOutputs,'Validation Data',...
%      testTargets,testOutputs,'Test Data',...
%      targets,outputs,'All Data')

% figure;
% ploterrhist(errors);
