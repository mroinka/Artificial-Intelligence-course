%NETWORK_1



% Solve an Input-Output Fitting problem with a Neural Network
% Script generated by Neural Fitting app
% Created 22-Dec-2023 09:59:30
%
% This script assumes these variables are defined:
%
%   SynchronousMachineinputs - input data.
%   SynchronousMachineoutputs - target data.

x=(zscore(SynchronousMachineinputs))';
t=(zscore(SynchronousMachineoutputs))';




% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

% Create a Fitting Network(***According to the demands of the question***)
hiddenLayerSize = [5,15]
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig'
net = fitnet(hiddenLayerSize,trainFcn);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 50/100;
net.divideParam.valRatio = 25/100;
net.divideParam.testRatio = 25/100;

% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y)

% View the Network
view(net)

%chose perfomance function
% (% UNFORUNAELY THIS COMMAND {net.performFcn = 'mae';}
% ALWAYS SHOWS mse and we use by defention function of performances!!!!
% )

%/////////////
%mse
msevalue=mse(t,y)

%mae 
maevalue=mae(t,y)
%or
maevalue1=mean(abs(t-y))
%////////////////
%RMSE
rmseValue = sqrt(mse(t,y)); 
disp(rmseValue); 
%R_square
meant = mean(t); 
rsquareValue = 1 - sum((t - y).^2) / sum((t - meant).^2); 
disp(rsquareValue); 
%Adj_Rsquare

n = length(t); 
k = 4;
adjRsquareValue = 1 - ((1 - rsquareValue) * (n - 1)) / (n - k - 1); 
disp(adjRsquareValue); 

%SSE,SSR,SST

sse = sum((t - y).^2);
mean_t = mean(t);
sst = sum((t - mean_t).^2);
ssr = sst - sse;

disp(['SSE: ', num2str(sse)]);
disp(['SST: ', num2str(sst)]);
disp(['SSR: ', num2str(ssr)]);

%Error_mean
meanError = mean(t - y);
disp(meanError);

%Error_Variance
errorVariance = var(t - y);
disp(errorVariance);

%DOF

 





% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotregression(t,y)
%figure, plotfit(net,x,t)

