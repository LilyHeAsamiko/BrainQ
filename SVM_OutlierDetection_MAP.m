%Copyright © 2018, Qin He (Lily)
function [svInd] = SVM_OutlierDetection_MAP(X,Y)
%X = X1
%X = X2
y = ones(size(X,1),1);
rng(1);
SVMModel = fitcsvm([X(:,1) X(:,2)],y,'KernelScale','auto','Standardize','on',...
    'OutlierFraction',0.1);

svInd = SVMModel.IsSupportVector;
h = 1; % Mesh grid step size
% [X1,X2,X3] = meshgrid(min(X(:,1)):h:max(X(:,1)),...
%     min(X(:,2)):h:max(X(:,2)),min(X(:,3)):h:max(X(:,3)));
[X10,X20] = meshgrid(min(X(:,1)):h:max(X(:,1)),min(X(:,2)):h:max(X(:,2)));
% [~,score] = predict(SVMModel,[X1(:),X2(:),X3(:)]);
[~,score] = predict(SVMModel,[X10(:),X20(:)]);

% scoreGrid = reshape(score,size(X1,1),size(X2,2),size(X3,3));
scoreGrid = reshape(score,size(X10,1),size(X20,2)); 
figure(5)
% plot3(X(:,3),X(:,2),X(:,1),'k.')
plot(X(:,1),X(:,2),'k.')
hold on
% plot3(X(svInd,3),X(svInd,2),X(svInd,1),'ro','MarkerSize',10)
plot(X(svInd,1),X(svInd,2),'ro','MarkerSize',5)
%contour3([X(svInd,3),X(svInd,1)])
contour(X10,X20, scoreGrid)
colorbar;
xlim = [-5 50];
ylim = [-10 100];
set(gca, 'xlim',xlim);
set(gca, 'ylim',ylim);
title('{\bf Data1 Outlier Detection via One-Class SVM}')
xlabel('Location difference (mm)')
%ylabel('Angle difference (mm)')
ylabel('Amplitude difference (mm)')
legend('Observation','Support Vector')
hold off

CVSVMModel = crossval(SVMModel);
[~,scorePred] = kfoldPredict(CVSVMModel);
outlierRate = mean(scorePred<0)
% 
%  axes(evalin('base','zef.h_axes1'));
%  cla(evalin('base','zef.h_axes1'));
%  set(evalin('base','zef.h_axes1'),'YDir','normal');
svInd = find(svInd==1);
end