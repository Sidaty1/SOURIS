function [Res]=Activations(NoSouris)
limtimeinf=5.0; %lower limit of stimulation time window
limtimesup=6.0; %higher limit of stimulation time window
[time, LABEL, REP300, ~] = Average5(300, NoSouris);
[~, ~, REP400, ~] = Average5(400, NoSouris);
[~, ~, REP500, ~] = Average5(500, NoSouris);
[~, ~, REP600, ~] = Average5(600, NoSouris);        %Extracting time, label and the 5 repetitions for every voltage
[~,indtimeinf]=min(abs(time-limtimeinf)); % finding the index corresponding to limtimeinf
[~,indtimesup]=min(abs(time-limtimesup)); % finding the index corresponding to limtimesup
s=size(REP300);
data_stim300=REP300(indtimeinf:indtimesup,:,:);
data_stim400=REP400(indtimeinf:indtimesup,:,:);
data_stim500=REP500(indtimeinf:indtimesup,:,:);
data_stim600=REP600(indtimeinf:indtimesup,:,:);
Res=zeros(5,s(2));
Res(2,1)=300;
Res(3,1)=400;
Res(4,1)=500;
Res(5,1)=600;
Res(1,:)=LABEL;
for rep=1:5
    for col=2:s(2)
        [ ~, ilx ] = min(abs(time-3));
        [ ~, ihx ] = min(abs(time-4.5));
        base300=REP300(ilx:ihx,col,rep);
        threshold300=3*std(base300);
        data_r300=data_stim300(:,col,rep);
        if not(all(data_r300<threshold300))
            Res(2,col)=Res(2,col)+1;
        end
        base400=REP400(ilx:ihx,col,rep);
        threshold400=3*std(base400);
        data_r400=data_stim400(:,col,rep);
        if not(all(data_r400<threshold400))
            Res(3,col)=Res(3,col)+1;
        end
        base500=REP500(ilx:ihx,col,rep);
        threshold500=3*std(base500);
        data_r500=data_stim500(:,col,rep);
        if not(all(data_r500<threshold500))
            Res(4,col)=Res(4,col)+1;
        end
        base600=REP600(ilx:ihx,col,rep);
        threshold600=3*std(base600);
        data_r600=data_stim600(:,col,rep);
        if not(all(data_r600<threshold600))
            Res(5,col)=Res(5,col)+1;
        end
    end
end
end