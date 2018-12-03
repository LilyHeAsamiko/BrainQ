axes(evalin('base','zef.h_axes1'));
cla(evalin('base','zef.h_axes1'));
set(evalin('base','zef.h_axes1'),'YDir','normal');

x = randn(100,2);
scatter(x(:,1),x(:,2));
