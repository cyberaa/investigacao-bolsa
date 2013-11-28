function [detected, dL, dH]=stdMethod(t, w, snd)
    dL = zeros(length(w),1);
    dH = zeros(length(w),1);
    detected = zeros(length(w),1);
    
    s = std(w);
    m = mean(w);          
    for i=1:length(w)
        dL(i) = m - snd * s;
        dH(i) = m + snd * s;
        
        sample = w(i);
        
        detected(i) = ~(sample > dL(i) && sample < dH(i));
    end
end