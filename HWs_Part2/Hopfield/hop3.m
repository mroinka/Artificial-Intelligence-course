clc;
clear;
close all;

%% Load Data

[X T]=prprob();

Letters='ABCDEF';

LettersIndex=double(Letters)-64;

P=X(:,LettersIndex);

%% Create and Train Hopfield Net

net=newhop(P);

% view(net);

%% Test Network

TestLetter='A';

TestLetterIndex=double(TestLetter)-64;

a=X(:,TestLetterIndex);
a=a+0.3*randn(size(a));

y=net({1 23},[],{a});

y(:,end)=mean(y(:,end-10:end),2);

N=size(y,2);

figure;
for i=1:N
    subplot(4,6,i);
    plotchar(y(:,i));
    title(['Step ' num2str(i-1)]);
end



