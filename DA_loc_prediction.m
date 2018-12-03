%Copyright © 2018, Qin He (Lily)
%%import conditional mean
function accuracy = DA_loc_prediction (Train_data,fs) 
data = [Train_data(:,fs) Train_data(:,8)];
tt  = tall(data) % Tall table
Y = tt(:,end)% Class labels
X = tt(:,1:end-1) % Predictor data
%R = rmmissing([X Y]); % Data with missing entries removed
%X = R(:,1:end-1); 
%Y = R(:,end); 
Z = zscore(X);
Mdl = fitcdiscr(Z,Y,...
    'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',...
    struct('AcquisitionFunctionName','expected-improvement-plus'))
pred = predict(Mdl, Z);
accuracy = sum(pred == Y)/size(Y,1)
end
