function res = check_activ(DATAF, time, roi)
    %Only look between 5 and 5.5 seconds
    avg=DATAF(:,roi);
    threshold=3*std(avg);
    [ ~, ilx ] = min(abs(time-5));
    [ ~, ihx ] = min(abs(time-5.5));
    avg=avg(ilx:ihx);
    if max(avg)>threshold  %If at any time in the interval we cross the threshold, then it is activated
        res=1;
    else
        res=0;
    end
end