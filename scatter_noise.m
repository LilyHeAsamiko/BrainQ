%Copyright © 2018, Qin He (Lily)
%exploring the data with the relation of noise and location difference, angle difference
%X = X1; Y3 = Y31;
X = X2; Y3 = Y32;
figure(4);
gscatter(X(:,3),X(:,2),Y3);
xlabel('angle difference');
ylabel('location difference');
title('noise');
set(gca , 'xlim');
set(gca , 'ylim');

% axes(evalin('base','zef.h_axes1'));
% cla(evalin('base','zef.h_axes1'));
% set(evalin('base','zef.h_axes1'),'YDir','normal');
