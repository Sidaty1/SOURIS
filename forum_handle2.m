function X = forum_handle2()
    [~,~,DATAF]=Average5(600,1);
    X=[];
    for i = 0:29
        m=DATAF(1+i*30:30+i*30,2:end)';
        e = eps(max(m(:)));
        figure,
        boxplot( DATAF(1+i*30:30+i*30,2:end)','whisker',3 )
        h = flipud(findobj(gcf,'tag','Outliers')); % flip order of handles
        for jj = 1 : length( h )
            x =  get( h(jj), 'XData' );
            y =  get( h(jj), 'YData' );
            for ii = 1 : length( x )
                if not( isnan( x(ii) ) )
                    ix = find( abs( m(:,jj)-y(ii) ) < e );
                    text( x(ii), y(ii), sprintf( '\\leftarrowY%02d', ix ) )
                    X = [X,ix];
                end
            end
        end  
    end    
end