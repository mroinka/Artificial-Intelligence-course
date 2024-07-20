clc;
clear;
close all;

x=linspace(0,2*pi,40);
y=sin(x);

inputs = x;
targets = y;

% Create a Fitting Network
hiddenLayerSize = 3;
net = fitnet(hiddenLayerSize);


% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;


% Train the Network
[net tr] = train(net,inputs,targets);

% Test the Network
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs)

% View the Network
view(net)

% Plots
% Uncomment these lines to enable various plots.
figure, plotperform(tr)
% figure, plottrainstate(tr)
% figure, plotfit(net,inputs,targets)
figure, plotregression(targets,outputs)
% figure, ploterrhist(errors)
