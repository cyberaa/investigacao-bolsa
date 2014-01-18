function [detected, dL, dH]=MADMethod(t, w, snd)
    dL = zeros(length(w),1);
    dH = zeros(length(w),1);
    detected = zeros(length(w),1);
    
    MAD=mad(w,1);            
    med=median(w);
    for i=1:length(w)
        dL(i) = med - snd * MAD;
        dH(i) = med + snd * MAD;
        
        sample = w(i);
        
        detected(i) = ~(sample > dL(i) && sample < dH(i));
    end
end