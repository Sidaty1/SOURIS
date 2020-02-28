function plot_avg_compare(voltage, NoSouris)
    [time, DATA, DATAF] = Average5(voltage, NoSouris);
    data=DATAF(:,roi);
    figure,
    hold on
    plot(time,DATA(:,roi,1));
    plot(time,DATA(:,roi,2));
    plot(time,DATA(:,roi,3));
    plot(time,DATA(:,roi,4));
    plot(time,DATA(:,roi,5));
    hold off,
    figure,
    plot(time, DATA(:,roi,1), 'Color', [0.701, 0.917, 0.705])
    hold on
    plot(time, data, 'Color', [0.090, 0.431, 0.090])
    hold off
end