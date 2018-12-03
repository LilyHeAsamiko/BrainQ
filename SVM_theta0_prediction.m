%Copyright © 2018, Qin He (Lily)
%% theta0 classification 
function accuracy = SVM_theta0_prediction(Train_data,fs)
%Best hyperparameters Baysopt
%X_train = X2(:,fs);
X_train = Train_data(:,fs);
%Mdl = fitcsvm(X_test,Train_data(:,8),'KernelFunction','rbf','Lambda','0.01','Learner','leastsquare' ...
%    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
%      'expected-improvement-plus','ShowPlots',true));%box = optimizableVariable('box',[1e-4,1e3],'Transform','log','Optimize',true);
% Mdl = fitcsvm(X_train,Train_data(:,8),'KernelFunction','gaussian', ...
%     'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName','OptimizeHyperparameters','auto',...
%      'expected-improvement-plus','ShowPlots',true));
box = optimizableVariable('box',[1e-4,1e3],'Transform','log','Optimize',true);
kern = optimizableVariable('kern',[1e-4,1e3],'Transform','log','Optimize',true);
% hyperparameterResults = optimizableVariable('OptimizationHyperparameters','auto');
vars = [box,kern];
fun = @(vars)kfoldLoss(fitcsvm(X_train,Train_data(:,8),'BoxConstraint',vars.box,'KernelScale',vars.kern,...
  'Kfold',5));
results = bayesopt(fun,vars,'UseParallel',true);
zbest = bestPoint(results);
Mdl = fitcsvm(X_train,Train_data(:,8),'BoxConstraint',zbest.box,'KernelScale',zbest.kern);
%Mdl = fitcsvm(X_train,Train_data(:,8),[],[],[],[]);


%% final test
X_test = Train_data(:,fs);
Y_test = Train_data(:,8);
y1 = predict(Mdl, X_test) ;
accuracy = sum(y1 ==Y_test)/size(y1,1)

% Y_pred = predict(Mdl,X_test);
% Y_train = predict(Mdl,X_test);

%% hyperplane
%%test 
%X_test = Test_data(:,fs);
figure;
hgscatter = gscatter(Train_data(:,1),Train_data(:,2),Train_data(:,8));
hold on
h_sv=plot(Mdl.SupportVectors(:,1),Mdl.SupportVectors(:,2),'ko','markersize',8);
gscatter(X_test(:,1),X_test(:,2),Y_test,'rb','xx');


%% 

%% decision plane
XLIMS = get(gca, 'xlim');
YLIMs = get(gca, 'ylim');
[xi, yi, zi] = meshgrid([XLIMS(1):1:XLIMS(2)],[YLIMs(1):1:YLIMs(2)],[XLIMS(1):1:XLIMS(2)]);
dd = [xi(:), yi(:),zi(:)];
pred_mesh = predict(Mdl, dd);
redcolor = [1, 0.8, 0.8];
bluecolor = [0.8, 0.8, 1];
pos = find(pred_mesh == 1);
h1 = plot(dd(pos,1), dd(pos,2),'s','color',redcolor,'Markersize',5,'MarkerEdgeColor',redcolor,'MarkerFaceColor',redcolor);
pos = find(pred_mesh == 2);
h2 = plot(dd(pos,1), dd(pos,2),'s','color',redcolor,'Markersize',5,'MarkerEdgeColor',redcolor,'MarkerFaceColor',redcolor);
uistack(h1,'bottom');
uistack(h2,'bottom');
legend([hgscatter;h_sv],{'locationdiff','anglediff','suppot vectors'});
title(' Theta0 prediction');
xlabel('location difference');
ylabel('angle difference');
end
