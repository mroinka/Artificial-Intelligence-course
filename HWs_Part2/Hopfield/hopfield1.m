clc;
clear;
close all;

P=[ 1 -1;-1  1];

net=newhop(P);

% view(net);

a=[0.8 0.2]';

y=net({1 10},[],{a});

y=[a cell2mat(y)];

figure;
plot(y(1,:),y(2,:),'b');
hold on;
plot(a(1,:),a(2,:),'bx');
plot(P(1,:),P(2,:),'rs','LineWidth',2);
legend('Trajectory','Start Point','Fixed Point');
legend('Location','NorthEastOutside');
grid on;



