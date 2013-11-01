%%%%
%% Detect and fix outliers. Given a source X, with a given number of
%% oversampling samples and a desired number of final samples.
%% snd is the SND (Standard Normal Deviation) used to detect the outliers
%%
%% We return a vector with two rows. The first contains the samples (which
%% may be fixed). The second highlights where we had to fix it (1 means we
%% detected and fixed an outlier)
%%%%
function [final_samples, band_low, band_high]=detect_outliers_linear(X, oversampling_samples, num_samples,snd,t)
%num_samples is the number of desired final samples
    final_samples=zeros(2,num_samples);
    band_low=zeros(1,num_samples);
    band_high=zeros(1,num_samples);
    t=t';
    for i=1:num_samples
        oversampling = X(1+(i-1)*(oversampling_samples) : i*(oversampling_samples)+1 );
        oversampling_t = t(1+(i-1)*(oversampling_samples) : i*(oversampling_samples)+1);
        sample = X(i*(oversampling_samples)+1);
        %avg=mean( oversampling );
        Y = DataFitting(oversampling,oversampling_t);
        a = Y(1);
        b = Y(2);
        stdev = std(oversampling);
        val = a-b* (oversampling_t(end)+1); %This is the next instant
        
        %[val sample]
        lower = val - snd * stdev;
        band_low(i) = lower;
        higher = val + snd * stdev;
        band_high(i) = higher;
        if (sample > lower && sample < higher)
            final_samples(1,i) = sample;  
            final_samples(2,i) = 0;  
        else
            final_samples(1,i) = val;  
            final_samples(2,i) = 1;   
        end        
    end
end