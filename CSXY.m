%Copyright © 2018, Qin He (Lily)
function CSx_y = CSXY(X,Y)
CSXY = fft(X)*fft(Y)'/(fft(X)*fft(X)');
AXY = corr(X,Y);
EXY = AXY*CSXY;
SNRXY = 10*log(AXY*AXY'/(EXY*EXY'));
end