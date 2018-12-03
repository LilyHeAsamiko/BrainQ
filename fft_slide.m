%Copyright © 2018, Qin He (Lily)
function FFT_M = fft_slide(X,M,N,fs,fpass,fstop,fc,t1,t2,m)
%X = zef_EEG.meas_urements(33,:);
w1 = t1:t2; %slide window 
N1 = t2-t1;
X_W1(t1:t2)= zeros(1,w1);
X_W1(t1:t2) = fft(X(m,1:w1)).* fft(m,1:w1);
M_X1(t1) = mean(X_W1(t1:t2),2);
FFT_M(t1) = mean(M_X1(t1:t1+1));
for j = 2:360-N1
    X_W1(j:j+N1) = fft(X(j:j+length(w1)-1)) .* fft(w1);% fft with convolution   
    M_X1(j) = mean(X_W1(j:j+N1),2); %average the slide windows
    FFT_M(j) = fft(M_X1(j));
end
% Display real part of windowed signal and the Hanning window:

figure,
subplot(2,1,1)
plot(1:N1+1,w1(:),'*');
title('Slide Window(from t1 to t2)');
xlabel('Time (samples)'); ylabel('Amplitude');
subplot(2,1,2)
plot(1:360,abs(fft(X(m,31:390))).^2,'b-');
plot on
plot((1:360),log(abs(fft(X(m,31:390))).^2),'r-');
title('Fast Fourier (Power Spectrum )with slide window (from t1 to t2)');
hold off

figure,
plot(1:360,(abs(fft(X(1,31:390)))).^2,'b-');
plot on
plot((1:360-N1),log((abs(FFT_M(:))).^2),'r-');
title('Fast Fourier log(Power Spectrum )with slide window (from t1 to t2)');

end