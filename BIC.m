%Copyright © 2018, Qin He (Lily)
function [bicR,s] = BIC(R)
%R = MEG_H;
k = size(R,2);
l = size(R,1)
for i = 1:k,
    H{i} = R(1:i,1:i);
end

bics = zeros(1,k);
    for i =1:k
        n = size(H{i},1);
        m = mean(H{i},2);
        RSS= mean(sum(((H{i}-m).^2),2));
        bics{i} = n*log(RSS/n)*k-k*log(n);
    end
    figure,
    plot(2:k,bics(i),'--');
    hold on    
    [bicR, s] = min(bics(2:k));    
    plot(s,bicR,'o')
    xlabel('order p')
    ylabel('BIC criteria')
end