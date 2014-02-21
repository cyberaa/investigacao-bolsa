function [data,outlier]=add_outliers(data, pct_outliers, min_dev, max_dev)
    n_outliers = round(pct_outliers*length(data));
    outlier = zeros(length(data),1);
    %%%%
    %% Select which indexes we are going to turn into outliers
    %%%%
    outlier_indexes = zeros(1,n_outliers);
    for i=1:n_outliers
        while true
            ind = randi([1, length(data)]);

            if ~isempty(find(outlier_indexes==ind, 1))
                continue;
            end

            outlier_indexes(i) = ind;
            outlier(ind) = 1;
            break;
        end
    end

    %%%%
    %% Turn them into outliers
    %%%%
    for i=1:n_outliers
        ind = outlier_indexes(i);
        sign = randi([0 1]);
        if sign == 0
            sign = 1;
        else
            sign = -1;
        end
        data(ind) = data(ind) + sign * ((max_dev-min_dev)*rand()+min_dev);
    end
end