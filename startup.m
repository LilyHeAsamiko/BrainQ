%Copyright © 2018, Qin He
%Startup function
function startup(datatype,sensors,H)
    switch datatype
        case 'EEG'% EEG electrodes
        figure,
        plot(sensors(:,1),sensors(:,2),'o');
        [r1,c1]=find(H>0);
        [r2,c2]=find(H<0);
        sparse(r1,c1,s1,72,360);
        sparse(r2,c2,s2,72,360);
        plot(sensors(r1,1),sensors(r2,2),'r-');
        hold on;
        plot(sensors(r1,1),sensors(r2,2),'b-');
        case 'MEG'% MEG coils
        plot(sensors(:,1),sensors(:,2),'o');
        [r1,c1]=find(H>08e06);
        [r2,c2]=find(H<08e06);
        sparse(r1,c1,s1,271,360);
        sparse(r2,c2,s2,271,360);
        plot(sensors(r1,1),sensors(r2,2),'r-');
        hold on;
        plot(sensors(r1,1),sensors(r2,2),'b-');
        end
end