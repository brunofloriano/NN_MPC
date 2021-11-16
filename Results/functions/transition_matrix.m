function Psi = transition_matrix(Pi_estimated,delta,Delta)
S = length(Pi_estimated);

if sum(Pi_estimated') == 1
    fprintf('Transition matrix \n','s');
    Psi = Pi_estimated;
else
    fprintf('Transition rate matrix \n','s');
    einterA = -delta + 2*delta*rand(S);
    einterB = diag(diag(einterA));
    einterC = einterA - einterB;
    einterD = -sum(einterC')';
    epsilon = einterC + diag(einterD);
    
    Pi = Pi_estimated + epsilon;
    Psi = eye(S) + Pi*Delta;
end