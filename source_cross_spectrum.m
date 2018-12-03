% source cross spectrum computation
function [SCS,E,SNR] = source_cross_spectral(L,X,f,e,df)
%X = zef.measurements(e,:);e=5;
%L = zef_MEG_L;
%CS = cross_spectral(X,f,e,df);
CS = load('CS_2');
SCS = L'*CS*L;
E = Xf*Af;
SNR = 10*log(SCS/(E*E'));
end