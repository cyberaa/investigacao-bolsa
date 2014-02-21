function [t,data] = fix_missing(t, data, method, ts)    
    tser = timeseries(data,t);
    if nargin == 4
        t = (t(1) : ts : t(end))';
    end
    tser_fixed = resample(tser,t, method);
    data = tser_fixed.data;
    
    if sum(isnan(data)) > 0
        data(end)=data(length(data)-1);
        disp('Problems are coming!');
        pause;
    end
end