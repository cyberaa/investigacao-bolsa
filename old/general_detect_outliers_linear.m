%%%%
%% Detect and fix outliers. Given a source X, with a given number of
%% oversampling samples and a desired number of final samples.
%% snd is the SND (Standard Normal Deviation) used to detect the outliers
%%
%% We return a vector with two rows. The first contains the samples (which
%% may be fixed). The second highlights where we had to fix it (1 means we
%% detected and fixed an outlier)
%%%%
function [final_samples, band_low, band_high]=general_detect_outliers_linear(X,window_size,snd, model,t)
%num_samples is the number of desired final samples
    final_samples=zeros(2,length(X));
    band_low=zeros(1,length(X));
    band_high=zeros(1,length(X));
    t=t';
    num_windows=floor(length(X)/window_size);
    for i=1:num_windows
        %%%%
        %% Perform linear regression on the window
        %%%%
        oversampling = X(1+(i-1)*(window_size) : min(i*(window_size)+1,length(X)) );
        oversampling_t = t(1+(i-1)*(window_size) : min(i*(window_size)+1,length(t)));
        Y = DataFitting(oversampling,oversampling_t);
        a = Y(1);
        b = Y(2);
        
        %% STD
        stdev = std(oversampling);
        
        %%%%
        %% Find outliers and fix them by exrapolating from the linear
        %% regression
        %%%%
        for j=1+(i-1)*(window_size):min(i*(window_size)+1,length(X))

            % Predicted value
            
            if ( model == 1 )
                val = a-b* (t(j));
            else
                val=mean(oversampling);
            end
            % Real value
            sample=X(j);

            %Ranges
            lower = val - snd * stdev;
            higher = val + snd * stdev;
            band_low(j) = lower;
            band_high(j) = higher;
            if (sample > lower && sample < higher)
                final_samples(1,j) = sample;  
                final_samples(2,j) = 0;  
            else
                final_samples(1,j) = val;  
                final_samples(2,j) = 1;   
            end        
        end

        %[val sample]        
    end
end