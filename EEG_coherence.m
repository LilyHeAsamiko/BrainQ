%%EEG data
% direct coherence

fs = 1200;
% coherence calculated by magnitude square
%R(1,:) = coherence(S(1,:),S(2,:),3,5);
C(1,:) = mscohere(X(1,:),X(2,:),hamming(100),[],[],fs,'mimo');
%Ra1b1 = wcoherence(Xa1,Xb1);
%R(2,:) = correlation(S(2,:),S(3,:),3,5);
C(2,:) = mscohere(X(2,:),X(3,:),hamming(100),[],[],fs,'mimo');
%Ra1I1 = wcoherence(Xa1,XI1);
%R(3,:) = correlation(S(3,:),S(3,:),3,5);
C(3,:) = mscohere(X(3,:),X(1,:),hamming(100),[],[],fs,'mimo');

%partialcoherence
%RI1b1 = wcoherence(XI1,Xb1);
% normalized_partial(remove1Ra1b1 = correlation(Fa1,Fb1,3,5);
Cpa3 = (C(3,:)-C(1,:).*C(2,:))./sqrt((1-C(1,:).^2).*(1-C(2,:).^2));
%Rpa1 = (R(1,:)-R(3,:).*R(2,:))./sqrt((1-R(3,:).^2).*(1-R(2,:).^2));
[h,p,ci,stats] = ttest(C(3,:),Cpa3);
%h=1, p= 2.1533e-31
figure,
area = ['a','b','1','a'];
for i =1:3
    subplot(4,1,i)
    plot(C(i,:));
    title(['coherence between area ',area(i),'& ',area(i+1)])
end
subplot(4,1,4)
plot(Cpa3);
title(['partial correlation remove ',area(1)])

%transform matrix for coherence analysis on time
% [H_mul,E] = MVAR(EEG_T,1,312);
% figure,
% for i = 1:4
%     subplot(4,1,i)
%     imagesc(abs(H_mul{90*i}));
%     title(['transform matrix for coherence analysis on time ',int2str(90*i)])
% end

MVAR(X(:,31:390));

R = H_mul;
k = length(R);
[bicR, s] = min(bics(1:k));  % minimize the BIC criteria to get the best order  
 

%% spectrum analysis
%load the simulated data
load('CS');
L = zef_MEG_L; 
S = zef_MEG_S;
G = zef_MEG_G;
V = zef_MEG_V;
A = V'*(S-L)*G';
SPC = source_cross_spectrum(L,f,X);
