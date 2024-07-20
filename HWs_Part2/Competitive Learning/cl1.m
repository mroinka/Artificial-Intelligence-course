clc;
clear;
close all;

%% Load Data

inputs=iris_dataset();

%% Creat and Train Network

nClass=3;

eta=0.05;

net=competlayer(nClass,eta);

net.trainParam.epochs=50;

net=train(net,inputs);

ClusterCenters=net.IW{:}';
%% Applye Network to Data

outputs=net(inputs);

ClassIndex=vec2ind(outputs);


%% plot Data

figure;

Colors=hsv(nClass);
%Colors=0.7*Colors;

c=0;
for i=1:4
    for j=1:4        
        c=c+1;
        if i~=j
            subplot(4,4,c);
            for k=1:nClass
                plot(inputs(i,ClassIndex==k),inputs(j,ClassIndex==k),'.','color',Colors(k,:));
                hold on;
            end
            plot(ClusterCenters(i,:),ClusterCenters(j,:),'kx','MarkerSize',14,'LineWidth',2);
            plot(ClusterCenters(i,:),ClusterCenters(j,:),'ko','MarkerSize',14,'LineWidth',2);
        end
    end
end



