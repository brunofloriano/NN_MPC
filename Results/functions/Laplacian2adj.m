function Adj = Laplacian2adj(L)
D = diag(diag(L));
Adj = D - L;
