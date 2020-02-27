function histogramme
    voltages = [300, 400, 500,600];
    NoActiveCell = zeros(1,4);
    for i = 1:length(voltages)
        voltage = voltages(i);
        [time,~, DATAF] = Average5(voltage);
        for roi = 1:229
            res = check_activ(DATAF, time, roi);
            if res == 1
                NoActiveCell(i) = NoActiveCell(i) + 1;
            end
        end
    end
    bar(300:100:600, NoActiveCell)
end