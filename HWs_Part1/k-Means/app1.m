clc;
clear;
close all;

%% Load Data

% data=load('mydata1');
% x=data.x

x=CreateData1(5000);

%% K-Means Settings

nCluster=3;                              % Number of Clusters

DistanceMetric='cityblock';            % Metric with variance=1

Options  = statset('Display','final');

%% Run K-Means

[I C  sumd D]=kmeans(x,nCluster,...
    'Distance',DistanceMetric,...
    'Options',Options);

%% Plot results

figure;
plot(x(I==1,1),x(I==1,2),'r.');
hold on;
plot(x(I==2,1),x(I==2,2),'b.');
plot(x(I==3,1),x(I==3,2),'y.');

plot(C(:,1),C(:,2),'kx','LineWidth',2,'MarkerSize',12);
plot(C(:,1),C(:,2),'ko','LineWidth',2,'MarkerSize',12);

legend('Claster 1','Cluster 2','Cluster 3','Cluster Centers');

xlabel('x_1');
ylabel('x_2');

hold off;
grid on;



