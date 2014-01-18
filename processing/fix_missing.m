function data = fix_missing(t, data, method, ts)
    if nargin == 4
        t = t(0) : ts : t(end);
    end

    tser = timeseries(data,t);
    tser_fixed = resample(tser,t, method);
    data = tser_fixed.data;
    
    if sum(isnan(data)) > 0
        data(end)=data(length(data)-1);
        disp('Problems are coming!');
        pause;
    end
end