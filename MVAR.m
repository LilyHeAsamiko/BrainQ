%Copyright © 2018, Qin He (Lily)
function [EEG_H, MEG_H] = MVAR(N)
V = zef_EEG_V;
G = zef_EEG_G;
L = zef_EEG_L;
S = zef_EEG_S;

EEG_H = inv(V)*(S-L)*G';

V = zef_MEG_V;
G = zef_MEG_G;
L = zef_MEG_L;
S = zef_MEG_S;

MEG_H = inv(V)*(S-L)*G';
        
figure,
subplot(2,1,1)
spectrogram(EEG_H(n,:));
subplot(2,1,2)
spectrogram(MEG_H(n,:));
end

