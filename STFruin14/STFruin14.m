close all
clear all
clc

format long;
u = [0,10.^9,5.*10.^9,10.^10,2.*10.^10,5.*10.^10]'; % initial capital of insurance company (in USD)
theta = 0.3;                                % relative safety loading
dparameters1 = [[0.0584,0.9416]',[3.5900e-10,7.5088e-09]']; % weights (first vector) and exponential parameters (second vector)
m = moments(1,dparameters1);    % 1st raw moment
m2 = moments(2,dparameters1);   % 2nd raw moment
psi1 = exp((-2*theta*m*u)/m2);  % the heavy traffic approximation
u1 = (1-1/(1+theta))*u;         % capital for the light traffic approximation
pa = dparameters1(:,1); % 2 x 1 matrix of weights
pb = dparameters1(:,2); %2 x 1 matrix of exponential parameters
paa = repmat(pa,1,6);
pbb = repmat(pb,1,6);

n = paa./pbb.*exp(-pb*u1');
d = sum(n);
c = meshgrid(m,d)-d';
psi2 = (m-c)/(1+theta)/m       % the light traffic approximation
%the heavy-light traffic approximation for mixture of 2 exponentials claims
%with beta1=3.5900e-10, beta2=7.5088e-09, alpha=0.0584 and theta=0.3 (u in USD)
psi = (1/(1+theta)^2)*psi1 + (1-1/(1+theta))*psi2
