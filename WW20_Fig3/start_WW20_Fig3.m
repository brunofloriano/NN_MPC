h = 0.8394; %LMI minimization

% INDIVIDUAL SYSTEM DYNAMICS
alpha = [0 0 0 0 0]; 
phi = [-5 5 5 10 15]; 
phi_dot = [-12 -8 5 5 12];

A = [-0.5 0.6;0.2 -0.5];
B = [0.8 -0.1;-1.2 0.3];

% COMMUNICATION GRAPH
L{1} = [0 0 0 0 0;0 1 -1 0 0;0 0 1 0 -1;1 0 0 0 0;0 0 0 0 0];
L{2} = [0 0 0 0 0;0 1 -1 0 0;0 0 1 0 -1;1 0 0 0 0;0 0 0 0 0];
Delta = 0.01;
delta = 0;
Pi_estimated = [0.6 0.4;0.3 0.7];
%Pi_estimated =[-5 5;2 -2];
%Pi_estimated =[0.5 0.5;0.5 0.5];
%Pi_estimated =[0.05 0.95;0.98 0.02];
mu = 0.11;
tau = 0.2;
tmax = 30;

% CONTROL SYSTEM
%K = [0.4683 -0.2158;-0.3932 0.3281];
%K = [0.8259 -0.4596;-0.3489 0.2947];
%K = [1 0;0 0]; %rng(300); % For reproducibility
K = [0 0;0 0];
tdelta = 0.01;