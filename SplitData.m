%Copyright © 2018, Qin He (Lily)
%% split the data into training data and test data
function [Train_data,Test_data] = SplitData(X,Y,svInd)
% X = X2; Y =Y2; % X1,Y1 for data 1, X2,Y2 for data2 
%err = sqrt((X(:,1)).^2+(X(:,2)).^2+(X(:,3)).^2);
err = sqrt((X(svInd,2)).^2+(X(svInd,3)).^2);
%X_sort = sort([err,X],1);
index_tr = find((err-mean(err)).^2/size(err,2)<50);
index_te = find(50<(err-mean(err)).^2/size(err,2)<150);
Train_data = [X(index_tr,:),Y(index_tr)];
Test_data = [X(index_te,:),Y(index_te)]; 

figure;
gscatter(Train_data(:,2),Train_data(:,3),Train_data(:,8));
xlim = [-30 40];
ylim = [-40 140];
set(gca,'xlim',xlim);
set(gca,'ylim',ylim);

figure;
gplotmatrix(Train_data(:,1:7),[],Train_data(:,8),[],'+xo.');
end
% axes(evalin('base','zef.h_axes1'));
% cla(evalin('base','zef.h_axes1'));
% set(evalin('base','zef.h_axes1'),'YDir','normal');
