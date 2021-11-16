function Kv = matrix2vector(K)

s = size(K);
S = s(1)*s(2);

Kv = reshape(K,[1,S]);