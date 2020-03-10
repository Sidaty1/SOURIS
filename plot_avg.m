function plot_avg(NoSouris, voltage, roi)
        [time, ~,~, DATAF] = Average5(voltage, NoSouris);
        data=DATAF(:,roi+1);
        [ ~, ilx ] = min(abs(time-3));
        [ ~, ihx ] = min(abs(time-4.5));
        base=data(ilx:ihx);
        plot(time, data)
        hold on
        threshold=3*std(base);
        plot(time,ones(size(time)) * threshold)
        hold off
end