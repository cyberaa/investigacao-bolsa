%%%%
% Add random gaps (i.e: missing data) to the input vector by removing valid
% data. The amount of missing data to add is given as a percentage of the
% original data (pct_missing). That is, to make 5% of the samples in 'data'
% disappear, make pct_missing=0.05
%%%%
function data = add_missing(data, pct_missing)
    n_missing = round(pct_missing*length(data));
    for i=1:n_missing
        while true
            ind = randi([1, length(data)]);

            if isnan(data(ind))
                continue;
            end

            data(ind) = NaN;
            break;
        end
    end
end