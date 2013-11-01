%%%%
%% Detect and fix outliers. Given a source X, with a given number of
%% oversampling samples and a desired number of final samples.
%% snd is the SND (Standard Normal Deviation) used to detect the outliers
%%
%% We return a vector with two rows. The first contains the samples (which
%% may be fixed). The second highlights where we had to fix it (1 means we
%% detected and fixed an outlier)
%%%%
function final_samples=detect_outliers(X, oversampling_samples, num_samples,snd)
%num_samples is the number of desired final samples
    final_samples=zeros(2,num_samples);
    
    for i=1:num_samples
        oversampling = X(1+(i-1)*(oversampling_samples) : i*(oversampling_samples)+1 );
        sample = X(i*(oversampling_samples)+1);
        avg=mean( oversampling );
        stdev = std(oversampling);
        
        lower = avg - snd * stdev;
        higher = avg + snd * stdev;
        if (sample > lower && sample < higher)
            final_samples(1,i) = sample;  
            final_samples(2,i) = 0;  
        else
            final_samples(1,i) = avg;  
            final_samples(2,i) = 1;   
        end        
    end
end