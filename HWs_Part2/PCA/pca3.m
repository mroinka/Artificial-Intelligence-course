clc;
clear;
close all;

%% Load Data

data=load('iris_dataset');

X=data.irisInputs;
T=vec2ind(data.irisTargets);

m=size(X,1);

nCluster=max(T(:));

%% Perform PCA

[Q lambda]=PerformPCA(X);

Y=Q'*X;


%% Plots

figure;

Colors=hsv(nCluster);

c=0;
for i=1:m
    for j=1:m
        c=c+1;
        if i~=j
            subplot(m,m,c);
            
            for k=1:nCluster
                plot(X(i,T==k),X(j,T==k),'+','Color',Colors(k,:));
                hold on;
            end
            
            mi=mean(X(i,:));
            mj=mean(X(j,:));

            for s=1:m
                lq=lambda(s)*Q(:,s);
                plot([mi mi+lq(i)],[mj mj+lq(j)],'k','LineWidth',3);
            end

            grid on;

            axis equal;
            
        end
    end
end

figure;
for s=1:m
    subplot(m,1,s);
    for k=1:nCluster
        plot(Y(s,T==k),'Color',Colors(k,:));
        hold on;
    end
end

figure;
c=0;
for i=1:m
    for j=1:m
        c=c+1;
        if i~=j
            subplot(m,m,c);
            
            for k=1:nCluster
                plot(Y(i,T==k),Y(j,T==k),'+','Color',Colors(k,:));
                hold on;
            end
            
            grid on;

            axis equal;
            
        end
    end
end
