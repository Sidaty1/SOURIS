function [Res]=Activations(NoSouris)
limtimeinf=5.0; %lower limit of stimulation time window
limtimesup=6.0; %higher limit of stimulation time window
[time, LABEL, DATAF300] = Average5(300, NoSouris);
[~, ~, DATAF400] = Average5(400, NoSouris);
[~, ~, DATAF500] = Average5(500, NoSouris);
[~, ~, DATAF600] = Average5(600, NoSouris);
[~,indtimeinf]=min(abs(time-limtimeinf)); % finding the index corresponding to limtimeinf
[~,indtimesup]=min(abs(time-limtimesup)); % finding the index corresponding to limtimesup
s=size(DATAF300);
data_stim300=DATAF300(indtimeinf:indtimesup,:);
data_stim400=DATAF400(indtimeinf:indtimesup,:);
data_stim500=DATAF500(indtimeinf:indtimesup,:);
data_stim600=DATAF600(indtimeinf:indtimesup,:);
Res=zeros(5,s(2));
Res(1,1)=NaN;
Res(2,1)=300;
Res(3,1)=400;
Res(4,1)=500;
Res(5,1)=600;
Res(1,:)=LABEL;
for r=2:s(2)
    [ ~, ilx ] = min(abs(time-3));
    [ ~, ihx ] = min(abs(time-4.5));
    base300=DATAF300(ilx:ihx,r);
    threshold300=3*std(base300);
    data_r300=data_stim300(:,r);
    if not(all(data_r300<threshold300))
        Res(2,r)=1;
    end
    base400=DATAF400(ilx:ihx,r);
    threshold400=3*std(base400);
    data_r400=data_stim400(:,r);
    if not(all(data_r400<threshold400))
        Res(3,r)=1;
    end
    base500=DATAF500(ilx:ihx,r);
    threshold500=3*std(base500);
    data_r500=data_stim500(:,r);
    if not(all(data_r500<threshold500))
        Res(4,r)=1;
    end
    base600=DATAF600(ilx:ihx,r);
    threshold600=3*std(base600);
    data_r600=data_stim600(:,r);
    if not(all(data_r600<threshold600))
        Res(5,r)=1;
    end
end
end