function [detected, dL, dH]=iqrMethod(t, w, snd)
    dL = zeros(length(w),1);
    dH = zeros(length(w),1);
    detected = zeros(length(w),1);
    
    IQR_L = quantile(w, 0.25);
    IQR_H = quantile(w, 0.75);
    IQR = iqr(w);
    for i=1:length(w)
        dL(i) = IQR_L - snd * IQR;
        dH(i) = IQR_H + snd * IQR;
        
        sample = w(i);
        
        detected(i) = ~(sample > dL(i) && sample < dH(i));
    end
end