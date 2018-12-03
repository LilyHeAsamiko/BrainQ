%Copyright © 2018, Qin He (Lily)
% zef_MEG.V = rand(271,271);
% zef_MEG.G = rand(360,227871);
% zef_MEG.S = rand(271,227871);

%spectrum analysis at f =0.4Hz
MEG_z = zscore(zef_MEG.measurements);
MEG_T = MEG_z(:,31:390);
X = MEG_T(13,:);
Y = MEG_T(15,:);
%Z = zef_MEG.measurements(27,:); 
L = zef_MEG.L;

Xf = fft(X);
Yf = fft(Y);
%Zf = fft(Z);

f =1200;
e = 10;
H = inv(A);
Af = fft(A);
% E = Xf.*Af;
% SNRxx = 10*log(CS/E(1:271,1:271));
A = corr(X);
B = corr(Y);
Xf = fft(X);
H = inv(A);
Af = fft(A);

CSXY = fft(X')*fft(Y);
SNR=snr(diag(CSXY),1200);
spectrogram(real(SNR))

ICSXY=inv(CSXY);
V = zef_MEG.V;
S = zef_MEG.S;
G = zef_MEG.G;
K = V'*(S-L)*G';
SPCXY = K*ICSXY*K';
SNR=snr(CSXY);

spectrogram(diag(SPCXY));
pspectrum(diag(SPCXY));
imagesc(real(SPCXY))

ROIX1=SPCXY(13:27);
d=diag(SPCXY);
ROIX2=d(13:27);

figure,
subplot(4,1,1)
spectrogram(ROIX1);
title('channels 13 -> channels 27 spectrogram of source partial cross discrete spectrum')
subplot(4,1,2)
pspectrum(ROIX1); 
title('channels 13 -> channels 27 spectrogram of source partial cross continuous spectrum')
subplot(4,1,3)
spectrogram(ROIX2);
title('channels 13 -> channels 27 spectrogram of source partial self-cross discrete spectrum')
subplot(4,1,4)
pspectrum(ROIX2); 
title('channels 13 -> channels 27 spectrogram of source partial self-cross continuous spectrum')

R = real(SPCXY(13:27,13:27));
I = imag(SPCXY(13:27,13:27));
[h,p,ci,stats]= ttest(R,I)
[h,p,ci,stats]= ttest(SPCXY,SPCYX)

figure
subplot(2,1,1)
imagesc()
title('channels 27 -> channels 13 spectrogram of source partial cross spectrum real part')
% 
% subplot(2,2,2)
% imagesc(real(SPCYX(13:27,13:27)))
% title('channels 27 -> channels 13 spectrogram of source partial cross spectrum real part')
% 
subplot(2,1,2)
imagesc(imag(SPCXY(13:27,13:27)))
title('channels 27 -> channels 13 spectrogram of source partial cross spectrum imaginery part')
% 
% subplot(2,2,4)
% imagesc(imag(SPCYX(13:27,13:27)))
% title('channels 27 -> channels 13 spectrogram of source partial cross spectrum real part')


% E = Xf.*Af;
% SNR = 10*log(SPCX/E(1:127,1:127)

%% 
%Load the data from my bachelor essay project : dynamic neurolab PDC and DTF data
load('DTFX2')
load('PDC')
for i = 1:3
    for j =1:3
    subplot(3,3,(i-1)*3+j)
    area(DTFX2{(i-1)*3+j})
    end
end

for i = 1:3
    for j =1:3
    subplot(3,3,(i-1)*3+j)
    area(PDCX((i-1)*3+j,:))
    end
end


load('CS_2','Af');
% data collected at channel X, data collected at channel Y from sratium to LPFC and 
X = zscore(X);
Xf = fft(X);
A = corr(X);
H = inv(A);
Af = fft(A);
E = Xf.*Af;
%SNR = 10*log(CS/(E*E'))
snr(real(CS),1200)
spectrogram(ans);


