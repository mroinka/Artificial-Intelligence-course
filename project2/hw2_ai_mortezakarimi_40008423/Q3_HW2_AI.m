clearvars, close all; clc;
K = 200; % Number of samples of each cluster
q = 2.5; % offset of classes
P = [randn(1,K)-q randn(1,K)+q randn(1,K)+q randn(1,K)-q;
 randn(1,K)+q randn(1,K)+q randn(1,K)-q randn(1,K)-q];
plot(P(1,:),P(2,:),'g.','MarkerSize',6);
grid on; 

x = P;

% Create a Self-Organizing Map
dimension1 = 2;
dimension2 = 2;

% CoverSteps=100;
% InitNeighbor=3;
% Tolology='hextop';
% Distance='linkdist';
net = selforgmap([dimension1 dimension2])
% net = selforgmap([dimension1 dimension2],CoverSteps,InitNeighbor,Tolology,Distance);
% 
% net.TrainParam.ShowWindow=true;
% net.TrainParam.ShowCommandLine=false;
% net.TrainParam.Show=1;
% net.TrainParam.Epochs=100;




% Choose Plot Functions
% For a list of all plot functions type: help nnplot
net.plotFcns = {'plotsomtop','plotsomnc','plotsomnd', ...
    'plotsomplanes', 'plotsomhits', 'plotsompos'};

% Train the Network
[net,tr] = train(net,x);




%% Simulate Network
% Test the Network
y = net(x);

Class=vec2ind(y);
nClass=size(y,1);


% View the Network
view(net)

%Plots
%Uncomment these lines to enable various plots.
% figure, plotsomtop(net)
% set(gcf,'Toolbar','figure');
% figure, plotsomnc(net)
% set(gcf,'Toolbar','figure');
% figure, plotsomnd(net)
% set(gcf,'Toolbar','figure');
% figure, plotsomplanes(net)
% figure, plotsomhits(net,x)
% set(gcf,'Toolbar','figure');
% figure, plotsompos(net,x)
% set(gcf,'Toolbar','figure');

% Deployment
% Change the (false) values to (true) to enable the following code blocks.
% See the help for each generation function for more information.
if (false)
    % Generate MATLAB function for neural network for application
    % deployment in MATLAB scripts or with MATLAB Compiler and Builder
    % tools, or simply to examine the calculations your trained neural
    % network performs.
    genFunction(net,'myNeuralNetworkFunction');
    y = myNeuralNetworkFunction(x);
end
if (false)
    % Generate a matrix-only MATLAB function for neural network code
    % generation with MATLAB Coder tools.
    genFunction(net,'myNeuralNetworkFunction','MatrixOnly','yes');
    y = myNeuralNetworkFunction(x);
end
if (false)
    % Generate a Simulink diagram for simulation or deployment with.
    % Simulink Coder tools.
    gensim(net);
end


figure;

Colors=0.9*hsv(nClass);
Colors=Colors(randperm(nClass),:);

plotsompos(net);
hold on;
for c=1:nClass
    plot(x(1,Class==c),x(2,Class==c),'.','Color',Colors(c,:));
end
set(gcf,'Toolbar','figure');









% Get cluster centers
clusterCenters = net.IW{1}; % Cluster centers are stored in the input layer weights

disp(clusterCenters);
