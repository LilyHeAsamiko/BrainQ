%Copyright © 2018, Qin He (Lily)
% cross spectrum matrix computation
function [CS,E,SNR] = cross_spectral(X,f,e,df)
%X = zef.measurements(e,:);

Xf = fft(X);
%df =3 resolution
[r,c] = find(min(abs(Xf-f)));
for i = 1:size(X,1)
    for j = 1:size(X,2)
        Af(i,j) = corr(X(i,j),c(e))/df;
        for n = e+1:e+9
            Af(i,j) = Af(i,j) + corr(X(i,j),c(n))/df;
        end
        Af(i,j) = Af(i,j)/10;
    end  
end

CS = Af*Af'/cov(X(e,:));
E = Xf.*Af;
SNR = 10*log(CS./(E*E'));
end


