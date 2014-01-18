%%%%
% This function will randomly add num_outliers to source X.
% oversampling_samples indicates how many samples are used for
% oversampling, and are thus not included in the final source, which uses
% num_samples samples. 
% min_outlier_thresh and max_outlier_thresh define the amount to add
% as outlier. It must be positive (the function randomly makes it either
% a positive outlier or a negative one)
%
%%%%
function X=general_add_outliers(X, num_outliers, min_outlier_thresh, max_outlier_thresh)

    %%%%
    %% Select which indexes we are going to turn into outliers
    %%%%
    outlier_indexes = zeros(1,num_outliers);
    for i=1:num_outliers
        while true
            ind = randi([1, length(X)]);

            if ~isempty(find(outlier_indexes==ind, 1))
                continue;
            end

            outlier_indexes(i) = ind;
            break;
        end
    end

    %%%%
    %% Turn them into outliers
    %%%%
    for i=1:num_outliers
        ind = outlier_indexes(i);
        sign = randi([0 1]);
        if sign == 0
            sign = 1;
        else
            sign = -1;
        end
        X(ind) = X(ind) + sign * ((max_outlier_thresh-min_outlier_thresh)*rand()+min_outlier_thresh);
    end
end