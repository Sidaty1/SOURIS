function histogramme(NoSouris)
    voltages = [300, 400, 500, 600];
    NoActiveCell = zeros(1,4);
    if NoSouris == 1
        NoOfColumn = 229;
    else
        NoOfColumn = 48;
    end
    for i = 1:length(voltages)
        voltage = voltages(i);
        [time,~, DATAF] = Average5(voltage, NoSouris);
        for roi = 1:NoOfColumn
            res = check_activ(DATAF, time, roi);
            if res == 1
                NoActiveCell(i) = NoActiveCell(i) + 1;
            end
        end
    end
    bar(300:100:600, NoActiveCell)
end
