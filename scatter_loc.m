%Copyright © 2018, Qin He (Lily)
% exploring the data with the relation of location(superficial, deep, pair) and location difference, angle difference 
%X = X1; Y1 = Y11;
X = X2; Y1 = Y12;
% h_axes1 = evalin('base','zef.h_axes1');
gscatter(X(:,3),X(:,2),Y1);
set(gca , 'xlim');
set(gca , 'ylim');
figure(1);
xlabel('location difference');
ylabel('angle difference');
title('location');
legend('Thalamus single','Somatosensory single','Thalamus paired','Somatosensory paired')
