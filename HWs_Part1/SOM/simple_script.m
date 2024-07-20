
load simplecluster_dataset;

inputs = simpleclusterInputs;

% Create a Self-Organizing Map
LatticeSize=[5 3];
net = selforgmap(LatticeSize);

% Train the Network
[net tr] = train(net,inputs);

% Test the Network
outputs = net(inputs);

% View the Network
%view(net)

% Plots
% Uncomment these lines to enable various plots.
figure;
plotsomtop(net)
set(gcf,'Toolbar','figure');

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
plotsompos(net,inputs);
set(gcf,'Toolbar','figure');
