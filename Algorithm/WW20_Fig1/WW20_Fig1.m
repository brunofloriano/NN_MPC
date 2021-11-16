clear; close all; clc;

h = 0.8394; %LMI minimization

% INDIVIDUAL SYSTEM DYNAMICS
a = 0.3;
d = 0.8;
c = d;
alpha = [1 2 3]; 
phi = [1 3 6]; 
phi_dot = [4 3 -2];

A = [0 1;-d -a];
B = [0 0;1 0];

x = [phi-alpha;phi_dot];
n = length(A);
m = size(B,2);
C = eye(n); 
Dsys = zeros(n,m);


% COMMUNICATION GRAPH
L{1} = [1 0 -1;0 0 0;0 0 0];
L{2} = [0 0 0;0 1 -1;0 -1 1];
Delta = 0.01;
delta = 0.3;
Pi_estimated =[-1 1;1 -1]; 

D{1} = diag(diag(L{1}));
D{2} = diag(diag(L{2}));
Aij{1} = D{1} - L{1};
Aij{2} = D{2} - L{2};
N = length(L{1});
S = length(Pi_estimated);

einterA = -delta + 2*delta*rand(S);
einterB = diag(diag(einterA));
einterC = einterA - einterB;
einterD = -sum(einterC')';
epsilon = einterC + diag(einterD);

Pi = Pi_estimated + epsilon;
Psi = eye(S) + Pi*Delta;
mc = dtmc(Psi);


%rng(98);

% CONTROL SYSTEM
%K = [0.4683 -0.2158;-0.3932 0.3281];
%K = [1 0;0 0]; %rng(300); % For reproducibility
K = [0 0;0 0];

% FOR AUGMENTED SYSTEM
xaug = [x(:,1);x(:,2);x(:,3)];
Aaug = kron(eye(N),A) - kron(L{1},B*K);
Baug = zeros(N*n,m);
Caug = eye(N*n);
Daug = zeros(N*n,m);

% SIMULATION
tmax = 30;
tdelta = 0.01;
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
for i = 2:length(t)
    Laplacian = L{mode(round(i*tdelta/Delta))};
    Aaug = kron(eye(N),A) - kron(Laplacian,B*K);
    state(:,i) = state(:,i-1) + tdelta*Aaug*state(:,i-1);
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

%sim('WW20sim_aug');