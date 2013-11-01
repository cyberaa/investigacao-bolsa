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