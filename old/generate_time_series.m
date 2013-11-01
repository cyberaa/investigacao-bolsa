%%%%
%% Generate a time series (line) with with num_samples samples and a random
%% starting value chosen from [minI,maxI]
%%%%
function series=generate_time_series(minI,maxI,num_samples,variation_range_min,variation_range_max, proportionality_factor) 
    series = zeros(1,num_samples);
    if nargin == 5
        proportionality_factor = 0.00001;
    end
    series(1) = (maxI-minI+1)*rand()+minI;
    
    proportionality_factor = proportionality_factor*num_samples;
    
    for i=2:num_samples
            variation = proportionality_factor*(variation_range_max-variation_range_min)*rand()+proportionality_factor*variation_range_min;
            series(i) = series(i-1)+variation;        
    end
end
