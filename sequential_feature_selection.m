%% split the data into training data and test data
%X = X2, Y =Y2;
%X = X1, Y =Y1;
%err = sqrt((X(:,1)).^2+(X(:,2)).^2+(X(:,3)).^2);
% err = sqrt((X(:,1)).^2+(X(:,2)).^2);
% %X_sort = sort([err,X],1);
% index_tr = find((err-mean(err)).^2/size(err,2)<70);
% index_te = find(50<(err-mean(err)).^2/size(err,2)<150);
% Train_data = [X(index_tr,:),Y1(index_tr)];
% Test_data = [X(index_te,:),Y1(index_te)]; 
function fs = sequential_feature_selection(Train_data)
%Train_data = [X(svInd,:),Y(svInd)];
    %%validation
    c = cvpartition(Train_data(:,8), 'k', 5);

    %feature selection
    opts = statset('display','iter');
    [~,p,stats] = manova1([Train_data(:,1:3),Train_data(:,5:7)],Train_data(:,8))
    fun = @(train_data, train_labels, test_data, test_labels)...
        sum(predict(fitcsvm(train_data,train_labels,'KernelFunction','Gaussian'),test_data) ~= test_labels);
    [fs, history] = sequentialfs(fun, [Train_data(:,1:3),Train_data(:,5:7)],Train_data(:,8),'cv',c,'options',opts,'nfeatures',3);


gscatter(Train_data(:,1),Train_data(:,2),Train_data(:,8))
end