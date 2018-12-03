%% SVM classifier
rng(1); % For reproducibility
 
%clean training data according to SVM outlier detection
Train_data = [X(svInd,:),Y(svInd)];
classes = unique(Y(svInd));
N = numel(classes);
y = {};
indx = {}
pred = {};
%pred = {zeros(size(Y1(index_tr),1),N)};
pred = {zeros(size(Y(svInd),1),N)};
colors = ['r','g','b','k']
figure

%binary classification
for j = 1:N
    
    %feature selection
    
    indx{j} = find(Y(svInd)==classes(j));
    y{j} = (Y(indx{j})==classes(j));  % Create binary classes for each classifier
    %cross-validation,fold number = 3
    c = cvpartition(Train_data(indx{j},8), 'k', 3);
    opts = statset('display','iter');
    [~,p,stats] = manova1([Train_data(indx{j},1:3)],Train_data(indx{j},8)==j)
    fun = @(train_data, train_labels, test_data, test_labels)...
        sum(predict(fitcsvm(train_data,train_labels,'KernelFunction','rbf'),test_data) ~= test_labels);
    [fs, history] = sequentialfs(fun, [Train_data(indx{j},1:3),Train_data(indx{j},5:7)],y{j},'cv',c,'options',opts,'nfeatures',3);

    SVMModels{j} = fitcsvm(X(indx{j},fs),y{j},'ClassNames',[false true],'Standardize',true,'KernelFunction','gaussian','BoxConstraint',1,'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName','OptimizeHyperparameters','auto',...
     'expected-improvement-plus','ShowPlots',true));%box = optimizableVariable('box',[1e-4,1e3],'Transform','log','Optimize',true);

   [pred{j},~] = predict(SVMModels{j},X(indx{j},fs));
%   gscatter(X((index_tr),3),X((index_tr),2),Y1(index_tr),[(j-1)/N j/N (j-1)/N;(j-1)/N j/N (j-1)/N],'xo');
%   [(j-1)/N j/N (j-1)/N;(j-1)/N j/N (j-1)/N]
    pred{j} = j*pred{j};    
%    figure
    gscatter(X(indx{j},1),X(indx{j},2),pred{j},colors(j),'ox');
%    gscatter(X(indx{j},3),X(indx{j},2),pred(indx{j},j) == y{j}(indx{j},:),colors(j),'ox');
    hold on
    Pred(j) = sum(pred{j}==y{j})

end
xlim =[-30 40]
ylim =[-40 140]
title(' Location prediction');
xlabel('location difference');
ylabel('angle difference');
legend('thalumus','somatosensory','thalumus-paired','somatosensory-paired')
set(gca,'xlim',xlim);
set(gca, 'ylim',ylim);
accuracy = sum(Pred)/length(Y1(svInd));
[h,~] = ttest([pred{1},{2};pred{1},{3};pred{1},{4};pred{1},{1};],Train_data(:,8),'Alpha',0.01)

% figure
% h = gscatter(X((svInd),1),X((svInd),2),[pred{1} ;pred{2}; pred{3}; pred{4}]);%for 4 classes
% legend('thalumus','somatosensory','thalumus_paired','somatosensory_paied')
% title(' Location Classification ');
% xlabel('locdif (mm)');
% ylabel('angdif (mm)');
% legend(h,{'thalamus','superficial','thalamus_2','superficial_2'},'Location','Northwest');
% axis tight
