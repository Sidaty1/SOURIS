[time,DATA,DATAF]=Average5(600,'Souris1');
boxplot( DATAF(1+13*30:30+13*30,2:end)','whisker',5 )
    h = flipud(findobj(gcf,'tag','Outliers')); % flip order of handles
    for jj = 1 : length( h )
        x =  get( h(jj), 'XData' );
        y =  get( h(jj), 'YData' );
        for ii = 1 : length( x )
            if not( isnan( x(ii) ) )
                ix = find( abs( m(:,jj)-y(ii) ) < e );
                text( x(ii), y(ii), sprintf( '\\leftarrowY%02d', ix ) )
            end
        end
    end