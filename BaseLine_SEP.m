%Copyright © 2018, Qin He (Lily)
function [EEG_B,MEG_B]=BaseLine(EEG,MEG,N)
%Transformation
EEG_Z = zscore(EEG); %student normalization
%EEG_L = log(EEG);
MEG_Z = zscore(MEG);
%MEG_L = log(MEG);

%Baseline correction of ERP analysis
ERP_BE(:,1) = mean(EEG_Z(:,1:30),2);
ERP_BM(:,1) = mean(MEG_Z(:,1:30),2);

for i = 2:360
    ERP_BE(:,i) = mean(EEG_Z(:,i:i+30),2);
    EEG_B(:,i) = EEG(:,i)-ERP_BE(:,i);
    PvalueE(:,i) = ttest(ERP_BE(:,i),EEG_B(:,i))
    
    ERP_BM(:,i) = mean(MEG_Z(:,i:i+29),2);
    MEG_B(:,i) = MEG(:,i)-ERP_BM(:,i);
    PvalueB(:,i) = ttest(ERP_BM(:,i),MEG_B(:,i))
end


%SEP
k1 = size(EEG_B,1);
k2 = size(MEG_B,1);
m1 = mean(mean(EEG_B,2));
m2 = mean(mean(MEG_B,2));

N = 5;
% the Nth channel
LogPower_E(N,:) = log(abs((fft(EEG_B(N,:)))).^2);
GMFP_E = sqrt(sum(((EEG_B(N,:)-m1).^2),1)/k1); %Global mean field potential of EEG
LogPower_M(N,:) = log(abs((fft(MEG_B(N,:)))).^2);
GMFP_M = sqrt(sum(((MEG_B(N,:)-m1).^2),1)/k2); %Global mean field potential of MEG

figure;
subplot(4,1,1)
plot(1:360,EEG(N,31:390),'b--',1:360,ERP_BE(N,:),'r');
xlabel('Time');
ylabel('Amplitude')
legend('RAW','ERP');
title('ERP corrected baseline for EEG');
subplot(4,1,2)
plot(1:360,EEG_B(N,:),'b--',1:360,GMFP_E,'r');
xlabel('Time');
ylabel('Amplitude')
legend('Baseline','GMFP');
title('ERP corrected baseline for EEG');
subplot(4,1,3)
plot(1:360,EEG_B(N,:),'b--',1:360,LogPower_E(N,:),'r');
xlabel('Time');
ylabel('Amplitude')
legend('Baseline','Log Power');
title('Log power of ERP corrected baseline');
subplot(4,1,4)
plot(1:360,PvalueE)
title('Pvalue for EEG');

figure,
subplot(4,1,1)
plot(1:360,MEG(N,31:390),'b--',1:360,ERP_BE(N,:),'r');
xlabel('Time');
ylabel('Amplitude')
legend('RAW','ERP');
title('ERP corrected baseline for MEG');
subplot(4,1,2)
plot(1:360,MEG_B(N,:),'b--',1:360,GMFP_M,'r');
xlabel('Time');
ylabel('Amplitude')
legend('Baseline','GMFP');
title('ERP corrected baseline for MEG');
subplot(4,1,3)
plot(1:360,MEG_B(N,:),'b--',1:360,LogPower_M(N,:),'r');
xlabel('Time');
ylabel('Amplitude')
legend('Baseline','Log Power');
title('Log power of ERP corrected baseline');
subplot(4,1,4)
plot(1:360,PvalueE)
title('Pvalue for MEG');
end