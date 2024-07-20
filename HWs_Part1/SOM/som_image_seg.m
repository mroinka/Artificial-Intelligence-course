clc;
clear;
close all;

%% Load Image Data

img=imread('image1.jpg');

img=double(img);
img=(img-min(img(:)))/(max(img(:))-min(img(:)));

[M N]=size(img);

inputs=zeros(3,M*N);

w1=1;
w2=1;
w3=2;

c=0;
for i=1:M
    for j=1:N
        c=c+1;
        
        inputs(:,c)=[w1*(j-1)/(N-1)
                     w2*(1-(i-1)/(M-1))
                     w3*img(i,j)];
    end
end

%% Create and Train SOM

% Create a Self-Organizing Map
LatticeSize=[1 2];
CoverSteps=10;
InitNeighbor=3;
Tolology='hextop';
Distance='linkdist';
net = selforgmap(LatticeSize,CoverSteps,InitNeighbor,Tolology,Distance);

net.TrainParam.ShowWindow=true;
net.TrainParam.ShowCommandLine=false;
net.TrainParam.Show=1;
net.TrainParam.Epochs=100;

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

