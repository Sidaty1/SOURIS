%% This function receives 5 cell elements originated via "SourisXLS" and generates a single cell element wich contains the avarage of the 5 initial inputs
function [time, DATA, DATAF] = Average5 (voltage, NoSouris)
    switch NoSouris
    case 1
        souris = 'Souris1/';
    case 2
        souris = 'Souris2/';
    otherwise
        souris = 'Souris1/';
    end
    if voltage == 300 || voltage == 400 || voltage == 500 || voltage == 600
       C1=SourisXLS(strcat(souris, num2str(voltage), '/Data_1'));
       C2=SourisXLS(strcat(souris, num2str(voltage), '/Data_2'));
       C3=SourisXLS(strcat(souris, num2str(voltage), '/Data_3'));
       C4=SourisXLS(strcat(souris, num2str(voltage), '/Data_4'));
       C5=SourisXLS(strcat(souris, num2str(voltage), '/Data_5'));
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
