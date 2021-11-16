% INDIVIDUAL SYSTEM DYNAMICS
alpha = [0 0 0 0]; 

%phi = [4 3 1 1 3];
phi = [3 1 1 3];
%phi_dot = [-2 -1 -1 -3 -3];
phi_dot = [-1 -1 -3 -3];
A = [0 1;0 -0.5];
B = [0.8;1.2];
Bw = [1 0;0 1];
tmax = 25;

% COMMUNICATION GRAPH
H{1} = [1 0 0 0;-1 1 0 0;0 -1 1 0;-1 0 0 1];
H{2} = [1 -1 0 0;0 1 0 0;-1 0 1 0;0 0 -1 1];
%L{1} = [0 zeros(1,4);zeros(4,1) H{1}];
%L{2} = [0 zeros(1,4);zeros(4,1) H{2}];
L = H;
Delta = 0.01;
delta = 0;
%Pi_estimated =[-5 5;2 -2];
Pi_estimated = [0.95    0.05;    0.02    0.98]; %Pi_1
%Pi_estimated =[0.6 0.4;0.3 0.7]; %Pi_2
%Pi_estimated =[0.5 0.5;0.5 0.5]; %Pi_3
Pi_estimated =[0.05 0.95;0.98 0.02]; %Pi_4
mu = 0;
tau = 0;

% CONTROL SYSTEM
%K = [0.4683 -0.2158;-0.3932 0.3281];
%K = [1 0;0 0]; %rng(300); % For reproducibility
Km{1} = [0.8955 1.719];
Km{2} = [1.7479 3.2955];

% DYNAMIC SYSTEM
dynamic_function = 'state(:,i) = state(:,i-1) + tdelta*(Aaug*state(:,i-1) + Baug*u + 0.01*sin(state(:,i-1)) + kron(ones(4,1),eye(2))*Bw*[0.02*sin(t(i));0.02*cos(t(i))] );';
vdynamic_function = 'vstate(:,vtime) = vstate(:,vtime-1) + tdelta*(Aaug*vstate(:,vtime-1) + Baug*vu + 0.01*sin(vstate(:,vtime-1)) + kron(ones(4,1),eye(2))*Bw*[0.02*sin(text(i-1+vtime));0.02*cos(text(i-1+vtime))]);';
nNeurons = 10;
tdelta = 0.01;
% SAVE NAME
save_mainname = 'dataGL20nKMPC ';