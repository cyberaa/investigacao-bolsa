%%%%
%% Detect and fix outliers. Given a source X, with a given number of
%% oversampling samples and a desired number of final samples.
%% snd is the SND (Standard Normal Deviation) used to detect the outliers
%%
%% We return a vector with two rows. The first contains the samples (which
%% may be fixed). The second highlights where we had to fix it (1 means we
%% detected and fixed an outlier)
%%%%
function [data_fix, detected, dL, dH]=accomodate_outliers(t,data,w_size,w_overlap,snd, model)
    data_fix=zeros(length(data),1);
    dL=zeros(length(data),1);
    dH=zeros(length(data),1);
    detected=zeros(length(data),1);   
    step = w_size-w_overlap;   
    
    for i=1 : step : length(data)-w_overlap+1
        %%%%
        %% Perform linear regression on the window
        %%%%
        n=i : min(i+(w_size),length(data));
        wnd = data( n );
        wnd_t = t(n);
        
        if ( model == 1 )
            Y = DataFitting(wnd,wnd_t);
            a = Y(1);
            b = Y(2);
        end
        
        %% STD
        stdev = std(wnd);
        
        %%%%
        %% Find outliers and fix them by exrapolating from the linear
        %% regression
        %%%%
        for j=i:min(i+(w_size),length(data))
            
            % Predicted value
            
            if ( model == 1 )
                val = a-b* (t(j));
            else
                val=mean(wnd);
            end
            % Real value
            sample=data(j);

            %Ranges
            lower = val - snd * stdev;
            higher = val + snd * stdev;
            dL(j) = lower;
            dH(j) = higher;
            
            if (sample > lower && sample < higher)
                data_fix(j) = sample;  
                detected(j) = 0;  
            else
                data_fix(j) = val;  
                detected(j) = 1;   
            end        
        end

        %[val sample]        
    end
end