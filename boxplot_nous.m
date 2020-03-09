function [m,X] = boxplot_nous()
    [time,~,DATAF]=Average5(600,1);
    X=[]; % array containing the mabels of outliers
    limtimeinf=5.0; %lower limit of stimulation time window
    limtimesup=6.0; %higher limit of stimulation time window
    [~,indtimeinf]=min(abs(time-limtimeinf)); % finding the index corresponding to limtimeinf
    [~,indtimesup]=min(abs(time-limtimesup)); % finding the index corresponding to limtimesup
    m=DATAF(indtimeinf:indtimesup,2:end)'; % transposing DATA matrix to use boxplot
    e = eps(max(m(:))); %eps for precision limit
    figure,
    boxplot(m,'whisker',1.5) %whisker length determined to have 
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