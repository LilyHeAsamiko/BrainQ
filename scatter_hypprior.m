%Copyright © 2018, Qin He (Lily)
%exploring the data with the relation of hyperprior and location difference, angle difference 
%X = X1; Y2 = Y21;
X = X2; Y2 = Y22;
figure(3);
gscatter(X(:,3),X(:,2),Y2);
xlabel('location difference');
ylabel('angle difference');
legend('Gamma','Inverse Gamma')
title('Hyperprior');
set(gca , 'xlim');
set(gca , 'ylim');
