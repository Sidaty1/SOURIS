%plot boxplot 

for i = 0:29
    figure,
 boxplot(DATAF(1+i*30:30+i*30,2:end)','whisker', 5);
end