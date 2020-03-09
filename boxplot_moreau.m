function [m,X] = boxplot_moreau()
    [time,~,DATAF]=Average5(600,1);
    X=[];
    limtimeinf=5.0;
    limtimesup=6.0;
    [~,indtimeinf]=min(abs(time-limtimeinf));
    [~,indtimesup]=min(abs(time-limtimesup));
    m=DATAF(indtimeinf:indtimesup,2:end)';
    e = eps(max(m(:)));
    figure,
    boxplot(m,'whisker',2.2)
    h = flipud(findobj(gcf,'tag','Outliers')); % flip order of handles
    for jj = 1 : length( h )
        x =  get( h(jj), 'XData' );
        y =  get( h(jj), 'YData' );
        for ii = 1 : length( x )
            if not( isnan( x(ii) ) )
                ix = find( abs( m(:,jj)-y(ii) ) < e );
                text( x(ii), y(ii), sprintf( '\\leftarrowY%02d', ix ) )
                X = [X, ix];
            end
        end
    end
    X=unique(X);
end