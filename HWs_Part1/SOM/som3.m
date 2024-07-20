clc;
clear;
close all;

%% Load Data

t=linspace(0,10,1000);

f0=0.15;

x=exp(-0.15*t).*sin(2*pi*f0*t)+0.05*randn(size(t));


inputs=[t
        x];
    
%% Create and Train SOM

% Create a Self-Organizing Map
LatticeSize=[10 10];
CoverSteps=0;
InitNeighbor=3;
Tolology='hextop';
Distance='linkdist';
net = selforgmap(LatticeSize,CoverSteps,InitNeighbor,Tolology,Distance);

net.TrainParam.ShowWindow=true;
net.TrainParam.ShowCommandLine=false;
net.TrainParam.Show=1;
net.TrainParam.Epochs=500;

% Train the Network
[net tr] = train(net,inputs);

%% Simulate Network

% Test the Network
outputs = net(inputs);

Class=vec2ind(outputs);

nClass=size(outputs,1);

%% Plots

% view(net)

% figure;
% plotsomtop(net)
% set(gcf,'Toolbar','figure');

% figure;
% plotsomnc(net);
% set(gcf,'Toolbar','figure');
% 
% figure;
% plotsomnd(net);
% set(gcf,'Toolbar','figure');
% 
% figure;
% plotsomplanes(net);
% set(gcf,'Toolbar','figure');
% 
% figure;
% plotsomhits(net,inputs);
% set(gcf,'Toolbar','figure');

figure;

Colors=0.9*hsv(nClass);
Colors=Colors(randperm(nClass),:);

plotsompos(net);
hold on;
for c=1:nClass
    plot(inputs(1,Class==c),inputs(2,Class==c),'.','Color',Colors(c,:));
end
set(gcf,'Toolbar','figure');

