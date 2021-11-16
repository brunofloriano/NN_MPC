clear; close all; clc;

h = 0.8394; %LMI minimization

% INDIVIDUAL SYSTEM DYNAMICS
%a = 0.3;
%d = 0.8;
%c = d;
alpha = [0 0 0 0 0]; 
phi = [-5 5 5 10 15]; 
phi_dot = [-12 -8 5 5 12];

A = [-0.5 0.6;0.2 -0.5];
B = [0.8 -0.1;-1.2 0.3];

x = [phi-alpha;phi_dot];
n = length(A);
m = size(B,2);
C = eye(n); 
Dsys = zeros(n,m);


% COMMUNICATION GRAPH
L{1} = [0 0 0 0 0;0 1 -1 0 0;0 0 1 0 -1;1 0 0 0 0;0 0 0 0 0];
L{2} = [0 0 0 0 0;0 1 -1 0 0;0 0 1 0 -1;1 0 0 0 0;0 0 0 0 0];
Delta = 0.01;
delta = 0;
Pi_estimated = [0.6 0.4;0.3 0.7];
mu = 0.11;
tau = 0.2;

D{1} = diag(diag(L{1}));
D{2} = diag(diag(L{2}));
Aij{1} = D{1} - L{1};
Aij{2} = D{2} - L{2};
N = length(L{1});
S = length(Pi_estimated);

% einterA = -delta + 2*delta*rand(S);
% einterB = diag(diag(einterA));
% einterC = einterA - einterB;
% einterD = -sum(einterC')';
% epsilon = einterC + diag(einterD);
% 
% Pi = Pi_estimated + epsilon;
% Psi = eye(S) + Pi*Delta;
Psi = Pi_estimated;
mc = dtmc(Psi);


%rng(98);

% CONTROL SYSTEM
%K = [0.4683 -0.2158;-0.3932 0.3281];
%K = [0.8259 -0.4596;-0.3489 0.2947];
%K = [1 0;0 0]; %rng(300); % For reproducibility
K = [0 0;0 0];

% FOR AUGMENTED SYSTEM
xaug = [];
for i = 1:N
xaug = [xaug;x(:,i)];
end
Aaug = kron(eye(N),A) - kron(L{1},B*K);
Baug = zeros(N*n,m);
Caug = eye(N*n);
Daug = zeros(N*n,m);

% SIMULATION
tmax = 30;
tdelta = 0.8;
if tdelta < Delta
    fprintf('Sampling time has to be greater than Delta \n','s');
    fprintf('Making tdelta = Delta \n','s');
    tdelta = Delta;
end
t = 0:tdelta:tmax-tdelta;
state(:,1) = xaug;
mode = simulate(mc,(tmax)/Delta);

%pause

state(:,1) = xaug;
delay = mu/2*randn(length(t),1) + (tau + mu/2);
for i = 2:length(t)
    Laplacian = L{mode(round(i*tdelta/Delta))};
    Aaug = kron(eye(N),A);
    Baug = kron(eye(N),B);
    if i - 1 - round(delay(i)/tdelta) <= 0
        delayedstate = zeros(length(state(:,1)),1);
    else
        delayedstate = state(:,i-1-round(delay(i)/tdelta));
    end
    u = - kron(Laplacian,K)*delayedstate;
    state(:,i) = state(:,i-1) + tdelta*(Aaug*state(:,i-1) + Baug*u);
end


figure
subplot(2,1,1)
plot(t,state([1:2:N*2-1],:)+alpha');
xlabel('t')
ylabel('\phi_i')
subplot(2,1,2)
plot(t,state([2:2:N*2],:));
ylabel('\phi`_i')
xlabel('t')

figure
plot(0:Delta:tmax,mode)
ylim([0 3])
xlabel('t')
ylabel('Markov mode')

figure
plot(t,delay)
xlabel('t')
ylabel('Delay')
%sim('WW20sim_aug');