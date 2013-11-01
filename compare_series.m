function [diffseries, quaddiff, complexdiff] = compare_series(data, data2)
    diffseries = data-data2;
    quaddiff = sum(diffseries.^2);
    
    CE_Q = sqrt(sum(diff(data).^2));
    CE_C = sqrt(sum(diff(data2).^2));
    complexdiff = sqrt(sum((data - data2).^2)) * (max(CE_Q,CE_C)/min(CE_Q,CE_C));
end