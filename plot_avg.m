function plot_avg(voltage, roi)
        [time, data, DATA] = Average5(voltage, roi);
        figure,
        plot(time, data)
        hold on
        threshold=3*std(data);
        plot(time,ones(size(time)) * threshold)
        hold off
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