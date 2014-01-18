function [detected, dL, dH]=modZScore(t, w, thresh)
    dL = zeros(length(w),1);
    dH = zeros(length(w),1);
    detected = zeros(length(w),1);
    
    MAD=mad(w,1);            
    med=median(w);
    for i=1:length(w)
        sample = w(i);
        score = 0.6745 * ( abs(sample - med) ) / MAD;
        
        sample = w(i);
        
        detected(i) = score >= thresh;
    end
end