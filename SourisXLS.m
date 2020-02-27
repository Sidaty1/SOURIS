%% Import data from spreadsheet
function C = sourisXLS(filename)
[NUM,TXT,~]= xlsread(filename);
[NoOfRows,NoOfColumn]= size(NUM);

for i = 2:NoOfColumn
    if (uint8(TXT{1,i}(3))>47 && uint8(TXT{1,i}(3))<57)
        TXT{1,i}=(uint8(TXT{1,i}(1))-48)*100 +(uint8(TXT{1,i}(2))-48)*10 +(uint8(TXT{1,i}(3))-48) ; %The number is bigger than 100
    else if (uint8(TXT{1,i}(2))>47 && uint8(TXT{1,i}(2))<57)                    
            TXT{1,i}=(uint8(TXT{1,i}(1))-48)*10 +(uint8(TXT{1,i}(2))-48);                           %The number is bigger than 10
        else
            TXT{1,i}=uint8(TXT{1,i}(1))-48;
        end
    end
end
LABEL=[NaN,zeros(1,NoOfColumn-1)];
LABEL(:,2:end)=cell2mat(TXT(:,2:end));

if LABEL(1,2)>LABEL(1,uint8(NoOfColumn/2))
    DATAF=[NUM(:,1),zeros(NoOfRows,NoOfColumn-1)];    
    LABELF=[NaN,zeros(1,NoOfColumn-1)];
        k=0;
        for i = 2:NoOfColumn
            LABELF(:,i)=LABEL(:,NoOfColumn-k);
            DATAF(:,i)=NUM(:,NoOfColumn-k);
            k=k+1;
        end
    LABEL=LABELF;
    NUM=DATAF;
end

C=[double(LABEL);NUM];
end
