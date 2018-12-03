%Copyright © 2018, Qin He (Lily)
% exploring the data with the relation of location(superficial, deep, pair) and location difference, angle difference 
%X = X1; Y = Y1;
X = X2; Y = Y2;
figure(2);
gscatter(X(:,3),X(:,2),Y);
xlabel('location difference');
ylabel('angle difference');
title('Theta0');
legend('10^-5','10^-9')
set(gca , 'xlim');
set(gca , 'ylim');
% axes(evalin('base','zef.h_axes1'));
% cla(evalin('base','zef.h_axes1'));
% set(evalin('base','zef.h_axes1'),'YDir','normal');
