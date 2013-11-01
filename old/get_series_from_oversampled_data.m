%%%%
%% Given an oversampled source, with n=oversampling_samples oversamples
%% and a target num_samples, read only the non-oversampling samples and
%% return them.
%%%%
function final_samples=get_series_from_oversampled_data(X, oversampling_samples, num_samples)
    final_samples=zeros(1,num_samples);
    
    for i=1:num_samples
        final_samples(i) = X(i*(oversampling_samples)+1);    
    end
end