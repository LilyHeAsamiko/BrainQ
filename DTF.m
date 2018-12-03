%Copyright © 2018, Qin He (Lily)
function [DTFX] = DTF(X,i,j,f)
%X=EEG_T;i=4;j=5;f=6;
A = corr(X);
Af = fft(A);
Xf = fft(X);
[r,c] = find(min(abs(Xf-f)));
H = inv(A);
B(1) =  abs(corr(X(:,1),X(:,r(j)))).^2;
for p = i:r(j)
%    B(p) = corr(X(:,p),X(:,p+1))
    B(p) = B(p) + B(p-1)
end
DTFX = H./B;

end

