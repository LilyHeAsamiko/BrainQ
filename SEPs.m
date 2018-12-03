%Copyright © 2018, Qin He (Lily)
%%Preprocessing
EEG = zef_EEG.measurements;
MEG = zef_MEG.measurements;

%Transformation
EEG_Z = zscore(EEG); %student normalization
EEG_L = log(EEG);
MEG_Z = zscore(MEG);
MEG_L = log(MEG);

%Baseline correction of ERP analysis
ERP_BE = mean(EEG_Z(:,1:30));
ERP_BM = mean(MEG_Z(:,1:30));
EEG_Tc = EEG_Z-repmat(ERP_BE,1,13);
MEG_Tc = MEG_Z-repmat(ERP_BM,1,13);
EEG_T = EEG_Tc(:,31:390);
MEG_T = MEG_Tc(:,31:390);

%SEP
k = size(EEG_Tc,1);
m = mean(EEG_Tc,2);
GMFP_E = sqrt(sum(((EEG_T-m).^2),1)/k);%Global mean field potential
figure;
plot(1:360,EEG_T,'b',1:360,GMFP_E,'r');
xlim([1 360]);
ylim([-1.2 1.2]);
xlabel('Time');
ylabel('Amplitude')
legend('Measurements','GMFP');
title('SEPs for EEG');

figure;
k = size(MEG_T,1);
m = mean(MEG_T,2);
GMFP_M = sqrt(sum(((MEG_T-m).^2),1)/k);
plot(1:360,MEG_T,'b',1:360,GMFP_M,'r');
xlim([1 360]);
ylim([-1.2 1.2]);
xlabel('Time');
ylabel('Amplitude')
legend('Measurements','GMFP');
title('SEPs for MEG');

pspectrum(zef.measurements(1,:))

 %time-frequency transformation(Hanning window = “raised cosine”.............)

M = 70;         % Window length

N = 75;         % FFT length (zero padding around a factor of 2)

% Compute Hanning window:
x = EEG_T(1,:);
nm = 0:M-1;
fc = 85; %fc is the midpoint of our transition band from 20Hz to 150Hz
w = 2*(fc/M)*cos(2*pi*linspace(0,1,N)) % hanning 
wzp = [w zeros(1,N-M)]; % zero-pad out to the length of x
for n = 2:390-length(x)
    xwzp = x(1)*2*(fc/M) + x(n:n+length(wzp)-1) .* wzp;
end     
figure,
% Display real part of windowed signal and the Hanning window:
subplot(2,1,1)
plot(1:N+N-M,xwzp); hold on;
title('Hanning Window and Windowed, Zero-Padded,sinusoid(cos)');
xlabel('Time (samples)'); ylabel('Amplitude(mV)'); hold on;
% fft with convolution 
subplot(2,1,2)
XWZP = real(fft(xwzp));
plot(1:N+N-M,real(XWZP));
title('Hanning Window and Windowed, Zero-Padded, tapered (Real Part)');
xlabel('Time (samples)'); ylabel('Frequency(Hz)'); hold on;


