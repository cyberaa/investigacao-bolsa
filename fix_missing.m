function data = fix_missing(t, data)
    tser = timeseries(data,t);
    tser_fixed = resample(tser,t);
    data = tser_fixed.data;
end