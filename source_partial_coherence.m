%Copyright © 2018, Qin He
function [SPCX,E,SNR] = source_partial_coherence(L,CS,V,S,G)
ICS=inv(CS);
L = zef_MEG_L;
V = zef_MEG_V;
S = zef_MEG_S;
G = zef_MEG_G;
K = V'*(S-L)*G';
SPCX = K'*ICS*K;
Af = fft(corr(X,Y));
E = SPCX*A'*A'*SPCX';
SNR = 10*log(SPCX/(E*E'));
end


