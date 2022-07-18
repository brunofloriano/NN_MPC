% INDIVIDUAL SYSTEM DYNAMICS
alpha = [2 3 4];
beta = [5 6 7];

phi = 10*[-0.6 1 2.5 -1];
phi_dot = 10*[0.6 -1 0.5 1];
theta_dot = [0 0 0 0];
delta_dot = [0 0 0 0];
A = [-1 -1;0 0];
B = [1;1];
% Bw = [1 0;0 1];
tmax = 45;
vf = 1;
Length = 0.3;
Car_token = 1;

% COMMUNICATION GRAPH
% H{1} = [1 0 0 0;-1 1 0 0;0 -1 1 0;-1 0 0 1];
% H{2} = [1 -1 0 0;0 1 0 0;-1 0 1 0;0 0 -1 1];
% %L{1} = [0 zeros(1,4);zeros(4,1) H{1}];
% %L{2} = [0 zeros(1,4);zeros(4,1) H{2}];
% L = H;

L{1} = [1 0 -1;0 0 0;0 0 0];
L{2} = [0 0 0;0 1 -1;0 -1 1];

Delta = 0.01;
delta = 0;


%Pi_estimated = [0.95    0.05;    0.02    0.98]; %Pi_1
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
%dynamic_function = 'An1=kron(eye(N),[1 0;0 0]);An2=kron(eye(N),[0 0;0 1]);state(:,i) = Aaug*state(:,i-1) + kron(ones(N,1),[0;1]) + sin(An1*state(:,i-1)+Baug*u) - cos(An2*state(:,i-1) + Baug*u);';
%vdynamic_function = 'vstate(:,vtime) = Aaug*vstate(:,vtime-1) + kron(ones(N,1),[0;1]) + sin(An1*vstate(:,vtime-1)+Baug*vu) - cos(An2*vstate(:,vtime-1) + Baug*vu);';
nNeurons = 4;

% CAR
dynamic_function = ['vf = ' num2str(vf) ';' newline];
dynamic_function = ['Length = ' num2str(Length) ';' newline];
dynamic_function = ['for agent = 1:N' newline];
dynamic_function = [dynamic_function 'istate(:,agent) = state((agent-1)*n+1:agent*n,i-1);' newline];
dynamic_function = [dynamic_function 'istatenext(:,agent) = [vf*cos( [0 0 1 1]*istate(:,agent) ); vf*sin( [0 0 1 1]*istate(:,agent) ); vf/Length*sin( [0 0 0 1]*istate(:,agent) ); u((agent-1)*m+1:agent*m) ] ;' newline];
dynamic_function = [dynamic_function 'state((agent-1)*n+1:agent*n,i) = istatenext(:,agent);' newline];
dynamic_function = [dynamic_function 'end' newline];

vdynamic_function = ['for agent = 1:N' newline];
vdynamic_function = [vdynamic_function 'istate(:,agent) = vstate((agent-1)*n+1:agent*n,vtime-1);' newline];
vdynamic_function = [vdynamic_function 'istatenext(:,agent) = [vf*cos( [0 0 1 1]*istate(:,agent) ); vf*sin( [0 0 1 1]*istate(:,agent) ); vf/Length*sin( [0 0 0 1]*istate(:,agent) ); vu((agent-1)*m+1:agent*m) ] ;' newline];
vdynamic_function = [vdynamic_function 'vstate((agent-1)*n+1:agent*n,vtime) = istatenext(:,agent);' newline];
vdynamic_function = [vdynamic_function 'end' newline];



dynamic_function0 = 'state0(:,i) = [vf*cos( [0 0 1 1]*state0(:,i-1) ); vf*sin( [0 0 1 1]*state0(:,i-1) ); vf/Length*sin( [0 0 0 1]*state0(:,i-1) ); 0 ] ;';
vdynamic_function0 = 'vstate0(:,vtime) = [vf*cos( [0 0 1 1]*vstate0(:,vtime-1) ); vf*sin( [0 0 1 1]*vstate0(:,vtime-1) ); vf/Length*sin( [0 0 0 1]*vstate0(:,vtime-1) ); 0 ] ;';


tdelta = 1;
% SAVE NAME
save_mainname = 'dataCarnKMPC ';