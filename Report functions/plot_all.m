for roi = 2:48
    [time, ~, DATAF] = Average5 (500, 2);
    data=DATAF(:,roi);
    [ ~, ilx ] = min(abs(time-5));
    [ ~, ihx ] = min(abs(time-5.5));
    base=data(ilx:ihx);
    threshold=3*std(base);
    figure;
    plot(time, data)
    hold on
    plot(time,ones(size(time)) * threshold)
    hold off
end
    