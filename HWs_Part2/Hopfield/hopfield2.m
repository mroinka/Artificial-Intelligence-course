clc;
clear;
close all;



P=[ 1 -1;-1  1];

net=newhop(P);

% view(net);


N=50;

figure;

Colors=hsv(N);

for i=1:N

    a=unifrnd(-1,1,[2 1]);

    y=net({1 50},[],{a});

    y=[a cell2mat(y)];

    plot(y(1,:),y(2,:),...
        'LineWidth',2,...
        'Color',Colors(i,:));
    
    hold on;
    
    if y(1,end)==1
        MARKER='+';
    else
        MARKER='^';
    end
    
    plot(a(1,:),a(2,:),MARKER,...
        'LineWidth',2,...
        'MarkerSize',10,...
        'Color',Colors(i,:));

end

plot(P(1,:),P(2,:),'rs','LineWidth',2);

plot([-1 1],[-1 1],'k--');

axis equal;

grid on;
