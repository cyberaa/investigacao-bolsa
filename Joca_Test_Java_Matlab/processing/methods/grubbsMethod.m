function [detected, dL, dH]=grubbsMethod(t, w, confidence)
    dL = zeros(length(w),1);
    dH = zeros(length(w),1);
    detected = zeros(length(w),1);
    
    [out, ~ ,~] =grubbsoutliers(w,confidence,1);
    
    idx = isnan(out);
    for k=1:length(idx)
        detected( idx(k) ) = 1;
    end
end