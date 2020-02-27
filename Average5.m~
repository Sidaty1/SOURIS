%% This function receives 5 cell elements originated via "SourisXLS" and generates a single cell element wich contains the avarage of the 5 initial inputs
function [time, DATA, DATAF] = Average5 (voltage)
    if voltage == 300 || voltage == 400 || voltage == 500 || voltage == 600
       C1=sourisXLS(voltage + "/Data_1");
       C2=sourisXLS(voltage + "/Data_2");
       C3=sourisXLS(voltage + "/Data_3");
       C4=sourisXLS(voltage + "/Data_4");
       C5=sourisXLS(voltage + "/Data_5");
    end
    DATA(:,:,1)=C1;
    DATA(:,:,2)=C2;
    DATA(:,:,3)=C3;
    DATA(:,:,4)=C4;
    DATA(:,:,5)=C5;
    [NoOfRows,NoOfColumn]=size(C1);
    DATAF=zeros([NoOfRows,NoOfColumn]);
    time=DATA(:,1);
    lowerBound=3000;
    higherBound=4500;
    [ ~, ilx ] = min(abs(time-lowerBound));
    [ ~, ihx ] = min(abs(time-higherBound));
    for j = 1:5
            for i = 2:NoOfColumn
                %get baseline
                baseline=DATA(ilx:ihx,i,j);
                F0=mean(baseline);
                DATA(:,i,j)=(DATA(:,i,j)-F0)/F0;
                DATAF(:,i)=DATAF(:,i)+DATA(:,i,j);
            end
    end
    DATAF(:,2:end)=DATAF(:,2:end)./5;
    time=time/1000;
end