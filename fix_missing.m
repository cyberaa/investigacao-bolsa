function data = fix_missing(t, data)
    tser = timeseries(data,t);
    tser_fixed = resample(tser,t);
    data = tser_fixed.data;
    
    if sum(isnan(data)) > 0
        data(end)=data(length(data)-1);
        disp('Problems are coming!');
        pause;
    end
end