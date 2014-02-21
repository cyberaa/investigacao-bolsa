function [detected, dL, dH]=linearMethod(t, w, snd)
    dL = zeros(length(w),1);
    dH = zeros(length(w),1);
    detected = zeros(length(w),1);
    
    s = std(w);
    %Y = DataFitting(w,t);
    %a = Y(1);
    %b = Y(2);      
    p = polyfit(t,w,1);
    a = p(2);
    b = -p(1);
    
    for i=1:length(w)
        predicted = a-b* (t(i));
        
        dL(i) = predicted - snd * s;
        dH(i) = predicted + snd * s;
        
        sample = w(i);
        
        detected(i) = ~(sample > dL(i) && sample < dH(i));
    end
end